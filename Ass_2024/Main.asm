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
	inputVar db 100 dup(?), 0
	first dd ?
	second dd ?
	result dd ?
.code




exam_proc proc
	push ebp
	mov ebp, esp

	mov eax, 0
	mov edx, 0

	mov eax, [ebp + 16]
	mov edx, [ebp + 12]

	; printf("First value: %c second value: %c ", eax, edx)

	; ziel - quell -> edx - eax (Example: input 123 = eax = 1 ; edx = 2)
	sub edx, eax

	cmp edx, 0
	js do_negation
	jmp conti


do_negation:
	neg edx

conti:
	; get value (address) from a parameter
	mov eax, [ebp + 8]
	; insert into this address value of edx 
	mov [eax], edx

	mov esp, ebp
	pop ebp
	ret 12 ; 4 x #input_params
exam_proc endp

greet_and_take:
	printf("Jakub Ciszak, 0112228\n")
	printf("Enter some text: ")
	
	; Define string size
	push 100

	; Define where to put it (address)
	push offset inputVar
	call StdIn

read_charecters:
	mov eax, 0
	lea si, inputVar ; Pass address of a string into si
	; Load string address from si register and advance one character (saves in AL)
	lodsb
	push eax

	lodsb
	push eax

	push offset result
	call exam_proc
	jmp goodbye
	
goodbye:
	printf("\nDistance between first and second number is: %d", result)
	exit


inout:
	mov eax,0
	mov edx, 0
	
	jmp greet_and_take
	jmp read_charecters

end inout