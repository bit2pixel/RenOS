; Author: Renan Cakirerk
; Print a string on the screen

[bits 16]

print_string_16:
    ; Put BIOS in tele-type output mode
    mov ah, 0x0e

    mov al, [bx]

    ; If end of the string, then return
    cmp al, 0
    je end_print_16

    ; Show the character
    int 0x10

    ; Increment the string pointer
    ; and call self again
    inc bx
    jmp print_string_16   

    ; Jump here when the string is terminated
    end_print_16:
        ; Restore accumulators
        ret
