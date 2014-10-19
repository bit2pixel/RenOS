; Author: Renan Cakirerk
; The bootloader

[bits 16]
[org 0x7c00] ; Start address

start:
    mov bp, 0x9000 ; start stack from this address
    mov sp, bp

    mov bx, STR_INIT_16
    call print_string_16


    call switch_to_32

    ; DISK OPERATIONS EXAMPLE
    ; mov bx, 0x9000 ; load 5 sectors 0x0000:0x9000
    ; mov dh, 5
    ; mov dl, [BOOT_DRIVE]
    ; call read_disk

    ; mov dx, [0x9000] ; read what was loaded in the disk
    ; call print_hex

    ; mov dx, [0x9000 + 512] ; read the next
    ; call print_hex

    jmp $

; Includes
%include "video/clear_screen_32.asm"
%include "video/print_string_16.asm"
; %include "video/print_hex_16.asm"
%include "gdt.asm"
%include "video/print_string_32.asm"
%include "switch_to_32.asm"
; %include "read_disk.asm"

[bits 32]
BEGIN_32:
    mov ebx, STR_INIT_32
    call clear_screen_32
    call print_string_32
    jmp $

; Global variables
STR_INIT_16: db "Starting RenOS - REAL MODE", 10, 13, 0  ; here 10, 13 is CLRF
STR_INIT_32: db "WE ARE NOW IN 32-bit PROTECTED MODE! HELL YEAH!", 0
BOOT_DRIVE: db 0

; Fill the rest of the instructions with 0
; until 510th byte. Then put the magic byte
; for BIOS to understand that this is a
; bootloader
times 510-($-$$) db 0
dw 0xaa55

; test data for reading after the boot sector
; times 256 dw 0xdada
; times 256 dw 0xface