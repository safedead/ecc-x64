#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

#include <gmp.h>

int main(int argc, char *argv[])
{
	mpz_t	a, b, c, p, r;
	
	//init mpz_t
	mpz_init2(a, 256);
	mpz_init2(b, 256);
	mpz_init2(c, 512);
	mpz_init2(p, 256);
	mpz_init2(r, 256);
        
	//input
	mpz_init_set_str(a, "6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296", 16);
	mpz_init_set_str(b, "4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5", 16);
	mpz_init_set_str(p, "ffffffff00000001000000000000000000000000ffffffffffffffffffffffff", 16);

	//process
	mpz_mul(c, a, b);//c = a * b
	mpz_mod(r, c, p);//r = c mod p

	//output
	mpz_out_str(stdout, 16, c);
	fprintf(stdout, "\r\n");
	mpz_out_str(stdout, 16, r);
	fprintf(stdout, "\r\n");

	//free
	mpz_clear(a);
	mpz_clear(b);
	mpz_clear(c);
	mpz_clear(p);
        
	exit(EXIT_SUCCESS);
}

