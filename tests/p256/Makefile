all: *.h *.c *.s
	gcc -Wall -O2 bn.c -lcrypto -o bn
	gcc -Wall -O2 mpn.c -lgmp -o mpn
	gcc -Wall -O2 self.c *.s -o self

clean:
	rm -f *.o mpn bn self
