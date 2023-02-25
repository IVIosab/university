from unittest import result
import zmq
import time
import sys

CLIENT_INPUTS = sys.argv[1]
CLIENT_OUTPUTS = sys.argv[2]
WORKER_INPUTS = sys.argv[3]
WORKER_OUTPUTS = sys.argv[4]

if __name__ == '__main__':
    context = zmq.Context()
    reply_socket = context.socket(zmq.REP)
    reply_socket.bind(f"tcp://*:{CLIENT_INPUTS}")
    publish_clients_socket = context.socket(zmq.PUB)
    publish_clients_socket.bind(f"tcp://*:{CLIENT_OUTPUTS}")
    publish_workers_socket = context.socket(zmq.PUB)
    publish_workers_socket.bind(f"tcp://*:{WORKER_INPUTS}")
    subscribe_socket = context.socket(zmq.SUB)
    subscribe_socket.bind(f"tcp://*:{WORKER_OUTPUTS}")
    subscribe_socket.setsockopt_string(zmq.SUBSCRIBE, '')
    subscribe_socket.RCVTIMEO = 100
    try:
        while True:
            client_message = reply_socket.recv_string()
            reply_socket.send_string("ack")
            publish_clients_socket.send_string(client_message)
            publish_workers_socket.send_string(client_message)
            try:
                while True:
                    try:
                        result_message = subscribe_socket.recv_string()
                        publish_clients_socket.send_string(result_message)
                    except zmq.ZMQError:
                        break
            except zmq.Again:
                pass
    except KeyboardInterrupt:
        print("Terminating server")
        sys.exit(0)
