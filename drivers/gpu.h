#ifndef GPU_H
#define GPU_H
#include <stdint.h>
#include "graphics.h"

//Instruction field sizes
#define GPU_CMD_WIDTH 4
#define GPU_PARAM_WIDTH 25

//Display sizes
#define DISP_X_WIDTH 10
#define DISP_Y_WIDTH 9

//Color bit widths
#define GPU_R_WIDTH 8
#define GPU_G_WIDTH 8
#define GPU_B_WIDTH 8

//Instruction set
#define GPU_CMD_RESET 0
#define GPU_CMD_SETXY1 1
#define GPU_CMD_SETXY2 2
#define GPU_CMD_SETRAD 3
#define GPU_CMD_DRAWLINE 4
#define GPU_CMD_DRAWRECT 5
#define GPU_CMD_DRAWCIRCLE 6
#define GPU_CMD_DRAWARC 7
#define GPU_CMD_FLUSH 8

//Instruction parameter field positions
//from LSB
#define GPU_POS_R (GPU_G_WIDTH + GPU_B_WIDTH ) //3 bits unused, one for LR
#define GPU_POS_G (GPU_B_WIDTH)
#define GPU_POS_B 0
#define GPU_POS_Y DISP_X_WIDTH
#define GPU_POS_X 0
#define GPU_POS_OCT (GPU_R_WIDTH + GPU_G_WIDTH + GPU_B_WIDTH)
#define GPU_POS_RAD 0

//Instruction Macros
#define GPU_INST(cmd,param) ((((uint32_t)cmd) << (GPU_PARAM_WIDTH + 3)) | param)
#define GPU_INST_PARAM(param, shift) ((uint32_t)param) << shift
#define GPU_INST_XY(x,y) (GPU_INST_PARAM(y, GPU_POS_Y) | \
                          GPU_INST_PARAM(x, GPU_POS_X))
#define GPU_INST_COLOR(r,g,b) (GPU_INST_PARAM((r & (2<<(GPU_R_WIDTH-1))-1), GPU_POS_R) | \
                               GPU_INST_PARAM((g & (2<<(GPU_G_WIDTH-1))-1), GPU_POS_G) | \
                               GPU_INST_PARAM((b & (2<<(GPU_B_WIDTH-1))-1), GPU_POS_B))

#define GPU_INST_ARC(oct,r,g,b) (GPU_INST_PARAM(oct, GPU_POS_OCT) | \
                                GPU_INST_PARAM((r & (2<<(GPU_R_WIDTH-1))-1), GPU_POS_R) | \
                                GPU_INST_PARAM((g & (2<<(GPU_G_WIDTH-1))-1), GPU_POS_G) | \
                                GPU_INST_PARAM((b & (2<<(GPU_B_WIDTH-1))-1), GPU_POS_B))

#define GPU_INST_RADIUS(r) GPU_INST_PARAM(r, GPU_POS_RAD)

//Issue instruction
inline void GPUIssueInstruction(uint32_t inst);

// set x1 y1
inline void GPUSetXY1(uint16_t x, uint16_t y);
//set x2 y2
inline void GPUSetXY2(uint16_t x, uint16_t y);
//set radius
inline void GPUSetRad(uint16_t rad);
#endif
