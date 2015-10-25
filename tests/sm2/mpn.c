#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

#include <gmp.h>

char *P  = "FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF";
char *Gx = "32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7";
char *Gy = "BC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0";
char *Gz = "1";

void ec_double(void)
{
	mpz_t	c, p;
	mpz_t	t1, t2, t3, t4, t5;

	//init mpz_t
	mpz_init2(c, 512);
	mpz_init2(p, 256);

	mpz_init2(t1, 256);
	mpz_init2(t2, 256);
	mpz_init2(t3, 256);
	mpz_init2(t4, 256);
	mpz_init2(t5, 256);

	//input
	mpz_init_set_str(p , P , 16);
	mpz_init_set_str(t1, Gx, 16);
	mpz_init_set_str(t2, Gy, 16);
	mpz_init_set_str(t3, Gz, 16);

	//t4 = t3 ^ 2
	mpz_mul(c, t3, t3);
	mpz_mod(t4, c, p);

	//t5 = t1 - t4
	mpz_sub(t5, p, t4);
	mpz_add(c, t1, t5);
	mpz_mod(t5, c, p);

	//t4 = t1 + t4
	mpz_add(c, t1, t4);
	mpz_mod(t4, c, p);

	//t5 = t4 * t5
	mpz_mul(c, t4, t5);
	mpz_mod(t5, c, p);

	//t4 = t5 * 3
	mpz_mul_ui(c, t5, 3);
	mpz_mod(t4, c, p);

	//t3 = t3 * t2
	mpz_mul(c, t3, t2);
	mpz_mod(t3, c, p);

	//t3 = t3 * 2
	mpz_mul_ui(c, t3, 2);
	mpz_mod(t3, c, p);

	//t2 = t2 ^ 2
	mpz_mul(c, t2, t2);
	mpz_mod(t2, c, p);

	//t5 = t1 * t2
	mpz_mul(c, t1, t2);
	mpz_mod(t5, c, p);

	//t5 = t5 * 4
	mpz_mul_ui(c, t5, 4);
	mpz_mod(t5, c, p);

	//t1 = t4 ^ 2
	mpz_mul(c, t4, t4);
	mpz_mod(t1, c, p);

	//t1 = t1 - 2t5
	mpz_add(c, t1, p);
	mpz_add(c, c, p);
	mpz_sub(c, c, t5);
	mpz_sub(c, c, t5);
	mpz_mod(t1, c, p);

	//t2 = t2 ^ 2
	mpz_mul(c, t2, t2);
	mpz_mod(t2, c, p);

	//t2 = t2 * 8
	mpz_mul_ui(c, t2, 8);
	mpz_mod(t2, c, p);

	//t5 = t5 - t1
	mpz_add(c, t5, p);
	mpz_sub(c, c, t1);
	mpz_mod(t5, c, p);

	//t5 = t4 * t5
	mpz_mul(c, t4, t5);
	mpz_mod(t5, c, p);
	
	//t2 = t5 - t2
	mpz_add(c, t5, p);
	mpz_sub(c, c, t2);
	mpz_mod(t2, c, p);
	
	//output
	mpz_out_str(stdout, 16, t1); fprintf(stdout, " Rx\n");
	mpz_out_str(stdout, 16, t2); fprintf(stdout, " Ry\n");
	mpz_out_str(stdout, 16, t3); fprintf(stdout, " Rz\n");

	//clear
	mpz_clear(c);
	mpz_clear(p);
	mpz_clear(t1);
	mpz_clear(t2);
	mpz_clear(t3);
	mpz_clear(t4);
	mpz_clear(t5);
}

void mul_and_mod(void)
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
	mpz_out_str(stdout, 16, c); fprintf(stdout, " c = a *b\n");
	mpz_out_str(stdout, 16, r); fprintf(stdout, " r = c mod p\n");

	//free
	mpz_clear(a);
	mpz_clear(b);
	mpz_clear(c);
	mpz_clear(p);
	mpz_clear(r);
}

int main(int argc, char *argv[])
{
	//base test
	mul_and_mod();

	//ec test
	ec_double();

	exit(EXIT_SUCCESS);
}

