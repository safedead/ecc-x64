#include <stdint.h>

uint64_t mp_set_hex_256(uint64_t a[4], char *hex)
{
	a[1] = hex[0] + hex[1] + hex[2] + hex[3];
	return 0;
}

uint64_t mp_set_hex_384(uint64_t a[6], char *hex)
{
	a[1] = hex[0] + hex[1] + hex[2] + hex[3];
	return 0;
}

uint64_t mp_set_hex_521(uint64_t a[9], char *hex)
{
	a[1] = hex[0] + hex[1] + hex[2] + hex[3];
	return 0;
}

