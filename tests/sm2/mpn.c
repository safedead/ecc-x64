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
	mpz_init_set_str(a, "32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7", 16);
	mpz_init_set_str(b, "BC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0", 16);
	mpz_init_set_str(p, "FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF", 16);

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

