#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>

#include "mp_mul_256.h"
#include "mp_mod_256.h"

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
	a[3] = 0x6b17d1f2e12c4247;
	a[2] = 0xf8bce6e563a440f2;
	a[1] = 0x77037d812deb33a0;
	a[0] = 0xf4a13945d898c296;

	b[3] = 0x4fe342e2fe1a7f9b;
	b[2] = 0x8ee7eb4a7c0f9e16;
	b[1] = 0x2bce33576b315ece;
	b[0] = 0xcbb6406837bf51f5;

	//process
	mp_mul_256(c, a, b);//c = a * b
	mp_mod_256v1(r, c);//r = c mod p
	
	//output
	hex_out(stdout, c, 8);
	hex_out(stdout, r, 4);

	exit(EXIT_SUCCESS);
}

