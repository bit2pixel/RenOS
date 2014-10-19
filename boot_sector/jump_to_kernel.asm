; Need to do this to ensure we jump to the main function
; otherwise we'll jump to the first instruction of kernel.c
; which might or might not be the beginning of the kernel
[bits 32]
[extern main]
call main      ; calls main in the kernel.c
jmp $