		lea	Z80_RAM+$1618,a5	; get this z80 address to a5
		move.l	d7,d6			; copy music address
		lsl.l	#1,d6			; shift 1 bit up
		swap	d6			; swap words
	;	divu.w	#$8000,d6		; divide address by $8000 (z80 bank size)
		move.b	d6,$B65-$1618(a5)	; set as music 1 bank

		or.w	#$8000,d7		; get z80 bank offset
	; we want to byteswap d7, because z80 is little-endian
		move.b	d7,d6			; get lower byte of d7 to d6
		lsr.w	#8,d7			; shift high byte of d7 to low byte
		move.b	d6,(a5)+		; first write high byte
		move.b	d7,(a5)+		; then low byte (68k order)

		move.b	#1,$1C0A-$161A(a5)	; play music 1
		rts
