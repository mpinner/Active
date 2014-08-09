#include "spi.h"
#include "opc.h"

#define POST_TX_DELAY_USECS 1000
// I'm seeing flickering at speeds above ~6mhz. Although the 
// WS2801 datasheet lists a max rate of 25mhz, anecdotal evidence 
// from forum posts suggests that most people have had trouble 
// obtaining that in practice.
#define WS2801_DEFAULT_SPEED 4000000

// Different WS2801 strips expect different input color orderings.
typedef enum { RGB=0, GRB=1, BGR=2 } order_t;
#define DEFAULT_INPUT_ORDER RGB

static int spi_fd = -1;
static u8 spi_data_tx[1 << 16];
static u32 spi_speed_hz = WS2801_DEFAULT_SPEED;
static order_t rgb_order = DEFAULT_INPUT_ORDER;

void ws2801_put_pixels(int fd, u8 spi_data_tx[], u32 spi_speed_hz, 
                       u16 count, pixel* pixels, order_t order) {
  int i;
  pixel* p;
  u8* d;

  u16 lower = 0;

  fprintf(stderr, "count : %d \n", count);

  
  d = spi_data_tx;
  for (i = 0; i < count; i++) {

    int rib = i / 24;
    int position = 23 - (i % 24);
    int remappedPixel = (rib * 24) + position;
    p = &pixels[remappedPixel];
//    p = &pixels[i];
    u16 fullPixel = (p->r+p->r+p->r + p->g+p->g+p->g+p->g + p->b ) << 1;    
//    fprintf(stderr, "%d : %d, %d, %d \n", i, p->r, p->g, p->b);    
    fprintf(stderr, "%d -> (%d,%d) -> %d : %d, %d, %d \n", i, rib, position, remappedPixel, p->r, p->g, p->b);    
  
    //although this creates a 16 space the spi out at 12 bits truncates each data value

    *d++ = fullPixel;
    *d++ = fullPixel >> 8;
    


  }
  spi_transfer(fd, spi_speed_hz, spi_data_tx, 0, 
      d - spi_data_tx, POST_TX_DELAY_USECS);
}


void handler(u8 address, u16 count, pixel* pixels) {
  fprintf(stderr, "%d ", count);
  fflush(stderr);
  ws2801_put_pixels(spi_fd, spi_data_tx, spi_speed_hz, count, 
    pixels, rgb_order);
}

order_t get_order(int argc, char** argv) {
  order_t order = DEFAULT_INPUT_ORDER;
  if (argc > 3) {
    if (!strcmp(argv[3], "rgb")) {
      order = RGB;
    } else if (!strcmp(argv[3], "grb")) {
      order = GRB;
    } else if (!strcmp(argv[3], "bgr")) {
      order = BGR;
    } else {
      fprintf(stderr, "Did not recognize color order argument - using default\n");
    }
  }
  return order;
}

int main(int argc, char** argv) {
  u16 port = OPC_DEFAULT_PORT;

  get_speed_and_port(&spi_speed_hz, &port, argc, argv);
  rgb_order = get_order(argc, argv);
  spi_speed_hz = 4000000;
  spi_fd = init_spidev("/dev/spidev1.0", 4000000);

  if (spi_fd < 0) {
    return 1;
  }
  fprintf(stderr, "SPI speed: %.2f MHz, ready...\n", spi_speed_hz*1e-6);
  opc_source s = opc_new_source(port);
  while (s >= 0 && opc_receive(s, handler, TIMEOUT_MS));
  fprintf(stderr, "Exiting after %d ms of inactivity\n", TIMEOUT_MS);
}
