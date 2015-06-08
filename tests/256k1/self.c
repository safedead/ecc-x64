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
	a[3] = 0x79BE667EF9DCBBAC;
	a[2] = 0x55A06295CE870B07;
	a[1] = 0x029BFCDB2DCE28D9;
	a[0] = 0x59F2815B16F81798;

	b[3] = 0x483ADA7726A3C465;
	b[2] = 0x5DA4FBFC0E1108A8;
	b[1] = 0xFD17B448A6855419;
	b[0] = 0x9C47D08FFB10D4B8;

	//process
	mp_mul_256(c, a, b);//c = a * b
	mp_mod_256k1(r, c);//r = c mod p
	
	//output
	hex_out(stdout, c, 8);
	hex_out(stdout, r, 4);

	exit(EXIT_SUCCESS);
}

