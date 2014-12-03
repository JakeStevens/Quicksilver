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
    GPUDrawArc(20,320,240,6,255,128,0); //orange 
    GPUDrawArc(20,320,240,7,255,0,127); //pink 
    
    GPUDrawArc(20,100,100,0,255,0,0); //R
    GPUDrawArc(20,100,100,1,0,255,0); //G
    GPUDrawArc(20,100,100,2,0,0,255); //B
    GPUDrawArc(20,100,100,3,235,31,228); //purple 
    GPUDrawArc(20,100,100,4,255,255,0); //yellow 
    GPUDrawArc(20,100,100,5,255,255,255); //white
    GPUFlush(); //drawing on one
    GPUDrawArc(20,100,100,6,255,128,0); //orange 
    GPUDrawArc(20,100,100,7,255,0,127); //pink 
    
    GPUDrawArc(20,400,240,0,255,0,0); //R
    GPUDrawArc(20,400,240,1,0,255,0); //G
    GPUDrawArc(20,400,240,2,0,0,255); //B
    GPUDrawArc(20,400,240,3,235,31,228); //purple 
    GPUFlush(); //drawing on two
    GPUDrawArc(20,400,240,4,255,255,0); //yellow 
    GPUDrawArc(20,400,240,5,255,255,255); //white
    GPUDrawArc(20,400,240,6,255,128,0); //orange 
    GPUDrawArc(20,400,240,7,255,0,127); //pink 

    GPUDrawRectangleOutline(10,10 ,40 ,30, 255, 0, 0);
    GPUDrawFilledRect(100,100,50,10, 0,0,255);
    GPUFlush();
    //drawing on one
    GPUDrawLine(0,480, 320, 240, 0, 255, 0);
    GPUDrawCircle(80,200,100, 255,0,255);

    return 1;
}	  

