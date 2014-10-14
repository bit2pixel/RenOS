; Author: Renan Cakirerk
; The bootloader

[org 0x7C00] ; Start address

start:
    mov bp, 0x8000 ; start stack from this address
    mov sp, bp

    mov bx, WELCOME_STRING
    call print

    ; DISK OPERATIONS EXAMPLE
    mov bx, 0x9000 ; load 5 sectors 0x0000:0x9000
    mov dh, 5
    mov dl, [BOOT_DRIVE]
    call read_disk

    mov dx, [0x9000] ; read what was loaded in the disk
    call print_hex

    mov dx, [0x9000 + 512] ; read the next
    call print_hex

    jmp $

; Includes
%include "print_string.asm"
%include "print_hex.asm"
%include "read_disk.asm"

; Global variables
WELCOME_STRING: db "Starting RenOS", 10, 13, 0
BOOT_DRIVE: db 0
HEX: db '0x0000', 0

; Fill the rest of the instructions with 0
; until 510th byte. Then put the magic byte
; for BIOS to understand that this is a
; bootloader
times 510-($-$$) db 0
dw 0xaa55

; test data for reading after the boot sector
times 256 dw 0xdada
times 256 dw 0xface