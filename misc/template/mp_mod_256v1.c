#include <stdint.h>

uint64_t mp_mod_256v1(uint64_t r[4], uint64_t a[8])
{
	r[0] = a[1] + a[2];
	return 0;
}

