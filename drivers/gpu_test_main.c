#include "gpu.c"

int main(void)
{
    GPUDrawLine(0,0, 100, 100, 255,255,255);
    GPUDrawLine(0,0, 50, 100, 255,255,255);
    GPUDrawLine(0,0, 200, 100, 255,255,255);
    GPUDrawLine(0,0, 300, 100, 255,255,255);
    GPUDrawLine(0,0, 250, 100, 255,255,255);
    GPUDrawLine(0,0, 150, 100, 255,255,255);
   // GPUDrawLine(639,399, 100, 400, 255,255,255);
   // GPUDrawLine(0,0, 100, 300, 255,255,255);
    GPUDrawFilledRect(320,240,50,50,255,0,0);
    GPUDrawFilledRect(270,240,50,50,0,255,0);
    return 1;
}	  

