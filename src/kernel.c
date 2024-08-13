void kernelMain(void) {
	const char *string = "Hello Kernel!";
	char *videomemptr = (char*)0xb8000; //points to video memory
	unsigned int i = 0;
	unsigned int j = 0;

	// loop clears the screen by writing blank char
	// the memory mapped supports 25 lines with 80 ascii char w/ 2 bytes of memory each
	while(j < 80 * 25 * 2) {
		videomemptr[j] = ' ';
		videomemptr[j+1] = 0x02; // attribute byte 0 - blank background
		j = j+2;
	}

	j = 0;
	// loop to write the string to video memory
	while(string[j] != '\0') {
		videomemptr[i] = string[j];
		videomemptr[i+1] = 0x02; // attribute byte for green
		++j;
		i = i+2;
	}
	return;
}

