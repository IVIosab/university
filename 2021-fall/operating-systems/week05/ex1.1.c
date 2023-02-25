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

	/*
	 * Order of printing is not defined.
	 * Main thread can sometimes print first,
	    and other times the new thread would print first
	 */

	for(int i=1; i<=N; i++)
	{
		pthread_t thread;
		pthread_create(&thread, NULL, thread_func, &i);
		printf("Created thread #%d\n", i);
	}
	return 0;
}
