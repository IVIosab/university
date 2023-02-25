import socket
import sys
import os

CLIENT_HOST = '127.0.0.1'
CLIENT_PORT = 12345
CLIENT_ADDR = (CLIENT_HOST, CLIENT_PORT)
CLIENT_BUFF_SIZE = 1024 

SERVER_ADDR = ((sys.argv[1]).split(':')[0],int((sys.argv[1]).split(':')[1])) #First argument
FILE_NAME = sys.argv[2] #Second argument
OUTPUT_FILE_NAME = sys.argv[3] #Third argument
SERVER_BUFF_SIZE = -1 # not yet initialized

FILE_SIZE = 0
SEQNO = 0

def send_start():
    global FILE_SIZE
    if not os.path.exists(FILE_NAME):
        print("File Doesn't Exist")
        exit()
    with open(FILE_NAME, 'rb'): 
        FILE_SIZE = os.path.getsize(FILE_NAME)
    return f's | 0 | {OUTPUT_FILE_NAME} | {FILE_SIZE}'.encode()

def get_ack(packet):
    global SERVER_BUFF_SIZE
    global SEQNO
    s.settimeout(0.5)
    tr = 1
    while tr < 6:
        try:
            s.sendto(packet, SERVER_ADDR)
            data, addr = s.recvfrom(CLIENT_BUFF_SIZE) 
            ack = data.decode().split(' | ') 
            if len(ack) == 3:
                SERVER_BUFF_SIZE = int(ack[2])
                print (f'bufsize selected by server: {SERVER_BUFF_SIZE}')
            SEQNO = int(ack[1])
            break
        except socket.timeout:
            print(f'seqNo={SEQNO} faild to send data, Retrying...')
            tr +=1
    if tr == 6:
        print('Connection problems, session is terminated')
        exit() 

def send_file():
    global FILE_SIZE
    
    with open(FILE_NAME, 'rb') as f:
        while FILE_SIZE>0:
            packet_headers = f'd | {str(SEQNO)} | '.encode()
            packet_headers_size = len(packet_headers)
            packet_content_size = SERVER_BUFF_SIZE - packet_headers_size
            r = f.read(packet_content_size)
            FILE_SIZE-=packet_content_size
            packet = packet_headers + r
            get_ack(packet)
        else:
            print(f'Successfully transmitted a file')

if __name__ == '__main__':
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        start = send_start()
        get_ack(start)
        send_file()