.386
.model flat,stdcall
option casemap:none
include C:\masm32\include\windows.inc
include C:\masm32\include\masm32.inc
include C:\masm32\include\kernel32.inc

include \masm32\include\masm32rt.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\masm32.lib

.data

;ASCII STUFF:
;Kleinbuchstaben: ab 97 bis 122 / 61h bis 7Ah
;Groﬂbuchstaben: ab 65 bis 90 / 45h bis 5Ah
;Nummer: ab 48 bis 57 / 30h bis 39h
; 0 - NUL; 10 - new line

Zeichenkette dd ?
namePrint db "Nowak, Jaroslaw",10, 0
;var name, size, content - 10 is new line, 0 is end of string
;push offset namePrint
;call StdOut

text1 db "Please enter a string:", 10, 0
text2 db "Please enter a number:", 10, 0

outputText db 99 dup (0),10,0
;99 copies of "?" followed by a new line and end of string
;this var will be edited in the code

inputNum db 8 dup (?),0
inputStr db 8 dup (?),0	
;8 copies of "?", ? is placeholder, will be changed through StdIn
;push offset inputStr
;call StdIn
;push 0

reusableVar db ?

.code

main:


;-----------------------------------------------
;ORGANISATION
;-----------------------------------------------
	push offset namePrint
	call StdOut	
	;----- ^ Name
	push offset text1
	call StdOut

	push 8	;reserved space
	push offset inputStr
	call StdIn
	push 0

	jmp DEBUGDEBUGDEBUGDEBUG
	;----- ^ take input String

	push offset text2
	call StdOut

	push 8
	push offset inputNum
	call StdIn
	push 0
	;----- ^ take input Number as String

	printf("\n")

	printf("This is your String: ")
	push offset inputStr
	call StdOut
	printf("\n")

	printf("This is your Number: ")
	push offset inputNum
	call StdOut

	;-----

	printf("\n\nwhat is it that you wish to do? \n")
	printf("[e] to exit; [a] to work with String; [b] to work with Number \n")

	push 1
	push offset reusableVar
	call StdIn
	push 0

	mov eax, 0
	mov al, reusableVar

	cmp al, 97	;compare if a was input, goto string
	je string_Label
	cmp al, 98	;compare if b was input, goto num
	je num_Label
	cmp al, 101	;compare if e was input, goto exit
	je exit_Label
	jmp false_Input_Label

	string_Label:
	DEBUGDEBUGDEBUGDEBUG:
	printf("\nThis is the string label \n")

	;Options:
	; - Length of the string
	; - Filter numbers / letters from the string
	; - spit out a letter of the string based on input index
	
	determineLength:
	;
	printf("\nString: ")
	push offset inputStr
	call StdOut

	printf("\n")

	lea esi, inputStr	;load inputStr

	process_characters:
        lodsb  ; Load the next character into AL and advance ESI

        ; Check if it's the null terminator
        cmp al, 0
        je end_loop

        push eax  ; Character is in AL
		printf("looping through eax: %d\n", eax)

		add esp, 8	;cleanup stack

        ; Continue the loop
        jmp process_characters

    end_loop:
	printf("\n")

	;
	jmp exit_Label
	;-----

	filterNumbers:
	;
	jmp exit_Label
	;-----

	filterLetters:
	;
	jmp exit_Label
	;-----

	indexToChar:
	;
	jmp exit_Label
	;-----

	jmp exit_Label

	num_Label:
	printf("\nThis is the num label \n")
	
	;Options:
	; - Length of the string
	; - find greatest + smallest number
	; - spit out a number based on input index

	jmp exit_Label

	false_Input_Label:
	printf("\nInput was false \n")
	jmp exit_Label

	exit_Label:
	inkey "press any key to end the application"
	call ExitProcess
end main
