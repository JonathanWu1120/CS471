#include <stdio.h>

int  powR(int pow, int base) {
  if (0==pow) {
    return 1;
  } else {
    return base * powR(pow-1, base);
  }
}

