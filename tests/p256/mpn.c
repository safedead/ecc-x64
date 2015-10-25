#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

#include <gmp.h>

char *Gx = "6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296";
char *Gy = "4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5";
char *P  = "ffffffff00000001000000000000000000000000ffffffffffffffffffffffff";

char *Sx = "de2444bebc8d36e682edd27e0f271508617519b3221a8fa0b77cab3989da97c9";
char *Sy = "c093ae7ff36e5380fc01a5aad1e66659702de80f53cec576b6350b243042a256";
char *Sz = "1";

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
	mpz_out_str(stdout, 16, c); fprintf(stdout, " c = a * b\n");
	mpz_out_str(stdout, 16, r); fprintf(stdout, " r = c mod p\n");

	//clear
	mpz_clear(a);	
	mpz_clear(b);	
	mpz_clear(c);	
	mpz_clear(p);	
	mpz_clear(r);	
}

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
	mpz_init_set_str(t1, Sx, 16);
	mpz_init_set_str(t2, Sy, 16);
	mpz_init_set_str(t3, Sz, 16);

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

int main(int argc, char *argv[])
{
	//base test
	mul_and_mod();

	//ec test
	ec_double();

	exit(EXIT_SUCCESS);
}

