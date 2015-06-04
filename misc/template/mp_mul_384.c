#include <stdint.h>

#include "mp_mul_384.h"

uint64_t mp_mul_384(uint64_t c[12], uint64_t a[6], uint64_t b[6])
{
	c[0] = a[1] + b[2];
	return 0;
}

uint64_t mp_sqr_384(uint64_t c[12], uint64_t a[6])
{
	c[0] = a[1] + a[2];
	return 0;
}

