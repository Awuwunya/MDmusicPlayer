		move.l	d7,d6			; copy music address
		divu	#$8000,d6		; divide address by $8000 (z80 bank size)
		move.b	d6,Z80_RAM+$B65		; set as music $81 bank

		and.w	#$7FFF,d7		; get z80 bank offset
	; we want to byteswap d7, because z80 is little-endian
		move.b	d7,d6			; get lower byte of d7 to d6
		lsr.w	#8,d7			; shift high byte of d7 to low byte
		move.b	d7,Z80_RAM+$1618	; first write high byte
		move.b	d6,Z80_RAM+$1619	; then low byte (68k order)

		move.b	#1,Z80_RAM+$1C0A	; play music $81
		rts

		lsl.l	#1,d6			; shift 1 bit up
		swap	d6			; swap words
