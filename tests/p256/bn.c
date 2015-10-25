#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

#include <openssl/bn.h>

char *Gx = "6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296";
char *Gy = "4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5";
char *P  = "ffffffff00000001000000000000000000000000ffffffffffffffffffffffff";

void hex_out(FILE *fp, uint64_t data[], uint64_t size)
{
	uint64_t	i;

	for(i = 0; i < size; i++) fprintf(fp, "%016lx", data[size - i - 1]);
	return;
}

void mul_and_mod(void)
{
	BIGNUM	*a, *b, *c, *p, *r;
	BN_CTX	*ctx;
	
	//init
	a = BN_new();
	b = BN_new();
	c = BN_new();
	p = BN_new();
	r = BN_new();
	ctx = BN_CTX_new();

	//input
	BN_hex2bn(&a, Gx);
	BN_hex2bn(&b, Gy);
	BN_hex2bn(&p, P);

	//process
	BN_mul(c, a, b, ctx);//c = a * b
	BN_mod(r, c, p, ctx);//r = c mod p
	//BN_mod_inverse(r, a, p, ctx);//r = a ^ (-1) mod p

	//output
	hex_out(stdout, c->d, c->top); fprintf(stdout, " c = a * b\n");
	hex_out(stdout, r->d, r->top); fprintf(stdout, " r = c mod p\n");

	//free
	BN_free(a);
	BN_free(b);
	BN_free(c);
	BN_free(p);
	BN_free(r);
	BN_CTX_free(ctx);
}
        
int main(int argc, char *argv[])
{
	//base test
	mul_and_mod();

	exit(EXIT_SUCCESS);
}

