
; Interrupt handler
;
; Must be compiled with FASM because it uses FASM's macro facilities

org     0x0

version equ 1

macro case interrupt {
    @@:
    cmp     ah, interrupt
    jne     @f
}

macro break {
    iret
}

case 0x00
    mov     al, 0x88
    break

case 0x01
    mov     al, version
    break

@@:
break
