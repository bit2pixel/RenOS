; Author: Renan Cakirerk
; The bootloader

[bits 16]
[org 0x7c00] ; Start address

KERNEL_OFFSET equ 0x1000

start:
    mov [BOOT_DRIVE], dl        ; BIOS stores the boot device in dl
                                ; so we'll remember that

    mov bp, 0x9000              ; start stack from this address

    mov sp, bp

    mov bx, STR_INIT_16
    call print_string_16

    call load_kernel            ; load kernel

    mov bx, STR_LOADED_KERNEL
    call print_string_16

    call switch_to_32           ; switch to 32bit protected mode

    jmp $

; Includes
%include "video/clear_screen_32.asm"
%include "video/print_string_16.asm"
%include "video/print_string_32.asm"
%include "read_disk.asm"
%include "gdt.asm"
%include "switch_to_32.asm"
%include "load_kernel.asm"

[bits 32]
BEGIN_32:
    call clear_screen_32

    mov ebx, STR_INIT_32
    call print_string_32

    call clear_screen_32

    call KERNEL_OFFSET          ; jump to the address of the loaded kernel code

    jmp $

; Global variables
STR_INIT_16: db "Starting RenOS - REAL MODE", 10, 13, 0  ; here 10, 13 is CLRF
STR_INIT_32: db "WE ARE NOW IN 32-bit PROTECTED MODE! HELL YEAH!", 0
STR_LOADED_KERNEL: db "LOADED THE KERNEL", 10, 13, 0
BOOT_DRIVE: db 0
VIDEO_MEMORY equ 0xb8000
SCREEN_COLORS equ 0x1a

; Fill the rest of the instructions with 0
; until 510th byte. Then put the magic byte
; for BIOS to understand that this is a
; bootloader
times 510-($-$$) db 0
dw 0xaa55