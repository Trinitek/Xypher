
%include "obj\loader.asm"

; The interrupt handler must be compiled with FASM
intHandler:
incbin "obj\interrupt.bin"

eof:
