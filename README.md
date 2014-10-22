![alt tag](https://raw.github.com/bit2pixel/renos/master/renos.png)

RenOS
=====

Can I make a basic operating system?

## Bootloader

Install qemu (Mac OS)
	
	brew install https://raw.github.com/Homebrew/homebrew-dupes/master/apple-gcc42.rb
	brew install qemu --env=std --cc=gcc-4.2

Assemble
	
	nasm -f bin boot_sector.asm -o boot_sector.bin

Run on Qemu
	
	qemu-system-i386 -fda boot_sector.bin

Checkout the machine code of the assembled boot sector with

	od -t x1 -A n boot_sector.bin


## Kernel

To be continued...
