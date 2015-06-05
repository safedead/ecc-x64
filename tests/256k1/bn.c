#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

#include <openssl/bn.h>

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
	BN_hex2bn(&a, "79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798");
	BN_hex2bn(&b, "483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8");
	BN_hex2bn(&p, "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F");

	//process
	BN_mul(c, a, b, ctx);//c = a * b
	BN_mod(r, c, p, ctx);//r = c mod p

	//output
	hex = BN_bn2hex(c);
	fprintf(stdout, "%s\r\n", hex);
	OPENSSL_free(hex);
	hex = BN_bn2hex(r);
	fprintf(stdout, "%s\r\n", hex);
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

