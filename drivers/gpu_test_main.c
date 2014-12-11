#include "gpu.c"

int main(void)
{ 
    GPUDrawFilledRect(0,0,150,120,0,0,0);

    GPUDrawFilledRect(10,14,7+14,10,255,215,0);
    GPUDrawFilledRect(10,96,30,10,255,215,0);
    GPUDrawFilledRect(10+8,14+10,14,72,255,215,0);
    GPUDrawFilledRect(10+21,14,16,57,255,215,0);
    GPUDrawCircle(28,10+8+28,14+28,255,215,0);
    GPUDrawCircle(14,10+8+28,14+28,0,0,0);
    GPUDrawFilledRect(10+18,28,15,29,0,0,0);

    /* Height is Outer Radius - Inner Radius + Height of Left Side + Height of Block */
    /* Width is Outer Radius + 10 */
    GPUDrawFilledRect(111-28-5,77-53-10,10+14,10,255,215,0); //Left Block Atop U
    GPUDrawFilledRect(111+14-5+1,77-53-10,10+14,10,255,215,0); //Right Block Atop U
    GPUDrawFilledRect(111-28,77-53,14,53,255,215,0); //Left Side Of U
    GPUDrawFilledRect(111+14+1,77-53,14,53,255,215,0); //Right Side Of U
    GPUDrawCircle(28, 111, 77, 255,215,0); // Outer circle to make bottom of U
    GPUDrawCircle(14, 111, 77, 0, 0, 0); // Inner circle to make bottom of U
    GPUDrawFilledRect(111-14, 77-30, 2*14+1, 30, 0, 0, 0); //Cover up top half of inner circle
    GPUDrawFilledRect(10+18,28,15,29,0,0,0);
    GPUDrawFilledRect(10+18,28,15,29,0,0,0);
    GPUDrawFilledRect(10+18,28,15,29,0,0,0);
    GPUDrawFilledRect(10+18,28,15,29,0,0,0);
    GPUDrawFilledRect(10+18,28,15,29,0,0,0);
    GPUDrawFilledRect(10+18,28,15,29,0,0,0);
    GPUDrawFilledRect(10+18,28,15,29,0,0,0);
    GPUDrawFilledRect(10+18,28,15,29,0,0,0);
    return 1;
}	  

