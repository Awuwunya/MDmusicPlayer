; ===========================================================================
; ---------------------------------------------------------------------------
; This function writes a string into screen at specific coordinates.
; If WriteString1 or WriteString3, then length is gotten from start of string
; If WriteString3 or WriteString4, writing right after last string.
; Breaks after V-int.
; input:
;   a0 - String start address
;   d4 - x-cell position
;   d5 - y-cell position
;   d6 - length in characters
; ---------------------------------------------------------------------------

WriteString3:
		move.w	(a0)+,d6		; get length
		bpl.s	WriteString4		; write the string
		rts
WriteString1:
		move.w	(a0)+,d6		; get length
		bpl.s	WriteString2		; write the string
		rts

WriteString2:
		jsr	SetupStringWrite.w	; get position onscreen

WriteString4:
.write		move.w	(a0)+,(a6)		; write next mapping
		dbf	d6,.write		; write util we are done
		rts				; return
; ===========================================================================
; ---------------------------------------------------------------------------
; This function writes a number into screen at specific coordinates.
; If WriteNumberX2, writing right after last string.
; Breaks after V-int.
; input:
;   d3 - number to write. Is destroyed
;   d4 - x-cell position
;   d5 - y-cell position
; ---------------------------------------------------------------------------

WriteNumberWord1:
		jsr	SetupStringWrite.w	; get position onscreen

WriteNumberWord2:
		moveq	#4-1,d6			; set up nibbles in num
		bra.s	WriteNumberLoop		; write the number then!
; ===========================================================================

WriteNumberLong1:
		jsr	SetupStringWrite.w	; get position onscreen

WriteNumberLong2:
		moveq	#8-1,d6			; set up nibbles in num
		bra.s	WriteNumberLoop		; write the number then!
; ===========================================================================

WriteNumberAddr1:
		jsr	SetupStringWrite.w	; get position onscreen

WriteNumberAddr2:
		moveq	#6-1,d6			; set up nibbles in num
		bra.s	WriteNumberLoop		; write the number then!
; ===========================================================================

WriteNumberNibble1:
		jsr	SetupStringWrite.w	; get position onscreen

WriteNumberNibble2:
		moveq	#1-1,d6			; set up nibbles in num
		bra.s	WriteNumberLoop		; write the number then!
; ===========================================================================

WriteNumberByte1:
		jsr	SetupStringWrite.w	; get position onscreen

WriteNumberByte2:
		moveq	#2-1,d6			; set up nibbles in num
	; continue directly to WriteNumberLoop.
; ===========================================================================

WriteNumberLoop:
		move.w	d6,d4			; copy length
.loop		move.b	d3,d2			; get next nibble
		andi.w	#%1111,d2		; keep the nibble only
		addq.b	#1,d2			; increment 1 (to skip null)
		move.w	d2,-(sp)		; then store the number on plane
		ror.l	#4,d3			; rotate right four times, to get the next nibble.
						; Also returns d3 to original value
		dbf	d6,.loop		; loop until full number is done

.write		move.w	(sp)+,(a6)		; copy number to VRAM
		dbf	d4,.write		; write for so many bytes as we need
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; This function writes a decimal number into screen at specific coordinates.
; If WriteNumberX2, writing right after last string.
; Breaks after V-int.
; input:
;   d2 - whether you want trailing 0's (0 - no, $FF - yes)
;   d3 - number to write. Is destroyed
;   d6 - number count
; ---------------------------------------------------------------------------

WriteDecMain:
		lea	.multbl(pc),a2
		move.w	d6,d4			; copy digit count
		move.w	d6,-(sp)		; push

.rightmul	subq.w	#4,a2			; go to earlier multiplication
		dbf	d4,.rightmul		; loop til we got it right

.digitsloop	moveq	#1,d1			; clear the digit counter
		move.l	(a2)+,d4		; get addition ctr

.numloop	sub.l	d4,d3			; sub the count from the output num
		bcs.s	.uflow			; if we underflowed, branch
		addq.w	#1,d1			; add 1 to digit ctr
		bra.s	.numloop

.uflow		add.l	d4,d3			; fix the number

		cmp.b	#1,d1			; check if d3 = 0
		beq.s	.is0			; branch if so
		st	d2			; allow writes (if d2 was 0, then no trailing 0's will appear)

.is0		tst.b	d2			; check if writes are enabled
		bpl.s	.chkloop		; if not, branch
		move.w	d1,(a6)			; write number
		subq.w	#1,(sp)

.chkloop	dbf	d6,.digitsloop		; loop for all numbers
		move.w	(sp)+,d6		; pop remaining loops tiles
		bmi.s	.end			; if none, branch
		moveq	#0,d4

.clr		move.w	d4,(a6)			; clear tiles
		dbf	d6,.clr			;
.end		rts

	dc.l 10000000
	dc.l 1000000
	dc.l 100000
	dc.l 10000
	dc.l 1000
	dc.l 100
	dc.l 10
	dc.l 1
.multbl
; ===========================================================================
; ---------------------------------------------------------------------------
; This function writes a string into screen at specific coordinates.
; If WriteString1 or WriteString3, then length is gotten from start of string
; If WriteString3 or WriteString4, writing right after last string.
; Breaks after V-int.
; input:
;   d4 - x-cell position
;   d5 - y-cell position
; ---------------------------------------------------------------------------

SetupStringWrite:
		lea	VDP_data_port,a6
		muls.w	#32*2,d5		; multiply the y-position by display width
		add.w	d4,d5			; add x-position
		add.w	d4,d5			; twice as each tile mapping is 2 bytes

		ori.w	#$4000,d5		; this enables VRAM write mode
		swap	d5			; swap low and high words
		move.w	#3,d5			; VRAM write to $Cxxx.
		move.l	d5,VDP_control_port-VDP_data_port(a6); set the VRAM mode to VDP
		rts
; ===========================================================================
