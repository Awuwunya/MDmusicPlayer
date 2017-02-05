; =============== S U B	R O U T	I N E =======================================
	include "..\..\code\macro.asm"

	org $FFFF0000		; pretend we are in RAM
UpdateSound:
	if pal60mod=1
		jmp	DoDoubleUpdate(pc)
DoUpdate:
	else
		clr.b	(Drv68Kmem+$0E).w
	endif

		tst.b	(Drv68Kmem+$07).w
		bne.w	PauseMusic
		jsr	sub_5CEF6
		jsr	DoTempo
		jsr	DoFadeOut
		tst.l	(Drv68Kmem+$0A).w
		beq.s	loc_5BDCA
		jsr	DoSoundQueue

loc_5BDCA:				; CODE XREF: UpdateSound+1Cj
		jsr	PlaySoundID
		lea	(Drv68Kmem+$40).w,a5
		tst.b	(a5)
		bpl.s	loc_5BDDA
		jsr	UpdateDACTrack

loc_5BDDA:				; CODE XREF: UpdateSound+2Cj
		clr.b	(Drv68Kmem+$08).w
		moveq	#5,d7

loc_5BDE0:				; CODE XREF: UpdateSound:loc_5BDECj
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_5BDEC
		jsr	UpdateFMTrack

loc_5BDEC:				; CODE XREF: UpdateSound+3Ej
		dbf	d7,loc_5BDE0
		moveq	#2,d7

loc_5BDF2:				; CODE XREF: UpdateSound:loc_5BDFEj
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_5BDFE
		jsr	UpdatePSGTrack

loc_5BDFE:				; CODE XREF: UpdateSound+50j
		dbf	d7,loc_5BDF2
		move.b	#$80,(Drv68Kmem+$0E).w
		moveq	#2,d7

loc_5BE0A:				; CODE XREF: UpdateSound:loc_5BE16j
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_5BE16
		jsr	UpdateFMTrack

loc_5BE16:				; CODE XREF: UpdateSound+68j
		dbf	d7,loc_5BE0A
		moveq	#2,d7

loc_5BE1C:				; CODE XREF: UpdateSound:loc_5BE28j
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_5BE28
		jsr	UpdatePSGTrack

loc_5BE28:				; CODE XREF: UpdateSound+7Aj
		dbf	d7,loc_5BE1C
		move.b	#$40,(Drv68Kmem+$0E).w
		moveq	#1,d7

loc_5BE34:				; CODE XREF: UpdateSound:loc_5BE4Cj
		adda.w	#$30,a5
		tst.b	(a5)
		bpl.s	loc_5BE4C
		tst.b	1(a5)
		bmi.s	loc_5BE48
		jsr	UpdateFMTrack
		bra.s	loc_5BE4C
; ---------------------------------------------------------------------------

loc_5BE48:				; CODE XREF: UpdateSound+98j
		jsr	UpdatePSGTrack

loc_5BE4C:				; CODE XREF: UpdateSound+92j
					; UpdateSound+9Ej
		dbf	d7,loc_5BE34
		rts
; End of function UpdateSound


; =============== S U B	R O U T	I N E =======================================


UpdateDACTrack:				; CODE XREF: UpdateSound+2Ep
		subq.b	#1,$E(a5)
		bne.w	locret_5BF06
		move.b	#$80,(Drv68Kmem+$08).w
		movea.l	4(a5),a4

loc_5BE64:				; CODE XREF: UpdateDACTrack+20j
		moveq	#0,d5
		move.b	(a4)+,d5
		cmpi.b	#$E0,d5
		bcs.s	loc_5BE74
		jsr	cfHandler
		bra.s	loc_5BE64
; ---------------------------------------------------------------------------

loc_5BE74:				; CODE XREF: UpdateDACTrack+1Aj
		tst.b	d5
		bpl.s	loc_5BE8A
		move.b	d5,$10(a5)
		move.b	(a4)+,d5
		bpl.s	loc_5BE8A
		subq.w	#1,a4
		move.b	$F(a5),$E(a5)
		bra.s	loc_5BE8E
; ---------------------------------------------------------------------------

loc_5BE8A:				; CODE XREF: UpdateDACTrack+24j
					; UpdateDACTrack+2Cj
		jsr	TickMultiplier

loc_5BE8E:				; CODE XREF: UpdateDACTrack+36j
		move.l	a4,4(a5)
		moveq	#0,d0
		move.b	$10(a5),d0
		subi.b	#$81,d0
		bcs.s	locret_5BF06
		ext.w	d0
		asl.w	#3,d0
		lea	DACDrum_Table(pc,d0.w),a3
		jsr	drv_stopz80
		tst.b	($A01FFD).l
		bmi.s	loc_5BEFE
		move.b	($A01FFC).l,d0
		andi.b	#$C0,d0
		move.b	5(a3),d1
		andi.b	#$C0,d1
		cmp.b	d0,d1
		bcs.w	loc_5BEFE
		move.b	#1,($A01FFD).l
	; upload DAC information to Z80
		move.b	(a3)+,($A01FE8).l	; Z80 DAC bank
		move.b	(a3)+,($A01FE9).l	; ^
		move.b	(a3)+,($A01FE6).l	; ROM PTR
		move.b	(a3)+,($A01FE7).l	; ^
		move.b	(a3)+,($A01FFE).l	; pitch
		move.b	(a3)+,($A01FFB).l	; priority(?)
		move.b	$27(a5),($A01FF9).l

loc_5BEFE:				; CODE XREF: UpdateDACTrack+5Ej
					; UpdateDACTrack+74j
		move.w	#0,($A11100).l

locret_5BF06:				; CODE XREF: UpdateDACTrack+4j
					; UpdateDACTrack+4Aj
		rts
; End of function UpdateDACTrack

; ---------------------------------------------------------------------------
DACDrum_Table:	dc.b	8, $80,	  0, $80,   2,	 0,   0,   0 ; DATA XREF: UpdateDACTrack+50o
		dc.b	8, $80,	  4, $80,   1,	 0,   0,   0
		dc.b	8, $80,	  8, $80,   2,	 0,   0,   0
		dc.b	8, $80,	 $C, $80,   2,	 0,   0,   0
		dc.b	8, $80,	$10, $80,   1,	 0,   0,   0
		dc.b	8, $80,	$14, $80,   8,	 0,   0,   0
		dc.b	8, $80,	$18, $80,   1,	 0,   0,   0
		dc.b	8, $80,	$10, $80,   2,	 0,   0,   0
		dc.b	8, $80,	$10, $80, $11,	 0,   0,   0
		dc.b	8, $80,	$10, $80, $1E,	 0,   0,   0
		dc.b	8, $80,	$1C, $80,   6,	 0,   0,   0
		dc.b	8, $80,	$20, $80,   1,	 0,   0,   0
		dc.b	8, $80,	$24, $80,   1,	 0,   0,   0
		dc.b	8, $80,	$24, $80,   8,	 0,   0,   0
		dc.b	8, $80,	$24, $80, $14,	 0,   0,   0
		dc.b	8, $80,	$28, $80, $10,	 0,   0,   0
		dc.b	8, $80,	$28, $80, $13,	 0,   0,   0
		dc.b	8, $80,	$2C, $80, $13,	 0,   0,   0
		dc.b	8, $80,	$2C, $80, $1A,	 0,   0,   0
		dc.b	8, $80,	$30, $80,   2,	 0,   0,   0
		dc.b	8, $80,	$34, $80,   3,	 0,   0,   0
		dc.b	8, $80,	$34, $80,   4,	 0,   0,   0
		dc.b	8, $80,	$34, $80,   5,	 0,   0,   0
		dc.b	8, $80,	$34, $80,   6,	 0,   0,   0
		dc.b	8, $80,	$34, $80,   7,	 0,   0,   0
		dc.b	8, $80,	$34, $80,   8,	 0,   0,   0
		dc.b	8, $80,	$34, $80,   9,	 0,   0,   0
		dc.b	8, $80,	$34, $80,  $A,	 0,   0,   0
		dc.b	8, $80,	$34, $80,  $B,	 0,   0,   0
		dc.b	8, $80,	$34, $80,  $C,	 0,   0,   0
		dc.b	8, $80,	$34, $80,  $D,	 0,   0,   0	; $9F
		dc.b	9,   0,	  0, $80,   1,	 0,   0,   0
		dc.b	9,   0,	  4, $80,   2,	 0,   0,   0
		dc.b	9,   0,	  8, $80,   3,	 0,   0,   0
		dc.b	9,   0,	 $C, $80,   3,	 0,   0,   0
		dc.b	9,   0,	$10, $80,   1,	 0,   0,   0
		dc.b	9,   0,	$10, $80,   2,	 0,   0,   0
		dc.b	9,   0,	$10, $80,   3,	 0,   0,   0
		dc.b	9,   0,	$10, $80,   4,	 0,   0,   0
		dc.b	9,   0,	$10, $80,   5,	 0,   0,   0
		dc.b	9,   0,	$14, $80,   2,	 0,   0,   0
		dc.b	9,   0,	$14, $80,   3,	 0,   0,   0
		dc.b	9,   0,	$14, $80,   4,	 0,   0,   0
		dc.b	9,   0,	$14, $80,   5,	 0,   0,   0
		dc.b	9,   0,	$14, $80,   6,	 0,   0,   0
		dc.b	9,   0,	$14, $80,   7,	 0,   0,   0
		dc.b	9,   0,	$14, $80,   8,	 0,   0,   0
		dc.b	9,   0,	$14, $80,   9,	 0,   0,   0
		dc.b	9,   0,	$14, $80,  $A,	 0,   0,   0
		dc.b	9,   0,	$14, $80,  $B,	 0,   0,   0
		dc.b	9,   0,	$14, $80,  $C,	 0,   0,   0
		dc.b	9,   0,	$18, $80,   1,	 0,   0,   0
		dc.b	9,   0,	$1C, $80,   1,	 0,   0,   0
		dc.b	9,   0,	$1C, $80,   2,	 0,   0,   0
		dc.b	9,   0,	$1C, $80,   3,	 0,   0,   0
		dc.b	9,   0,	$1C, $80,   4,	 0,   0,   0
		dc.b	9,   0,	$1C, $80,   5,	 0,   0,   0
		dc.b	9,   0,	$20, $80,   1,	 0,   0,   0
		dc.b	9,   0,	$24, $80,   2,	 0,   0,   0	; $BC
		dc.b	9, $80,	  0, $80,   1,	 0,   0,   0
		dc.b	9, $80,	  4, $80,   1,	 0,   0,   0
		dc.b	9, $80,	  8, $80,   1,	 0,   0,   0
		dc.b	9, $80,	 $C, $80,   3,	 0,   0,   0
		dc.b	9, $80,	$10, $80,   1,	 0,   0,   0
		dc.b	9, $80,	$14, $80,   1,	 0,   0,   0
		dc.b	9, $80,	$14, $80,   3,	 0,   0,   0
		dc.b	9, $80,	$14, $80,   6,	 0,   0,   0	; $C4
		dc.b	9,   0,	$1C, $80,   6,	 0,   0,   0
		dc.b	9,   0,	$1C, $80,   7,	 0,   0,   0
		dc.b	9,   0,	$1C, $80,   8,	 0,   0,   0
		dc.b	9,   0,	$1C, $80,   9,	 0,   0,   0
		dc.b	9,   0,	$1C, $80,  $A,	 0,   0,   0
; =============== S U B	R O U T	I N E =======================================


UpdateFMTrack:				; CODE XREF: UpdateSound+40p
					; UpdateSound+6Ap ...

; FUNCTION CHUNK AT 0005CE02 SIZE 0000001C BYTES

		subq.b	#1,$E(a5)
		bne.s	loc_5C162
		bclr	#4,(a5)
		jsr	sub_5C172
		jsr	sub_5C2BA
		jsr	sub_5C3FE
		bra.w	loc_5CE02
; ---------------------------------------------------------------------------

loc_5C162:				; CODE XREF: UpdateFMTrack+4j
		jsr	sub_5C242
		jsr	sub_5C418
		jsr	sub_5C26A
		bra.w	loc_5C2C6
; End of function UpdateFMTrack


; =============== S U B	R O U T	I N E =======================================


sub_5C172:				; CODE XREF: UpdateFMTrack+Ap
		movea.l	4(a5),a4
		bclr	#1,(a5)

loc_5C17A:				; CODE XREF: sub_5C172+16j
		moveq	#0,d5
		move.b	(a4)+,d5
		cmpi.b	#$E0,d5
		bcs.s	loc_5C18A
		jsr	cfHandler
		bra.s	loc_5C17A
; ---------------------------------------------------------------------------

loc_5C18A:				; CODE XREF: sub_5C172+10j
		jsr	sub_5CE1E
		tst.b	d5
		bpl.s	loc_5C1A0
		jsr	sub_5C1A8
		move.b	(a4)+,d5
		bpl.s	loc_5C1A0
		subq.w	#1,a4
		bra.w	sub_5C1FA
; ---------------------------------------------------------------------------

loc_5C1A0:				; CODE XREF: sub_5C172+1Ej
					; sub_5C172+26j
		jsr	TickMultiplier
		bra.w	sub_5C1FA
; End of function sub_5C172


; =============== S U B	R O U T	I N E =======================================


sub_5C1A8:				; CODE XREF: sub_5C172+20p

; FUNCTION CHUNK AT 0005C1F2 SIZE 00000008 BYTES

		subi.b	#$80,d5
		beq.s	loc_5C1F2
		add.b	8(a5),d5
		andi.l	#$7F,d5	; ''
		divu.w	#$C,d5
		swap	d5
		lsl.w	#1,d5
		lea	FMFreqs,a0
		move.w	(a0,d5.w),d6
		swap	d5
		andi.w	#7,d5
		moveq	#$B,d0
		lsl.w	d0,d5
		or.w	d5,d6
		move.w	d6,$10(a5)
		rts
; End of function sub_5C1A8


; =============== S U B	R O U T	I N E =======================================


TickMultiplier:				; CODE XREF: UpdateDACTrack:loc_5BE8Ap
					; sub_5C172:loc_5C1A0p	...
		move.b	d5,d0
		move.b	2(a5),d1

loc_5C1E0:				; CODE XREF: TickMultiplier+Cj
		subq.b	#1,d1
		beq.s	loc_5C1E8
		add.b	d5,d0
		bra.s	loc_5C1E0
; ---------------------------------------------------------------------------

loc_5C1E8:				; CODE XREF: TickMultiplier+8j
		move.b	d0,$F(a5)
		move.b	d0,$E(a5)
		rts
; End of function TickMultiplier

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_5C1A8

loc_5C1F2:				; CODE XREF: sub_5C1A8+4j
		bset	#1,(a5)
		clr.w	$10(a5)
; END OF FUNCTION CHUNK	FOR sub_5C1A8

; =============== S U B	R O U T	I N E =======================================


sub_5C1FA:				; CODE XREF: sub_5C172+2Aj
					; sub_5C172+32j ...
		move.l	a4,4(a5)
		move.b	$F(a5),$E(a5)
		btst	#4,(a5)
		bne.s	locret_5C240
		move.b	$13(a5),$12(a5)
		clr.b	$C(a5)
		clr.b	$26(a5)
		clr.b	3(a5)
		btst	#7,$A(a5)
		beq.s	locret_5C240
		movea.l	$14(a5),a0
		move.b	(a0)+,$18(a5)
		move.b	(a0)+,$19(a5)
		move.b	(a0)+,$1A(a5)
		move.b	(a0)+,d0
		lsr.b	#1,d0
		move.b	d0,$1B(a5)
		clr.w	$1C(a5)

locret_5C240:				; CODE XREF: sub_5C1FA+Ej
					; sub_5C1FA+28j
		rts
; End of function sub_5C1FA


; =============== S U B	R O U T	I N E =======================================


sub_5C242:				; CODE XREF: UpdateFMTrack:loc_5C162p
					; UpdatePSGTrack:loc_5D060p
		tst.b	$12(a5)
		beq.s	locret_5C268
		subq.b	#1,$12(a5)
		bne.s	locret_5C268
		bset	#1,(a5)
		tst.b	1(a5)
		bmi.w	loc_5C262
		jsr	sub_5CE1E
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

loc_5C262:				; CODE XREF: sub_5C242+14j
		jsr	sub_5D1C4
		addq.w	#4,sp

locret_5C268:				; CODE XREF: sub_5C242+4j sub_5C242+Aj
		rts
; End of function sub_5C242


; =============== S U B	R O U T	I N E =======================================


sub_5C26A:				; CODE XREF: UpdateFMTrack+22p
					; UpdatePSGTrack+1Ep
		btst	#7,$A(a5)
		beq.s	locret_5C2B8
		tst.b	$18(a5)
		beq.s	loc_5C27E
		subq.b	#1,$18(a5)
		rts
; ---------------------------------------------------------------------------

loc_5C27E:				; CODE XREF: sub_5C26A+Cj
		subq.b	#1,$19(a5)
		beq.s	loc_5C286
		rts
; ---------------------------------------------------------------------------

loc_5C286:				; CODE XREF: sub_5C26A+18j
		movea.l	$14(a5),a0
		move.b	1(a0),$19(a5)
		tst.b	$1B(a5)
		bne.s	loc_5C2A2
		move.b	3(a0),$1B(a5)
		neg.b	$1A(a5)
		rts
; ---------------------------------------------------------------------------

loc_5C2A2:				; CODE XREF: sub_5C26A+2Aj
		subq.b	#1,$1B(a5)
		move.b	$1A(a5),d6
		ext.w	d6
		add.w	$1C(a5),d6
		move.w	d6,$1C(a5)
		add.w	$10(a5),d6

locret_5C2B8:				; CODE XREF: sub_5C26A+6j
		rts
; End of function sub_5C26A


; =============== S U B	R O U T	I N E =======================================


sub_5C2BA:				; CODE XREF: UpdateFMTrack+Ep

; FUNCTION CHUNK AT 0005C3B8 SIZE 0000003E BYTES

		move.w	$10(a5),d6
		bne.s	loc_5C2CE
		bset	#1,(a5)
		rts
; ---------------------------------------------------------------------------

loc_5C2C6:				; CODE XREF: UpdateFMTrack+26j
		tst.b	$A(a5)
		beq.w	locret_5C314

loc_5C2CE:				; CODE XREF: sub_5C2BA+4j
		btst	#1,(a5)
		bne.w	locret_5C314
		btst	#2,(a5)
		bne.w	locret_5C314
		jsr	DoModEnv
		tst.b	(Drv68Kmem+$0F).w
		beq.s	loc_5C2F2
		cmpi.b	#2,1(a5)
		beq.w	loc_5C3B8

loc_5C2F2:				; CODE XREF: sub_5C2BA+2Cj
		move.w	d6,d1
		lsr.w	#8,d1
		move.b	#$A4,d0
		jsr	drv_stopz80
		jsr	WriteFMMain
		move.b	d6,d1
		move.b	#$A0,d0
		jsr	WriteFMMain
		move.w	#0,($A11100).l

locret_5C314:				; CODE XREF: sub_5C2BA+10j
					; sub_5C2BA+18j ...
		rts
; End of function sub_5C2BA


; =============== S U B	R O U T	I N E =======================================


DoModEnv:				; CODE XREF: sub_5C2BA+24p
					; sub_5D0D4+1Ep
		moveq	#0,d6
		move.b	$A(a5),d0
		andi.w	#$7F,d0
		beq.s	loc_5C366
		lea	ModEnvPtrs,a0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	(a0,d0.w),a0

loc_5C32E:				; CODE XREF: DoModEnv+70j DoModEnv+76j ...
		moveq	#0,d0
		move.b	$26(a5),d0
		addq.b	#1,$26(a5)
		move.b	(a0,d0.w),d6
		bpl.s	loc_5C35C
		cmpi.b	#$80,d6
		beq.s	loc_5C382
		cmpi.b	#$81,d6
		beq.s	loc_5C388
		cmpi.b	#$83,d6
		beq.s	loc_5C38E
		cmpi.b	#$82,d6
		beq.s	loc_5C3A0
		cmpi.b	#$84,d6
		beq.s	loc_5C3A8

loc_5C35C:				; CODE XREF: DoModEnv+26j
		ext.w	d6
		move.b	3(a5),d0
		ext.w	d0
		mulu.w	d0,d6

loc_5C366:				; CODE XREF: DoModEnv+Aj
		move.b	$1E(a5),d0
		ext.w	d0
		add.w	d0,d6
		add.w	$10(a5),d6
		tst.b	$A(a5)
		bpl.s	locret_5C37C
		add.w	$1C(a5),d6

locret_5C37C:				; CODE XREF: DoModEnv+60j
		rts
; ---------------------------------------------------------------------------
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

loc_5C382:				; CODE XREF: DoModEnv+2Cj
		clr.b	$26(a5)
		bra.s	loc_5C32E
; ---------------------------------------------------------------------------

loc_5C388:				; CODE XREF: DoModEnv+32j
		subq.b	#2,$26(a5)
		bra.s	loc_5C32E
; ---------------------------------------------------------------------------

loc_5C38E:				; CODE XREF: DoModEnv+38j
		bset	#1,(a5)
		tst.b	1(a5)
		bmi.s	loc_5C39C
		bra.w	sub_5CE1E
; ---------------------------------------------------------------------------

loc_5C39C:				; CODE XREF: DoModEnv+80j
		bra.w	sub_5D1C4
; ---------------------------------------------------------------------------

loc_5C3A0:				; CODE XREF: DoModEnv+3Ej
		move.b	1(a0,d0.w),$26(a5)
		bra.s	loc_5C32E
; ---------------------------------------------------------------------------

loc_5C3A8:				; CODE XREF: DoModEnv+44j
		move.b	1(a0,d0.w),d0
		add.b	d0,3(a5)
		addq.b	#1,$26(a5)
		bra.w	loc_5C32E
; End of function DoModEnv

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_5C2BA

loc_5C3B8:				; CODE XREF: sub_5C2BA+34j
		lea	SpcFM3Regs,a1
		lea	(Drv68Kmem+$10).w,a2
		tst.b	(Drv68Kmem+$0E).w
		beq.s	loc_5C3CA
		lea	(Drv68Kmem+$18).w,a2

loc_5C3CA:				; CODE XREF: sub_5C2BA+10Aj
		moveq	#3,d5
		jsr	drv_stopz80

loc_5C3D0:				; CODE XREF: sub_5C2BA+12Ej
		move.w	d6,d1
		move.w	(a2)+,d0
		add.w	d0,d1
		move.w	d1,d3
		lsr.w	#8,d1
		move.b	(a1)+,d0
		jsr	WriteFMI
		move.b	d3,d1
		move.b	(a1)+,d0
		jsr	WriteFMI
		dbf	d5,loc_5C3D0
		move.w	#0,($A11100).l
		rts
; END OF FUNCTION CHUNK	FOR sub_5C2BA
; ---------------------------------------------------------------------------
SpcFM3Regs:	dc.b $AD, $A9, $AC, $A8, $AE, $AA, $A6,	$A2
					; DATA XREF: sub_5C2BA:loc_5C3B8o

; =============== S U B	R O U T	I N E =======================================


sub_5C3FE:				; CODE XREF: UpdateFMTrack+12p
		btst	#1,(a5)
		bne.s	locret_5C410
		moveq	#0,d0
		move.b	$1F(a5),d0
		lsl.w	#1,d0
		jmp	locret_5C410(pc,d0.w)

locret_5C410:				; CODE XREF: sub_5C3FE+4j
		rts
; End of function sub_5C3FE

; ---------------------------------------------------------------------------
		bra.s	loc_5C43C
; ---------------------------------------------------------------------------
		bra.s	loc_5C432
; ---------------------------------------------------------------------------
		bra.s	loc_5C432

; =============== S U B	R O U T	I N E =======================================


sub_5C418:				; CODE XREF: UpdateFMTrack+1Ep
		btst	#1,(a5)
		bne.s	locret_5C42A
		moveq	#0,d0
		move.b	$1F(a5),d0
		lsl.w	#1,d0
		jmp	locret_5C42A(pc,d0.w)

locret_5C42A:				; CODE XREF: sub_5C418+4j
		rts
; End of function sub_5C418

; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------
		bra.s	loc_5C43C
; ---------------------------------------------------------------------------
		bra.s	loc_5C43C
; ---------------------------------------------------------------------------

loc_5C432:				; CODE XREF: ROM:0005C414j
					; ROM:0005C416j
		move.b	$23(a5),$24(a5)
		clr.b	$21(a5)

loc_5C43C:				; CODE XREF: ROM:0005C412j
					; ROM:0005C42Ej ...
		move.b	$24(a5),d0
		cmp.b	$23(a5),d0
		bne.s	loc_5C464
		move.b	$22(a5),d3
		cmp.b	$21(a5),d3
		bpl.s	loc_5C45C
		cmpi.b	#2,$1F(a5)
		beq.s	locret_5C490
		clr.b	$21(a5)

loc_5C45C:				; CODE XREF: ROM:0005C44Ej
		clr.b	$24(a5)
		addq.b	#1,$21(a5)

loc_5C464:				; CODE XREF: ROM:0005C444j
		moveq	#0,d0
		move.b	$20(a5),d0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	PanAniPtrList(pc,d0.w),a0
		moveq	#0,d0
		move.b	$21(a5),d0
		subq.w	#1,d0
		move.b	(a0,d0.w),d1
		move.b	$27(a5),d0
		andi.b	#$37,d0
		or.b	d0,d1
		jsr	SendPan
		addq.b	#1,$24(a5)

locret_5C490:				; CODE XREF: ROM:0005C456j
		rts
; ---------------------------------------------------------------------------
PanAniPtrList:	dc.l byte_5C49E, byte_5C4A0, byte_5C4A3	; DATA XREF: ROM:0005C46Er
byte_5C49E:	dc.b $40, $80		; DATA XREF: ROM:PanAniPtrListo
byte_5C4A0:	dc.b $40, $C0, $80	; DATA XREF: ROM:PanAniPtrListo
byte_5C4A3:	dc.b $C0, $80, $C0, $40	; DATA XREF: ROM:PanAniPtrListo
		even

; =============== S U B	R O U T	I N E =======================================


SendPan:				; CODE XREF: ROM:0005C488p
					; cfHandler+BAj ...
		btst	#2,(a5)
		bne.s	locret_5C4EA
		jsr	drv_stopz80
		cmpi.b	#6,1(a5)
		bne.w	loc_5C4DA
		cmpa.l	#$40,a5
		beq.w	loc_5C4E2
		tst.b	($A01FFD).l
		beq.w	loc_5C4DA
		move.b	$27(a5),($A01FF8).l
		bra.s	loc_5C4E2
; ---------------------------------------------------------------------------

loc_5C4DA:				; CODE XREF: SendPan+10j SendPan+24j
		move.b	#$B4,d0
		jsr	WriteFMMain

loc_5C4E2:				; CODE XREF: SendPan+1Aj SendPan+30j
		move.w	#0,($A11100).l

locret_5C4EA:				; CODE XREF: SendPan+4j
		rts
; End of function SendPan

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR UpdateSound

PauseMusic:				; CODE XREF: UpdateSound+8j
		cmpi.b	#$FF,(Drv68Kmem+$07).w
		bne.w	loc_5C4F8
		rts
; ---------------------------------------------------------------------------

loc_5C4F8:				; CODE XREF: UpdateSound+74Aj
		tst.b	(Drv68Kmem+$07).w
		bmi.s	loc_5C536
		move.b	#$FF,(Drv68Kmem+$07).w
		moveq	#2,d2
		move.b	#$B4,d0
		moveq	#0,d1
		jsr	drv_stopz80

loc_5C510:				; CODE XREF: UpdateSound+772j
		jsr	WriteFMI
		jsr	sub_5CE92
		addq.b	#1,d0
		dbf	d2,loc_5C510
		moveq	#2,d2
		moveq	#$28,d0

loc_5C522:				; CODE XREF: UpdateSound+786j
		move.b	d2,d1
		jsr	WriteFMI
		addq.b	#4,d1
		jsr	WriteFMI
		dbf	d2,loc_5C522
		bra.w	loc_5D1DA
; ---------------------------------------------------------------------------

loc_5C536:				; CODE XREF: UpdateSound+754j
		clr.b	(Drv68Kmem+$07).w
		moveq	#$30,d3	; '0'
		jsr	drv_stopz80
		tst.b	($A01FFD).l
		beq.w	loc_5C564
		bmi.w	loc_5C556
		move.b	($A01FF9).l,d1
		bra.s	loc_5C55C
; ---------------------------------------------------------------------------

loc_5C556:				; CODE XREF: UpdateSound+7A2j
		move.b	($A01FFA).l,d1

loc_5C55C:				; CODE XREF: UpdateSound+7ACj
		move.b	#$B6,d0
		jsr	sub_5CE92

loc_5C564:				; CODE XREF: UpdateSound+79Ej
		lea	(Drv68Kmem+$70).w,a5
		moveq	#5,d4

loc_5C56A:				; CODE XREF: UpdateSound+7D4j
		btst	#7,(a5)
		beq.s	loc_5C57A
		btst	#2,(a5)
		bne.s	loc_5C57A
		jsr	sub_5C5BA

loc_5C57A:				; CODE XREF: UpdateSound+7C6j
					; UpdateSound+7CCj
		adda.w	d3,a5
		dbf	d4,loc_5C56A
		lea	(Drv68Kmem+$220).w,a5
		moveq	#2,d4

loc_5C586:				; CODE XREF: UpdateSound+7F0j
		btst	#7,(a5)
		beq.s	loc_5C596
		btst	#2,(a5)
		bne.s	loc_5C596
		jsr	sub_5C5BA

loc_5C596:				; CODE XREF: UpdateSound+7E2j
					; UpdateSound+7E8j
		adda.w	d3,a5
		dbf	d4,loc_5C586
		lea	(Drv68Kmem+$340).w,a5
		btst	#7,(a5)
		beq.s	loc_5C5B0
		btst	#2,(a5)
		bne.s	loc_5C5B0
		jsr	sub_5C5BA

loc_5C5B0:				; CODE XREF: UpdateSound+7FCj
					; UpdateSound+802j
		move.w	#0,($A11100).l
		rts
; END OF FUNCTION CHUNK	FOR UpdateSound

; =============== S U B	R O U T	I N E =======================================


sub_5C5BA:				; CODE XREF: UpdateSound+7CEp
					; UpdateSound+7EAp ...
		cmpi.b	#6,1(a5)
		bne.w	loc_5C5CE
		tst.b	($A01FFD).l
		bne.w	locret_5C5DA

loc_5C5CE:				; CODE XREF: sub_5C5BA+6j
		move.b	$27(a5),d1
		move.b	#$B4,d0
		jmp	WriteFMMain
; ---------------------------------------------------------------------------

locret_5C5DA:				; CODE XREF: sub_5C5BA+10j
		rts
; End of function sub_5C5BA


; =============== S U B	R O U T	I N E =======================================


DoSoundQueue:				; CODE XREF: UpdateSound+1Ep
		lea	SndPriorities,a0
		lea	(Drv68Kmem+$0E).w,a1
		move.b	(Drv68Kmem+$00).w,d3
		moveq	#3,d4

loc_5C5EA:				; CODE XREF: DoSoundQueue:loc_5C60Aj
		move.b	-(a1),d0
		move.b	d0,d1
		clr.b	(a1)
		subq.b	#1,d0
		bcs.s	loc_5C60A
		andi.w	#$FF,d0
		move.b	(a0,d0.w),d2
		bmi.w	loc_5C610
		cmp.b	d3,d2
		bcs.s	loc_5C60A
		move.b	d2,d3
		move.b	d1,(Drv68Kmem+$09).w

loc_5C60A:				; CODE XREF: DoSoundQueue+16j
					; DoSoundQueue+26j
		dbf	d4,loc_5C5EA
		bra.s	loc_5C630
; ---------------------------------------------------------------------------

loc_5C610:				; CODE XREF: DoSoundQueue+20j
		move.b	d2,d3
		move.b	d1,(Drv68Kmem+$09).w
		bra.s	loc_5C62C
; ---------------------------------------------------------------------------

loc_5C618:				; CODE XREF: DoSoundQueue:loc_5C62Cj
		move.b	-(a1),d0
		subq.b	#1,d0
		bcs.s	loc_5C62A
		andi.w	#$FF,d0
		move.b	(a0,d0.w),d2
		bmi.w	loc_5C62C

loc_5C62A:				; CODE XREF: DoSoundQueue+40j
		clr.b	(a1)

loc_5C62C:				; CODE XREF: DoSoundQueue+3Aj
					; DoSoundQueue+4Aj
		dbf	d4,loc_5C618

loc_5C630:				; CODE XREF: DoSoundQueue+32j
		tst.b	d3
		bmi.s	locret_5C638
		move.b	d3,(Drv68Kmem+$00).w

locret_5C638:				; CODE XREF: DoSoundQueue+56j
		rts
; End of function DoSoundQueue


; =============== S U B	R O U T	I N E =======================================


PlaySoundID:				; CODE XREF: UpdateSound:loc_5BDCAp

; FUNCTION CHUNK AT 0005CC34 SIZE 0000001A BYTES
; FUNCTION CHUNK AT 0005CD5A SIZE 00000024 BYTES

		moveq	#0,d7
		move.b	(Drv68Kmem+$09).w,d7
		move.b	#$FF,(Drv68Kmem+$09).w
		tst.b	d7
		cmpi.b	#$FF,d7
		beq.s	locret_5C68A
		cmpi.b	#1,d7
		bcs.w	StopAllSound
		cmpi.b	#$10,d7
		bcs.w	PlaySnd_Command
		cmpi.b	#$40,d7
		bcs.w	PlayDACSFX	; 10-3F	- DAC SFX
		cmpi.b	#$81,d7
		bcs.w	PlaySFX2	; 40-7F	- SFX (2)
		cmpi.b	#$AB,d7
		bcs.w	PlayMusic	; 81-AA	- Music
		cmpi.b	#$FB,d7
		bcs.w	PlaySFX		; AB-FA	- SFX (1)
		cmpi.b	#$FD,d7
		bcs.w	PlaySpcSFX	; FD-FE	- Special SFX

locret_5C68A:				; CODE XREF: PlaySoundID+16j
		rts
; ---------------------------------------------------------------------------

PlaySnd_Command:			; CODE XREF: PlaySoundID+24j
		cmpi.b	#5,d7
		bcs.w	loc_5C696
		rts
; ---------------------------------------------------------------------------

loc_5C696:				; CODE XREF: PlaySoundID+56j
		subq.b	#1,d7
		lsl.w	#2,d7
		jmp	CmdJmpTable(pc,d7.w)

CmdJmpTable:
		bra.w	FadeOutMusic
; ---------------------------------------------------------------------------
		bra.w	StopSFX
; ---------------------------------------------------------------------------
		bra.w	StopSpcSFX
; ---------------------------------------------------------------------------
		bra.w	StopAllSound
; ---------------------------------------------------------------------------

PlayDACSFX:				; CODE XREF: PlaySoundID+2Cj
		cmpi.b	#$28,d7
		bcc.w	locret_5C734
		subi.b	#$10,d7
		ext.w	d7
		asl.w	#3,d7
		lea	DACSFX_Table(pc,d7.w),a3
		jsr	drv_stopz80
		move.b	($A01FFC).l,d0
		andi.b	#$C0,d0
		move.b	5(a3),d1
		andi.b	#$C0,d1
		cmp.b	d0,d1
		bcs.w	loc_5C72C
		move.b	#$80,($A01FFD).l
		move.b	(a3)+,($A01FE8).l
		move.b	(a3)+,($A01FE9).l
		move.b	(a3)+,($A01FE6).l
		move.b	(a3)+,($A01FE7).l
		move.b	(a3)+,($A01FFE).l
		move.b	(a3)+,($A01FFB).l
		btst	#5,($A01FFB).l
		beq.w	loc_5C726
		cmpi.b	#2,(Drv68Kmem+$2B).w
		beq.w	loc_5C726
		move.b	#1,(Drv68Kmem+$2B).w

loc_5C726:				; CODE XREF: PlaySoundID+D8j
					; PlaySoundID+E2j
		move.b	(a3),($A01FFA).l

loc_5C72C:				; CODE XREF: PlaySoundID+A0j
		move.w	#0,($A11100).l

locret_5C734:				; CODE XREF: PlaySoundID+78j
		rts
; ---------------------------------------------------------------------------
DACSFX_Table:				; DATA XREF: PlaySoundID+84o
		dc.b   $A,   0,	  0, $80, $13,	 0, $C0,   0
		dc.b   $A,   0,	  0, $80, $36,	 0, $C0,   0
		dc.b   $A,   0,	  0, $80,   8,	 0, $C0,   0
		dc.b   $A,   0,	  4, $80,   1,	 0, $C0,   0
		dc.b   $A,   0,	  8, $80,   2,	 0, $C0,   0
		dc.b   $A,   0,	 $C, $80,   1,	 0, $C0,   0
		dc.b   $A,   0,	$10, $80,   2, $E0, $C0,   0
		dc.b   $A,   0,	$14, $80,   2,	 0, $C0,   0
		dc.b   $A,   0,	$18, $80,   2, $80, $C0,   0
		dc.b   $A, $80,	  0, $80,   2, $E0, $C0,   0
		dc.b   $A, $80,	  4, $80,   2, $80, $C0,   0
		dc.b   $A, $80,	  8, $80,   2, $80, $C0,   0
		dc.b   $B,   0,	  0, $80,   2, $80, $C0,   0
		dc.b   $B,   0,	  4, $80,   2, $E0, $C0,   0
		dc.b   $B, $80,	  0, $80,   2, $E0, $C0,   0
		dc.b   $B, $80,	  4, $80,   2, $80, $C0,   0
		dc.b   $B, $80,	  8, $80,   2, $80, $C0,   0
		dc.b   $B, $80,	 $C, $80,   2, $80, $C0,   0
		dc.b   $C,   0,	  0, $80,   2, $80, $C0,   0
		dc.b   $C,   0,	  4, $80,   2, $80, $C0,   0
		dc.b   $C,   0,	  8, $80,   2, $80, $C0,   0
		dc.b   $C,   0,	 $C, $80,   2, $80, $C0,   0
		dc.b   $C,   0,	$10, $80,   2, $80, $C0,   0
		dc.b   $C, $80,	  0, $80,   2, $80, $C0,   0
; ---------------------------------------------------------------------------

PlayMusic:				; CODE XREF: PlaySoundID+3Cj
		cmpi.b	#$AB,d7
		bcs.w	loc_5C800
		rts
; ---------------------------------------------------------------------------

loc_5C800:				; CODE XREF: PlaySoundID+1C0j
		jsr	StopSFX
		jsr	StopSpcSFX
		jsr	SilenceFM
		lea	MusPtrs,a4
		subi.b	#$81,d7
		lsl.w	#2,d7
		movea.l	(a4,d7.w),a4
		moveq	#0,d0
		move.w	(a4),d0
		add.l	a4,d0
		move.l	d0,(Drv68Kmem+$20).w
		move.b	5(a4),(Drv68Kmem+$02).w
		move.b	5(a4),(Drv68Kmem+$01).w
		moveq	#0,d1
		movea.l	a4,a3
		addq.w	#6,a4
		moveq	#0,d7
		move.b	2(a3),d7
		beq.s	loc_5C884
		subq.b	#1,d7
		move.b	#$C0,d1
		move.b	#$80,d3
		move.b	4(a3),d4
		moveq	#$30,d6
		move.b	#1,d5
		lea	(Drv68Kmem+$40).w,a1
		lea	FMInitBytes,a2

loc_5C85A:				; CODE XREF: PlaySoundID+246j
		move.b	d3,(a1)
		move.b	(a2)+,1(a1)
		move.b	d4,2(a1)
		move.b	d6,$D(a1)
		move.b	d1,$27(a1)
		move.b	d5,$E(a1)
		moveq	#0,d0
		move.w	(a4)+,d0
		add.l	a3,d0
		move.l	d0,4(a1)
		move.w	(a4)+,8(a1)
		adda.w	d6,a1
		dbf	d7,loc_5C85A

loc_5C884:				; CODE XREF: PlaySoundID+202j
		moveq	#0,d7
		move.b	3(a3),d7
		beq.s	loc_5C8C4
		subq.b	#1,d7
		lea	(Drv68Kmem+$190).w,a1
		lea	PSGInitBytes,a2

loc_5C896:				; CODE XREF: PlaySoundID+286j
		move.b	d3,(a1)
		move.b	(a2)+,1(a1)
		move.b	d4,2(a1)
		move.b	d6,$D(a1)
		move.b	d5,$E(a1)
		moveq	#0,d0
		move.w	(a4)+,d0
		add.l	a3,d0
		move.l	d0,4(a1)
		move.w	(a4)+,8(a1)
		move.b	(a4)+,$A(a1)
		move.b	(a4)+,$B(a1)
		adda.w	d6,a1
		dbf	d7,loc_5C896

loc_5C8C4:				; CODE XREF: PlaySoundID+250j
		lea	(Drv68Kmem+$220).w,a1
		moveq	#5,d7

loc_5C8CA:				; CODE XREF: PlaySoundID+2B4j
		tst.b	(a1)
		bpl.w	loc_5C8EC
		moveq	#0,d0
		move.b	1(a1),d0
		bmi.s	loc_5C8DE
		subq.b	#2,d0
		lsl.b	#2,d0
		bra.s	loc_5C8E0
; ---------------------------------------------------------------------------

loc_5C8DE:				; CODE XREF: PlaySoundID+29Cj
		lsr.b	#3,d0

loc_5C8E0:				; CODE XREF: PlaySoundID+2A2j
		lea	BGMChnPtrs,a0
		movea.l	(a0,d0.w),a0
		bset	#2,(a0)

loc_5C8EC:				; CODE XREF: PlaySoundID+292j
		adda.w	d6,a1
		dbf	d7,loc_5C8CA
		tst.w	(Drv68Kmem+$340).w
		bpl.s	loc_5C8FE
		bset	#2,(Drv68Kmem+$100).w

loc_5C8FE:				; CODE XREF: PlaySoundID+2BCj
		tst.w	(Drv68Kmem+$370).w
		bpl.s	loc_5C90A
		bset	#2,(Drv68Kmem+$1F0).w

loc_5C90A:				; CODE XREF: PlaySoundID+2C8j
		lea	(Drv68Kmem+$70).w,a5
		moveq	#5,d4

loc_5C910:				; CODE XREF: PlaySoundID+2DCj
		jsr	sub_5CE1E
		adda.w	d6,a5
		dbf	d4,loc_5C910
		moveq	#2,d4

loc_5C91C:				; CODE XREF: PlaySoundID+2E8j
		jsr	sub_5D1C4
		adda.w	d6,a5
		dbf	d4,loc_5C91C
		btst	#2,(Drv68Kmem+$1F0).w
		bne.s	loc_5C936
		move.b	#$FF,($C00011).l

loc_5C936:				; CODE XREF: PlaySoundID+2F2j
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------
FMInitBytes:				; DATA XREF: PlaySoundID+21Co
		dc.b 6,	0, 1, 2, 4, 5, 6
		align 2
PSGInitBytes:				; DATA XREF: PlaySoundID+258o
		dc.b $80, $A0, $C0
		align 2

PlaySFX2:				; CODE XREF: PlaySoundID+34j
		cmpi.b	#$6F,d7
		bcs.w	loc_5C950
		rts
; ---------------------------------------------------------------------------

loc_5C950:				; CODE XREF: PlaySoundID+310j
		lea	SFXPtrs2,a0
		subi.b	#$40,d7
		bra.w	loc_5C96E
; ---------------------------------------------------------------------------

PlaySFX:				; CODE XREF: PlaySoundID+44j
		cmpi.b	#$FB,d7
		bcs.w	loc_5C966
		rts
; ---------------------------------------------------------------------------

loc_5C966:				; CODE XREF: PlaySoundID+326j
		lea	SFXPtrs,a0
		subi.b	#$AB,d7

loc_5C96E:				; CODE XREF: PlaySoundID+31Ej
		lsl.w	#2,d7
		movea.l	(a0,d7.w),a3
		movea.l	a3,a1
		moveq	#0,d1
		move.w	(a1)+,d1
		add.l	a3,d1
		move.b	(a1)+,d5
		moveq	#0,d7
		move.b	(a1)+,d7
		subq.w	#1,d7
		moveq	#$30,d6

loc_5C986:				; CODE XREF: PlaySoundID:loc_5CA02j
		moveq	#0,d3
		move.b	1(a1),d3
		move.b	d3,d4
		bmi.s	loc_5C9A2
		subq.w	#2,d3
		lsl.w	#2,d3
		lea	BGMChnPtrs,a5
		movea.l	(a5,d3.w),a5
		bset	#2,(a5)
		bra.s	loc_5C9C8
; ---------------------------------------------------------------------------

loc_5C9A2:				; CODE XREF: PlaySoundID+354j
		lsr.w	#3,d3
		movea.l	BGMChnPtrs(pc,d3.w),a5
		bset	#2,(a5)
		cmpi.b	#$C0,d4
		bne.s	loc_5C9C8
		move.b	d4,d0
		ori.b	#$1F,d0
		move.b	d0,($C00011).l
		bchg	#5,d0
		move.b	d0,($C00011).l

loc_5C9C8:				; CODE XREF: PlaySoundID+366j
					; PlaySoundID+376j
		movea.l	SFXChnPtrs(pc,d3.w),a5
		movea.l	a5,a2
		moveq	#$B,d0

loc_5C9D0:				; CODE XREF: PlaySoundID+398j
		clr.l	(a2)+
		dbf	d0,loc_5C9D0
		move.l	d1,$20(a5)
		move.w	(a1)+,(a5)
		move.b	d5,2(a5)
		moveq	#0,d0
		move.w	(a1)+,d0
		add.l	a3,d0
		move.l	d0,4(a5)
		move.w	(a1)+,8(a5)
		move.b	#1,$E(a5)
		move.b	d6,$D(a5)
		tst.b	d4
		bmi.s	loc_5CA02
		move.b	#$C0,$27(a5)

loc_5CA02:				; CODE XREF: PlaySoundID+3C0j
		dbf	d7,loc_5C986
		tst.b	(Drv68Kmem+$250).w
		bpl.s	loc_5CA12
		bset	#2,(Drv68Kmem+$340).w

loc_5CA12:				; CODE XREF: PlaySoundID+3D0j
		tst.b	(Drv68Kmem+$310).w
		bpl.s	locret_5CA1E
		bset	#2,(Drv68Kmem+$370).w

locret_5CA1E:				; CODE XREF: PlaySoundID+3DCj
		rts
; ---------------------------------------------------------------------------
BGMChnPtrs:	dc.l Drv68Kmem+$D0		; DATA XREF: PlaySoundID:loc_5C8E0o
					; PlaySoundID+35Ao ...
		dc.l 0
		dc.l Drv68Kmem+$100
		dc.l Drv68Kmem+$130
		dc.l Drv68Kmem+$190
		dc.l Drv68Kmem+$1C0
		dc.l Drv68Kmem+$1F0
		dc.l Drv68Kmem+$1F0
SFXChnPtrs:				; DATA XREF: PlaySoundID:loc_5C9C8r
		dc.l Drv68Kmem+$220
		dc.l 0
		dc.l Drv68Kmem+$250
		dc.l Drv68Kmem+$280
		dc.l Drv68Kmem+$2B0
		dc.l Drv68Kmem+$2E0
		dc.l Drv68Kmem+$310
		dc.l Drv68Kmem+$310
; ---------------------------------------------------------------------------

PlaySpcSFX:				; CODE XREF: PlaySoundID+4Cj
		cmpi.b	#$FD,d7
		bcs.w	loc_5CA6A
		rts
; ---------------------------------------------------------------------------

loc_5CA6A:				; CODE XREF: PlaySoundID+42Aj
		lea	SpcSFXPtrs,a0
		subi.b	#$FB,d7
		lsl.w	#2,d7
		movea.l	(a0,d7.w),a3
		movea.l	a3,a1
		moveq	#0,d0
		move.w	(a1)+,d0
		add.l	a3,d0
		move.l	d0,(Drv68Kmem+$24).w
		move.b	(a1)+,d5
		moveq	#0,d7
		move.b	(a1)+,d7
		subq.w	#1,d7
		moveq	#$30,d6

loc_5CA8E:				; CODE XREF: PlaySoundID:loc_5CADCj
		move.b	1(a1),d4
		bmi.s	loc_5CAA0
		bset	#2,(Drv68Kmem+$100).w
		lea	(Drv68Kmem+$340).w,a5
		bra.s	loc_5CAAA
; ---------------------------------------------------------------------------

loc_5CAA0:				; CODE XREF: PlaySoundID+458j
		bset	#2,(Drv68Kmem+$1F0).w
		lea	(Drv68Kmem+$370).w,a5

loc_5CAAA:				; CODE XREF: PlaySoundID+464j
		movea.l	a5,a2
		moveq	#$B,d0

loc_5CAAE:				; CODE XREF: PlaySoundID+476j
		clr.l	(a2)+
		dbf	d0,loc_5CAAE
		move.w	(a1)+,(a5)
		move.b	d5,2(a5)
		moveq	#0,d0
		move.w	(a1)+,d0
		add.l	a3,d0
		move.l	d0,4(a5)
		move.w	(a1)+,8(a5)
		move.b	#1,$E(a5)
		move.b	d6,$D(a5)
		tst.b	d4
		bmi.s	loc_5CADC
		move.b	#$C0,$27(a5)

loc_5CADC:				; CODE XREF: PlaySoundID+49Aj
		dbf	d7,loc_5CA8E
		tst.b	(Drv68Kmem+$250).w
		bpl.s	loc_5CAEC
		bset	#2,(Drv68Kmem+$340).w

loc_5CAEC:				; CODE XREF: PlaySoundID+4AAj
		tst.b	(Drv68Kmem+$310).w
		bpl.s	locret_5CB0C
		bset	#2,(Drv68Kmem+$370).w
		ori.b	#$1F,d4
		move.b	d4,($C00011).l
		bchg	#5,d4
		move.b	d4,($C00011).l

locret_5CB0C:				; CODE XREF: PlaySoundID+4B6j
		rts
; End of function PlaySoundID

; ---------------------------------------------------------------------------
		dc.l Drv68Kmem+$100
		dc.l Drv68Kmem+$1F0
		dc.l Drv68Kmem+$250
		dc.l Drv68Kmem+$310
		dc.l Drv68Kmem+$340
		dc.l Drv68Kmem+$370

; =============== S U B	R O U T	I N E =======================================


StopSFX:				; CODE XREF: PlaySoundID+68j
					; PlaySoundID:loc_5C800p ...
		clr.b	(Drv68Kmem+$00).w
		moveq	#$27,d0	; '''
		moveq	#0,d1
		jsr	WriteFMI_Z
		lea	(Drv68Kmem+$220).w,a5
		moveq	#5,d6

loc_5CB38:				; CODE XREF: StopSFX+9Ej
		tst.b	(a5)
		bpl.w	loc_5CBC0
		bclr	#7,(a5)
		moveq	#0,d3
		move.b	1(a5),d3
		bmi.s	loc_5CB8A
		jsr	sub_5CE1E
		cmpi.b	#4,d3
		bne.s	loc_5CB64
		tst.b	(Drv68Kmem+$340).w
		bpl.s	loc_5CB64
		lea	(Drv68Kmem+$340).w,a5
		movea.l	(Drv68Kmem+$24).w,a1
		bra.s	loc_5CB76
; ---------------------------------------------------------------------------

loc_5CB64:				; CODE XREF: StopSFX+2Cj StopSFX+32j
		subq.b	#2,d3
		lsl.b	#2,d3
		lea	BGMChnPtrs,a0
		movea.l	a5,a3
		movea.l	(a0,d3.w),a5
		movea.l	(Drv68Kmem+$20).w,a1

loc_5CB76:				; CODE XREF: StopSFX+3Cj
		bclr	#2,(a5)
		bset	#1,(a5)
		move.b	$B(a5),d0
		jsr	SendFMIns
		movea.l	a3,a5
		bra.s	loc_5CBC0
; ---------------------------------------------------------------------------

loc_5CB8A:				; CODE XREF: StopSFX+22j
		jsr	sub_5D1C4
		lea	(Drv68Kmem+$370).w,a0
		cmpi.b	#$E0,d3
		beq.s	loc_5CBA8
		cmpi.b	#$C0,d3
		beq.s	loc_5CBA8
		lsr.b	#3,d3
		lea	BGMChnPtrs,a0
		movea.l	(a0,d3.w),a0

loc_5CBA8:				; CODE XREF: StopSFX+70j StopSFX+76j
		bclr	#2,(a0)
		bset	#1,(a0)
		cmpi.b	#$E0,1(a0)
		bne.s	loc_5CBC0
		move.b	$25(a0),($C00011).l

loc_5CBC0:				; CODE XREF: StopSFX+14j StopSFX+62j ...
		adda.w	#$30,a5	; '0'
		dbf	d6,loc_5CB38
		rts
; End of function StopSFX


; =============== S U B	R O U T	I N E =======================================


StopSpcSFX:				; CODE XREF: PlaySoundID+6Cj
					; PlaySoundID+1CAp ...
		lea	(Drv68Kmem+$340).w,a5
		tst.b	(a5)
		bpl.s	loc_5CBFC
		bclr	#7,(a5)
		btst	#2,(a5)
		bne.s	loc_5CBFC
		jsr	sub_5CE2A
		lea	(Drv68Kmem+$100).w,a5
		bclr	#2,(a5)
		bset	#1,(a5)
		tst.b	(a5)
		bpl.s	loc_5CBFC
		movea.l	(Drv68Kmem+$20).w,a1
		move.b	$B(a5),d0
		jsr	SendFMIns

loc_5CBFC:				; CODE XREF: StopSpcSFX+6j
					; StopSpcSFX+10j ...
		lea	(Drv68Kmem+$370).w,a5
		tst.b	(a5)
		bpl.s	locret_5CC32
		bclr	#7,(a5)
		btst	#2,(a5)
		bne.s	locret_5CC32
		jsr	sub_5D1CA
		lea	(Drv68Kmem+$1F0).w,a5
		bclr	#2,(a5)
		bset	#1,(a5)
		tst.b	(a5)
		bpl.s	locret_5CC32
		cmpi.b	#$E0,1(a5)
		bne.s	locret_5CC32
		move.b	$25(a5),($C00011).l

locret_5CC32:				; CODE XREF: StopSpcSFX+38j
					; StopSpcSFX+42j ...
		rts
; End of function StopSpcSFX

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR PlaySoundID

FadeOutMusic:				; CODE XREF: PlaySoundID:CmdJmpTablej
		jsr	StopSFX
		jsr	StopSpcSFX
		move.b	#3,(Drv68Kmem+$06).w
		move.b	#$28,(Drv68Kmem+$04).w
		clr.b	(Drv68Kmem+$40).w
		rts
; END OF FUNCTION CHUNK	FOR PlaySoundID

; =============== S U B	R O U T	I N E =======================================


DoFadeOut:				; CODE XREF: UpdateSound+14p
		moveq	#0,d0
		move.b	(Drv68Kmem+$04).w,d0
		beq.s	locret_5CC60
		move.b	(Drv68Kmem+$06).w,d0
		beq.s	loc_5CC62
		subq.b	#1,(Drv68Kmem+$06).w

locret_5CC60:				; CODE XREF: DoFadeOut+6j
		rts
; ---------------------------------------------------------------------------

loc_5CC62:				; CODE XREF: DoFadeOut+Cj
		subq.b	#1,(Drv68Kmem+$04).w
		beq.w	StopAllSound
		move.b	#3,(Drv68Kmem+$06).w
		lea	(Drv68Kmem+$70).w,a5
		moveq	#5,d7

loc_5CC76:				; CODE XREF: DoFadeOut+40j
		tst.b	(a5)
		bpl.s	loc_5CC8A
		addq.b	#1,9(a5)
		bpl.s	loc_5CC86
		bclr	#7,(a5)
		bra.s	loc_5CC8A
; ---------------------------------------------------------------------------

loc_5CC86:				; CODE XREF: DoFadeOut+30j
		jsr	RefreshVolume

loc_5CC8A:				; CODE XREF: DoFadeOut+2Aj
					; DoFadeOut+36j
		adda.w	#$30,a5	; '0'
		dbf	d7,loc_5CC76
		moveq	#2,d7

loc_5CC94:				; CODE XREF: DoFadeOut+68j
		tst.b	(a5)
		bpl.s	loc_5CCB2
		addq.b	#1,9(a5)
		cmpi.b	#$10,9(a5)
		bcs.s	loc_5CCAA
		bclr	#7,(a5)
		bra.s	loc_5CCB2
; ---------------------------------------------------------------------------

loc_5CCAA:				; CODE XREF: DoFadeOut+54j
		move.b	9(a5),d6
		jsr	sub_5D172

loc_5CCB2:				; CODE XREF: DoFadeOut+48j
					; DoFadeOut+5Aj
		adda.w	#$30,a5	; '0'
		dbf	d7,loc_5CC94
		rts
; End of function DoFadeOut


; =============== S U B	R O U T	I N E =======================================


DoTempo:				; CODE XREF: UpdateSound+10p
		tst.b	(Drv68Kmem+$02).w
		beq.s	locret_5CCE4
		subq.b	#1,(Drv68Kmem+$01).w
		bne.s	locret_5CCE4
		move.b	(Drv68Kmem+$02).w,(Drv68Kmem+$01).w
		lea	(Drv68Kmem+$40).w,a0
		moveq	#$30,d0
		moveq	#9,d1

loc_5CCD6:				; CODE XREF: DoTempo+24j
		tst.b	(a0)
		bpl.s	loc_5CCDE
		addq.b	#1,$E(a0)

loc_5CCDE:				; CODE XREF: DoTempo+1Cj
		adda.w	d0,a0
		dbf	d1,loc_5CCD6

locret_5CCE4:				; CODE XREF: DoTempo+4j DoTempo+Aj
		rts
; End of function DoTempo


; =============== S U B	R O U T	I N E =======================================


SilenceFMChn:				; CODE XREF: cfHandler:cfE3_SilenceTrkp
		jsr	drv_stopz80
		moveq	#3,d4
		moveq	#$40,d3
		moveq	#$7F,d1

loc_5CCF0:				; CODE XREF: SilenceFMChn+12j
		move.b	d3,d0
		jsr	WriteFMMain
		addq.b	#4,d3
		dbf	d4,loc_5CCF0
		moveq	#3,d4
		move.b	#$80,d3
		moveq	#$F,d1

loc_5CD04:				; CODE XREF: SilenceFMChn+26j
		move.b	d3,d0
		jsr	WriteFMMain
		addq.b	#4,d3
		dbf	d4,loc_5CD04
		move.w	#0,($A11100).l
		rts
; End of function SilenceFMChn


; =============== S U B	R O U T	I N E =======================================


sub_5CD1A:				; CODE XREF: PlaySoundID+73Cp
		moveq	#2,d2
		moveq	#$28,d0	; '('
		jsr	drv_stopz80

loc_5CD22:				; CODE XREF: sub_5CD1A+14j
		move.b	d2,d1
		jsr	WriteFMI
		addq.b	#4,d1
		jsr	WriteFMI
		dbf	d2,loc_5CD22
		moveq	#$40,d0	; '@'
		moveq	#$7F,d1	; ''
		moveq	#2,d3

loc_5CD38:				; CODE XREF: sub_5CD1A+32j
		moveq	#3,d2

loc_5CD3A:				; CODE XREF: sub_5CD1A+2Aj
		jsr	WriteFMI
		jsr	sub_5CE92
		addq.w	#4,d0
		dbf	d2,loc_5CD3A
		subi.b	#$F,d0
		dbf	d3,loc_5CD38
		move.w	#0,($A11100).l
		rts
; End of function sub_5CD1A

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR PlaySoundID

StopAllSound:				; CODE XREF: PlaySoundID+1Cj
					; PlaySoundID+70j ...
		moveq	#$27,d0
		moveq	#0,d1
		jsr	WriteFMI_Z
		lea	(Drv68Kmem+$00).w,a0
		move.w	#$E3,d0

loc_5CD6A:				; CODE XREF: PlaySoundID+732j
		clr.l	(a0)+
		dbf	d0,loc_5CD6A
		move.b	#$FF,(Drv68Kmem+$09).w
		jsr	sub_5CD1A
		bra.w	loc_5D1DA
; END OF FUNCTION CHUNK	FOR PlaySoundID

; =============== S U B	R O U T	I N E =======================================


SilenceFM:				; CODE XREF: PlaySoundID+1CEp
		moveq	#$27,d0
		moveq	#0,d1
		jsr	WriteFMI_Z
		lea	(Drv68Kmem+$00).w,a0
		move.b	(Drv68Kmem+$00).w,d1
		move.w	#$87,d0

loc_5CD92:				; CODE XREF: SilenceFM+16j
		clr.l	(a0)+
		dbf	d0,loc_5CD92
		move.b	d1,(Drv68Kmem+$00).w
		move.b	#$FF,(Drv68Kmem+$09).w
		rts
; End of function SilenceFM

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR UpdateFMTrack

loc_5CE02:				; CODE XREF: UpdateFMTrack+16j
		btst	#1,(a5)
		bne.s	locret_5CE1C
		btst	#2,(a5)
		bne.s	locret_5CE1C
		moveq	#$28,d0
		move.b	1(a5),d1
		ori.b	#$F0,d1
		bra.w	WriteFMI_Z
; ---------------------------------------------------------------------------

locret_5CE1C:				; CODE XREF: UpdateFMTrack+CBEj
					; UpdateFMTrack+CC4j
		rts
; END OF FUNCTION CHUNK	FOR UpdateFMTrack

; =============== S U B	R O U T	I N E =======================================


sub_5CE1E:				; CODE XREF: sub_5C172:loc_5C18Ap
					; sub_5C242+18p ...

; FUNCTION CHUNK AT 0005CE34 SIZE 00000002 BYTES

		btst	#4,(a5)
		bne.s	locret_5CE34
		btst	#2,(a5)
		bne.s	locret_5CE34
; End of function sub_5CE1E


; =============== S U B	R O U T	I N E =======================================


sub_5CE2A:				; CODE XREF: StopSpcSFX+12p
		moveq	#$28,d0
		move.b	1(a5),d1
		bra.w	WriteFMI_Z
; End of function sub_5CE2A

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_5CE1E

locret_5CE34:				; CODE XREF: sub_5CE1E+4j sub_5CE1E+Aj
		rts
; END OF FUNCTION CHUNK	FOR sub_5CE1E

; =============== S U B	R O U T	I N E =======================================


WriteFMMain_Z:				; CODE XREF: cfHandler+146p
					; cfHandler+18Cj ...
		btst	#2,(a5)
		bne.s	locret_5CE4C
		jsr	drv_stopz80
		jsr	WriteFMMain
		move.w	#0,($A11100).l

locret_5CE4C:				; CODE XREF: WriteFMMain_Z+4j
		rts
; End of function WriteFMMain_Z


; =============== S U B	R O U T	I N E =======================================


WriteFMI_Z:				; CODE XREF: StopSFX+8p
					; PlaySoundID+724p ...
		jsr	drv_stopz80
		jsr	WriteFMI
		move.w	#0,($A11100).l
		rts
; End of function WriteFMI_Z


; =============== S U B	R O U T	I N E =======================================


WriteFMMain:				; CODE XREF: sub_5C2BA+44p
					; sub_5C2BA+4Ep ...

; FUNCTION CHUNK AT 0005CE88 SIZE 0000000A BYTES

		btst	#2,1(a5)
		bne.s	loc_5CE88
		add.b	1(a5),d0
; End of function WriteFMMain


; =============== S U B	R O U T	I N E =======================================


WriteFMI:				; CODE XREF: sub_5C2BA+122p
					; sub_5C2BA+12Ap ...
		lea	($A04000).l,a0

loc_5CE72:				; CODE XREF: WriteFMI+Aj
		btst	#7,(a0)
		bne.s	loc_5CE72
		move.b	d0,(a0)
		nop

loc_5CE7C:				; CODE XREF: WriteFMI+14j
		btst	#7,(a0)
		bne.s	loc_5CE7C
		move.b	d1,1(a0)
		rts
; End of function WriteFMI

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR WriteFMMain

loc_5CE88:				; CODE XREF: WriteFMMain+6j
		move.b	1(a5),d2
		bclr	#2,d2
		add.b	d2,d0
; END OF FUNCTION CHUNK	FOR WriteFMMain

; =============== S U B	R O U T	I N E =======================================


sub_5CE92:				; CODE XREF: UpdateSound+76Cp
					; UpdateSound+7B8p ...
		lea	($A04000).l,a0

loc_5CE98:				; CODE XREF: sub_5CE92+Aj
		btst	#7,(a0)
		bne.s	loc_5CE98
		move.b	d0,2(a0)
		nop

loc_5CEA4:				; CODE XREF: sub_5CE92+16j
		btst	#7,(a0)
		bne.s	loc_5CEA4
		move.b	d1,3(a0)
		rts
; End of function sub_5CE92


; =============== S U B	R O U T	I N E =======================================


drv_stopz80:				; CODE XREF: UpdateDACTrack+54p
					; sub_5C2BA+40p ...
		move.w	#$100,($A11100).l

loc_5CEB8:				; CODE XREF: drv_stopz80+10j
		btst	#0,($A11100).l
		bne.s	loc_5CEB8
		tst.b	($A01F2A).l
		beq.s	locret_5CEF4
		move.w	#0,($A11100).l
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		bra.s	drv_stopz80
; ---------------------------------------------------------------------------

locret_5CEF4:				; CODE XREF: drv_stopz80+18j
		rts
; End of function drv_stopz80


; =============== S U B	R O U T	I N E =======================================


sub_5CEF6:				; CODE XREF: UpdateSound+Cp
		cmpi.b	#2,(Drv68Kmem+$2B).w
		beq.w	loc_5CF28
		move.b	(Drv68Kmem+$28).w,d0
		beq.w	loc_5CF28
		bmi.w	loc_5CF1E
		cmpi.b	#1,d0
		bne.w	loc_5CF28
		move.b	#2,(Drv68Kmem+$28).w
		bra.w	loc_5CFA4
; ---------------------------------------------------------------------------

loc_5CF1E:				; CODE XREF: sub_5CEF6+12j
		move.b	#0,(Drv68Kmem+$28).w
		bra.w	loc_5CFEC
; ---------------------------------------------------------------------------

loc_5CF28:				; CODE XREF: sub_5CEF6+6j sub_5CEF6+Ej ...
		cmpi.b	#2,(Drv68Kmem+$28).w
		beq.w	locret_5CFA2
		move.b	(Drv68Kmem+$2B).w,d0
		beq.w	locret_5CFA2
		cmpi.b	#1,d0
		bne.w	loc_5CF7E
		jsr	drv_stopz80
		move.b	($A01FFC).l,d7
		move.w	#0,($A11100).l
		btst	#5,d7
		beq.w	locret_5CFA2
		move.b	#2,(Drv68Kmem+$2B).w
		move.b	(Drv68Kmem+$29).w,d0
		or.b	(Drv68Kmem+$2A).w,d0
		bne.w	loc_5CFA4
		move.b	#$A,(Drv68Kmem+$29).w
		move.b	#2,(Drv68Kmem+$2A).w
		bra.w	loc_5CFA4
; ---------------------------------------------------------------------------

loc_5CF7E:				; CODE XREF: sub_5CEF6+48j
		jsr	drv_stopz80
		move.b	($A01FFC).l,d7
		move.w	#0,($A11100).l
		btst	#5,d7
		bne.w	locret_5CFA2
		move.b	#0,(Drv68Kmem+$2B).w
		bra.w	loc_5CFEC
; ---------------------------------------------------------------------------

locret_5CFA2:				; CODE XREF: sub_5CEF6+38j
					; sub_5CEF6+40j ...
		rts
; ---------------------------------------------------------------------------

loc_5CFA4:				; CODE XREF: sub_5CEF6+24j
					; sub_5CEF6+74j ...
		move.b	(Drv68Kmem+$29).w,d6
		lea	(Drv68Kmem+$70).w,a5
		moveq	#5,d7

loc_5CFAE:				; CODE XREF: sub_5CEF6+CAj
		tst.b	(a5)
		bpl.s	loc_5CFBC
		add.b	d6,9(a5)
		bmi.s	loc_5CFBC
		jsr	RefreshVolume

loc_5CFBC:				; CODE XREF: sub_5CEF6+BAj
					; sub_5CEF6+C0j
		adda.w	#$30,a5
		dbf	d7,loc_5CFAE
		move.b	(Drv68Kmem+$2A).w,d5
		moveq	#2,d7

loc_5CFCA:				; CODE XREF: sub_5CEF6+F0j
		tst.b	(a5)
		bpl.s	loc_5CFE2
		add.b	d5,9(a5)
		cmpi.b	#$10,9(a5)
		bcc.s	loc_5CFE2
		move.b	9(a5),d6
		jsr	sub_5D172

loc_5CFE2:				; CODE XREF: sub_5CEF6+D6j
					; sub_5CEF6+E2j
		adda.w	#$30,a5
		dbf	d7,loc_5CFCA
		rts
; ---------------------------------------------------------------------------

loc_5CFEC:				; CODE XREF: sub_5CEF6+2Ej
					; sub_5CEF6+A8j
		move.b	(Drv68Kmem+$29).w,d6
		lea	(Drv68Kmem+$70).w,a5
		moveq	#5,d7

loc_5CFF6:				; CODE XREF: sub_5CEF6+110j
		tst.b	(a5)
		bpl.s	loc_5D002
		sub.b	d6,9(a5)
		jsr	RefreshVolume

loc_5D002:				; CODE XREF: sub_5CEF6+102j
		adda.w	#$30,a5
		dbf	d7,loc_5CFF6
		move.b	(Drv68Kmem+$2A).w,d5
		moveq	#2,d7

loc_5D010:				; CODE XREF: sub_5CEF6+12Ej
		tst.b	(a5)
		bpl.s	loc_5D020
		sub.b	d5,9(a5)
		move.b	9(a5),d6
		jsr	sub_5D172

loc_5D020:				; CODE XREF: sub_5CEF6+11Cj
		adda.w	#$30,a5
		dbf	d7,loc_5D010
		clr.b	(Drv68Kmem+$29).w
		clr.b	(Drv68Kmem+$2A).w
		rts
; End of function sub_5CEF6

; ---------------------------------------------------------------------------
FMFreqs:	dc.w $25E, $284, $2AB, $2D3, $2FE, $32D, $35C, $38F, $3C5, $3FF, $43C, $47C
					; DATA XREF: sub_5C1A8+18o

; =============== S U B	R O U T	I N E =======================================


UpdatePSGTrack:				; CODE XREF: UpdateSound+52p
					; UpdateSound+7Cp ...
		subq.b	#1,$E(a5)
		bne.s	loc_5D060
		bclr	#4,(a5)
		jsr	sub_5D070
		jsr	sub_5D0D4
		bra.w	loc_5D128
; ---------------------------------------------------------------------------

loc_5D060:				; CODE XREF: UpdatePSGTrack+4j
		jsr	sub_5C242
		jsr	DoVolEnv
		jsr	sub_5C26A
		bra.w	loc_5D0E0
; End of function UpdatePSGTrack


; =============== S U B	R O U T	I N E =======================================


sub_5D070:				; CODE XREF: UpdatePSGTrack+Ap
		bclr	#1,(a5)
		movea.l	4(a5),a4

loc_5D078:				; CODE XREF: sub_5D070+16j
		moveq	#0,d5
		move.b	(a4)+,d5
		cmpi.b	#$E0,d5
		bcs.s	loc_5D088
		jsr	cfHandler
		bra.s	loc_5D078
; ---------------------------------------------------------------------------

loc_5D088:				; CODE XREF: sub_5D070+10j
		tst.b	d5
		bpl.s	loc_5D09C
		jsr	sub_5D0A4
		move.b	(a4)+,d5
		tst.b	d5
		bpl.s	loc_5D09C
		subq.w	#1,a4
		bra.w	sub_5C1FA
; ---------------------------------------------------------------------------

loc_5D09C:				; CODE XREF: sub_5D070+1Aj
					; sub_5D070+24j
		jsr	TickMultiplier
		bra.w	sub_5C1FA
; End of function sub_5D070


; =============== S U B	R O U T	I N E =======================================


sub_5D0A4:				; CODE XREF: sub_5D070+1Cp
		subi.b	#$81,d5
		bcs.s	loc_5D0C2
		add.b	8(a5),d5
		andi.w	#$7F,d5
		lsl.w	#1,d5
		lea	PSGFreqs,a0
		move.w	(a0,d5.w),$10(a5)
		bra.w	sub_5C1FA
; ---------------------------------------------------------------------------

loc_5D0C2:				; CODE XREF: sub_5D0A4+4j
		bset	#1,(a5)
		move.w	#$FFFF,$10(a5)
		jsr	sub_5C1FA
		bra.w	sub_5D1C4
; End of function sub_5D0A4


; =============== S U B	R O U T	I N E =======================================


sub_5D0D4:				; CODE XREF: UpdatePSGTrack+Ep
		move.w	$10(a5),d6
		bpl.s	loc_5D0E6
		bset	#1,(a5)
		rts
; ---------------------------------------------------------------------------

loc_5D0E0:				; CODE XREF: UpdatePSGTrack+22j
		tst.b	$A(a5)
		beq.s	locret_5D11E

loc_5D0E6:				; CODE XREF: sub_5D0D4+4j
		btst	#1,(a5)
		bne.s	locret_5D11E
		btst	#2,(a5)
		bne.s	locret_5D11E
		jsr	DoModEnv
		move.b	1(a5),d0
		cmpi.b	#$E0,d0
		bne.s	loc_5D104
		move.b	#$C0,d0

loc_5D104:				; CODE XREF: sub_5D0D4+2Aj
		move.w	d6,d1
		andi.b	#$F,d1
		or.b	d1,d0
		lsr.w	#4,d6
		andi.b	#$3F,d6
		move.b	d0,($C00011).l
		move.b	d6,($C00011).l

locret_5D11E:				; CODE XREF: sub_5D0D4+10j
					; sub_5D0D4+16j ...
		rts
; End of function sub_5D0D4


; =============== S U B	R O U T	I N E =======================================


DoVolEnv:				; CODE XREF: UpdatePSGTrack+1Ap

; FUNCTION CHUNK AT 0005D1A2 SIZE 00000022 BYTES

		tst.b	$B(a5)
		beq.w	locret_5D192

loc_5D128:				; CODE XREF: UpdatePSGTrack+12j
		move.b	9(a5),d6
		moveq	#0,d0
		move.b	$B(a5),d0
		beq.s	sub_5D172
		lea	VolEnvPtrs,a0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	(a0,d0.w),a0

loc_5D140:				; CODE XREF: DoVolEnv+9Aj DoVolEnv+A0j
		moveq	#0,d0
		move.b	$C(a5),d0
		addq.b	#1,$C(a5)
		move.b	(a0,d0.w),d0
		bpl.s	loc_5D168
		cmpi.b	#$83,d0
		beq.s	loc_5D1A2
		cmpi.b	#$81,d0
		beq.s	loc_5D1AE
		cmpi.b	#$82,d0
		beq.s	loc_5D1B4
		cmpi.b	#$80,d0
		beq.s	loc_5D1BC

loc_5D168:				; CODE XREF: DoVolEnv+2Ej
		add.w	d0,d6
		cmpi.b	#$10,d6
		bcs.s	sub_5D172
		moveq	#$F,d6
; End of function DoVolEnv


; =============== S U B	R O U T	I N E =======================================


sub_5D172:				; CODE XREF: DoFadeOut+60p
					; sub_5CEF6+E8p ...
		btst	#1,(a5)
		bne.s	locret_5D192
		btst	#2,(a5)
		bne.s	locret_5D192
		btst	#4,(a5)
		bne.s	loc_5D194

loc_5D184:				; CODE XREF: sub_5D172+26j
					; sub_5D172+2Cj
		or.b	1(a5),d6
		addi.b	#$10,d6
		move.b	d6,($C00011).l

locret_5D192:				; CODE XREF: DoVolEnv+4j sub_5D172+4j	...
		rts
; ---------------------------------------------------------------------------

loc_5D194:				; CODE XREF: sub_5D172+10j
		tst.b	$13(a5)
		beq.s	loc_5D184
		tst.b	$12(a5)
		bne.s	loc_5D184
		rts
; End of function sub_5D172

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR DoVolEnv

loc_5D1A2:				; CODE XREF: DoVolEnv+34j
		subq.b	#2,$C(a5)
		bset	#1,(a5)
		bra.w	sub_5D1C4
; ---------------------------------------------------------------------------

loc_5D1AE:				; CODE XREF: DoVolEnv+3Aj
		subq.b	#2,$C(a5)
		rts
; ---------------------------------------------------------------------------

loc_5D1B4:				; CODE XREF: DoVolEnv+40j
		move.b	1(a0,d0.w),$C(a5)
		bra.s	loc_5D140
; ---------------------------------------------------------------------------

loc_5D1BC:				; CODE XREF: DoVolEnv+46j
		clr.b	$C(a5)
		bra.w	loc_5D140
; END OF FUNCTION CHUNK	FOR DoVolEnv

; =============== S U B	R O U T	I N E =======================================


sub_5D1C4:				; CODE XREF: sub_5C242:loc_5C262p
					; DoModEnv:loc_5C39Cj ...
		btst	#2,(a5)
		bne.s	locret_5D1D8
; End of function sub_5D1C4


; =============== S U B	R O U T	I N E =======================================


sub_5D1CA:				; CODE XREF: StopSpcSFX+44p
		move.b	1(a5),d0
		ori.b	#$1F,d0
		move.b	d0,($C00011).l

locret_5D1D8:				; CODE XREF: sub_5D1C4+4j
		rts
; End of function sub_5D1CA

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR UpdateSound

loc_5D1DA:				; CODE XREF: UpdateSound+78Aj
					; PlaySoundID+740j
		lea	($C00011).l,a0
		move.b	#$9F,(a0)
		move.b	#$BF,(a0)
		move.b	#$DF,(a0)
		move.b	#$FF,(a0)
		rts
; END OF FUNCTION CHUNK	FOR UpdateSound
; ---------------------------------------------------------------------------
PSGFreqs:	dc.w  $356, $326, $2F9,	$2CE, $2A5, $280, $25C,	$23A, $21A, $1FB, $1DF,	$1C4
					; DATA XREF: sub_5D0A4+10o
		dc.w  $1AB, $193, $17D,	$167, $153, $140, $12E,	$11D, $10D,  $FE,  $EF,	 $E2
		dc.w   $D6,  $C9,  $BE,	 $B4,  $A9,  $A0,  $97,	 $8F,  $87,  $7F,  $78,	 $71
		dc.w   $6B,  $65,  $5F,	 $5A,  $55,  $50,  $4B,	 $47,  $43,  $40,  $3C,	 $39
		dc.w   $36,  $33,  $30,	 $2D,  $2B,  $28,  $26,	 $24,  $22,  $20,  $1F,	 $1D
		dc.w   $1B,  $1A,  $18,	 $17,  $16,  $15,  $13,	 $12,  $11,    0

; =============== S U B	R O U T	I N E =======================================


cfHandler:
		subi.w	#$E0,d5
		lsl.w	#2,d5
		jmp	cfPtrTable(pc,d5.w)
; ---------------------------------------------------------------------------

cfPtrTable:
		bra.w	cfE0_Pan
; ---------------------------------------------------------------------------
		bra.w	cfE1_Detune
; ---------------------------------------------------------------------------
		bra.w	cfE2_SetComm
; ---------------------------------------------------------------------------
		bra.w	cfE3_SilenceTrk
; ---------------------------------------------------------------------------
		bra.w	cfE4_PanAnim
; ---------------------------------------------------------------------------
		bra.w	cfE5_ChgPFMVol
; ---------------------------------------------------------------------------
		bra.w	cfE6_ChgFMVol
; ---------------------------------------------------------------------------
		bra.w	cfE7_Hold
; ---------------------------------------------------------------------------
		bra.w	cfE8_NoteStop
; ---------------------------------------------------------------------------
		bra.w	cfE9_SetLFO
; ---------------------------------------------------------------------------
		bra.w	cfEA_SetTempo
; ---------------------------------------------------------------------------
		bra.w	cfEB_PlaySnd
; ---------------------------------------------------------------------------
		bra.w	cfEC_ChgPSGVol
; ---------------------------------------------------------------------------
		bra.w	cfED_FMChnWrite
; ---------------------------------------------------------------------------
		bra.w	cfEE_FM1Write
; ---------------------------------------------------------------------------
		bra.w	cfEF_SetFMIns
; ---------------------------------------------------------------------------
		bra.w	cfF0_ModSetup
; ---------------------------------------------------------------------------
		bra.w	cfF1_ModTypePFM
; ---------------------------------------------------------------------------
		bra.w	cfF2_StopTrk
; ---------------------------------------------------------------------------
		bra.w	cfF3_PSGNoise
; ---------------------------------------------------------------------------
		bra.w	cfF4_ModType
; ---------------------------------------------------------------------------
		bra.w	cfF5_SetPSGIns
; ---------------------------------------------------------------------------
		bra.w	cfF6_GoTo
; ---------------------------------------------------------------------------
		bra.w	cfF7_Loop
; ---------------------------------------------------------------------------
		bra.w	cfF8_GoSub
; ---------------------------------------------------------------------------
		bra.w	cfF9_Return
; ---------------------------------------------------------------------------
		bra.w	cfFA_TickMult
; ---------------------------------------------------------------------------
		bra.w	cfFB_ChgTransp
; ---------------------------------------------------------------------------
		bra.w	cfFC_ModulatOn
; ---------------------------------------------------------------------------
		bra.w	cfFD_ModulatOff
; ---------------------------------------------------------------------------
		bra.w	cfFE_SpcFM3Mode
; ---------------------------------------------------------------------------

cfMetaCoordFlag:
		moveq	#0,d0
		move.b	(a4)+,d0
		lsl.w	#2,d0
		jmp	cfMetaPtrTable(pc,d0.w)
; ---------------------------------------------------------------------------

cfMetaPtrTable:
		bra.w	cf00_SSGEG
; ---------------------------------------------------------------------------
		bra.w	cf01_MusPause
; ---------------------------------------------------------------------------
		bra.w	cf02_TickMulAll
; ---------------------------------------------------------------------------
		bra.w	cf03_FadeIn_On
; ---------------------------------------------------------------------------
		bra.w	cf04_FadeIn_Off
; ---------------------------------------------------------------------------

cfE0_Pan:				; CODE XREF: cfHandler:cfPtrTablej
		move.b	(a4)+,d1
		tst.b	1(a5)
		bmi.s	locret_5D33C
		move.b	$27(a5),d0
		andi.b	#$37,d0
		or.b	d0,d1
		move.b	d1,$27(a5)
		jmp	SendPan
; ---------------------------------------------------------------------------

locret_5D33C:				; CODE XREF: cfHandler+AAj
		rts
; ---------------------------------------------------------------------------

cfE1_Detune:				; CODE XREF: cfHandler+Ej
		move.b	(a4)+,$1E(a5)
		rts
; ---------------------------------------------------------------------------

cfE2_SetComm:				; CODE XREF: cfHandler+12j
		move.b	(a4)+,(Drv68Kmem+$03).w
		rts
; ---------------------------------------------------------------------------

cfE3_SilenceTrk:			; CODE XREF: cfHandler+16j
		jsr	SilenceFMChn
		bra.w	cfF2_StopTrk
; ---------------------------------------------------------------------------

cfE4_PanAnim:				; CODE XREF: cfHandler+1Aj
		move.b	(a4)+,$1F(a5)
		beq.s	loc_5D36E
		move.b	(a4)+,$20(a5)
		move.b	(a4)+,$21(a5)
		move.b	(a4)+,$22(a5)
		move.b	(a4),$23(a5)
		move.b	(a4)+,$24(a5)
		rts
; ---------------------------------------------------------------------------

loc_5D36E:				; CODE XREF: cfHandler+D8j
		move.b	$27(a5),d1
		jmp	SendPan
; ---------------------------------------------------------------------------

cfE5_ChgPFMVol:				; CODE XREF: cfHandler+1Ej
		move.b	(a4)+,d0
		tst.b	1(a5)
		bpl.s	cfE6_ChgFMVol
		add.b	d0,9(a5)
		addq.w	#1,a4
		rts
; ---------------------------------------------------------------------------

cfE6_ChgFMVol:				; CODE XREF: cfHandler+22j
					; cfHandler+FEj
		move.b	(a4)+,d0
		add.b	d0,9(a5)
		bra.w	RefreshVolume
; ---------------------------------------------------------------------------

cfE7_Hold:				; CODE XREF: cfHandler+26j
		bset	#4,(a5)
		rts
; ---------------------------------------------------------------------------

cfE8_NoteStop:				; CODE XREF: cfHandler+2Aj
		move.b	(a4),$12(a5)
		move.b	(a4)+,$13(a5)
		rts
; ---------------------------------------------------------------------------

cfE9_SetLFO:				; CODE XREF: cfHandler+2Ej
		movea.l	(Drv68Kmem+$20).w,a1
		beq.s	loc_5D3AA
		movea.l	$20(a5),a1

loc_5D3AA:				; CODE XREF: cfHandler+126j
		move.b	(a4),d3
		adda.w	#9,a0
		lea	AMSEn_Ops,a2
		moveq	#3,d6

loc_5D3B6:				; CODE XREF: cfHandler+14Cj
		move.b	(a1)+,d1
		move.b	(a2)+,d0
		btst	#7,d3
		beq.s	loc_5D3C8
		bset	#7,d1
		jsr	WriteFMMain_Z

loc_5D3C8:				; CODE XREF: cfHandler+140j
		lsl.w	#1,d3
		dbf	d6,loc_5D3B6
		move.b	(a4)+,d1
		moveq	#$22,d0
		jsr	WriteFMI_Z
		move.b	(a4)+,d1
		move.b	$27(a5),d0
		andi.b	#$C0,d0
		or.b	d0,d1
		move.b	d1,$27(a5)
		jmp	SendPan
; End of function cfHandler

; ---------------------------------------------------------------------------
AMSEn_Ops:	dc.b $60, $68, $64, $6C	; DATA XREF: cfHandler+132o
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR cfHandler

cfEA_SetTempo:				; CODE XREF: cfHandler+32j
		move.b	(a4),(Drv68Kmem+$02).w
		move.b	(a4)+,(Drv68Kmem+$01).w
		rts
; ---------------------------------------------------------------------------

cfEB_PlaySnd:				; CODE XREF: cfHandler+36j
		move.b	(a4)+,(Drv68Kmem+$0A).w
		rts
; ---------------------------------------------------------------------------

cfEC_ChgPSGVol:				; CODE XREF: cfHandler+3Aj
		move.b	(a4)+,d0
		add.b	d0,9(a5)
		rts
; ---------------------------------------------------------------------------

cfED_FMChnWrite:			; CODE XREF: cfHandler+3Ej
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		bra.w	WriteFMMain_Z
; ---------------------------------------------------------------------------

cfEE_FM1Write:				; CODE XREF: cfHandler+42j
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		bra.w	WriteFMI_Z
; ---------------------------------------------------------------------------

cfEF_SetFMIns:				; CODE XREF: cfHandler+46j
		moveq	#0,d0
		move.b	(a4)+,d0
		move.b	d0,$B(a5)
		btst	#2,(a5)
		bne.w	locret_5D4CA
		movea.l	(Drv68Kmem+$20).w,a1
		tst.b	(Drv68Kmem+$0E).w
		beq.s	SendFMIns
		movea.l	$20(a5),a1
		bmi.s	SendFMIns
		movea.l	(Drv68Kmem+$24).w,a1
; END OF FUNCTION CHUNK	FOR cfHandler

; =============== S U B	R O U T	I N E =======================================


SendFMIns:				; CODE XREF: StopSFX+5Cp
					; StopSpcSFX+2Ep ...
		subq.w	#1,d0
		bmi.s	loc_5D448
		move.w	#$19,d1

loc_5D442:				; CODE XREF: SendFMIns+Aj
		adda.w	d1,a1
		dbf	d0,loc_5D442

loc_5D448:				; CODE XREF: SendFMIns+2j
		jsr	drv_stopz80
		move.b	(a1)+,d1
		move.b	d1,$25(a5)
		move.b	d1,d4
		move.b	#$B0,d0
		jsr	WriteFMMain
		lea	FMInsOperators,a2
		moveq	#$13,d3

loc_5D462:				; CODE XREF: SendFMIns+30j
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		jsr	WriteFMMain
		dbf	d3,loc_5D462
		moveq	#3,d5
		andi.w	#7,d4
		move.b	FMAlgoMask(pc,d4.w),d4
		move.b	9(a5),d3

loc_5D47C:				; CODE XREF: SendFMIns+50j
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		lsr.b	#1,d4
		bcc.s	loc_5D486
		add.b	d3,d1

loc_5D486:				; CODE XREF: SendFMIns+48j
		jsr	WriteFMMain
		dbf	d5,loc_5D47C
		cmpi.b	#6,1(a5)
		bne.w	loc_5D4B6
		cmpa.l	#$40,a5
		beq.w	loc_5D4C2
		tst.b	($A01FFD).l
		beq.w	loc_5D4B6
		move.b	$27(a5),($A01FF8).l
		bra.s	loc_5D4C2
; ---------------------------------------------------------------------------

loc_5D4B6:				; CODE XREF: SendFMIns+5Aj
					; SendFMIns+6Ej
		move.b	$27(a5),d1
		move.b	#$B4,d0
		jsr	WriteFMMain

loc_5D4C2:				; CODE XREF: SendFMIns+64j
					; SendFMIns+7Aj
		move.w	#0,($A11100).l

locret_5D4CA:				; CODE XREF: cfHandler+1A4j
		rts
; End of function SendFMIns

; ---------------------------------------------------------------------------
FMAlgoMask:	dc.b 8,	8, 8, 8, $A, $E, $E, $F	; DATA XREF: SendFMIns+3Ar
					; RefreshVolume+42r

; =============== S U B	R O U T	I N E =======================================


RefreshVolume:				; CODE XREF: DoFadeOut:loc_5CC86p
					; sub_5CEF6+C2p ...
		btst	#2,(a5)
		bne.s	locret_5D542
		moveq	#0,d0
		move.b	$B(a5),d0
		movea.l	(Drv68Kmem+$20).w,a1
		tst.b	(Drv68Kmem+$0E).w
		beq.s	loc_5D4F8
		movea.l	$20(a5),a1
		tst.b	(Drv68Kmem+$0E).w
		bmi.s	loc_5D4F8
		movea.l	(Drv68Kmem+$24).w,a1

loc_5D4F8:				; CODE XREF: RefreshVolume+14j
					; RefreshVolume+1Ej
		subq.w	#1,d0
		bmi.s	loc_5D506
		move.w	#$19,d1

loc_5D500:				; CODE XREF: RefreshVolume+2Ej
		adda.w	d1,a1
		dbf	d0,loc_5D500

loc_5D506:				; CODE XREF: RefreshVolume+26j
		adda.w	#$15,a1
		lea	Volume_Ops,a2
		move.b	$25(a5),d0
		andi.w	#7,d0
		move.b	FMAlgoMask(pc,d0.w),d4
		move.b	9(a5),d3
		bmi.s	locret_5D542
		moveq	#3,d5
		jsr	drv_stopz80

loc_5D526:				; CODE XREF: RefreshVolume:loc_5D536j
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		lsr.b	#1,d4
		bcc.s	loc_5D536
		add.b	d3,d1
		bcs.s	loc_5D536
		jsr	WriteFMMain

loc_5D536:				; CODE XREF: RefreshVolume+58j
					; RefreshVolume+5Cj
		dbf	d5,loc_5D526
		move.w	#0,($A11100).l

locret_5D542:				; CODE XREF: RefreshVolume+4j
					; RefreshVolume+4Aj
		rts
; End of function RefreshVolume

; ---------------------------------------------------------------------------
FMInsOperators:	dc.b  $30, $38,	$34, $3C ; DATA	XREF: SendFMIns+22o
		dc.b  $50, $58,	$54, $5C
		dc.b  $60, $68,	$64, $6C
		dc.b  $70, $78,	$74, $7C
		dc.b  $80, $88,	$84, $8C
Volume_Ops:	dc.b  $40, $48,	$44, $4C ; DATA	XREF: RefreshVolume+36o
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR cfHandler

cfF0_ModSetup:				; CODE XREF: cfHandler+4Aj
		bset	#7,$A(a5)
		move.l	a4,$14(a5)
		move.b	(a4)+,$18(a5)
		move.b	(a4)+,$19(a5)
		move.b	(a4)+,$1A(a5)
		move.b	(a4)+,d0
		lsr.b	#1,d0
		move.b	d0,$1B(a5)
		clr.w	$1C(a5)
		rts
; ---------------------------------------------------------------------------

cfF1_ModTypePFM:			; CODE XREF: cfHandler+4Ej
		move.b	(a4)+,d0
		tst.b	1(a5)
		bpl.w	cfF4_ModType
		move.b	d0,$A(a5)
		move.b	(a4)+,d0
		rts
; ---------------------------------------------------------------------------

cfF2_StopTrk:				; CODE XREF: cfHandler+52j
					; cfHandler+D0j
		bclr	#7,(a5)
		bclr	#4,(a5)
		tst.b	1(a5)
		bmi.s	loc_5D5AE
		tst.b	(Drv68Kmem+$08).w
		bmi.w	loc_5D652
		jsr	sub_5CE1E
		bra.s	loc_5D5B2
; ---------------------------------------------------------------------------

loc_5D5AE:				; CODE XREF: cfHandler+320j
		jsr	sub_5D1C4

loc_5D5B2:				; CODE XREF: cfHandler+32Ej
		tst.b	(Drv68Kmem+$0E).w
		bpl.w	loc_5D652
		clr.b	(Drv68Kmem+$00).w
		moveq	#0,d0
		move.b	1(a5),d0
		bmi.s	loc_5D61C
		lea	BGMChnPtrs,a0
		movea.l	a5,a3
		cmpi.b	#4,d0
		bne.s	loc_5D5E2
		tst.b	(Drv68Kmem+$340).w
		bpl.s	loc_5D5E2
		lea	(Drv68Kmem+$340).w,a5
		movea.l	(Drv68Kmem+$24).w,a1
		bra.s	loc_5D5F2
; ---------------------------------------------------------------------------

loc_5D5E2:				; CODE XREF: cfHandler+352j
					; cfHandler+358j
		subq.b	#2,d0
		lsl.b	#2,d0
		movea.l	(a0,d0.w),a5
		tst.b	(a5)
		bpl.s	loc_5D602
		movea.l	(Drv68Kmem+$20).w,a1

loc_5D5F2:				; CODE XREF: cfHandler+362j
		bclr	#2,(a5)
		bset	#1,(a5)
		move.b	$B(a5),d0
		jsr	SendFMIns

loc_5D602:				; CODE XREF: cfHandler+36Ej
		movea.l	a3,a5
		cmpi.b	#2,1(a5)
		bne.s	loc_5D652
		tst.b	(Drv68Kmem+$0F).w
		bne.s	loc_5D652
		moveq	#0,d1
		moveq	#$27,d0	; '''
		jsr	WriteFMI_Z
		bra.s	loc_5D652
; ---------------------------------------------------------------------------

loc_5D61C:				; CODE XREF: cfHandler+346j
		lea	(Drv68Kmem+$370).w,a0
		tst.b	(a0)
		bpl.s	loc_5D630
		cmpi.b	#$E0,d0
		beq.s	loc_5D63A
		cmpi.b	#$C0,d0
		beq.s	loc_5D63A

loc_5D630:				; CODE XREF: cfHandler+3A4j
		lea	BGMChnPtrs,a0
		lsr.b	#3,d0
		movea.l	(a0,d0.w),a0

loc_5D63A:				; CODE XREF: cfHandler+3AAj
					; cfHandler+3B0j
		bclr	#2,(a0)
		bset	#1,(a0)
		cmpi.b	#$E0,1(a0)
		bne.s	loc_5D652
		move.b	$25(a0),($C00011).l

loc_5D652:				; CODE XREF: cfHandler+326j
					; cfHandler+338j ...
		addq.w	#8,sp
		rts
; ---------------------------------------------------------------------------

cfF3_PSGNoise:				; CODE XREF: cfHandler+56j
		move.b	#$E0,1(a5)
		move.b	(a4)+,$25(a5)
		btst	#2,(a5)
		bne.s	locret_5D66E
		move.b	-1(a4),($C00011).l

locret_5D66E:				; CODE XREF: cfHandler+3E6j
		rts
; ---------------------------------------------------------------------------

cfF4_ModType:				; CODE XREF: cfHandler+5Aj
					; cfHandler+308j
		move.b	(a4)+,$A(a5)
		rts
; ---------------------------------------------------------------------------

cfF5_SetPSGIns:				; CODE XREF: cfHandler+5Ej
		move.b	(a4)+,$B(a5)
		rts
; ---------------------------------------------------------------------------

cfF6_GoTo:				; CODE XREF: cfHandler+62j
					; cfHandler+41Ej ...
		move.b	(a4)+,d0
		lsl.w	#8,d0
		move.b	(a4)+,d0
		adda.w	d0,a4
		subq.w	#1,a4
		rts
; ---------------------------------------------------------------------------

cfF7_Loop:				; CODE XREF: cfHandler+66j
		moveq	#0,d0
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		tst.b	$28(a5,d0.w)
		bne.s	loc_5D698
		move.b	d1,$28(a5,d0.w)

loc_5D698:				; CODE XREF: cfHandler+414j
		subq.b	#1,$28(a5,d0.w)
		bne.s	cfF6_GoTo
		addq.w	#2,a4
		rts
; ---------------------------------------------------------------------------

cfF8_GoSub:				; CODE XREF: cfHandler+6Aj
		moveq	#0,d0
		move.b	$D(a5),d0
		subq.b	#4,d0
		move.l	a4,(a5,d0.w)
		move.b	d0,$D(a5)
		bra.s	cfF6_GoTo
; ---------------------------------------------------------------------------

cfF9_Return:				; CODE XREF: cfHandler+6Ej
		moveq	#0,d0
		move.b	$D(a5),d0
		movea.l	(a5,d0.w),a4
		addq.w	#2,a4
		addq.b	#4,d0
		move.b	d0,$D(a5)
		rts
; ---------------------------------------------------------------------------

cfFA_TickMult:				; CODE XREF: cfHandler+72j
		move.b	(a4)+,2(a5)
		rts
; ---------------------------------------------------------------------------

cfFB_ChgTransp:				; CODE XREF: cfHandler+76j
		move.b	(a4)+,d0
		add.b	d0,8(a5)
		rts
; ---------------------------------------------------------------------------

cfFC_ModulatOn:				; CODE XREF: cfHandler+7Aj
		bset	#7,$A(a5)
		rts
; ---------------------------------------------------------------------------

cfFD_ModulatOff:			; CODE XREF: cfHandler+7Ej
		bclr	#7,$A(a5)
		rts
; ---------------------------------------------------------------------------

cfFE_SpcFM3Mode:			; CODE XREF: cfHandler+82j
		lea	(Drv68Kmem+$18).w,a0
		tst.b	(Drv68Kmem+$0E).w
		bne.s	loc_5D6FA
		lea	(Drv68Kmem+$10).w,a0
		move.b	#$80,(Drv68Kmem+$0F).w

loc_5D6FA:				; CODE XREF: cfHandler+470j
		moveq	#3,d0

loc_5D6FC:				; CODE XREF: cfHandler+488j
		moveq	#0,d1
		move.b	(a4)+,d1
		lsl.w	#1,d1
		move.w	FM3_FreqVals(pc,d1.w),(a0)+
		dbf	d0,loc_5D6FC
		move.b	#$27,d0
		moveq	#$40,d1
		bra.w	WriteFMI_Z
; END OF FUNCTION CHUNK	FOR cfHandler
; ---------------------------------------------------------------------------
FM3_FreqVals:	dc.w 0,	$180, $1F4, $260 ; DATA	XREF: cfHandler+484r
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR cfHandler

cf00_SSGEG:				; CODE XREF: cfHandler:cfMetaPtrTablej
		lea	SSGEG_Ops,a1
		moveq	#3,d3

loc_5D722:				; CODE XREF: cfHandler+4B4j
		move.b	(a1)+,d0
		move.b	(a4)+,d1
		jsr	WriteFMMain_Z
		move.b	(a1)+,d0
		moveq	#$1F,d1
		jsr	WriteFMMain_Z
		dbf	d3,loc_5D722
		rts
; END OF FUNCTION CHUNK	FOR cfHandler
; ---------------------------------------------------------------------------
SSGEG_Ops:	dc.b  $90, $50		; DATA XREF: cfHandler:cf00_SSGEGo
		dc.b  $98, $58
		dc.b  $94, $54
		dc.b  $9C, $5C
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR cfHandler

cf01_MusPause:				; CODE XREF: cfHandler+94j
		moveq	#$30,d3
		move.b	(a4)+,d0
		beq.s	loc_5D79C
		movea.l	a5,a3
		lea	(Drv68Kmem+$40).w,a5
		btst	#7,(a5)
		beq.s	loc_5D75A
		bclr	#7,(a5)
		bset	#0,(a5)

loc_5D75A:				; CODE XREF: cfHandler+4D2j
		moveq	#5,d4

loc_5D75C:				; CODE XREF: cfHandler:loc_5D77Aj
		adda.w	d3,a5
		btst	#7,(a5)
		beq.s	loc_5D77A
		bclr	#7,(a5)
		bset	#0,(a5)
		move.b	#$B4,d0
		moveq	#0,d1
		jsr	WriteFMMain_Z
		jsr	sub_5CE1E

loc_5D77A:				; CODE XREF: cfHandler+4E4j
		dbf	d4,loc_5D75C
		moveq	#2,d4

loc_5D780:				; CODE XREF: cfHandler:loc_5D794j
		adda.w	d3,a5
		btst	#7,(a5)
		beq.s	loc_5D794
		bclr	#7,(a5)
		bset	#0,(a5)
		jsr	sub_5D1C4

loc_5D794:				; CODE XREF: cfHandler+508j
		dbf	d4,loc_5D780
		movea.l	a3,a5
		rts
; ---------------------------------------------------------------------------

loc_5D79C:				; CODE XREF: cfHandler+4C6j
		movea.l	a5,a3
		lea	(Drv68Kmem+$40).w,a5
		jsr	drv_stopz80
		tst.b	($A01FFD).l
		beq.w	loc_5D7CA
		bmi.w	loc_5D7BC
		move.b	($A01FF9).l,d1
		bra.s	loc_5D7C2
; ---------------------------------------------------------------------------

loc_5D7BC:				; CODE XREF: cfHandler+532j
		move.b	($A01FFA).l,d1

loc_5D7C2:				; CODE XREF: cfHandler+53Cj
		move.b	#$B6,d0
		jsr	sub_5CE92

loc_5D7CA:				; CODE XREF: cfHandler+52Ej
		move.w	#0,($A11100).l
		btst	#0,(a5)
		beq.s	loc_5D7E0
		bset	#7,(a5)
		bclr	#0,(a5)

loc_5D7E0:				; CODE XREF: cfHandler+558j
		moveq	#5,d4

loc_5D7E2:				; CODE XREF: cfHandler:loc_5D824j
		adda.w	d3,a5
		btst	#0,(a5)
		beq.s	loc_5D824
		bset	#7,(a5)
		bclr	#0,(a5)
		btst	#2,(a5)
		bne.s	loc_5D824
		move.b	$27(a5),d1
		move.b	#$B4,d0
		jsr	drv_stopz80
		cmpi.b	#6,1(a5)
		bne.w	loc_5D818
		tst.b	($A01FFD).l
		bne.w	loc_5D81C

loc_5D818:				; CODE XREF: cfHandler+58Cj
		jsr	WriteFMMain

loc_5D81C:				; CODE XREF: cfHandler+596j
		move.w	#0,($A11100).l

loc_5D824:				; CODE XREF: cfHandler+56Aj
					; cfHandler+578j
		dbf	d4,loc_5D7E2
		moveq	#2,d4

loc_5D82A:				; CODE XREF: cfHandler:loc_5D83Aj
		adda.w	d3,a5
		btst	#0,(a5)
		beq.s	loc_5D83A
		bset	#7,(a5)
		bclr	#0,(a5)

loc_5D83A:				; CODE XREF: cfHandler+5B2j
		dbf	d4,loc_5D82A
		movea.l	a3,a5
		rts
; ---------------------------------------------------------------------------

cf02_TickMulAll:			; CODE XREF: cfHandler+98j
		lea	(Drv68Kmem+$40).w,a0
		move.b	(a4)+,d0
		moveq	#$30,d1
		moveq	#9,d2

loc_5D84C:				; CODE XREF: cfHandler+5D4j
		move.b	d0,2(a0)
		adda.w	d1,a0
		dbf	d2,loc_5D84C
		rts
; ---------------------------------------------------------------------------

cf03_FadeIn_On:				; CODE XREF: cfHandler+9Cj
		tst.b	(Drv68Kmem+$28).w
		beq.w	loc_5D864
		addq.w	#2,a4
		rts
; ---------------------------------------------------------------------------

loc_5D864:				; CODE XREF: cfHandler+5DEj
		move.b	#1,(Drv68Kmem+$28).w
		move.b	(Drv68Kmem+$29).w,d0
		or.b	(Drv68Kmem+$2A).w,d0
		bne.w	locret_5D87E
		move.b	(a4)+,(Drv68Kmem+$29).w
		move.b	(a4)+,(Drv68Kmem+$2A).w

locret_5D87E:				; CODE XREF: cfHandler+5F4j
		rts
; ---------------------------------------------------------------------------

cf04_FadeIn_Off:			; CODE XREF: cfHandler+A0j
		cmpi.b	#2,(Drv68Kmem+$28).w
		bne.w	locret_5D890
		move.b	#$80,(Drv68Kmem+$28).w

locret_5D890:				; CODE XREF: cfHandler+608j
		rts
; END OF FUNCTION CHUNK	FOR cfHandler
; ---------------------------------------------------------------------------
SFXPtrs:
SpcSFXPtrs:
SFXPtrs2:
GeneralPtrList:	dc.l SndPriorities
		dc.l SpcSFXPtrs
		dc.l MusPtrs
		dc.l SFXPtrs
		dc.l ModEnvPtrs
		dc.l VolEnvPtrs
		dc.l $AB
		dc.l UpdateSound
		dc.l SFXPtrs2
ModEnvPtrs:	dc.l byte_5E0DE, byte_5E0F4, byte_5E10A, byte_5E114, byte_5E12F
					; DATA XREF: DoModEnv+Co ROM:0005E0AAo
		dc.l byte_5E11E, byte_5E159, byte_5E15B
byte_5E0DE:	dc.b 0,	1, 2, 3, 4, 5, 6, 7, 8,	9, $A, $B, $C, $D, $E
					; DATA XREF: ROM:ModEnvPtrso
		dc.b $F, $10, $11, $12,	$13, $14, $83
byte_5E0F4:	dc.b 0,	1, 2, 3, 4, 5, 6, 7, 8,	9, $A, $B, $C, $D, $E
					; DATA XREF: ROM:ModEnvPtrso
		dc.b $F, $10, $11, $12,	$13, $14, $80
byte_5E10A:	dc.b $D8, $E2, $EC, $F6, 0, $A,	$14, $1E, $28, $83
					; DATA XREF: ROM:ModEnvPtrso
byte_5E114:	dc.b $D8, $E2, $EC, $F6, 0, $A,	$14, $1E, $28, $80
					; DATA XREF: ROM:ModEnvPtrso
byte_5E11E:	dc.b 4,	4, 4, 4, 3, 3, 3, 3, 2,	2, 2, 2, 1, 1, 1, 1, $80
					; DATA XREF: ROM:ModEnvPtrso
byte_5E12F:	dc.b 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 1, 1, 1, 1, 1, 1, 1
					; DATA XREF: ROM:ModEnvPtrso
		dc.b 1,	1, 1, 1, 1, 1, 1, 2, 2,	2, 2, 2, 2, 2, 2, 3, 3
		dc.b 3,	3, 3, 3, 3, 3, 4, $83
byte_5E159:	dc.b 2,	$83		; DATA XREF: ROM:ModEnvPtrso
byte_5E15B:	dc.b 0,	0, 0, 0, 0, 1, 1, 1, 1,	1, 2, 2, 2, 2, 2, 2, 3
					; DATA XREF: ROM:ModEnvPtrso
		dc.b 3,	3, 3, 3, 4, 4, 4, 4, 4,	5, 5, 5, 5, 5, 6, 6, 6
		dc.b 6,	6, 7, 7, 7, $83, 0
VolEnvPtrs:	dc.l byte_5E1DC, byte_5E1F3, byte_5E1FA, byte_5E203, byte_5E21E
					; DATA XREF: DoVolEnv+14o
					; ROM:0005E0AEo
		dc.l byte_5E20E, byte_5E248, byte_5E261, byte_5E289, byte_5E2C0
		dc.l byte_5E32F, byte_5E344, byte_5E359, byte_5E36B, byte_5E3A6
		dc.l byte_5E3E6, byte_5E413, byte_5E432, byte_5E452, byte_5E46B
		dc.l byte_5E4BF, byte_5E515
byte_5E1DC:	dc.b 0,	0, 0, 1, 1, 1, 2, 2, 2,	3, 3, 3, 4, 4, 4, 5, 5
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 5,	6, 6, 6, 7, $83
byte_5E1F3:	dc.b 0,	2, 4, 6, 8, $10, $83 ; DATA XREF: ROM:VolEnvPtrso
byte_5E1FA:	dc.b 0,	0, 1, 1, 3, 3, 4, 5, $83 ; DATA	XREF: ROM:VolEnvPtrso
byte_5E203:	dc.b 0,	0, 2, 3, 4, 4, 5, 5, 5,	6, $83 ; DATA XREF: ROM:VolEnvPtrso
byte_5E20E:	dc.b 4,	4, 4, 4, 3, 3, 3, 3, 2,	2, 2, 2, 1, 1, 1, 1
					; DATA XREF: ROM:VolEnvPtrso
byte_5E21E:	dc.b 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 1, 1, 1, 1, 1, 1, 1
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 1,	1, 1, 1, 1, 1, 1, 2, 2,	2, 2, 2, 2, 2, 2, 3, 3
		dc.b 3,	3, 3, 3, 3, 3, 4, $83
byte_5E248:	dc.b 0,	1, 2, 1, 1, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 1, 1
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 1,	2, 2, 2, 3, 3, 4, $81
byte_5E261:	dc.b 0,	0, 0, 0, 0, 1, 1, 1, 1,	1, 2, 2, 2, 2, 2, 2, 3
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 3,	3, 3, 3, 4, 4, 4, 4, 4,	5, 5, 5, 5, 5, 6, 6, 6
		dc.b 6,	6, 7, 7, 7, $83
byte_5E289:	dc.b 0,	0, 0, 0, 0, 0, 1, 1, 1,	1, 1, 1, 2, 2, 2, 2, 2
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 2,	2, 2, 3, 3, 3, 3, 3, 3,	3, 4, 4, 4, 4, 4, 5, 5
		dc.b 5,	5, 5, 6, 6, 6, 6, 6, 7,	7, 7, 7, 7, 7, 7, 8, 8
		dc.b 8,	9, 9, $83
byte_5E2C0:	dc.b 7,	6, 6, 6, 5, 5, 5, 4, 4,	3, 3, 3, 3, 3, 2, 2, 2
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 1,	1, 1, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0
		dc.b 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 1
		dc.b 1,	1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1, 1, 1, 1, 1, 1
		dc.b 1,	1, 2, 2, 2, 2, 2, 2, 3,	3, 3, 3, 4, 4, 4, 4, 4
		dc.b 5,	5, 5, 5, 5, 6, 6, 6, 6,	6, 7, 7, 7, 7, 7, 8, 8
		dc.b 8,	8, 8, 9, 9, 9, 9, 9, $81
byte_5E32F:	dc.b 0,	0, 0, 0, 2, 2, 2, 3, 3,	4, 4, 4, 4, 5, 5, 5, 5
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 5,	5, 6, $83
byte_5E344:	dc.b 3,	2, 2, 1, 1, 1, 1, 0, 0,	0, 1, 1, 1, 2, 2, 2, 1
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 1,	1, 1, $81
byte_5E359:	dc.b 0,	0, 0, 0, 0, 0, 0, 2, 3,	3, 4, 4, 5, 5, 5, 6, 7
					; DATA XREF: ROM:VolEnvPtrso
		dc.b $83
byte_5E36B:	dc.b 3,	2, 2, 2, 1, 1, 1, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0
		dc.b 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0
		dc.b 0,	0, 0, 0, 0, 0, 1, $81
byte_5E3A6:	dc.b 6,	6, 6, 5, 5, 5, 5, 4, 4,	4, 4, 4, 4, 3, 3, 3, 3
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 3,	3, 3, 3, 3, 3, 3, 3, 3,	3, 3, 3, 3, 3, 3, 3, 3
		dc.b 3,	3, 3, 3, 3, 3, 3, 3, 3,	3, 3, 2, 2, 2, 2, 2, 2
		dc.b 2,	2, 2, 2, 1, 1, 1, 1, 1,	1, 1, 0, $81
byte_5E3E6:	dc.b 6,	6, 6, 6, 5, 5, 5, 5, 4,	4, 4, 4, 4, 3, 3, 3, 3
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 3,	3, 3, 3, 3, 3, 3, 3, 3,	3, 3, 3, 2, 2, 2, 2, 2
		dc.b 2,	2, 2, 2, 1, 1, 1, 0, 0,	0, $83
byte_5E413:	dc.b 6,	6, 6, 5, 5, 5, 4, 4, 4,	4, 3, 3, 3, 3, 3, 3, 3
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 3,	3, 2, 2, 2, 2, 2, 1, 1,	1, 0, 0, 0, $83
byte_5E432:	dc.b 0,	0, 0, 1, 1, 1, 2, 2, 2,	3, 3, 3, 4, 4, 4, 4, 4
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 5,	5, 5, 5, 6, 6, 6, 6, 7,	7, 8, 8, 9, $A,	$81
byte_5E452:	dc.b 0,	1, 2, 1, 1, 0, 0, 0, $12, $11, $18, $18, $18, $18
					; DATA XREF: ROM:VolEnvPtrso
		dc.b $18, $18, 4, 4, 2,	2, 2, 3, 3, 4, $81
byte_5E46B:	dc.b 6,	6, 6, 5, 5, 5, 5, 4, 4,	4, 4, 4, 4, 4, 4, 3, 3
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 3,	3, 3, 3, 3, 3, 3, 3, 3,	3, 3, 3, 3, 3, 3, 3, 3
		dc.b 3,	3, 3, 3, 3, 3, 3, 3, 3,	3, 3, 3, 3, 3, 3, 3, 3
		dc.b 3,	3, 3, 3, 3, 2, 2, 2, 2,	2, 2, 2, 2, 2, 2, 2, 2
		dc.b 2,	2, 2, 2, 2, 2, 1, 1, 1,	1, 1, 1, 1, 1, 0, $81
byte_5E4BF:	dc.b 7,	6, 6, 6, 5, 5, 5, 4, 4,	3, 3, 3, 3, 3, 2, 2, 2
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 1,	1, 1, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0
		dc.b 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 1
		dc.b 1,	1, 1, 1, 1, 1, 1, 1, 1,	1, 1, 1, 1, 1, 1, 1, 1
		dc.b 1,	1, 2, 2, 2, 2, 2, 2, 3,	3, 3, 3, 4, 4, 4, 4, 4
		dc.b $81
byte_5E515:	dc.b 4,	3, 2, 2, 2, 2, 1, 1, 1,	1, 1, 0, 0, 0, 0, 1, 2
					; DATA XREF: ROM:VolEnvPtrso
		dc.b 3,	4, 5, 3, 3, 2, 2, 2, 1,	1, 1, 2, 3, 4, 5, $81
MusPtrs:	dc.l 0
SndPriorities:	dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
					; DATA XREF: DoSoundQueueo
					; ROM:GeneralPtrListo
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $40, $45, $40, $40,	$40, $55, $45
		dc.b $55, $50, $50, $50, $40, $40, $45,	$50, $50, $50
		dc.b $50, $45, $50, $40, $50, $50, $50,	$50, $40, $50
		dc.b $60, $45, $43, $55, $55, $50, $40,	$4A, $55, $50
		dc.b $40, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $40, $50, $50, $50, $50, $50, $45,	$50, $60, $50
		dc.b $50, $40, $50, $50, $50, $50, $50,	$50, $50, $45
		dc.b $45, $50, $50, $45, $60, $50, $50,	$40, $50, $55
		dc.b $40, $40, $40, $50, $50, $50, $45,	$40, $50, $45
		dc.b $7F, $60, $50, $50, $40, $40, $40,	$60, $50, $70
		dc.b $40, $40, $40, $40, $50, $50, $55,	$50, $50, $60
		dc.b $50, $50, $50, $50, $50, $50, $50,	$50, $50, $50
		dc.b $50, $50, $55, $50, $55, $50, $50,	$50, $50, $50
		dc.b $80, $80, $80, $80, $80

	if pal60mod=1
		even

DoDoubleUpdate:
		tst.b	IsPal
		bpl.s	.notPAL		; NATSUMI: Branch if this is not a PAL Mega Drive
		subq.b	#1,PalCounter	; NATSUMI: sub 1 from the delay
		bpl.s	.notPAL		; NATSUMI: branch if not 0
		bsr.s	.notPAL		; NATSUMI: run twice
		move.b	#5,PalCounter	; NATSUMI: reset PAL counter

.notPAL		clr.b	(Drv68Kmem+$0E).w
		jmp	DoUpdate(pc)
	endif
PalCounter:	dc.b 0	; NATSUMI: Count from 5 to -1 to check which frame to do double update
IsPal:		dc.b 0	; NATSUMI: Is -1 if PAL mode is active.
