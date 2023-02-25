import zmq
import sys
import math

WORKER_INPUTS = sys.argv[1]
WORKER_OUTPUTS = sys.argv[2]

def checker(message):
    parsed_message = message.split(" ")
    if len(parsed_message) == 3 and parsed_message[0] == "gcd" and parsed_message[1].isdigit() and parsed_message[2].isdigit():
        return (int(parsed_message[1]), int(parsed_message[2]))
    else:
        return False

if __name__ == '__main__':
    context = zmq.Context()

    subscribe_socket = context.socket(zmq.SUB)
    subscribe_socket.connect(f"tcp://localhost:{WORKER_INPUTS}")
    subscribe_socket.setsockopt_string(zmq.SUBSCRIBE, '')
    subscribe_socket.RCVTIMEO = 100
    publish_socket = context.socket(zmq.PUB)
    publish_socket.connect(f"tcp://localhost:{WORKER_OUTPUTS}")
    try:
        while True:
            try:        
                message_recieved = subscribe_socket.recv_string()
                valid = checker(message_recieved)
                if valid != False:
                    x, y = valid
                    publish_socket.send_string(f'gcd for {x} {y} is {math.gcd(x,y)}')
            except zmq.ZMQError:
                pass
    except KeyboardInterrupt:
        print("Terminating gcd")
        sys.exit(0)