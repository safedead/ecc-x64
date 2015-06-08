#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>

#include "mp_mul.h"
#include "mp_mod.h"

void hex_out(FILE *fp, uint64_t data[], uint64_t size)
{
	uint64_t	i;

	for(i = 0; i < size; i++) fprintf(fp, "%016lx", data[size - i - 1]);
	fprintf(fp, "\n");
	return;
}

int main(int argc, char *argv[])
{
	uint64_t	a[4], b[4], c[8], r[4];

	//input
	a[3] = 0x32C4AE2C1F198119;
	a[2] = 0x5F9904466A39C994;
	a[1] = 0x8FE30BBFF2660BE1;
	a[0] = 0x715A4589334C74C7;

	b[3] = 0xBC3736A2F4F6779C;
	b[2] = 0x59BDCEE36B692153;
	b[1] = 0xD0A9877CC62A4740;
	b[0] = 0x02DF32E52139F0A0;

	//process
	mp_mul_256(c, a, b);//c = a * b
	mp_mod_sm2(r, c);//r = c mod p
	
	//output
	hex_out(stdout, c, 8);
	hex_out(stdout, r, 4);

	exit(EXIT_SUCCESS);
}

