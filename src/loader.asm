
;; Directives ;;
org     32768
include 'mikedevf.inc'

;; Global constants ;;
CR      equ 0x0D
LF      equ 0x0A

;; Macros ;;
macro return { ret }

macro os_printString reg {
    mov     si, reg
    call    os_print_string
}

macro os_print4hex reg {
    mov     ax, reg
    call    os_print_4hex
}

;; Entry point ;;
jmp     main

;; Global data ;;
greeting:
        db "===========================",CR,LF
        db "Xypher Windowing API Loader",CR,LF
        db "===========================",CR,LF
        db "Version 1.0",CR,LF
        db "Copyright (c) 2014 Blake Burgess",CR,LF,CR,LF,0
alreadyInstalled:
        db "Xypher is already in memory.",CR,LF,0
loaded:
        db "Xypher successfully loaded at segment 0x",0
hooked:
        db CR,LF,"Hooked into interrupt 0x45",CR,LF,0

;; Main program ;;
main:
    os_printString greeting

    checkIfInstalled:
        mov     ah, 0
        int     0x45
        cmp     al, 0x88
        je      .present
        jmp     .absent

        .present:
            os_printString alreadyInstalled
            return

        .absent:
            ; Load the interrupt handler at the next full segment
            push    es
            mov     dx, ds
            add     dx, 4096
            mov     es, dx      ; Keep handler segment in DX for next step
            xor     di, di
            mov     si, intHandler
            mov     cx, intHandler.end - intHandler
            rep     movsb

            os_printString loaded
            os_print4hex dx

            ; Hook into interrupt 0x45
            cli                 ; Disable interrupts
            xor     ax, ax
            mov     es, ax
            mov     di, 0x45*4  ; Offset to vector for interrupt 0x45
            stosw               ; Offset goes in first
            mov     ax, dx
            stosw               ; Segment goes in second
            sti                 ; Re-enable interrupts
            pop     es

            os_printString hooked

    return
