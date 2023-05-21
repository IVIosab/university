#include <stdio.h>
#include <limits.h>
#include <math.h>
#include <float.h>


int main(void) {
    int i=INT_MAX;
    float f=FLT_MAX;
    double d=DBL_MAX;
    printf("Integer = %d\n",i);
    printf("Float = %f\n",f);
    printf("Double = %lf\n",d);
    printf("Sizeof integer = %d\n",sizeof(i));
    printf("Sizeof float = %d\n",sizeof(f));
    printf("Sizeof double = %d\n",sizeof(d));
    return 0;
}

