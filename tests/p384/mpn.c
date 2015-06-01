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
	mpz_init2(a, 384);
	mpz_init2(b, 384);
	mpz_init2(c, 768);
	mpz_init2(p, 384);
	mpz_init2(r, 384);
        
	//input
	mpz_init_set_str(a, "aa87ca22be8b05378eb1c71ef320ad746e1d3b628ba79b9859f741e082542a385502f25dbf55296c3a545e3872760aB7", 16);
	mpz_init_set_str(b, "3617de4a96262c6f5d9e98bf9292dc29f8f41dbd289a147ce9da3113b5f0b8c00a60b1ce1d7e819d7a431d7c90ea0e5F", 16);
	mpz_init_set_str(p, "fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff", 16);

	//process
	mpz_mul(c, a, b);//c = a *b
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

