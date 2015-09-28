#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>

#include "mp_mul.h"

void hex_out(FILE *fp, uint64_t data[], uint64_t size)
{
	uint64_t	i;

	for(i = 0; i < size; i++) fprintf(fp, "%015lx", data[size - i - 1]);
	fprintf(fp, "\n");
	return;
}

int main(int argc, char *argv[])
{
	uint64_t	a[10], b[10], c[18];

	//input
	a[9] = 0x0;
	a[8] = 0x000000c6858e06b7;
	a[7] = 0x00404e9cd9e3ecb6;
	a[6] = 0x062395b4429c6481;
	a[5] = 0x039053fb521f828a;
	a[4] = 0x0f606b4d3dbaa14b;
	a[3] = 0x05e77efe75928fe1;
	a[2] = 0x0dc127a2ffa8de33;
	a[1] = 0x048b3c1856a429bf;
	a[0] = 0x097e7e31c2e5bd66;

	b[9] = 0x0;
	b[8] = 0x0000011839296a78;
	b[7] = 0x09a3bc0045c8a5fb;
	b[6] = 0x042c7d1bd998f544;
	b[5] = 0x049579b446817afb;
	b[4] = 0x0d17273e662c97ee;
	b[3] = 0x072995ef42640c55;
	b[2] = 0x00b9013fad076135;
	b[1] = 0x03c7086a272c2408;
	b[0] = 0x08be94769fd16650;

	//process
	mp_mul_521(c, a, b);//c = a * b
	
	//output
	hex_out(stdout, c, 18);

	exit(EXIT_SUCCESS);
}

