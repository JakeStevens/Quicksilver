#include <stdint.h>
#include <stdio.h>
#include "gpu.h"
#include "graphics.h"

#define GPU_BASE (volatile int *)0x80003000
#define GPU *(GPU_BASE + 1)

//INIT GPU?

//GPU CLEAR?
void GPUDrawRectangleOutline(uint16_t x1, uint16_t y1, uint16_t width, uint16_t height,
                             uint8_t r, uint8_t g, uint8_t b)
{
    GPUDrawLine(x1, y1, x1+(width-1), y1, r, g, b);
    GPUDrawLine(x1, y1, x1, y1+(width-1), r, g, b);
    GPUDrawLine(x1+(width-1), y1, x1+(width-1), y1+(width-1), r, g, b);
    GPUDrawLine(x1, y1+(width-1), x1+(width-1), y1+(width-1), r, g, b);
}

void GPUDrawFilledRect(uint16_t x, uint16_t y, 
                        uint16_t width, uint16_t height,
                        uint8_t r, uint8_t g, uint8_t b)
{
    GPUSetXY1(x,y);
    GPUSetXY2(x+(width-1), y+(height-1));
    GPUIssueInstruction(GPU_INST(GPU_CMD_DRAWRECT, GPU_INST_COLOR(r,g,b)));
}

void GPUDrawLine(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2,
                 uint8_t r, uint8_t g, uint8_t b)
{
    GPUSetXY1(x1,y1);
    GPUSetXY2(x2,y2);
    GPUIssueInstruction(GPU_INST(GPU_CMD_DRAWLINE, GPU_INST_COLOR(r,g,b)));
}

void GPUDrawCircle(uint16_t radius, uint16_t x, uint16_t y,
                   uint8_t r, uint8_t g, uint8_t b)
{
    GPUSetRad(radius);
    GPUSetXY1(x, y);
    GPUIssueInstruction(GPU_INST(GPU_CMD_DRAWCIRCLE, GPU_INST_COLOR(r,g,b)));
}

void GPUDrawArc(uint16_t radius, uint16_t x, uint16_t y, uint16_t lr_flag,
                uint8_t r, uint8_t g, uint8_t b)
{
    GPUSetRad(radius);
    GPUSetXY1(x, y);
    GPUIssueInstruction(GPU_INST(GPU_CMD_DRAWARC, GPU_INST_ARC(lr_flag, r,g,b)));
}

void GPUFlush(void)
{
    GPUIssueInstruction(GPU_INST(GPU_CMD_FLUSH,0));
}

inline void GPUIssueInstruction(uint32_t inst)
{
//    GPU = inst; //Write to address corresponding to GPU
    printf("Instruction is %x\n", inst);
}



inline void GPUSetXY1(uint16_t x, uint16_t y)
{
    GPUIssueInstruction(GPU_INST(GPU_CMD_SETXY1, GPU_INST_XY(x,y)));
}

inline void GPUSetXY2(uint16_t x, uint16_t y)
{
    GPUIssueInstruction(GPU_INST(GPU_CMD_SETXY2, GPU_INST_XY(x,y)));
}

inline void GPUSetRad(uint16_t rad)
{
    GPUIssueInstruction(GPU_INST(GPU_CMD_SETRAD, GPU_INST_RADIUS(rad)));
}

