; Author: Renan Cakirerk
; Read a given number of sectors from the first cylinder and head

read_disk:
    push dx
    mov ah, 0x02 ; BIOS read sector
    mov al, dh   ; Read DH sectors
    mov ch, 0x00 ; cylinder 0
    mov dh, 0x00 ; head 0
    mov cl, 0x02 ; start reading from sector

    int 0x13 ; read the data
    jc disk_read_error ; jump to error if carry

    pop dx
    cmp dh, al ; jump to error if not couldn't read
               ; enough sectors
    jne disk_read_error
    ret
 
disk_read_error:
    mov bx, DISK_ERROR_MSG
    call print
    jmp $

DISK_ERROR_MSG : db "Error reading the disk!", 10, 13