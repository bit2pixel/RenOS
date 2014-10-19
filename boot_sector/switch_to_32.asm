; Author: Renan Cakirerk

[bits 16]
switch_to_32:
	cli                           ; turn off interrupts permanetly
	lgdt [gdt_descriptor]

	mov eax, cr0                  ; set set the lowest bit of CR0 (control 0)
	or eax, 0x1                   ; to make a switch to protected mode
	mov cr0, eax

								  ; SWITCH TO 32 bit !
	jmp CODE_SEG:init_32          ; make a far jump to the 32bit code

[bits 32]
init_32:
	mov ax, DATA_SEG              ; old segments are meaningless
	mov ds, ax                    ; so we point them to the DATA_SEG
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000              ; update stack position to top of free space
	mov esp, ebp

	call BEGIN_32