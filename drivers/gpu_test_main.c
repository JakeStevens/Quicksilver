#include "gpu.c"

int main(void)
{
    GPUDrawArc(20,320,240,0,255,0,0); //R
    GPUDrawArc(20,320,240,1,0,255,0); //G
    GPUDrawArc(20,320,240,2,0,0,255); //B
    GPUDrawArc(20,320,240,3,235,31,228); //purple 
    GPUDrawArc(20,320,240,4,255,255,0); //yellow 
    GPUDrawArc(20,320,240,5,255,255,255); //white
    GPUDrawArc(20,320,240,6,255,128,0); //orange 
    GPUDrawArc(20,320,240,7,255,0,127); //pink 
    return 1;
}	  

