[bits 16]

load_kernel:
	mov bx, STR_LOADING_KERNEL
	call print_string_16

	mov bx, KERNEL_OFFSET       ; start from here
	mov dh, 15					; read 15 sectors (it's more than we need actually)
	mov dl, [BOOT_DRIVE]		; from this disk
	call read_disk

	ret

STR_LOADING_KERNEL: db "LOADING KERNEL!", 13, 10, 0
