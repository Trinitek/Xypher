bits 16

%define CR 0x0D
%define LF 0x0A
org 32768
jmp _main
; glb greeting : char
_greeting:
	times	1 db 0
db '===========================',CR,LF
db 'Xypher Windowing API Loader',CR,LF
db '===========================',CR,LF
db 'Version 1.0',CR,LF
db 'Copyright (c) 2014 Blake Burgess',CR,LF,CR,LF,0
; glb alreadyInstalled : [0u] char
_alreadyInstalled:
; =
; RPN'ized expression: "L1 "
; Expanded expression: "L1 "
L1:
	db	"Xypher is already in memory.",13,10,0
; glb loaded : [0u] char
_loaded:
; =
; RPN'ized expression: "L3 "
; Expanded expression: "L3 "
L3:
	db	"Xypher successfully loaded at segment 0x",0
; glb hooked : [0u] char
_hooked:
; =
; RPN'ized expression: "L5 "
; Expanded expression: "L5 "
L5:
	db	13,10,"Hooked into interrupt 0x45.",13,10,0
; glb main : (void) void
_main:
	push	bp
	mov	bp, sp
	jmp	L8
L7:
; RPN'ized expression: "( greeting &u 1 + os_printString ) "
; Expanded expression: " greeting 1 +  os_printString ()2 "
; Fused expression:    "( + greeting 1 , os_printString )2 "
	mov	ax, _greeting
	inc	ax
	push	ax
	call	_os_printString
	sub	sp, -2
checkIfInstalled:
mov ah, 0x00
int 0x45
cmp al, 0x88
je .present
jmp .absent
.present:
; RPN'ized expression: "( alreadyInstalled &u os_printString ) "
; Expanded expression: " alreadyInstalled  os_printString ()2 "
; Fused expression:    "( alreadyInstalled , os_printString )2 "
	push	_alreadyInstalled
	call	_os_printString
	sub	sp, -2
; return
	jmp	L9
.absent:
push es
mov dx, ds
add dx, 4096
mov es, dx
xor di, di
mov si, intHandler
mov cx, eof - intHandler
rep movsb

; RPN'ized expression: "( loaded &u os_printString ) "
; Expanded expression: " loaded  os_printString ()2 "
; Fused expression:    "( loaded , os_printString )2 "
	push	_loaded
	call	_os_printString
	sub	sp, -2
mov ax, dx
call os_print_4hex
cli
xor ax, ax
mov es, ax
mov di, 0x114
stosw
mov ax, dx
stosw
sti
pop es
; RPN'ized expression: "( hooked &u os_printString ) "
; Expanded expression: " hooked  os_printString ()2 "
; Fused expression:    "( hooked , os_printString )2 "
	push	_hooked
	call	_os_printString
	sub	sp, -2
; return
	jmp	L9
; Fused expression:    "0 "
	mov	ax, 0
L9:
	leave
	ret
L8:
	jmp	L7
%include 'mikedev.inc'
; glb os_printString : (
; prm     stringPtr : * char
;     ) void
_os_printString:
	push	bp
	mov	bp, sp
	jmp	L12
L11:
; loc     stringPtr : (@4): * char
mov si, [bp + 4]
call os_print_string
L13:
	leave
	ret
L12:
	jmp	L11

; Syntax/declaration table/stack:
; Bytes used: 312/20736


; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_16__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Bytes used: 63/4096


; Identifier table:
; Ident greeting
; Ident alreadyInstalled
; Ident loaded
; Ident hooked
; Ident main
; Ident <something>
; Ident os_printString
; Ident stringPtr
; Bytes used: 90/4752

; Next label number: 15
; Compilation succeeded.
