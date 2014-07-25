
@rem Interrupt handler must be assembled separately
fasm interrupt.asm obj\interrupt.bin

@rem Main program file
fasm main.asm bin\xypher.bin

@rem Copy the binary to disk
imdisk -a -f mikeos.img -m F:
copy bin\xypher.bin F:\
imdisk -D -m F:

@rem Launch emulator
dosbox -c "boot mikeos.img" -noconsole
