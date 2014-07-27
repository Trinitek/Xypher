
;
; Main source file for the Xypher Window API
;
; All Xypher-specific files are specified here as INCLUDEs
; and are then compiled to a flat binary, which is then
; imported directly with the loader in the file 'main.asm'.
;

;; Global constants ;;
VERSION             equ 1

SCREEN_WIDTH        equ 80
SCREEN_WIDTH_MAX    equ 79
SCREEN_HEIGHT       equ 25
SCREEN_HEIGHT_MAX   equ 24

; Interrupt handler
; Offset is specified as 0x0'
; This file must be first!
include 'interrupt.asm'

; Drawing functions
include 'draw.asm'

; Window functions
include 'window.asm'
