; ===========================================================================
; This function writes a string into screen at specific coordinates.
; If WriteString1 or WriteString3, then length is gotten from start of string
; If WriteString3 or WriteString4, writing right after last string.
; Breaks after V-int.
; input:
;  a0 - String start address
;  d4 - x-cell position
;  d5 - y-cell position
;  d6 - length in characters
; ===========================================================================
WriteString3:
		move.w	(a0)+,d6		; get length
		bra.s	WriteString4		; write the string

WriteString1:
		move.w	(a0)+,d6		; get length

WriteString2:
		jsr	SetupStringWrite.w	; get position onscreen

WriteString4:
.write		move.w	(a0)+,(a6)		; write next mapping
		dbf	d6,.write		; write util we are done
		rts				; return

; ===========================================================================
; This function writes a 16-bit number into screen at specific coordinates.
; If WriteNumberWord2, writing right after last string.
; Breaks after V-int.
; input:
;  d2 - value to be or'd to the number
;  d3 - number to write. ignores most significant word. Is destroyed
;  d4 - x-cell position
;  d5 - y-cell position
; ===========================================================================
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
WriteNumberByte1:
		jsr	SetupStringWrite.w	; get position onscreen

WriteNumberByte2:
		moveq	#2-1,d6			; set up nibbles in num
		bra.s	WriteNumberLoop		; write the number then!

; ===========================================================================
WriteNumberNibble1:
		jsr	SetupStringWrite.w	; get position onscreen

WriteNumberNibble2:
		moveq	#1-1,d6			; set up nibbles in num
	; continue directly to WriteNumberLoop.
; ===========================================================================
WriteNumberLoop:
		move.w	d6,d4			; copy length
.loop		move.b	d3,d2			; get next nibble
		andi.b	#%1111,d2		; keep the nibble only
		addq.b	#1,d2			; increment 1 (to skip null)
		move.w	d2,-(sp)		; then store the number on plane
		ror.l	#4,d3			; rotate right four times, to get the next nibble.
						; Also returns d3 to original value
		dbf	d6,.loop		; loop until full number is done

.write		move.w	(sp)+,(a6)		; copy number to VRAM
		dbf	d4,.write		; write for so many bytes as we need
		rts

; ===========================================================================
; This function writes a string into screen at specific coordinates.
; If WriteString1 or WriteString3, then length is gotten from start of string
; If WriteString3 or WriteString4, writing right after last string.
; Breaks after V-int.
; input:
;  d4 - x-cell position
;  d5 - y-cell position
; ===========================================================================
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
