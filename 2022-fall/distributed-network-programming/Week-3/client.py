import zmq
import sys

CLIENT_INPUTS = sys.argv[1]
CLIENT_OUTPUTS = sys.argv[2]

if __name__ == '__main__':
    context = zmq.Context()

    request_socket = context.socket(zmq.REQ)
    request_socket.connect(f"tcp://localhost:{CLIENT_INPUTS}")
    subscribe_socket = context.socket(zmq.SUB)
    subscribe_socket.connect(f"tcp://localhost:{CLIENT_OUTPUTS}")
    subscribe_socket.setsockopt_string(zmq.SUBSCRIBE, '')
    subscribe_socket.RCVTIMEO = 100
    try:
        while True:
            line = input('> ')
            if len(line) != 0:
                request_socket.send_string(line)
                request_socket.recv_string()
            try:
                while True:
                    try:
                        message_recieve = subscribe_socket.recv_string()
                        print(message_recieve)
                    except zmq.ZMQError:
                        break
            except zmq.Again:
                pass
    except KeyboardInterrupt:
        print("Terminating client")
        sys.exit(0)