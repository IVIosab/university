import grpc
import sys
import os
import queue_pb2 as pb2
import queue_pb2_grpc as pb2_grpc

SERVER_ADDR = ((sys.argv[1]).split(':')[0],int((sys.argv[1]).split(':')[1])) #First argument


if __name__ == '__main__':
    channel = grpc.insecure_channel(f'{SERVER_ADDR[0]}:{SERVER_ADDR[1]}')
    stub = pb2_grpc.ServiceStub(channel)
    while True:
        try:
            input_buffer = input("> ")
            if len(input_buffer) <= 1: #User entered an empty line
                continue
            command = input_buffer.split()[0] #command type
            command_args = input_buffer.split()[1:] #command arguments 
            query = ' '.join(command_args)
            if command == "put":
                message = pb2.StringMessage(str=query)
                response = stub.ServerPut(message)
                print(response.result)
            if command == "peek":
                message = pb2.EmptyMessage()
                response = stub.ServerPeek(message)
                print(response.str)
            if command == "pop":
                message = pb2.EmptyMessage()
                response = stub.ServerPop(message)
                print(response.str)
            if command == "size":
                message = pb2.EmptyMessage()
                response = stub.ServerSize(message)
                print(response.size)
        except KeyboardInterrupt:
            print("Terminating\n")
            os._exit(1)
            
