
; Interrupt handler
;
; Must be compiled with FASM because it uses FASM's macro facilities

;; Directives ;;
org     0x0

;; Global constants ;;
version equ 1

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
userspaceSeg:
        dw 0
handlerSeg:
        dw 0

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
        mov     al, version
        break

    ; Initialize environment variables
    ; PARAM:
    ; bx = userspace segment
    ; cx = Xypher segment
    case 0x02
        mov     [userspaceSeg], bx
        mov     [handlerSeg], cx
        break

    ; Get environment variables
    ; PARAM:
    ; ax = userspace segment
    ; bx = Xypher segment
    case 0x03
        mov     ax, [userspaceSeg]
        mov     bx, [handlerSeg]
        break

    @@:
    break
