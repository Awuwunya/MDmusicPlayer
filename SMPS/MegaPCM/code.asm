; ===========================================================================
; ---------------------------------------------------------------------------
; Play a song
; ---------------------------------------------------------------------------

MegaPCM_play:
		move.l	d7,Driver68K+$1C	; set music pointer
		move.b	#$81,Drv68Kmem+9.w	; play music id $81
; ===========================================================================
; ---------------------------------------------------------------------------
; Enable DMA
; ---------------------------------------------------------------------------

MegaPCM_dmaon:
; ===========================================================================
; ---------------------------------------------------------------------------
; Disable DMA
; ---------------------------------------------------------------------------

MegaPCM_dmaoff:
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Update driver data
; ---------------------------------------------------------------------------

MegaPCM_update:
		lea	sPSG3.w,a1		; get PSG3 tick multiplier
		lea	Drv68Kmem+$1F0.w,a0	; get last channel
		moveq	#10-1,d0		; 9 channels
		moveq	#0,d1

.loop		tst.b	(a0)
		bpl.s	.inactive		; branch if channel is inactive
		bset	d0,d1			; set active bit

		move.b	2(a0),(a1)		; get tick multiplier
		move.b	$B(a0),1(a1)		; get instrument
		move.b	9(a0),2(a1)		; get volume
		move.b	$E(a0),3(a1)		; get time counter

		move.w	$10(a0),d6		; get freq to d6
		move.w	d6,4(a1)		; save it
		add.w	$1C(a0),d6		; add mod freq

		move.b	$1E(a0),d5		; get detune
		ext.w	d5			; extend to word
		add.w	d5,d6			; add to mod freq
		move.w	d6,6(a1)		; save it

.inactive	lea	-$30(a0),a0		; get last channel
		addq.w	#8,a1			; advance offset
		dbf	d0,.loop		; loop until done

		move.w	d1,ActiveChn.w		; now set the active channels and be happy
		move.b	Drv68Kmem+$02.w,sTempo.w; get tempo
		st.b	sTickMul.w		; get tick multiplier
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Load SMPS sound driver
; ---------------------------------------------------------------------------

MegaPCM_load:
		move.l	#sDriverPropertyData,DisplayList.w
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
; ===========================================================================
; ---------------------------------------------------------------------------
; Mega PCM data
; ---------------------------------------------------------------------------

		include "SMPS/MegaPCM/MegaPCM.asm"
; ===========================================================================
