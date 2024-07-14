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
	result db 100 dup(?), 0 ; change it into array of ints
	char_to_add db ?
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
	add edx, 30h
	; get value (address) from a parameter
	mov eax, [ebp + 8]
	; insert into this address value of edx 

	mov [eax + ebx], edx
	inc ebx

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

	lea si, inputVar ; Pass address of a string into si
	; Load string address from si register and advance one character (saves in AL)
	
	; increment to take 2 first values at the beginning
	inc si

	read:
		dec si
		mov eax, 0
	
		lodsb
		push eax

		cmp eax, 0
		je goodbye

		lodsb
		push eax

		; Beacuse the case where first number is something and a second is 0 (end of a string)
		cmp eax, 0
		je goodbye

		push offset result
		call exam_proc
		jmp read
	
goodbye:
	; printf("Result: %s")
	push offset result
	call StdOut
	exit


inout:
	mov eax, 0
	mov ebx, 0
	mov edx, 0
	
	jmp greet_and_take
	jmp read_charecters

end inout