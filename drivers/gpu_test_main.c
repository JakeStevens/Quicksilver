#include "gpu.c"

int main(void)
{
    //GPUDrawFilledRect(0,0,20,20,255,255,255);
    GPUDrawLine(150, 180, 60, 60, 50, 90, 180);
    GPUDrawLine(60, 60, 150, 180, 50, 90, 180);
    GPUDrawLine(120, 120, 120, 200, 60, 70, 90);
    GPUDrawLine(1, 2, 50, 200, 100, 100, 100);    
    return 1;
}
