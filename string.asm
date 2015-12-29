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
		bra.s	WriteString3		; write the string

WriteString1:
		move.w	(a0)+,d6		; get length

WriteString2:
		lea	VDP_data_port,a6
		muls.w	#32*2,d5		; multiply the y-position by display width
		add.w	d4,d5			; add x-position
		add.w	d4,d5			; twice as each tile mapping is 2 bytes

		ori.w	#$4000,d5		; this enables VRAM write mode
		swap	d5			; swap low and high words
		move.w	#3,d5			; VRAM write to $Cxxx.
		move.l	d5,VDP_control_port-VDP_data_port(a6); set the VRAM mode to VDP

WriteString4:
.write		move.w	(a0)+,(a6)		; write next mapping
		dbf	d6,.write		; write util we are done
		rts				; return
