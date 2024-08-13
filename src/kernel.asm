bits 32 ;nasm directive indicating 32 bit
	section .text 
	 ;multiboot spec
	 ;standard for loading x86 kernels
	 ;4 byte aligned, dd is 4 bytes (double word)
	 align 4
 	 dd 0x1BADB002 ;magic identifying boot header
	 dd 0x00 ;flags
	 dd - (0x1BADb002 + 0x00) ;checksum

	global start ;sets symbols from source as global
	extern kernelMain ;name of the function in C

	start:
	 cli ;clear (disable) interrupts
	 mov esp, stack_space ;set stack pointer
	 call kernelMain ; calls C func
	 hlt ;halts the CPU

	section .bss ;section for reserving unit'd mem
	 resb 8192 ;8kb of memory for the stack
	 stack_space:
