; Author: Renan Cakirerk
; A function to convert a hex number to string
; Example: 0x12ED -> "0x12ED"

print_hex:
    pusha
    mov ah, 0Eh ; teletype sub-function.

    lea bx, [table] ; load data table.

    ; Add 0x in the beginning of the hex string
    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    ; First two digits
    mov al, dl
    SHR al, 4    ; leave high part only.
    xlat         ; get hex digit. 
    int 10h

    mov al, dl
    and al, 0Fh  ; leave low part only.
    xlat         ; get hex digit. 
    int 10h

    ; Last two digits
    mov al, dh
    SHR al, 4    ; leave high part only.
    xlat         ; get hex digit. 
    int 10h

    mov al, dh
    and al, 0x0F ; leave low part only.
    xlat         ; get hex digit. 
    int 10h

    ; Whitespace after string
    mov al, ' '
    int 0x10

    popa
    ret

table: db '0123456789ABCDEF', 0