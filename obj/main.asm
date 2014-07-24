bits 16

org 32768
; glb main : (void) void
_main:
	push	bp
	mov	bp, sp
	jmp	L2
L1:
mov ah, 0x0E
mov al, 'A'
int 0x10
; Fused expression:    "0 "
	mov	ax, 0
L3:
	leave
	ret
L2:
	jmp	L1

; Syntax/declaration table/stack:
; Bytes used: 120/20736


; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_16__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Bytes used: 63/4096


; Identifier table:
; Ident main
; Ident <something>
; Bytes used: 19/4752

; Next label number: 5
; Compilation succeeded.
