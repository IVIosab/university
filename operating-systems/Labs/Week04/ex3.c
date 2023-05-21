#include <stdio.h>
#include <stdlib.h>

int main()
{
    char command[1000];
    printf("Enter the command\n");
    while(1)
    {
        printf(">>| ");
        scanf("%s", command);
        system(command);
    }
}
