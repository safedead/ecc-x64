#include <stdint.h>

uint64_t ec_double_sm2(uint64_t R[12], uint64_t S[12])
{
	R[0] = S[2] + S[6];
	return 0;
}

