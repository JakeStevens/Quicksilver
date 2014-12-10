#include "gpu.c"

#define ANIMATION_FRAMES  32
#define HEIGHT            640
#define WIDTH             480
#define COLOR1            0x8c6000
#define COLOR2            0xc5991d
#define FONTSIZE          9

#define SPLITCOLOR(color) (color & 0xFF0000) >> 16, (color & 0x00FF00) >> 8, (color & 0x0000FF)

inline uint32_t fadeColor(uint32_t color1, uint32_t color2, uint8_t step, uint8_t numSteps);
inline void drawQ(uint16_t x, uint16_t y, uint32_t color);
inline void drawU(uint16_t x, uint16_t y, uint32_t color);
inline void drawI(uint16_t x, uint16_t y, uint32_t color);
inline void drawC(uint16_t x, uint16_t y, uint32_t color);
inline void drawK(uint16_t x, uint16_t y, uint32_t color);
inline void drawS(uint16_t x, uint16_t y, uint32_t color);
inline void drawL(uint16_t x, uint16_t y, uint32_t color);
inline void drawV(uint16_t x, uint16_t y, uint32_t color);
inline void drawE(uint16_t x, uint16_t y, uint32_t color);
inline void drawR(uint16_t x, uint16_t y, uint32_t color);
inline void drawQuicksilverLogo(uint16_t x, uint16_t y, uint32_t color);
inline void drawPurdueP(uint16_t x, uint16_t y);
inline void drawTM(uint16_t x, uint16_t y, uint32_t color);

int main(void) {
    // each frame in the sequence
    
    uint32_t tempColor;
    uint8_t i;
    uint8_t j;
    
    for(i = 0; i < ANIMATION_FRAMES; i++) {
    
      // Draw gradient background
      for(j = 0; j < ANIMATION_FRAMES; j++) {
        tempColor = fadeColor(COLOR1, COLOR2, j, ANIMATION_FRAMES);
        GPUDrawFilledRect(0, 0 + j*15, WIDTH, 15, SPLITCOLOR(tempColor));
      }
      
      // Draw quicksilver text
      drawQ(129,282, 0x000000);
      drawU(174,282, 0x000000);
      drawI(219,282, 0x000000);
      drawC(255,282, 0x000000);
      drawK(300,282, 0x000000);
      drawS(345,282, 0x000000);
      drawI(390,282, 0x000000);
      drawL(426,282, 0x000000);
      drawV(462,282, 0x000000);
      drawE(516,282, 0x000000);
      drawR(552,282, 0x000000);
      
      drawQuicksilverLogo(40,291, 0x000000);
      
      drawPurdueP(221, 64);
      
      break;
    }
    
    return 1;
}

// Fades from color 1 to color 2
inline uint32_t fadeColor(uint32_t color1, uint32_t color2, uint8_t step, uint8_t numSteps) {
  uint8_t red   = (step == numSteps ? color2 : ((((color2 & 0xFF0000) - (color1 & 0xFF0000)) >> 16) / numSteps * step) + (color1 & 0xFF0000));
  uint8_t green = (step == numSteps ? color2 : ((((color2 & 0x00FF00) - (color1 & 0x00FF00)) >> 8) / numSteps * step) + (color1 & 0x00FF00));
  uint8_t blue  = (step == numSteps ? color2 : (((color2 & 0x0000FF) - (color1 & 0x0000FF)) / numSteps * step) + (color1 & 0x0000FF));
  return red << 16 | green << 8 | blue;
}

inline void drawQ(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawU(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawI(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawC(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawK(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 5, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawS(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawL(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  4 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  4 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  4 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawV(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  4 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  4 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawE(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawR(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  0 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 0, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 1, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  1 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 2, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  2 , y + FONTSIZE * 3, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
  GPUDrawFilledRect(x + FONTSIZE *  3 , y + FONTSIZE * 4, FONTSIZE, FONTSIZE, SPLITCOLOR(color));
}

inline void drawQuicksilverLogo(uint16_t x, uint16_t y, uint32_t color) {
  GPUDrawFilledRect(x + 6, y + 10, 39, 13, SPLITCOLOR(color));
  GPUDrawCircle(6, x + 7, y + 16, SPLITCOLOR(color));
  GPUDrawCircle(15, x + 60, y + 16, SPLITCOLOR(color));
  
  uint32_t bgColor = fadeColor(COLOR1, COLOR2, (y + 9) / 15, ANIMATION_FRAMES);
  GPUDrawFilledRect(x + 57, y + 9, 20, 15, SPLITCOLOR(bgColor));
}

inline void drawPurdueP(uint16_t x, uint16_t y) {

  const uint32_t silverColor = 0xa3a6a5;
  const uint32_t goldColor = 0x846c30;
  
  // draw black P
  GPUDrawFilledRect(x, y, 26, 62, SPLITCOLOR(0x000000));
  GPUDrawFilledRect(x, y + 93, 26, 62, SPLITCOLOR(0x000000));
  GPUDrawFilledRect(x + 26, y, 121, 155, SPLITCOLOR(0x000000));
  GPUDrawFilledRect(x + 147, y, 26, 113, SPLITCOLOR(0x000000));
  GPUDrawCircle(56, x + 170, y + 56, SPLITCOLOR(0x000000));
  
  // draw grey outline
  GPUDrawFilledRect(x + 17, y + 16, 28, 29, SPLITCOLOR(silverColor));
  GPUDrawFilledRect(x + 17, y + 110, 28, 28, SPLITCOLOR(silverColor));
  GPUDrawFilledRect(x + 100, y + 110, 29, 28, SPLITCOLOR(silverColor));
  GPUDrawFilledRect(x + 45, y + 95, 55, 43, SPLITCOLOR(silverColor));
  GPUDrawFilledRect(x + 45, y + 16, 125, 79, SPLITCOLOR(silverColor));
  GPUDrawCircle(40, x + 170, y + 56, SPLITCOLOR(silverColor));
  
  // draw yellow
  GPUDrawFilledRect(x + 19, y + 18, 28, 25, SPLITCOLOR(goldColor));
  GPUDrawFilledRect(x + 19, y + 112, 28, 24, SPLITCOLOR(goldColor));
  GPUDrawFilledRect(x + 98, y + 112, 29, 24, SPLITCOLOR(goldColor));
  GPUDrawFilledRect(x + 47, y + 93, 51, 43, SPLITCOLOR(goldColor));
  GPUDrawFilledRect(x + 47, y + 18, 123, 75, SPLITCOLOR(goldColor));
  GPUDrawCircle(37, x + 169, y + 55, SPLITCOLOR(goldColor));
  
  // draw inside grey
  GPUDrawFilledRect(x + 98, y + 43, 52, 25, SPLITCOLOR(silverColor));
  GPUDrawCircle(12, x + 137, y + 43, SPLITCOLOR(silverColor));
  
  // draw inside black
  GPUDrawFilledRect(x + 100, y + 45, 50, 21, SPLITCOLOR(0x000000));
  GPUDrawCircle(10, x + 139, y + 45, SPLITCOLOR(0x000000));
  
  drawTM(x + 157, y + 153, 0x000000);
}

inline void drawTM(uint16_t x, uint16_t y, uint32_t color) {
  // T
  GPUDrawLine(x, y, x + 6, y, SPLITCOLOR(color));
  GPUDrawLine(x + 3, y, x + 3, y + 8, SPLITCOLOR(color));
  
  // M
  GPUDrawLine(x + 9, y, x + 9, y + 8, SPLITCOLOR(color));
  GPUDrawLine(x + 10, y, x + 13, y + 8, SPLITCOLOR(color));
  GPUDrawLine(x + 18, y, x + 18, y + 8, SPLITCOLOR(color));
  GPUDrawLine(x + 17, y, x + 14, y + 8, SPLITCOLOR(color));
}
  
