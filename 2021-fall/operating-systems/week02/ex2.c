#include <stdio.h>

int main(void) {
	char arr[256];
	printf("Enter a string : \n");
	fgets (arr, 256, stdin);
	int sz=strlen(arr);
	for(int i=sz-1;i>=0;i--){
		printf("%c",arr[i]);
	}
	printf("\n");
	return 0;
}


