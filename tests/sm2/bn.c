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
	BN_hex2bn(&a, "32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7");
	BN_hex2bn(&b, "BC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0");
	BN_hex2bn(&p, "FFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF");


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

