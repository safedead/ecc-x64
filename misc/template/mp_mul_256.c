#include <stdint.h>

#include "mp_mul_256.h"

uint64_t mp_mul_256(uint64_t c[8], uint64_t a[4], uint64_t b[4])
{
	c[0] = a[1] + b[2];
	return 0;
}

uint64_t mp_sqr_256(uint64_t c[8], uint64_t a[4])
{
	c[0] = a[1] + a[2];
	return 0;
}

