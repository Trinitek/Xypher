
; Interrupt handler
;
; Must be compiled with FASM because it uses FASM's macro facilities

;; Directives ;;
org     0x0

;; Macros ;;
macro case interrupt {
    @@:
    cmp     ah, interrupt
    jne     @f
}

macro break {
    iret
}

;; Entry point ;;
jmp     parseIntNumber

;; Global data ;;

;; Main code ;;
parseIntNumber:
    ; Check installation
    ; RETURN:
    ; al = 88
    case 0x00
        mov     al, 0x88
        break

    ; Get version
    ; RETURN:
    ; al = version
    case 0x01
        mov     al, VERSION
        break

    ; Get resident segment
    ; RETURN:
    ; ax = Xypher segment
    case 0x02
        push    cs
        pop     ax
        break

    @@:
    break
