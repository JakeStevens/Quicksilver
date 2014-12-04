#include "gpu.c"

int main(void)
{
    GPUDrawArc(20,320,240,0,255,0,0); //R
    GPUDrawArc(20,320,240,1,0,255,0); //G
    GPUDrawArc(20,320,240,2,0,0,255); //B
    GPUDrawArc(20,320,240,3,235,31,228); //purple 
    GPUDrawArc(20,320,240,4,255,255,0); //yellow 
    GPUDrawArc(20,320,240,5,255,255,255); //white
    GPUFlush(); //drawing on two
    GPUDrawFilledRect(100,100,50,10, 0,0,255);
    GPUDrawArc(50, 175,175,4,255,255,255);
    GPUDrawLine(0,480, 320, 240, 0, 255, 0);
    GPUFlush(); //drawing on one
    GPUDrawCircle(80,200,100, 255,0,255);

    return 1;
}	  

