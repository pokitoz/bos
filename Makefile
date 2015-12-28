all: sub_make

run: sub_make
	qemu-system-i386 -monitor stdio -hda boot_sector.bin

sub_make:
	nasm boot_sector.asm -f bin -o boot_sector.bin

asm_hex:
	od -t x1 -A n boot_sector.bin

clean:
	rm *.bin
	
