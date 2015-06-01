# ecc-x64
Elliptic Curve Cryptography in assembly for linux x64

## Calling Conventions
1. User-level applications use as integer registers for passing the sequence
%rdi, %rsi, %rdx, %rcx, %r8 and %r9. 
2. Linux Kernel code is not allowed to change the x87 and SSE units. 
