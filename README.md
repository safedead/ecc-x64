# ecc-x64
Elliptic Curve Cryptography in assembly for linux x64

## Caution
1. The pointer must be aligned on a 16-byte boundary or a general-protection exception (#GP) will be generated.
2. These assembly code can only use to build User-level applications, because Linux Kernel code is not allowed to change the x87 and SSE units. 

