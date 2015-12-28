all: run

run: sub_make
	qemu-system-i386 -monitor stdio -hda boot_sector.bin

sub_make:
	nasm boot_sector.asm -f bin -o boot_sector.bin

clean:
	rm *.bin
	
