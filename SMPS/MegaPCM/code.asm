MegaPCM_play:
		move.l	d7,Driver68K+$1C	; set music pointer
		move.b	#$81,Drv68Kmem+9.w	; play music id $81

MegaPCM_dmaon:
MegaPCM_dmaoff:
		rts

MegaPCM_update:
		lea	sPSG3tmul.w,a1		; get PSG3 tick multiplier
		lea	Drv68Kmem+$1F0.w,a0	; get last channel
		moveq	#9-1,d0			; 9 channels
		moveq	#0,d1

.loop		tst.b	(a0)
		bpl.s	.inactive		; branch if channel is inactive
		bset	d0,d1			; set active bit

		move.b	2(a0),(a1)		; get tick multiplier
		move.b	$B(a0),1(a1)		; get instrument
		move.b	9(a0),2(a1)		; get volume
		move.b	$10(a0),3(a1)		; get note
		move.b	$E(a0),4(a1)		; get time counter

.inactive	lea	-$30(a0),a0		; get last channel
		addq.w	#5,a1			; advance offset
		dbf	d0,.loop		; loop until done

		tst.b	(a0)
		bpl.s	.noDAC			; branch if channel is inactive
		bset	#9,d1			; set active bit
		move.b	$10(a0),sDACnumber.w	; get DAC number to variable
		move.b	$E(a0),sDACtime.w	; get DAC timer

.noDAC		move.w	d1,ActiveChn.w		; now set the active channels and be happy
		move.b	Drv68Kmem+$02.w,sTempo.w; get tempo
		st.b	sTickMul.w		; get tick multiplier
		rts

MegaPCM_load:
		move.b	#TYPE_SMPS,DriverType.w
		lea	MegaPCM_DAC(pc),a1
		lea	Z80_RAM+$210,a0
		move.w	#(MegaPCM_DAC_End-MegaPCM_DAC)-1,d0

.loop		move.b	(a1)+,(a0)+
		dbf	d0,.loop

		btst	#6,HWVersion.w		; is this NTSC Genesis?
		beq.s	.isNTSC			; if is, branch
		st	Driver68K+$21		; set PAL mode
.isNTSC		rts

		include "SMPS/MegaPCM/MegaPCM.asm"
