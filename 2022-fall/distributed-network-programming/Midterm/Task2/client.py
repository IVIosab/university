import socket 
import sys
import os

SERVER_ADDR = ((sys.argv[1]).split(':')[0],int((sys.argv[1]).split(':')[1])) #First argument
NAME = str(sys.argv[2])
CLIENT_BUFSIZE = 1024


if __name__ == "__main__":
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        try: 
            s.connect(SERVER_ADDR)
            s.send(NAME.encode())
            while True:
                try:
                    names = s.recv(CLIENT_BUFSIZE)
                    print(f'{names.decode()}')
                except KeyboardInterrupt:
                    print(f'Terminating\n')
                    s.close()
                    os._exit(0)
        except BrokenPipeError:
            print("Server is not reachable")
        except ConnectionRefusedError:
            print("Server is unavaliable")