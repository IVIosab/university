import queue_pb2_grpc as pb2_grpc
import queue_pb2 as pb2
import grpc
import sys
from concurrent import futures

PORT = sys.argv[1]
MAX_SIZE = int(sys.argv[2])
QUEUE = []
FRONT = 0 
SIZE = 0

class Handler(pb2_grpc.ServiceServicer):
    def __init__(self, *args, **kwargs):
        pass

    def ServerPut(self, request, context):
        global QUEUE,SIZE
        str = request.str
        result = False
        if SIZE != MAX_SIZE:
            result=True
            QUEUE.append(str)
            SIZE=SIZE+1
        reply = {"result": result}
        return pb2.BoolResponse(**reply)

    def ServerPeek(self, request, context):
        global QUEUE, FRONT
        str = "None"
        if FRONT != len(QUEUE):
            str = QUEUE[FRONT]
        reply = {"str": str}
        return pb2.StringResponse(**reply) 

    def ServerPop(self, request, context):
        global QUEUE, FRONT, SIZE
        str = "None"
        if FRONT != len(QUEUE):
            str = QUEUE[FRONT]
            FRONT=FRONT+1
            SIZE=SIZE-1
        reply = {"str": str}
        return pb2.StringResponse(**reply) 
        
    def ServerSize(self, request, context):
        global SIZE
        size = SIZE
        reply = {"size": size}
        return pb2.IntResponse(**reply) 
        
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
    