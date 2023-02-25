import socket
import os 
import sys
import time

SERVER_HOST = '127.0.0.1'
SERVER_PORT = int(sys.argv[1]) #first argument
SERVER_ADDR = (SERVER_HOST, SERVER_PORT) 
SERVER_BUFF_SIZE = 1024
sessions = {}

def new_session():
    global sessions
    parsed_data = data.split(b' | ')
    seqno = int(parsed_data[1].decode())
    file_name = parsed_data[2].decode()
    file_size = int(parsed_data[3].decode())   

    if addr in sessions:
        print(f'session with "{addr[0]}:{int(addr[1])}" already exists')
        return
    else:
        print(f'session="{addr[0]}:{int(addr[1])}" started')
        sessions[addr] = [seqno+1, file_name, file_size, b'', time.time(), False]

def session_send_ack():
    ack = f'a | {str(sessions[addr][0])} | {str(SERVER_BUFF_SIZE)}'.encode()
    s.sendto(ack, addr)

def recieve_data():
    global sessions
    parsed_data = data.split(b' | ')
    seqno = int(parsed_data[1].decode())
    if seqno != sessions[addr][0]:
        if seqno == sessions[addr][0]-1:
            print(f'session="{addr[0]}:{int(addr[1])}" seqNo={sessions[addr][0]} received old chunk')
        else:
            print("Bruh... What ?!")
        return
    sessions[addr][4] = time.time() #should this be inside the if statement too ?
    sessions[addr][0] = sessions[addr][0] + 1 

def data_send_ack():
    parsed_data = data.split(b' | ')
    if sessions.get(addr) is None:
        print("Unidentified session, Ignoring...")
    else:
        ack = f'a | {str(sessions[addr][0])}'.encode()

        for i in range(2, len(parsed_data)):
            if i !=2:
                sessions[addr][3]+=b' | '
            sessions[addr][3]+=parsed_data[i]
        packet_headers_size = len(f'd | {str(sessions[addr][0])} | '.encode())
        packet_content_size = SERVER_BUFF_SIZE - packet_headers_size
        sessions[addr][2]-=packet_content_size
        if sessions[addr][2]<=0:
            make_file()
        s.sendto(ack, addr)

def update_sessions():
    current_time = time.time()
    for key in list(sessions.keys()):
        if sessions[key][5] == True:
            if (current_time - sessions[key][4]) >= 1:
                sessions.pop(key)
                print(f'session="{key[0]}:{int(key[1])}" removed after successful termination')
        else:
            if (current_time - sessions[key][4]) >= 3:
                sessions.pop(key)
                print(f'session="{key[0]}:{int(key[1])}" removed due to inactivity')

def make_file():
    print(f'session="{addr[0]}:{int(addr[1])}" finished successfully')
    f = open(sessions[addr][1], 'wb')
    f.write(sessions[addr][3])
    f.close()
    sessions[addr][5] = True


if __name__ == '__main__':
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        s.bind(SERVER_ADDR)
        s.settimeout(1)
        print("Server started...")
        
        while True:
            try:
                data, addr = s.recvfrom(SERVER_BUFF_SIZE)
                message_type = data.split(b' | ')[0].decode()
                update_sessions()
                if message_type == 's':
                    new_session()
                    session_send_ack()
                else:
                    recieve_data()
                    data_send_ack()
            except KeyboardInterrupt:
                print("Server shutting down...")
                break
            except socket.timeout:
                update_sessions()
                continue