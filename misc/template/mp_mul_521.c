#include <stdint.h>

uint64_t mp_mul_521(uint64_t c[18], uint64_t a[9], uint64_t b[9])
{
	c[0] = a[1] + b[2];
	return 0;
}

uint64_t mp_sqr_521(uint64_t c[18], uint64_t a[9])
{
	c[0] = a[1] + a[2];
	return 0;
}

