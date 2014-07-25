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
db 'Copyright (c) 2014 Blake Burgess',CR,LF,0
; glb alreadyInstalled : [0u] char
_alreadyInstalled:
; =
; RPN'ized expression: "L1 "
; Expanded expression: "L1 "
L1:
	db	"Xypher is already in memory.",13,10,0
; glb success : [0u] char
_success:
; =
; RPN'ized expression: "L3 "
; Expanded expression: "L3 "
L3:
	db	"Xypher successfully loaded. Hooked into interrupt 0x45.",13,10,0
; glb main : (void) void
_main:
	push	bp
	mov	bp, sp
	jmp	L6
L5:
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
	jmp	L7
.absent:
push es
mov dx, ds
add dx, 4096
mov es, dx
xor di, di
mov si, intHandler
mov cx, eof - intHandler
rep movsb

cli
xor ax, ax
mov es, ax
mov di, 0x114
stosw
mov ax, dx
stosw
sti

pop es
; RPN'ized expression: "( success &u os_printString ) "
; Expanded expression: " success  os_printString ()2 "
; Fused expression:    "( success , os_printString )2 "
	push	_success
	call	_os_printString
	sub	sp, -2
; return
	jmp	L7
; Fused expression:    "0 "
	mov	ax, 0
L7:
	leave
	ret
L6:
	jmp	L5
%include 'mikedev.inc'
; glb os_printString : (
; prm     stringPtr : * char
;     ) void
_os_printString:
	push	bp
	mov	bp, sp
	jmp	L10
L9:
; loc     stringPtr : (@4): * char
mov si, [bp + 4]
call os_print_string
L11:
	leave
	ret
L10:
	jmp	L9

; Syntax/declaration table/stack:
; Bytes used: 272/20736


; Macro table:
; Macro __SMALLER_C__ = `0x0100`
; Macro __SMALLER_C_16__ = ``
; Macro __SMALLER_C_SCHAR__ = ``
; Bytes used: 63/4096


; Identifier table:
; Ident greeting
; Ident alreadyInstalled
; Ident success
; Ident main
; Ident <something>
; Ident os_printString
; Ident stringPtr
; Bytes used: 83/4752

; Next label number: 13
; Compilation succeeded.
