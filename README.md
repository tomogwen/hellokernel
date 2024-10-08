# Hello Kernel!

Extremely minimal kernel, following [this blog post](https://computers-art.medium.com/writing-a-basic-kernel-6479a495b713).

## Building and Running

Requires `make`, `nasm`, `gcc`, `ld`, `qemu-system-i386`.

Building:
```
make
```

Running:
```
make run
```
## Notes

- The [kernel](https://en.wikipedia.org/wiki/Kernel_(operating_system)) is loaded by a [bootloader](https://en.wikipedia.org/wiki/Bootloader), which is loaded by the [bios](https://en.wikipedia.org/wiki/BIOS).

How is the kernel loaded?
- Bios looks for bootable devices by checking the first 512 byte block (sector 0) of a device. A magic number (0x55 and 0xAA) at the end of the sector indicates there is a Master Boot Record (MBR).
- There should also be a partition table in the first sector, describing the partition layout.
- The bios then looks for a partition marked as bootable in the MBR, and attempts to execute the first sector of the boot partition (starting from physical address 0x7c00). This should be your bootloader, e.g., [GRUB](https://en.wikipedia.org/wiki/GNU_GRUB).
- The bootloader then finds the kernel (via the multiboot header - see kernel.asm), loads the kernel into physical address 0x100000 (on x86 machines), and executes it.
- All x86 processors begin in a 16-bit mode called real mode, but GRUB switches to 32-bit protected mode

Assembly:
- The initial bit of the kernel is written in assembly, which calls the main C function.

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

