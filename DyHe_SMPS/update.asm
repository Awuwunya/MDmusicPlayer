; by the way, this works almost exactly like Sonic 1
		lea	PSG3tmul.w,a1		; get PSG3 tick multiplier
		lea	Drv68Kmem+$1F0.w,a0	; get last channel
		moveq	#9-1,d0			; 9 channels
		moveq	#0,d1

.loop		tst.b	(a0)
		bpl.s	.inactive		; branch if channel is inactive
		bset	d0,d1			; set active bit

		move.b	2(a0),(a1)+		; get tick multiplier
		move.b	$B(a0),(a1)+		; get instrument
		move.b	9(a0),(a1)+		; get volume
		move.b	$10(a0),(a1)+		; get note
		move.b	$E(a0),(a1)+		; get time counter

.inactive	lea	-$30(a0),a0		; get last channel
		dbf	d0,.loop		; loop until done

		tst.b	(a0)
		bpl.s	.noDAC			; branch if channel is inactive
		bset	#9,d1			; set active bit
		move.b	$10(a0),DACnumber.w	; get DAC number to variable
		move.b	$E(a0),DACtime.w	; get DAC timer

.noDAC		move.w	d1,ActiveChn.w		; now set the active channels and be happy
		move.b	Drv68Kmem+$02.w,Tempo.w; get tempo
		st.b	TickMul.w		; get tick multiplier
		rts
