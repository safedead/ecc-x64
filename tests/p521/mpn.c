#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

#include <gmp.h>

char *P521 = "1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
char *Gx = "c6858e06b70404e9cd9e3ecb662395b4429c648139053fb521f828af606b4d3dbaa14b5e77efe75928fe1dc127a2ffa8de3348b3c1856a429bf97e7e31c2e5bd66";
char *Gy = "11839296a789a3bc0045c8a5fb42c7d1bd998f54449579b446817afbd17273e662c97ee72995ef42640c550b9013fad0761353c7086a272c24088be94769fd16650";

int main(int argc, char *argv[])
{
	mpz_t	a, b, c, p, r;
	
	//init mpz_t
	mpz_init2(a, 576);
	mpz_init2(b, 576);
	mpz_init2(c, 1280);
	mpz_init2(p, 576);
	mpz_init2(r, 576);
        
	//input
	mpz_init_set_str(a, Gx, 16);
	mpz_init_set_str(b, Gy, 16);
	mpz_init_set_str(p, P521, 16);

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

