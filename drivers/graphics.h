#ifndef GRAPHICS_H
#define GRAPHICS_H
#include <stdint.h>
//Display size
#define DISP_WIDTH 680
#define DISP_HEIGHT 420

//Clear screen
/* WE DONT HAVE THIS BUT SHOULD */
void GPUClear(void);

//flush the current frame buffer
void GPUFlush(void);

//draw line
void GPUDrawLine(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2, 
                 uint8_t r, uint8_t g, uint8_t b);

//draw unfilled rectangle
void GPUDrawRectangleOutline(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2,
                             uint8_t r, uint8_t g, uint8_t b);

//draw filled rectangle

void GPUDrawFilledRectangle(uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2,
                            uint8_t r, uint8_t g, uint8_t b);

//draw an unfilled circle
void GPUDrawCircle(uint16_t radius, uint16_t x, uint16_t y,
                    uint8_t r, uint8_t g, uint8_t b);

//draw an arc
void GPUDrawArc(uint16_t radius, uint16_t x, uint16_t y, uint16_t lr_flag,
                uint8_t r, uint8_t g, uint8_t b);


#endif
