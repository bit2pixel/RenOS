; Author: Renan Cakirerk
; Print a string on the screen

print:
    ; Put BIOS in tele-type output mode
    mov ah, 0x0e

    mov al, [bx]

    ; If end of the string, then return
    cmp al, 0
    je end_print

    ; Show the character
    int 0x10

    ; Increment the string pointer
    ; and call self again
    inc bx
    jmp print   

    ; Jump here when the string is terminated
    end_print:
        ; Restore accumulators
        ret
