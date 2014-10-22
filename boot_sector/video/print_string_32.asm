; Author: Renan Cakirerk

[bits 32]

VIDEO_MEMORY equ 0xb8000
GREEN_ON_BLACK equ 0x0a

print_string_32:
	pusha
	mov edx, VIDEO_MEMORY

print_string_32_loop:
	mov al, [ebx]           ; store the char

	mov ah, SCREEN_COLORS	; store attributes

	cmp al, 0               ; end of the string
	je print_string_32_done

	mov [edx], ax           ; store char in character cell

	add ebx, 1              ; inc EBX to the next char
	add edx, 2				; move to next char cell in video VIDEO_MEMORY

	jmp print_string_32_loop

print_string_32_done:
	popa
	ret