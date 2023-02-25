import socket 
import sys

SERVER_ADDR = ((sys.argv[1]).split(':')[0],int((sys.argv[1]).split(':')[1])) #First argument
CLIENT_BUFSIZE = 1024

numbers = [
    15492781, 15492787, 15492803,
    15492811, 15492810, 15492833,
    15492859, 15502547, 15520301,
    15527509, 15522343, 1550784
    ]

if __name__ == "__main__":
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect(SERVER_ADDR)
        for number in numbers:
            s.send(str(number).encode())
            is_prime = s.recv(CLIENT_BUFSIZE)
            print(f'{number} {is_prime.decode()}')
        print('Conpleted')
        s.close()
