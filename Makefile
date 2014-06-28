IMG=os.img
BOOT=boot.bin

all : boot.s
	make boot
	make img

os.img : $(BOOT)
	mformat -f 1440 -C -B $(BOOT) -i $(IMG) ::

boot.bin : boot.s boot.ld
	gcc boot.s -nostdlib -Tboot.ld -o $(BOOT)

run : $(IMG)
	qemu -m 32 -localtime -vga std -fda $(IMG)

install : $(IMG)
	@echo 'sudo dd if=os.img of=[Device File]'

clean :
	@rm -f boot.bin *~

src_only :
	make clean
	@rm -f os.img

boot :;  make boot.bin
img :;  make os.img
