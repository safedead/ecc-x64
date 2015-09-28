#include <stdint.h>

uint64_t mp_mod_384(uint64_t r[6], uint64_t a[12])
{
	r[0] = a[1] + a[2];
	return 0;
}

