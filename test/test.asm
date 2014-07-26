
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

macro os_waitForKey { call os_wait_for_key }

macro os_printNewline { call os_print_newline }

macro os_intToString reg {
    ; RETURNS: ax = ptr to string
    mov     ax, reg
    call    os_int_to_string
}

;; Entry point ;;
jmp     main

;; Global data ;;
greeting:
        db "Xypher Windowing API Test Program",CR,LF,0
notInstalled:
        db "Not installed.",CR,LF,0
isInstalled:
        db "Installed.",CR,LF,0
version:
        db "Version: ",0
xypherSeg:
        db "Segment: 0x",0
fatalError:
        db "This is a fatal error.",0

;; Main program ;;
main:
    os_printString greeting

    checkIfInstalled:
        mov     ah, 0x00
        int     0x45
        cmp     al, 0x88
        je      .isInstalled

        .notInstalled:
            os_printString notInstalled
            return

        .isInstalled:
            os_printString isInstalled

    getVersion:
        os_printString version

        mov     ah, 0x01
        int     0x45

        ; Convert integer to string, then print
        mov     ah, 0x00
        os_intToString ax
        os_printString ax
        os_printNewline

    getSegment:
        os_printString xypherSeg

        mov     ah, 0x02
        int     0x45

        os_print4hex ax
        os_printNewline

        mov ax, fatalError
        call os_fatal_error

    return
