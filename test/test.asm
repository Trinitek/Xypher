
;; Directives ;;
org     32768
include 'src\mikedevf.inc'

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

macro os_clearScreen { call os_clear_screen }

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
testString:
        db "TEST",0

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

    displayFilledBoxes:
        os_waitForKey

        ; Plot 10x6 box at (1,2) with color (black on l_gray)
        mov     ah, 0x03
        mov     al, 0x70
        mov     bh, 10
        mov     bl, 6
        mov     ch, 1
        mov     cl, 2
        int     0x45
        os_printString testString

        ; Plot 20x15 box at (40,23) with color (white on red)
        ; The lower half of the box should clip off the bottom of the screen
        mov     ah, 0x03
        mov     al, 0x4F
        mov     bh, 20
        mov     bl, 15
        mov     ch, 40
        mov     cl, 23
        int     0x45
        os_printString testString

        ; Plot 20x15 box at (65,8) with color (white on blue)
        ; The right half of the box should clip off the side of the screen
        mov     ah, 0x03
        mov     al, 0x1F
        mov     bh, 20
        mov     bl, 15
        mov     ch, 65
        mov     cl, 8
        int     0x45
        os_printString testString

        ; Plot 30x10 box at (25,5) with color (black on yellow)
        mov     ah, 0x03
        mov     al, 0xE0
        mov     bh, 30
        mov     bl, 10
        mov     ch, 25
        mov     cl, 5
        int     0x45
        os_printString testString

        ; Plot a 4x2 box at (0,0) with color (black on aqua)
        mov     ah, 0x03
        mov     al, 0xB0
        mov     bh, 4
        mov     bl, 2
        mov     ch, 0
        mov     cl, 0
        int     0x45
        os_printString testString
        
        os_waitForKey
        os_clearScreen
    
    .displayHorizontalLines:
        ; Plot a 40 long horizontal line at (1,2) with color (black on l_gray)
        mov     ah, 0x04
        mov     al, 0x70
        mov     dl, 1
        mov     dh, 2
        mov     cl, 40
        int     0x45
        os_printString testString
        
        ; Plot a 10 long horizontal line at (45, 18) with color (white on red)
        mov     ah, 0x04
        mov     al, 0x4F
        mov     dl, 45
        mov     dh, 18
        mov     cl, 10
        int     0x45
        os_printString testString
        
        ; Plot a 15 long horizontal line at (72, 15) with color (white on blue)
        mov     ah, 0x04
        mov     al, 0x1F
        mov     dl, 72
        mov     dh, 15
        mov     cl, 15
        int     0x45
        os_printString testString
        
        ; Plot a 4 long horizontal line at (0, 0) with color (black on yellow)
        mov     ah, 0x04
        mov     al, 0xE0
        mov     dl, 0
        mov     dh, 0
        mov     cl, 4
        int     0x45
        os_printString testString
        
        os_waitForKey
        os_clearScreen
    
    .displayVerticalLines:
        ; Plot a 40 long vertical line at (1,2) with color (black on l_gray)
        mov     ah, 0x05
        mov     al, 0x70
        mov     dl, 1
        mov     dh, 2
        mov     cl, 40
        int     0x45
        os_printString testString
        
        ; Plot a 10 long vertical line at (45, 18) with color (white on red)
        mov     ah, 0x05
        mov     al, 0x4F
        mov     dl, 45
        mov     dh, 18
        mov     cl, 10
        int     0x45
        os_printString testString
        
        ; Plot a 15 long vertical line at (72, 15) with color (white on blue)
        mov     ah, 0x05
        mov     al, 0x1F
        mov     dl, 72
        mov     dh, 15
        mov     cl, 15
        int     0x45
        os_printString testString
        
        ; Plot a 4 long vertical line at (0, 0) with color (black on yellow)
        mov     ah, 0x05
        mov     al, 0xE0
        mov     dl, 0
        mov     dh, 0
        mov     cl, 4
        int     0x45
        os_printString testString
    
        os_waitForKey
        os_clearScreen

    return
