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
	uint64_t	a[6], b[6], c[12], r[6];

	//input
	a[5] = 0xaa87ca22be8b0537;
	a[4] = 0x8eb1c71ef320ad74;
	a[3] = 0x6e1d3b628ba79b98;
	a[2] = 0x59f741e082542a38;
	a[1] = 0x5502f25dbf55296c;
	a[0] = 0x3a545e3872760aB7;
	
	b[5] = 0x3617de4a96262c6f;
	b[4] = 0x5d9e98bf9292dc29;
	b[3] = 0xf8f41dbd289a147c;
	b[2] = 0xe9da3113b5f0b8c0;
	b[1] = 0x0a60b1ce1d7e819d;
	b[0] = 0x7a431d7c90ea0e5F;

	//process
	mp_mul_384(c, a, b);//c = a * b
	mp_mod_384(r, c);//r = c mod p
	
	//output
	hex_out(stdout, c, 12);
	hex_out(stdout, r, 6);

	exit(EXIT_SUCCESS);
}

