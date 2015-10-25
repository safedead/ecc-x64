#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>

#include "mp_mul.h"
#include "mp_mod.h"
#include "ec_double.h"

void hex_out(FILE *fp, uint64_t data[], uint64_t size)
{
	uint64_t	i;

	for(i = 0; i < size; i++) fprintf(fp, "%016lx", data[size - i - 1]);
	return;
}

int main(int argc, char *argv[])
{
	uint64_t	a[4], b[4], c[8], r[4];
	uint64_t	R[12], S[12];

	//input
	a[3] = 0x6b17d1f2e12c4247;
	a[2] = 0xf8bce6e563a440f2;
	a[1] = 0x77037d812deb33a0;
	a[0] = 0xf4a13945d898c296;

	b[3] = 0x4fe342e2fe1a7f9b;
	b[2] = 0x8ee7eb4a7c0f9e16;
	b[1] = 0x2bce33576b315ece;
	b[0] = 0xcbb6406837bf51f5;

	S[3] = 0xde2444bebc8d36e6;
	S[2] = 0x82edd27e0f271508;
	S[1] = 0x617519b3221a8fa0;
	S[0] = 0xb77cab3989da97c9;

	S[7] = 0xc093ae7ff36e5380;
	S[6] = 0xfc01a5aad1e66659;
	S[5] = 0x702de80f53cec576;
	S[4] = 0xb6350b243042a256;

	S[11] = 0x0;
	S[10] = 0x0;
	S[9] = 0x0;
	S[8] = 0x1;

	//process
	mp_mul_256(c, a, b);//c = a * b
	mp_mod_256(r, c);//r = c mod p
	ec_double_256(R, S);
	
	//output
	hex_out(stdout, c, 8); fprintf(stdout, " c = a * b\n");
	hex_out(stdout, r, 4); fprintf(stdout, " r = c mod p\n");
	hex_out(stdout, R, 4); fprintf(stdout, " Rx\n");
	hex_out(stdout, R + 4, 4); fprintf(stdout, " Ry\n");
	hex_out(stdout, R + 8, 4); fprintf(stdout, " Rz\n");

	exit(EXIT_SUCCESS);
}

