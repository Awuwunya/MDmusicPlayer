; by the way, this works exactly same as Sonic 1
		lea	PSG3tmul.w,a1		; get PSG3 tick multiplier
		lea	.addrList(pc),a2	; get last channel
		moveq	#9-1,d0			; 9 channels
		moveq	#0,d1

.loop		move.l	(a2)+,a0		; get the track pointer to a0
		; FM6 is always in DAC mode in S3K, therefore we need to ignore it here
		cmp.b	#6-1,d0			; check if this is the FM6/DAC channel
		beq.s	.inactive		; if is, branch

		tst.b	(a0)
		bpl.s	.inactive		; branch if channel is inactive
		bset	d0,d1			; set active bit

		move.b	2(a0),(a1)+		; get tick multiplier
		move.b	8(a0),(a1)+		; get instrument
		move.b	6(a0),(a1)+		; get volume
		move.b	$D(a0),(a1)+		; get note
		move.b	$B(a0),(a1)+		; get time counter
.inactive	dbf	d0,.loop		; loop until done

		lea	-$30(a0),a0		; get DAC track
		tst.b	(a0)
		bpl.s	.noDAC			; branch if DAC is inactive
		bset	#9,d1			; set active bit
		move.b	$D(a0),DACnumber.w	; get DAC number
		move.b	$B(a0),DACtime.w	; get DAC timer

.noDAC		move.w	d1,ActiveChn.w		; now set the active channels and be happy
		move.l	(a2)+,a0		; get Z80 RAM address
		move.b	$24(a0),Tempo.w		; get tempo
		st.b	TickMul.w		; get tick multiplier
		rts

.addrList	dc.l Z80_RAM+$1DC0, Z80_RAM+$1D90, Z80_RAM+$1D60
		dc.l Z80_RAM+$1C40, Z80_RAM+$1D30, Z80_RAM+$1D00
		dc.l Z80_RAM+$1CD0, Z80_RAM+$1CA0, Z80_RAM+$1C70
		dc.l Z80_RAM+$1C00
