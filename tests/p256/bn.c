#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

#include <openssl/bn.h>

char *Gx = "6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296";
char *Gy = "4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5";
char *P  = "ffffffff00000001000000000000000000000000ffffffffffffffffffffffff";

int main(int argc, char *argv[])
{
	BIGNUM	*a, *b, *c, *p, *r;
	BN_CTX	*ctx;
	char	*hex = NULL;
	
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
	hex = BN_bn2hex(c);
	fprintf(stdout, "%s\n", hex);
	OPENSSL_free(hex);
	hex = BN_bn2hex(r);
	fprintf(stdout, "%s\n", hex);
	OPENSSL_free(hex);

	//free
	BN_free(a);
	BN_free(b);
	BN_free(c);
	BN_free(p);
	BN_free(r);
	BN_CTX_free(ctx);
        
	exit(EXIT_SUCCESS);
}

