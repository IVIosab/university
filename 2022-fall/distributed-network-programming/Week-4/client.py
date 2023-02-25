import grpc
import service_pb2 as pb2
import service_pb2_grpc as pb2_grpc
import sys

SERVER_HOST = (sys.argv[1]).split(':')[0]
SERVER_PORT = (sys.argv[1]).split(':')[1]

def nums_generator(nums):
    for num in nums:
        message = pb2.IsprimeMessage(num=int(num))
        yield message

if __name__ == '__main__':
    channel = grpc.insecure_channel(f'{SERVER_HOST}:{SERVER_PORT}')
    stub = pb2_grpc.ServiceStub(channel)
    while True:
        try:
            inp = input("> ")
            if len(inp) <= 1:
                continue
            type = inp.split()[0]
            query = ' '.join(inp.split()[1:])
            if type == "reverse":
                message = pb2.ReverseMessage(text=query)
                response = stub.ServerReverse(message)
                print(f'message: "{response.reversed}"\n')
            elif type == "split":
                message = pb2.SplitMessage(text=query, delim=" ")
                response = stub.ServerSplit(message)
                print(f'number: {response.size}')
                for part in response.parts:
                    print(f'parts: "{part}"')
                print()
            elif type == "isprime":
                nums = query.split()
                for response in stub.ServerIsprime(nums_generator(nums)):
                    print(f'{response.verdict}')
                print()
            elif type == 'exit':
                print("\nShutting Down\n")
                sys.exit(0)
            else:
                print(f'"{type}" is not a valid method.\n')        
        except KeyboardInterrupt:
            print("\nShutting Down\n")
            sys.exit(0)
            

