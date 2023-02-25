import service_pb2_grpc as pb2_grpc
import service_pb2 as pb2
import grpc
import sys
from concurrent import futures

PORT = sys.argv[1]

def is_prime(n):
    if n in (2, 3):
        return f'{n} is prime'
    if n % 2 == 0:
        return f'{n} is not prime'
    for divisor in range(3, n, 2):
        if n % divisor == 0:
            return f'{n} is not prime'
    return f'{n} is prime'

class Handler(pb2_grpc.ServiceServicer):
    def __init__(self, *args, **kwargs):
        pass

    def ServerReverse(self, request, context):
        text = request.text
        reversed_text = text[::-1]
        reply = {"reversed": reversed_text}
        return pb2.ReverseMessageResponse(**reply) 
    
    def ServerSplit(self, request, context):
        text = request.text
        delim = request.delim
        parts = text.split(delim)
        size = len(parts)
        reply = {"size": size, "parts": parts}
        return pb2.SplitMessageResponse(**reply) 
    
    def ServerIsprime(self, request_iterator, context):
        for request in request_iterator:
            verdict = is_prime(request.num)
            reply = {"verdict": verdict}
            yield pb2.IsprimeMessageResponse(**reply)
        

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    pb2_grpc.add_ServiceServicer_to_server(Handler(), server)
    server.add_insecure_port(f'127.0.0.1:{PORT}')
    server.start()
    try:
        server.wait_for_termination()
    except KeyboardInterrupt:
        print("\nShutting down\n")
        sys.exit(0)

if __name__ == "__main__":
    serve()
    