
loader:
include 'loader.asm'

; Interrupt handler must be assembled separately
intHandler:
file 'obj\interrupt.bin'
.end:
