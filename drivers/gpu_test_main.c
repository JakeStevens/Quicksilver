#include "gpu.c"

int main(void)
{
    printf("Draw rectangle from 0,0 to 3,3\n");
    GPUDrawFilledRect(0,0,3,3,255,255,255);    
    return 1;
}
