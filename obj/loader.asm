bits 16

org 32768
jmp _main
; glb greeting : [0u] char
_greeting:
; =
; RPN'ized expression: "L1 "
; Expanded expression: "L1 "
L1:
	db	"Xypher Window Library loader version 1.0",13,10,"Copyright (c) 2014 Blake Burgess",13,10,0
; glb main : (void) void
_main:
	push	bp
	mov	bp, sp
	jmp	L4
L3:
; RPN'ized expression: "( greeting &u os_printString ) "
; Expanded expression: " greeting  os_printString ()2 "
; Fused expression:    "( greeting , os_printString )2 "
	push	_greeting
	call	_os_printString
	sub	sp, -2
; Fused expression:    "0 "
	mov	ax, 0
L5:
	leave
	ret
L4:
	jmp	L3
%include 'mikedev.inc'
; glb os_printString : (
; prm     stringPtr : * char
;     ) void
_os_printString:
	push	bp
	mov	bp, sp
	jmp	L8
L7:
; loc     stringPtr : (@4): * char
mov si, [bp + 4]
call os_print_string
L9:
	leave
	ret
L8:
	jmp	L7

; Syntax/declaration table/stack:
; Bytes used: 216/20736


; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_16__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Bytes used: 63/4096


; Identifier table:
; Ident greeting
; Ident main
; Ident <something>
; Ident os_printString
; Ident stringPtr
; Bytes used: 56/4752

; Next label number: 11
; Compilation succeeded.
