#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void* thread_func(void* arg)
{
	printf("This is thread #%d\n", *(int*)arg);
	pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
	int N=5;
	if(argc == 2)
		N = strtol(argv[1], NULL, 10);

	for(int i=1; i<=N; i++)
	{
		pthread_t thread;
		pthread_create(&thread, NULL, thread_func, &i);
		printf("Created thread #%d\n", i);
		/*
		 * Will wait until the thread exits to create the new one.
		 * The ID printed is the same for all of them,
		    since the previous one exited and the ID can be reused
		 */
		pthread_join(thread, NULL);	// Addition to ex1.1
	}
	return 0;
}
