# Define directories
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

# Object files
OBJ_FILES = $(OBJ_DIR)/kernasm.o $(OBJ_DIR)/kernc.o

# Kernel binary
KERNEL_BIN = $(BIN_DIR)/kernel-001

# Linker script
LINKER_SCRIPT = $(SRC_DIR)/link.ld

# Targets
all: $(KERNEL_BIN)

$(OBJ_DIR)/kernasm.o: $(SRC_DIR)/kernel.asm
	mkdir -p $(OBJ_DIR)
	nasm -f elf32 $(SRC_DIR)/kernel.asm -o $(OBJ_DIR)/kernasm.o

$(OBJ_DIR)/kernc.o: $(SRC_DIR)/kernel.c
	mkdir -p $(OBJ_DIR)
	gcc -m32 -c $(SRC_DIR)/kernel.c -o $(OBJ_DIR)/kernc.o

$(KERNEL_BIN): $(OBJ_FILES)
	mkdir -p $(BIN_DIR)
	ld -m elf_i386 -T $(LINKER_SCRIPT) -o $(KERNEL_BIN) $(OBJ_FILES)

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

run: $(KERNEL_BIN)
	qemu-system-i386 -kernel $(KERNEL_BIN)

.PHONY: all clean run
