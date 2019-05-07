#include <stdio.h>

#include "main.h"


extern void SystemInit(void);
extern void initialise_monitor_handles(void);

void main() {

  SystemInit();
  initialise_monitor_handles();

  while(1) {
    // do something
    printf("hello world\n");
  }

}
