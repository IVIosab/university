import socket
import sys
from threading import Thread
from multiprocessing import Queue
from queue import Empty
import os

SERVER_HOST = '127.0.0.1'
SERVER_PORT = int(sys.argv[1]) #first argument
SERVER_ADDR = (SERVER_HOST, SERVER_PORT) 
SERVER_BUFSIZE = 1024
QUEUE = Queue()
NAMES = []
CONNECTIONS = {} #name: conn

def send_to_connections(add, name, conn):
    global NAMES, CONNECTIONS
    if add:
        NAMES.append(name)
        NAMES.sort()
        CONNECTIONS[name] = conn
    else:
        x = -1
        for i in range(len(NAMES)):
            if NAMES[i] == name:
                x = i
                break
        if x != -1:
            NAMES.pop(x)
            NAMES.sort()
            del CONNECTIONS[name]
    for key, value in CONNECTIONS.items():
        value.send((' '.join(NAMES)).encode())



def worker():
    global NAMES
    while True:
        try:
            conn, addr = QUEUE.get()
            print(f'{addr} connected')
            name = conn.recv(SERVER_BUFSIZE)
            send_to_connections(True, name.decode(), conn)
            conn.settimeout(0.1)
            while True:
                try: 
                    check = conn.recv(SERVER_BUFSIZE)
                    if check == b'':
                        print(f'{addr} disconnected')
                        send_to_connections(False, name.decode(), conn)
                        conn.close()
                        break
                except socket.timeout:
                    pass
        except Empty:
            print("No work to do")


def main():
    global CONNECTIONS
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind(SERVER_ADDR)
        s.listen()
        THREADS = [Thread(target=worker) for i in range(5)]
        [t.start() for t in THREADS]
        try: 
            while True:
                conn, address = s.accept()
                global QUEUE
                QUEUE.put((conn, address))
        except KeyboardInterrupt:
            print('\nServer is shutting down')
            for key, value in CONNECTIONS.items():
                value.close()
            os._exit(0)
        

if __name__ == "__main__":
    main()