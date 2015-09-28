#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

#include <openssl/bn.h>

char *P521 = "1ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
char *Gx = "c6858e06b70404e9cd9e3ecb662395b4429c648139053fb521f828af606b4d3dbaa14b5e77efe75928fe1dc127a2ffa8de3348b3c1856a429bf97e7e31c2e5bd66";
char *Gy = "11839296a789a3bc0045c8a5fb42c7d1bd998f54449579b446817afbd17273e662c97ee72995ef42640c550b9013fad0761353c7086a272c24088be94769fd16650";

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
	BN_hex2bn(&p, P521);

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

