# ecc-x64
Elliptic Curve Cryptography in assembly for linux x64

## System Requirement
1. A computer which has been installed Linux x64. The CPU must support SSE4_1 and SSE4_2.
2. To complie all assemly code, GCC version should >= 4.4.
3. To compile all program in tests/, you need to install OpenSSL and GNU MP Library.

## Caution
1. The pointer must be aligned on a 16-byte boundary or a general-protection exception (#GP) will be generated.
2. These assembly code can only use to build User-level applications, because Linux Kernel code is not allowed to change the x87 and SSE units. 

