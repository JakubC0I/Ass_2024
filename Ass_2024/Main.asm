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


; Thank you. To all who are still trying to understand, for me the key was to tell this to myself:
; 1.push ebp to the stack for a ebp backup.
; 2.Then move esp to ebp.
; 3.Now we can "play" with esp.
; 4.Before function returns, move back ebp to esp to restore what esp was before we moved esp to ebp.
; 5.Then pop ebp to restore ebp from the top of the stack


; The pop instruction removes the 4-byte data element from the top of the hardware-supported stack into the specified operand (i.e. register or memory location).
; It first moves the 4 bytes located at memory location [SP] into the specified register or memory location, and then increments SP by 4.

; Why does it crash when I use other register than eax
test_func proc
	push ebp ; 1.
	mov ebp, esp ; 2.
    mov eax, [ebp + 12] ; move the first parameter into eax
    mov first, eax     ; move eax into first
    mov eax, [ebp + 8] ; move the second parameter into eax
    mov second, eax    ; move eax into second
	printf("First element you pushed: %s\n", first)
	printf("Second element you pushed: %s\n", second)
	mov esp, ebp
	pop ebp
	ret 8
test_func endp

exam_proc proc
	push ebp
	mov ebp, esp

	mov eax, 0
	mov edx, 0

	mov eax, [ebp + 16]
	mov edx, [ebp + 12]

	printf("First value: %c second value: %c", eax, edx)

	distance:
		neg eax

	sub eax, edx

	cmp eax, 0
	jbe distance

	mov [ebp + 8], eax
	
	mov esp, ebp
	pop ebp
	ret 8
exam_proc endp


	

inout:
	mov eax,0
	mov edx, 0
	; Just print some text 
	printf("Jakub Ciszak, 0112228\n")
	; Alternative way to print a string and store the result on stack
	; push input("Please enter some text:")
	printf("Enter some text: ")
	
	; Define string size
	push 100

	; Define where to put it (address)
	push offset inputVar
	call StdIn
	
	; printf("\nYou wrote: %s and %s\n", inputVar[1], inputVar[2])
	; lea - load address of inputVar[1] into eax
    ; lea eax, inputVar + 1
	; move the contents (value) of eax into the 4 bytes at memory address of first
    ; mov [first], eax
    ; push eax
    ; lea eax, inputVar + 2
    ; mov [second], eax
    ; push eax
    ; call test_func

	; Clear eax
	mov eax, 0
	; Pass address of a string into si
	lea si, inputVar

	; Load string address from si register and advance one character (saves in AL)
	lodsb
	push eax
	printf("Value: %c", eax)
	; add esp, 8

	lodsb
	push eax
	printf("Value: %c", eax)
	; add esp, 8

	push offset result
	call exam_proc

	printf("Distance between first and second symbol is: %s", result)


	exit
end inout