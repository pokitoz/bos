# bos
Basic OS

Boot loader
-> After reboot, the OS must be loaded from a permanent storage.
-> Use the BIOS: routines loaded into memory at start time. Autodetect essential devices (screen, disks, keyboard) to gain basic controls.
-> No file system: BIOS cannot load the OS as a file.
-> Can only read specific sector of 512bytes
-> The OS will be placed at the boot sector of a disk : Cylinder 0 Head 0 Sector 0
-> The others disks may not contain an OS and may be only used for storage. BIOS needs to know if the data can be executed or only for storage.
-> The CPU cannot make the difference between Data and instructions. Only bit sequence.
-> To make the difference the last 2 bytes of a boot sector must be set to 0xaa55
-> BIOS will check all storage devices, read the boot sector into memory and execute the first sector endding by this magic number.
-> nasm boot sect.asm -f bin -o boot sect.bin



Bochs and Qemu




Baremetal programming
Extend CPU functionalities
Configuration CPU
Use higher level languages
Device drivers
File System
-> Read write logical files from to disk
Multi process
