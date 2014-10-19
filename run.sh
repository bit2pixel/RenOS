gcc -c kernel/kernel.c -o kernel.o -ffreestanding -m32 &&

cd boot_sector &&

nasm -f bin boot_sector.asm -o boot_sector.bin &&

# The option -f elf tells the assembler to output an 
# object file of the particular format Executable and 
# Linking Format (ELF), which is the default format 
# output by out C compiler.
nasm jump_to_kernel.asm -f elf -o jump_to_kernel.o &&

mv boot_sector.bin ../ &&
mv jump_to_kernel.o ../ &&

cd .. &&

ld -m elf_i386 -o kernel.bin -Ttext 0x1000 jump_to_kernel.o kernel.o --oformat binary &&

cat boot_sector.bin kernel.bin > os-image &&
qemu-system-i386 -fda os-image
