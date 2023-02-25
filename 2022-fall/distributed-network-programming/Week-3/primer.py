import zmq
import sys

WORKER_INPUTS = sys.argv[1]
WORKER_OUTPUTS = sys.argv[2]

def checker(message):
    parsed_message = message.split(" ")
    if len(parsed_message) == 2 and parsed_message[0] == "isprime" and parsed_message[1].isdigit():
        return int(parsed_message[1])
    else:
        return False

def is_prime(n):
    if n in (2, 3):
        return True
    if n % 2 == 0:
        return False
    for divisor in range(3, n, 2):
        if n % divisor == 0:
            return False
    return True

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
                    isprime = is_prime(valid)
                    if isprime:
                        publish_socket.send_string(f'{valid} is prime')
                    else:
                        publish_socket.send_string(f'{valid} is not prime')            
            except zmq.ZMQError:
                pass    
    except KeyboardInterrupt:
        print("Terminating primer")
        sys.exit(0)