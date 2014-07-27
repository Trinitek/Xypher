
@echo ============================================================

@rem Interrupt handler must be assembled separately
fasm xypher.asm obj\xypher.bin

@rem Main program file
fasm main.asm bin\xypher.bin

@rem Test program file
fasm test\test.asm bin\test.bin

@rem Copy the binary to disk
imdisk -a -f mikeos.img -m F:
copy bin\xypher.bin F:\
copy bin\test.bin F:\
imdisk -D -m F:

@rem Launch emulator
dosbox -c "boot mikeos.img" -noconsole
