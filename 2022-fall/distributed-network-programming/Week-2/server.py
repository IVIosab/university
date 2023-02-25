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
        
def is_prime(n):
    if n in (2, 3):
        return True
    if n % 2 == 0:
        return False
    for divisor in range(3, n, 2):
        if n % divisor == 0:
            return False
    return True

def worker():
    while True:
        try:
            conn, addr = QUEUE.get()
            print(f'{addr} connected')
            while True:
                number = conn.recv(SERVER_BUFSIZE)
                if number == b'':
                    print(f'{addr} disconnected')
                    conn.close()
                    break
                prime = is_prime(int(number.decode()))
                if prime:
                    conn.send('is prime'.encode())
                else:
                    conn.send('is not prime'.encode())
        except Empty:
            print("No work to do")


def main():
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
            print('Done')
            os._exit(0)
        

if __name__ == "__main__":
    main()