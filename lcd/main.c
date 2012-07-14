/*
* g15icon.c: simple icon printing application
* Compile with:
*  gcc -o g15icon g15icon.c -lg15render -lg15daemon_client
*/

#include <stdio.h>
#include <libg15render.h>
#include <g15daemon_client.h>

void drawIcon(struct g15canvas *c, unsigned char *icon, int x, int y, int w, int h)
{
  for (int i = 0; i < h; i++)
    for (int j = 0; j < w; j++)
      g15r_setPixel(c, x + j, y + i, icon[i * w + j]);

}


int main(int argc, char **argv)
{
    int screen = 0;
    struct g15canvas canvas;

    char icon8x8[] = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                      1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,
                      1,1,0,1,1,0,1,1,1,1,1,1,1,1,1,1,
                      1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,
                      1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,
                      1,1,1,0,0,1,1,1,1,1,1,0,1,0,0,1,
                      1,1,0,1,1,0,1,1,1,1,1,0,1,1,0,1,
                      1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,1,
                      1,1,0,1,1,0,1,1,1,1,1,1,1,1,1,1,
                      1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,
                      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                      1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
    
   
    screen = new_g15_screen(G15_G15RBUF);
   
    int i = 1;
    
    g15r_clearScreen(&canvas, G15_COLOR_BLACK);
    drawIcon(&canvas, icon8x8, 8, i + 8 % 99, 16, 16);
    g15_send(screen, (char*)canvas.buffer, G15_BUFFER_LEN);


   
    getchar();
   
    g15_close_screen(screen);
   
    return 0;
}
