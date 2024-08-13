# Hello Kernel!

Extremely minimal kernel, following [this blog post](https://computers-art.medium.com/writing-a-basic-kernel-6479a495b713).

## Notes

- A kernel is the program that sits between hardware resources and applications. It is responsible for handling different processes, all hardware (via drivers).
- It is loaded by a bootloader, which is loaded by the bios.

How is it loaded?
- Bios looks for bootable devices by checking the first 512 byte block (sector 0) of a device, which includes the Master Boot Record (MBR). If there is a magic number (0x55 and 0xAA) at the end of the sector, it is an MBR.
- There should also be a partition table in the first sector, describing the partition layout.
- The bios then looks for a partition marked as bootable in the MBR, and attempts to execute the first sector of the boot partition (starting from physical address 0x7c00) by copying it into RAM.
- The bootloader then loads the kernel into physical address 0x100000 (on x86 machines).
- All x86 processors begin in a 16-bit mode called real mode, but GRUB switches to 32-bit protected mode.

The bootloader:
- The bootloader is written in assembly, to fire the main kernel function.
- Additional comments in the file.

The kernel:
- This kernel simply displays a string and halts.
- The address 0xB8000 is where the text screen video memory resides for colour monitors.
- The kernel has a loop which clears the screen, followed by a loop which writes our string on the screen.
- The screen supports 25 lines of 80 ASCII characteres, each having 2 bytes of memory (the character and the attribute). 

Linking:
- NASM produces an object file from the ASM, and GCC produces an object file from the C. We need a linker to link them and generate a single executable file which we use as the kernel.
- The output format is elf32-i386, i.e., executable 32-bit linkable format.
- The entry point is defined as start, which is in the assembly.
- The layout of the executable is defined in SECTIONS, specifying 0x100000 as where the kernel code should start.
- The '.' represents the location counter, and the following lines in the linker script represent sections defined in the assembly.

Building:
```
make
```

Running in qemu:
```
make run
```
