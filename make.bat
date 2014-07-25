
smlrcw -flat16 loader.c obj\loader.asm
nasm -f bin main.asm -o bin\xypher.bin

imdisk -a -f mikeos.img -m F:
copy bin\xypher.bin F:\
imdisk -D -m F:
