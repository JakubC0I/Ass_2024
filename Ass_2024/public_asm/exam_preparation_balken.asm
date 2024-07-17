.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc
include \masm32\macros\macros.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
    zahl_in db 14 dup (0),0
    zahlen dd 0,0,0,0,0
    balken_out db 99 dup (0),10,0
    
.code
  
balken:
  ; Aufgabe: es sollen 5 beliebige Zahlen zwischen 1-99 eingegeben werden
  ; Daraufhin soll ein "Balken" für jede Zahl ausgegeben werden, der
  ; genauso viele Zeichen ('*') lang ist, wie die Zahl angibt
  ; 4,11,2,5,19 ->
  ; ****
  ; ***********
  ; **
  ; *****
  ; *******************
  printf("Bitte geben Sie 5 Zahlen zwischen 1 und 99 durch ',' getrennt ein.\n")
  wiederhole_eingabe:
    push 14
    push offset zahl_in
    call StdIn
    lea esi, zahl_in
    mov ecx, 14
    mov ebx, 0
    mov eax, 0
    mov edx, 0
    in_schleife:
        lods zahl_in
        cmp al, ','
        je zahl_gelesen
        cmp al, 0
        je zahl_gelesen
        mov ebx, eax
        sub ebx, 30h
        lods zahl_in
        cmp al, ','
        je zahl_gelesen
        cmp al, 0
        je zahl_gelesen
        push eax
        mov eax, 10
        mul bl
        mov ebx, eax
        pop eax
        sub eax, 30h
        add ebx, eax
        jmp in_schleife
        zahl_gelesen:
            mov zahlen[edx], ebx
            add edx, 4
            cmp edx, 16
            jg end_schleife
            jmp in_schleife
        end_schleife:
  mov ebx, 0
  out_schleife:
    ; printf("Die eingebene Zahl lautet: %d\n", zahlen[ebx])
    mov ecx, zahlen[ebx]
    mov al, '*'
    lea edi, balken_out
    rep stos balken_out
    mov al, 10
    stos balken_out
    push offset balken_out
    call StdOut
    mov al, 0
    mov ecx, 100
    lea edi, balken_out
    rep stos balken_out
    add ebx, 4
    cmp ebx, 16
    jg nach_schleife
    jmp out_schleife
  nach_schleife:

  push 0
  call ExitProcess
end balken