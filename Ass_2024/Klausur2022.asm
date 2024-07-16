;==============================================================
 .386
 .model flat,stdcall
 option casemap:none
;========================================================

include \masm32\include\masm32rt.inc
include \masm32\macros\macros.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib


.data
	inputVar db 1000 dup(?), 0
	debugger_msg db "debug modus anschalten? (j - ja / n - nein)",10, 0 ; 10 is a newline and 0 is string end
	flag dd ?
	result db 100 dup(?), 0 ; change it into array of ints
	char_to_add db ?
.code

handle_debug proc 
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8] ; eax contains the flag

	cmp al, 'j'
	je ja_debug

	cmp al, 'n'
	je nein_debug

conti:

	mov esp, ebp
	pop ebp
	ret 4 ; 4 x #input_params
handle_debug endp

greet_and_take:
	printf("Jakub Ciszak, 0112228\n")
	printf("Enter some text: ")
	
	; Define string size
	push 1000

	; Define where to put it (address)
	push offset inputVar
	call StdIn
	jmp after_greet

ja_debug:
	printf("Debugger modus activated\n")
	jmp conti:

nein_debug:
	printf("Debugger modus deactivated\n")
	jmp conti:

klausur2022:
	mov eax, 0
	
	jmp greet_and_take

after_greet:
	push offset debugger_msg
	call StdOut

	getkey() ; takes one key input and saves it in al
	push eax
	call handle_debug

	jmp after_greet

goodbye:
	xor eax, eax
	exit


end klausur2022