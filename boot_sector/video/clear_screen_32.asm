; Author: Renan Cakirerk

[bits 32]

clear_screen_32:      
    mov cx, 2000 ; Word count of whole screen
    mov edx, VIDEO_MEMORY


    clear:
        mov ax, ' '   ; Fill screen with spaces
        mov ah, SCREEN_COLORS
        mov [edx], ax
        dec cx
        add edx, 2
        cmp cx, 0
        jnz clear

    ret