# bos
Basic OS

Boot loader
--> After reboot, the OS must be loaded from a permanent storage.
--> Use the BIOS: routines loaded into memory at start time. Autodetect essential devices (screen, disks, keyboard) to gain basic controls.
--> No file system: BIOS cannot load the OS as a file.
--> Can only read specific sector of 512bytes
--> The OS will be placed at the boot sector of a disk : Cylinder 0 Head 0 Sector 0
--> The others disks may not contain an OS and may be only used for storage. BIOS needs to know if the data can be executed or only for storage.
--> The CPU cannot make the difference between Data and instructions. Only bit sequence.
--> To make the difference the last 2 bytes of a boot sector must be set to 0xaa55
--> BIOS will check all storage devices, read the boot sector into memory and execute the first sector endding by this magic number.
--> nasm boot sect.asm -f bin -o boot sect.bin

16bits Real mode
--> CPU boots in 16bits real mode to stay backward compatible with older os
--> Instruction can only add 2 16bits numbers in one instruction
--> We want to have 32bits and next 64bits advanced modes.

Bochs and Qemu


Character on screen!
--> Use interrupt
--> int 0x10
--> BIOS adds some of its own ISRs to the interrupt vector
---> interrupt 0x10 causes the screen-related ISR to be invoked
---> interrupt 0x13, the disk-related I/O ISR.

x86 CPUs have four general purpose registers: ax, bx, cx, and dx
that can be usedin particular routines


BIOS always load the boot sector to the address 0x7c00


Too small numbr of registers, need to use the stack
pop, push
The stack is implemented by two special CPU registers, bp and sp, which maintain
the addresses of the stack base (i.e. the stack bottom) and the stack top respectively.


CPU has cs, ds, ss, and es called segment registers.



Baremetal programming
Extend CPU functionalities
Configuration CPU
Use higher level languages
Device drivers
File System
-> Read write logical files from to disk
Multi process
