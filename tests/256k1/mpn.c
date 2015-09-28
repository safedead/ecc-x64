#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

#include <gmp.h>

char *Gx = "79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798";
char *Gy = "483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8";
char *P  = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F";

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
	mpz_init_set_str(a, Gx, 16);
	mpz_init_set_str(b, Gy, 16);
	mpz_init_set_str(p, P , 16);

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

