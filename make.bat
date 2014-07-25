
smlrcw -flat16 loader.c obj\loader.asm
fasm interrupt.asm obj\interrupt.bin

nasm -f bin main.asm -o bin\xypher.bin

imdisk -a -f mikeos.img -m F:
copy bin\xypher.bin F:\
imdisk -D -m F:

dosbox -c "boot mikeos.img" -noconsole
