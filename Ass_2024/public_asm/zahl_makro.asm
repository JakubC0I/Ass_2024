zahl_makro macro zahl_len, zahl_ergebnis
		LOCAL set_max, set_min, starte_eingabe, eingabe_schleife, ende_eingabe, zahl_eingabe
		.data
			zahl_eingabe db 7 dup (0),0
		.code
		push eax
		push ebx
		push ecx
		push edx
		mov ecx, zahl_len
		cmp ecx, 7
		jg set_max
		cmp ecx, 1
		jl set_min
		jmp starte_eingabe
		set_max:
			mov ecx, 7
			jmp starte_eingabe
		set_min:
			mov ecx, 1
		starte_eingabe:
			push ecx
			push offset zahl_eingabe
			call StdIn
			mov eax, 0
			mov ebx, 0
			mov ecx, zahl_len
			mov edx, 0
			lea esi, zahl_eingabe
			eingabe_schleife:
				lods zahl_eingabe
				cmp al, 0
				je ende_eingabe
				cmp al, 30h
				jl starte_eingabe
				cmp al, 39h
				jg starte_eingabe
				sub al, 30h
				push edx
				push eax
				mov eax, 10
				mul ebx
				mov ebx, eax
				pop eax
				add ebx, eax
				pop edx
				inc edx
				loop eingabe_schleife
			ende_eingabe:
				cmp edx, 0
				je starte_eingabe
				mov zahl_ergebnis, ebx
				pop edx
				pop ecx
				pop ebx
				pop eax
				exitm
	endm