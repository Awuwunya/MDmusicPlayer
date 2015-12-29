	opt ae+		; automatic even's
	opt l+		; . is local lable symbol
	opt w+		; print warnings
	opt op+		; optimize PC relative addressing
	opt os+		; optimize short branches
	opt ow+		; optimize absolute long addressing
	opt oz+		; optimize zero displacements
	opt oaq+	; optimize addq
	opt osq+	; optimize subq
	opt omq+	; optimize moveq

align macro
	cnop 0,\1
	endm

; allows you to declare string to be converted to character map or mappings
asc	macro	or, str
.lc = 0
	rept strlen(\str)
.cc		substr .lc+1,.lc+1,\str

		if '\.cc'=' '
			dc.\0 0|or			; whitespace

		elseif ('\.cc'>='0')&('\.cc'<='9')
			dc.\0 ('\.cc'-'0'+1)|or		; 0-9

		elseif ('\.cc'>='a')&('\.cc'<='z')
			dc.\0 ('\.cc'-'a'+11)|or	;a-z

		elseif ('\.cc'>='A')&('\.cc'<='Z')
			dc.\0 ('\.cc'-'A'+11)|or	; A-Z
		else
			dc.\0 '\.cc'|or			; unknown, defaulting to ASCII value
		endif

.lc =		.lc+1
	endr
    endm

	rsset	$FFFF0000
Z80music	equ __rs+2	; if z80 driver, this is the address of the music file.
Driver68K	rs.b $8000	; 68k driver ROM. if Z80 driver, this is rte
Drv68Kmem	rs.b $1000	; memory for the 68k driver. This may be used by z80 drivers for things too
		rs.l 3		; stack overflow area
StackUflowRAM	rs.l 1		; stack overflow area
		rs.b $100	; 68k stack
Stack		rs.b 0		; 68k stack pointer
StackOflowRAM	rs.l 4		; stack underflow area
MusSelection	rs.w 1		; current song selection
MusPlaying	rs.w 1		; current song playing