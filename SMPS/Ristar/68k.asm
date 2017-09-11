; RISTAR SOUD DRIVER DISASSEMBLY. LAZILY BOTCHED TOGETHER BY NATSUMI
	include "..\..\code\macro.asm"

Play_sample_data_macro macro index, plf, f2, f3
	dc.b \index, \plf, \f2, \f3
    endm

	org Driver68K		; pretend we are in RAM
	jmp	loc_C867E(pc)	; start driver

MusicPointers:	dc.l 0		; Fill out dynamically
PCMSimpleDriver:dc.l 0
PCMDualDriver:	dc.l 0
PCMSamples:	dc.l 0
DACTable1:	dc.l 0
DACTable2:	dc.w 0

SFXList:
SpecialList_Broken:
	dc.w 0

j_LoadPCMDriver:
		bra.w	LoadDualDriver

j_LoadSimplePCMDriver:
		bra.w	LoadSimpleDriver

NoiseIndex:	dc.l byte_C8070		; DATA XREF: ROM:000C8030o
					; SMPS_FMPSGNoiseEffects+Co
		dc.l byte_C8086
		dc.l byte_C809C
		dc.l byte_C80A6
		dc.l byte_C80C0
		dc.l byte_C80B0
		dc.l byte_C80EA
		dc.l byte_C80EC
byte_C8070:	dc.b	0,   1,	  2,   3,   4,	 5,   6,   7,	8,   9,	 $A,  $B,  $C,	$D,  $E,  $F
					; DATA XREF: ROM:NoiseIndexo
		dc.b  $10, $11,	$12, $13, $14, $83
byte_C8086:	dc.b	0,   1,	  2,   3,   4,	 5,   6,   7,	8,   9,	 $A,  $B,  $C,	$D,  $E,  $F
					; DATA XREF: ROM:000C8054o
		dc.b  $10, $11,	$12, $13, $14, $80
byte_C809C:	dc.b  $D8, $E2,	$EC, $F6,   0,	$A, $14, $1E, $28, $83
					; DATA XREF: ROM:000C8058o
byte_C80A6:	dc.b  $D8, $E2,	$EC, $F6,   0,	$A, $14, $1E, $28, $80
					; DATA XREF: ROM:000C805Co
byte_C80B0:	dc.b	4,   4,	  4,   4,   3,	 3,   3,   3,	2,   2,	  2,   2,   1,	 1,   1,   1
					; DATA XREF: ROM:000C8064o
byte_C80C0:	dc.b	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  1,   1,   1,	 1,   1,   1
					; DATA XREF: ROM:000C8060o
		dc.b	1,   1,	  1,   1,   1,	 1,   1,   1,	2,   2,	  2,   2,   2,	 2,   2,   2
		dc.b	3,   3,	  3,   3,   3,	 3,   3,   3,	4, $83
byte_C80EA:	dc.b	2, $83		; DATA XREF: ROM:000C8068o
byte_C80EC:	dc.b	0,   0,	  0,   0,   0,	 1,   1,   1,	1,   1,	  2,   2,   2,	 2,   2,   2
					; DATA XREF: ROM:000C806Co
		dc.b	3,   3,	  3,   3,   3,	 4,   4,   4,	4,   4,	  5,   5,   5,	 5,   5,   6
		dc.b	6,   6,	  6,   6,   7,	 7,   7, $83
FlutterIndex:	dc.l byte_C818C		; DATA XREF: ROM:000C8034o
					; SMPS_PSGUpdateVolFX+14o
		dc.l byte_C81B2
		dc.l byte_C81B9
		dc.l byte_C81C2	; 4
		dc.l byte_C81DE
		dc.l byte_C81CD
		dc.l byte_C8208
		dc.l byte_C8211	; 8
		dc.l byte_C8239
		dc.l byte_C823B
		dc.l byte_C8242
		dc.l byte_C825B	; C
		dc.l byte_C826F
		dc.l byte_C827A
		dc.l byte_C8289
		dc.l byte_C8292	; 10
		dc.l byte_C82A3
		dc.l byte_C82AF
		dc.l byte_C82C4
		dc.l byte_C82CE	; 14
		dc.l byte_C82E5
		dc.l byte_C82FE
		dc.l byte_C8301
		dc.l byte_C8362	; 18
		dc.l byte_C8367
		dc.l byte_C8380
		dc.l byte_C8397
		dc.l byte_C83AA	; 1C
		dc.l byte_C83BF
		dc.l byte_C83D7
byte_C818C:	dc.b   $C,  $C,	 $C,  $B,  $B,	$B,  $A,  $A,  $A,   9,	  9,   9,   8,	 8,   8,   7
					; DATA XREF: ROM:FlutterIndexo
		dc.b	7,   7,	  6,   6,   6,	 5,   5,   5,	4,   4,	  4,   3,   3,	 3,   2,   2
		dc.b	2,   1,	  1,   1,   2, $81
byte_C81B2:	dc.b	0,   2,	  4,   6,   8, $10, $83	; DATA XREF: ROM:000C8118o
byte_C81B9:	dc.b	0,   0,	  1,   1,   3,	 3,   4,   5, $83 ; DATA XREF: ROM:000C811Co
byte_C81C2:	dc.b	0,   0,	  2,   3,   4,	 4,   5,   5,	5,   6,	$83
					; DATA XREF: ROM:000C8120o
byte_C81CD:	dc.b	4,   4,	  4,   4,   3,	 3,   3,   3,	2,   2,	  2,   2,   1,	 1,   1,   1
					; DATA XREF: ROM:000C8128o
		dc.b  $83
byte_C81DE:	dc.b	0,   0,	  0,   0,   0,	 0,   0,   0,	0,   0,	  1,   1,   1,	 1,   1,   1
					; DATA XREF: ROM:000C8124o
		dc.b	1,   1,	  1,   1,   1,	 1,   1,   1,	2,   2,	  2,   2,   2,	 2,   2,   2
		dc.b	3,   3,	  3,   3,   3,	 3,   3,   3,	4, $83
byte_C8208:	dc.b	3,   2,	  1,   0,   0,	 1,   1,   2, $81 ; DATA XREF: ROM:000C812Co
byte_C8211:	dc.b	0,   0,	  0,   0,   0,	 1,   1,   1,	1,   1,	  2,   2,   2,	 2,   2,   2
					; DATA XREF: ROM:000C8130o
		dc.b	3,   3,	  3,   3,   3,	 4,   4,   4,	4,   4,	  5,   5,   5,	 5,   5,   6
		dc.b	6,   6,	  6,   6,   7,	 7,   7, $83
byte_C8239:	dc.b	2, $83		; DATA XREF: ROM:000C8134o
byte_C823B:	dc.b	0,   2,	  4,   6,   8, $10, $83	; DATA XREF: ROM:000C8138o
byte_C8242:	dc.b	2,   1,	  0,   0,   1,	 2,   2,   2,	2,   2,	  2,   2,   2,	 2,   2,   2
					; DATA XREF: ROM:000C813Co
		dc.b	2,   3,	  3,   3,   4,	 4,   4,   5, $81
byte_C825B:	dc.b	0,   1,	  2,   3,   4,	 4,   4,   5,	5,   5,	  6,   7,   6,	 5,   4,   3
					; DATA XREF: ROM:000C8140o
		dc.b	2,   1,	  0, $81
byte_C826F:	dc.b	3,   0,	  1,   1,   1,	 2,   3,   4,	4,   5,	$81
					; DATA XREF: ROM:000C8144o
byte_C827A:	dc.b	0,   0,	  1,   1,   2,	 3,   4,   5,	5,   6,	  8,   7,   7,	 6, $81
					; DATA XREF: ROM:000C8148o
byte_C8289:	dc.b	1,  $C,	  3,  $F,   2,	 7,   3,  $F, $80 ; DATA XREF: ROM:000C814Co
byte_C8292:	dc.b	0,   0,	  0,   2,   3,	 3,   4,   5,	6,   7,	  8,   9,  $A,	$B,  $E,  $F
					; DATA XREF: ROM:000C8150o
		dc.b  $83
byte_C82A3:	dc.b	0,   0,	  1,   1,   3,	 3,   4,   5,	5,   5,	$82,   4
					; DATA XREF: ROM:000C8154o
byte_C82AF:	dc.b	1,   0,	  0,   0,   0,	 1,   1,   1,	2,   2,	  2,   3,   3,	 3,   3,   4
					; DATA XREF: ROM:000C8158o
		dc.b	4,   4,	  5,   5, $81
byte_C82C4:	dc.b  $10, $20,	$30, $40, $30, $20, $10,   0, $F0, $80
					; DATA XREF: ROM:000C815Co
byte_C82CE:	dc.b	6,   5,	  4,   3,   1,	 1,   0,   0,	0,   0,	  0,   0,   0,	 0,   1,   1
					; DATA XREF: ROM:000C8160o
		dc.b	2,   2,	  3,   3,   4,	 4, $81
byte_C82E5:	dc.b   $E,  $E,	 $D,  $D,  $C,	$C,  $B,  $B,  $B,  $A,	 $A,  $A,   9,	 9,   9,   8
					; DATA XREF: ROM:000C8164o
		dc.b	8,   8,	  7,   7,   7,	 6,   6,   5, $81
byte_C82FE:	dc.b	3,   0,	$80	; DATA XREF: ROM:000C8168o
byte_C8301:	dc.b	6,   6,	  6,   6,   6,	 6,   6,   6,	6,   6,	  6,   6,   6,	 6,   6,   6
					; DATA XREF: ROM:000C816Co
		dc.b	6,   6,	  6,   6,   6,	 6,   6,   6,	6,   6,	  6,   6,   6,	 6,   6,   6
		dc.b	6,   6,	  6,   6,   7,	 7,   7,   7,	7,   7,	  7,   7,   7,	 7,   7,   7
		dc.b	7,   7,	  7,   7,   7,	 7,   7,   7,	7,   7,	  7,   7,   8,	 8,   8,   8
		dc.b	8,   8,	  8,   8,   8,	 8,   8,   8,	8,   8,	  8,   8,   8,	 8,   8,   8
		dc.b	8,   8,	  8,   8,   9,	 9,   9,   9,	9,   9,	  9,   9,   9,	 9,   9,   9
		dc.b  $81
byte_C8362:	dc.b	0,   3,	  6,   9, $83 ;	DATA XREF: ROM:000C8170o
byte_C8367:	dc.b	7,   6,	  5,   4,   3,	 2,   1,   2,	1,   2,	  1,   2,   1,	 2,   1,   2
					; DATA XREF: ROM:000C8174o
		dc.b	1,   2,	  1,   2,   1,	 2,   3,   4, $81
byte_C8380:	dc.b	6,   5,	  4,   3,   3,	 3,   3,   3,	2,   2,	  2,   2,   2,	 1,   1,   1
					; DATA XREF: ROM:000C8178o
		dc.b	1,   1,	  2,   2,   2,	 2, $81
byte_C8397:	dc.b	6,   6,	  5,   5,   4,	 3,   2,   1,	0,   0,	  0,   0,   0,	 1,   1,   2
					; DATA XREF: ROM:000C817Co
		dc.b	2,   3,	$81
byte_C83AA:	dc.b	0,   1,	  2,   3,   3,	 4,   4,   4,	5,   5,	  5,   6,   6,	 7,  $A,  $C
					; DATA XREF: ROM:000C8180o
		dc.b   $C,  $D,	 $D,  $E, $83
byte_C83BF:	dc.b	0,   0,	  0,   0,   1,	 1,   1,   1,	1,   2,	  2,   3,   3,	 4,   4,   4
					; DATA XREF: ROM:000C8184o
		dc.b	4,   3,	  3,   2,   2,	 1, $81, $83
byte_C83D7:	dc.b	0,   0,	  2,   2,   4,	 4,   6,   8, $10, $83,	  0
					; DATA XREF: ROM:000C8188o
DACIndex_0:	Play_sample_data_macro $81, $30, 1, 0 ; DATA XREF: ROM:000C8048o
					; SMPS_UpdateDAC+48o
		Play_sample_data_macro $82, $30, 1, 0
		Play_sample_data_macro $83, $30, 1, 0
		Play_sample_data_macro $84, $30, 1, 0
		Play_sample_data_macro 1, $30, 1, 0
		Play_sample_data_macro 2, $40, 1, 0
		Play_sample_data_macro 9, $30, 1, 0
		Play_sample_data_macro $A, $30, 1, 0
		Play_sample_data_macro $B, $30, 1, 0
		Play_sample_data_macro $C, $50, 1, 0
		Play_sample_data_macro $D, $50, 1, 0
		Play_sample_data_macro $E, $50, 1, 0
		Play_sample_data_macro $F, $50, 1, 0
		Play_sample_data_macro $10, $50, 1, 0
		Play_sample_data_macro $11, $50, 1, 0
		Play_sample_data_macro $12, $50, 1, 0	; $10
		Play_sample_data_macro $13, $30, 1, 0
		Play_sample_data_macro $14, $30, 1, 0
		Play_sample_data_macro $15, $30, 1, 0
		Play_sample_data_macro $85, $30, 1, 0
		Play_sample_data_macro $16, $10, 1, 0
		Play_sample_data_macro $17, $10, 1, 0
		Play_sample_data_macro $18, $30, 1, 0
		Play_sample_data_macro $19, $30, 1, 0
		Play_sample_data_macro $1A, $30, 1, 0
		Play_sample_data_macro $1B, $30, 1, 0
		Play_sample_data_macro $1C, $30, 1, 0
		Play_sample_data_macro 3, $40, 1, 0
		Play_sample_data_macro 4, $40, 1, 0
		Play_sample_data_macro 5, $40, 1, 0
		Play_sample_data_macro 6, $40, 1, 0
		Play_sample_data_macro 7, $40, 1, 0
		Play_sample_data_macro 8, $40, 1, 0
		Play_sample_data_macro $1D, $40, 1, 0
		Play_sample_data_macro $1E, $40, 1, 0
		Play_sample_data_macro $1F, $40, 1, 0
		Play_sample_data_macro $20, $40, 1, 0
		Play_sample_data_macro $21, $30, 1, 0
		Play_sample_data_macro $22, $30, 1, 0
		Play_sample_data_macro $23, $50, 1, 0
		Play_sample_data_macro $24, $50, 1, 0
		Play_sample_data_macro $25, $30, 1, 0
		Play_sample_data_macro $26, $50, 1, 0
		Play_sample_data_macro $27, $50, 1, 0
		Play_sample_data_macro $28, $50, 1, 0
		Play_sample_data_macro $33, $50, 1, 0
DACIndex_1:	Play_sample_data_macro 3, $50, 1, 0	; DATA XREF: ROM:000C804Co
					; Sound_PlaySample+Co
		Play_sample_data_macro 4, $50, 1, 0
		Play_sample_data_macro 5, $50, 1, 0
		Play_sample_data_macro 6, $50, 1, 0
		Play_sample_data_macro 7, $50, 1, 0
		Play_sample_data_macro 8, $50, 1, 0
		Play_sample_data_macro $C, $50, 1, 0
		Play_sample_data_macro $D, $50, 1, 0
		Play_sample_data_macro $E, $50, 1, 0
		Play_sample_data_macro $F, $50, 1, 0
		Play_sample_data_macro $10, $50, 1, 0
		Play_sample_data_macro $11, $50, 1, 0
		Play_sample_data_macro $12, $50, 1, 0
		Play_sample_data_macro $24, $50, 1, 0
		Play_sample_data_macro $27, $50, 1, 0
		Play_sample_data_macro $28, $50, 1, 0
		Play_sample_data_macro $22, $50, 1, 0
		Play_sample_data_macro $29, $40, 1, 0
		Play_sample_data_macro $2A, $50, 1, 0
		Play_sample_data_macro $2B, $50, 1, 0
		Play_sample_data_macro $2C, $50, 1, 0
		Play_sample_data_macro $2D, $40, 1, 0
		Play_sample_data_macro $2E, $50, 1, 0
		Play_sample_data_macro $2F, $50, 1, 0
		Play_sample_data_macro $30, $50, 1, 0
		Play_sample_data_macro $31, $50, 1, 0
		Play_sample_data_macro $32, $50, 1, 0
		Play_sample_data_macro $33, $50, 1, 0
		Play_sample_data_macro $34, $50, 1, 0
		Play_sample_data_macro $35, $50, 1, 0
		Play_sample_data_macro $36, $50, 1, 0
		Play_sample_data_macro $37, $50, 1, 0
		Play_sample_data_macro $38, $50, 1, 0
		Play_sample_data_macro $39, $50, 1, 0
		Play_sample_data_macro $3A, $50, 1, 0
		Play_sample_data_macro $3B, $50, 1, 0
SoundPriorities:dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
					; DATA XREF: ROM:000C8020o
					; Sound_Play+6o
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $70, $70, $70, $70, $70, $7E,	$7E, $70, $70
		dc.b $70, $70, $70, $7F, $70, $70, $70,	$70, $70, $70
		dc.b $70, $70, $70, $70, $70, $70, $70,	$70, $70, $70
		dc.b $70, $7F, $70, $70, $70, $70, $70,	$70, $70, $70
		dc.b $70, $70, $70, $70, $70, $70, $70,	$70, $70, $70
		dc.b $70, $70, $7F, $7F, $7F, $7F, $7F,	$70, $80, $70
		dc.b $70, $70, $7F, $70, $7E, $80, $70,	$70, $70, $70
		dc.b $70, $7E, $7E, $70, $70, $70, $70,	$70, $70, $70
		dc.b $70, $7F, $7F, $70, $70, $70, $70,	$70, $70, $70
		dc.b $70, $70, $80, $70, $70, $70, $70,	$70, $70, $70
		dc.b $70, $70, $70, $7E, $70, $70, $70,	$70, $70, $80
		dc.b $70, $70, $70, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80, $80, $80, $80,	$80, $80, $80
		dc.b $80, $80, $80, $80

loc_C867E:				; CODE XREF: sub_C8018j
		movem.l	d0-a6,-(sp)
		lea	Drv68Kmem.w,a6
		bsr.w	Sound_Play
		bsr.w	Sound_ChkValue
		tst.b	3(a6)
		bmi.w	loc_C86E8
		bsr.w	DoFade
		bsr.w	TempoWait
		bsr.w	DoFadeOut
		bsr.w	UpdateEverything
		bsr.w	OverrideFM4Freq
		bsr.w	DoTrackNoteCutoff
		btst	#6,HWVersion.w
		beq.w	loc_C86E8
		cmpi.b	#5,$48(a6)
		beq.w	loc_C86CA
		addq.b	#1,$48(a6)
		bra.w	loc_C86E8
; ---------------------------------------------------------------------------

loc_C86CA:				; CODE XREF: sub_C8018+6A6j
		move.b	#0,$48(a6)
		bsr.w	DoFade
		bsr.w	TempoWait
		bsr.w	DoFadeOut
		bsr.w	UpdateEverything
		bsr.w	OverrideFM4Freq
		bsr.w	DoTrackNoteCutoff

loc_C86E8:				; CODE XREF: sub_C8018+67Aj
					; sub_C8018+69Cj ...
		movem.l	(sp)+,d0-a6
		rts
; End of function sub_C8018


; =============== S U B	R O U T	I N E =======================================


DoTrackNoteCutoff:			; CODE XREF: sub_C8018+692p
					; sub_C8018+6CCp
		lea	$4A(a6),a0
		moveq	#$34,d0	; '4'
		moveq	#9,d1

loc_C86F6:				; CODE XREF: DoTrackNoteCutoff+2Cj
		tst.b	(a0)
		bpl.s	loc_C8718
		tst.b	$2C(a0)
		beq.w	loc_C8718
		move.b	$2C(a0),d2
		cmp.b	$E(a0),d2
		bpl.w	loc_C8718
		sub.b	d2,$E(a0)
		move.b	#0,$2C(a0)

loc_C8718:				; CODE XREF: DoTrackNoteCutoff+Aj
					; DoTrackNoteCutoff+10j ...
		adda.w	d0,a0
		dbf	d1,loc_C86F6
		rts
; End of function DoTrackNoteCutoff

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR Sound_ChkValue

PlaySample:				; CODE XREF: Sound_ChkValue+52j
		lea	$4A(a6),a5
		moveq	#0,d0
		move.b	d7,d0
		subi.b	#$91,d0
		lea	DACIndex_1,a0
		andi.b	#$7F,d0	; ''
		subq.b	#1,d0
		add.w	d0,d0
		add.w	d0,d0
		adda.w	d0,a0
		move.b	2(a0),d4
		move.b	1(a0),d5
		move.b	(a0),d6
		bpl.w	@getsampledata
		move.b	#0,$16(a5)
		bra.w	@gotsampledata
; ---------------------------------------------------------------------------

@getsampledata:				; CODE XREF: Sound_ChkValue-7D6j
		moveq	#0,d0
		move.b	d6,d0
		move.b	#$80,d6
		move.l	DACTable1(pc),a0
		subq.b	#1,d0
		add.w	d0,d0
		add.w	d0,d0
		add.w	d0,d0
		add.w	d0,d0
		adda.w	d0,a0
		move.l	(a0)+,d0
		move.l	d0,d1
		swap	d1
		rol.l	#1,d1
		ori.b	#$80,d1
		move.b	d1,$16(a5)
		ori.w	#$8000,d0
		move.w	d0,d1
		move.b	d1,$18(a5)
		lsr.w	#8,d1
		move.b	d1,$17(a5)
		neg.w	d0
		ext.l	d0
		move.l	(a0)+,d1
		cmp.l	d1,d0
		bcs.s	loc_C879A
		move.w	d1,d0

loc_C879A:				; CODE XREF: Sound_ChkValue-786j
		sub.l	d0,d1
		move.b	d0,$1A(a5)
		lsr.w	#8,d0
		move.b	d0,$19(a5)
		move.b	d1,$1D(a5)
		lsr.l	#8,d1
		move.b	d1,$1C(a5)
		lsr.w	#8,d1
		move.b	d1,$1B(a5)

@gotsampledata:				; CODE XREF: Sound_ChkValue-7CCj
		lea	($A00000).l,a0
		lea	($A01FEA).l,a1
		bsr.w	WaitForZ80
		cmp.b	0(a1),d5
		bcs.w	.releasebus
		move.b	#$80,$1FFE(a0)
		move.b	d6,1(a1)
		move.b	d5,0(a1)
		move.b	$16(a5),2(a1)
		move.b	$18(a5),4(a1)
		move.b	$17(a5),3(a1)
		move.b	$1A(a5),6(a1)
		move.b	$19(a5),5(a1)
		move.b	$1D(a5),9(a1)
		move.b	$1C(a5),8(a1)
		move.b	$1B(a5),7(a1)

.releasebus:				; CODE XREF: Sound_ChkValue-752j
		move.w	#0,($A11100).l
		rts
; END OF FUNCTION CHUNK	FOR Sound_ChkValue

; =============== S U B	R O U T	I N E =======================================


UpdateEverything:			; CODE XREF: sub_C8018+68Ap
					; sub_C8018+6C4p
		clr.b	$E(a6)
		lea	$4A(a6),a5
		move.b	#$80,8(a6)
		moveq	#1,d7

loc_C8826:				; CODE XREF: UpdateEverything+1Cj
		tst.b	(a5)
		bpl.s	loc_C882E
		bsr.w	sub_C88AE

loc_C882E:				; CODE XREF: UpdateEverything+12j
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C8826
		clr.b	8(a6)
		moveq	#4,d7

loc_C883C:				; CODE XREF: UpdateEverything+32j
		tst.b	(a5)
		bpl.s	loc_C8844
		bsr.w	sub_C8A00

loc_C8844:				; CODE XREF: UpdateEverything+28j
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C883C
		moveq	#2,d7

loc_C884E:				; CODE XREF: UpdateEverything+44j
		tst.b	(a5)
		bpl.s	loc_C8856
		bsr.w	sub_C9A9C

loc_C8856:				; CODE XREF: UpdateEverything+3Aj
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C884E
		move.b	#$80,$E(a6)
		moveq	#2,d7

loc_C8866:				; CODE XREF: UpdateEverything+5Cj
		tst.b	(a5)
		bpl.s	loc_C886E
		bsr.w	sub_C8A00

loc_C886E:				; CODE XREF: UpdateEverything+52j
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C8866
		moveq	#2,d7

loc_C8878:				; CODE XREF: UpdateEverything+6Ej
		tst.b	(a5)
		bpl.s	loc_C8880
		bsr.w	sub_C9A9C

loc_C8880:				; CODE XREF: UpdateEverything+64j
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C8878
		move.b	#$40,$E(a6) ; '@'
		moveq	#1,d7

loc_C8890:				; CODE XREF: UpdateEverything+92j
		tst.b	(a5)
		bpl.s	loc_C88A4
		tst.b	1(a5)
		bmi.s	loc_C88A0
		bsr.w	sub_C8A00
		bra.s	loc_C88A4
; ---------------------------------------------------------------------------

loc_C88A0:				; CODE XREF: UpdateEverything+82j
		bsr.w	sub_C9A9C

loc_C88A4:				; CODE XREF: UpdateEverything+7Cj
					; UpdateEverything+88j
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C8890
		rts
; End of function UpdateEverything


; =============== S U B	R O U T	I N E =======================================


sub_C88AE:				; CODE XREF: UpdateEverything+14p
		subq.b	#1,$E(a5)
		bne.w	locret_C89FE
		movea.l	4(a5),a4

loc_C88BA:				; CODE XREF: sub_C88AE+1Aj
		moveq	#0,d5
		move.b	(a4)+,d5
		cmpi.b	#$E0,d5
		bcs.s	loc_C88CA
		bsr.w	cfHandler
		bra.s	loc_C88BA
; ---------------------------------------------------------------------------

loc_C88CA:				; CODE XREF: sub_C88AE+14j
		tst.b	d5
		bpl.s	loc_C88E0
		move.b	d5,$10(a5)
		move.b	(a4)+,d5
		bpl.s	loc_C88E0
		subq.w	#1,a4
		move.b	$F(a5),$E(a5)
		bra.s	gotsampledur
; ---------------------------------------------------------------------------

loc_C88E0:				; CODE XREF: sub_C88AE+1Ej
					; sub_C88AE+26j
		bsr.w	sub_C8A98

gotsampledur:				; CODE XREF: sub_C88AE+30j
		move.l	a4,4(a5)
		moveq	#0,d0
		move.b	$10(a5),d0
		cmpi.b	#$80,d0
		beq.w	locret_C89FE
		lea	DACIndex_0,a0
		andi.b	#$7F,d0	; ''
		subq.b	#1,d0
		add.w	d0,d0
		add.w	d0,d0
		adda.w	d0,a0
		move.b	2(a0),d4
		move.b	1(a0),d5
		move.b	(a0),d6
		bpl.w	@validsample
		move.b	#0,$16(a5)
		move.b	#0,$1D(a5)
		move.b	#0,$1C(a5)
		move.b	#0,$1B(a5)
		bra.w	@setsampledata
; ---------------------------------------------------------------------------

@validsample:				; CODE XREF: sub_C88AE+62j
		moveq	#0,d0
		move.b	d6,d0
		move.b	#$80,d6
		move.l	DACTable1(pc),a0
		subq.b	#1,d0
		add.w	d0,d0
		add.w	d0,d0
		add.w	d0,d0
		add.w	d0,d0
		adda.w	d0,a0
		move.l	(a0)+,d0
		move.l	d0,d1
		swap	d1
		rol.l	#1,d1
		ori.b	#$80,d1
		move.b	d1,$16(a5)
		ori.w	#$8000,d0
		move.w	d0,d1
		move.b	d1,$18(a5)
		lsr.w	#8,d1
		move.b	d1,$17(a5)
		neg.w	d0
		ext.l	d0
		move.l	(a0)+,d1
		cmp.l	d1,d0
		bcs.s	@C8976
		move.w	d1,d0

@C8976:					; CODE XREF: sub_C88AE+C4j
		sub.l	d0,d1
		move.b	d0,$1A(a5)
		lsr.w	#8,d0
		move.b	d0,$19(a5)
		move.b	d1,$1D(a5)
		lsr.l	#8,d1
		move.b	d1,$1C(a5)
		lsr.w	#8,d1
		move.b	d1,$1B(a5)

@setsampledata:				; CODE XREF: sub_C88AE+7Ej
		lea	($A00000).l,a0
		lea	($A01FF4).l,a1
		btst	#0,1(a5)
		beq.w	@gotsampleentry
		suba.w	#$A,a1

@gotsampleentry:			; CODE XREF: sub_C88AE+F6j
		bsr.w	WaitForZ80
		cmp.b	0(a1),d5
		bcs.w	.releasebus
		move.b	#$80,$1FFE(a0)
		move.b	d6,1(a1)
		move.b	d5,0(a1)
		move.b	$16(a5),2(a1)
		move.b	$18(a5),4(a1)
		move.b	$17(a5),3(a1)
		move.b	$1A(a5),6(a1)
		move.b	$19(a5),5(a1)
		move.b	$1D(a5),9(a1)
		move.b	$1C(a5),8(a1)
		move.b	$1B(a5),7(a1)

.releasebus:				; CODE XREF: sub_C88AE+106j
		move.w	#0,($A11100).l

locret_C89FE:				; CODE XREF: sub_C88AE+4j
					; sub_C88AE+44j
		rts
; End of function sub_C88AE


; =============== S U B	R O U T	I N E =======================================


sub_C8A00:				; CODE XREF: UpdateEverything+2Ap
					; UpdateEverything+54p	...

; FUNCTION CHUNK AT 000C9922 SIZE 0000001C BYTES

		subq.b	#1,$E(a5)
		bne.s	loc_C8A1A
		bclr	#4,(a5)
		bsr.w	sub_C8A2A
		bsr.w	sub_C8C50
		bsr.w	sub_C8D94
		bra.w	loc_C9922
; ---------------------------------------------------------------------------

loc_C8A1A:				; CODE XREF: sub_C8A00+4j
		bsr.w	sub_C8B82
		bsr.w	sub_C8DAE
		bsr.w	sub_C8BB6
		bra.w	loc_C8C5C
; End of function sub_C8A00


; =============== S U B	R O U T	I N E =======================================


sub_C8A2A:				; CODE XREF: sub_C8A00+Ap
		movea.l	4(a5),a4
		bclr	#1,(a5)

loc_C8A32:				; CODE XREF: sub_C8A2A+16j
		moveq	#0,d5
		move.b	(a4)+,d5
		cmpi.b	#$E0,d5
		bcs.s	loc_C8A42
		bsr.w	cfHandler
		bra.s	loc_C8A32
; ---------------------------------------------------------------------------

loc_C8A42:				; CODE XREF: sub_C8A2A+10j
		bsr.w	sub_C993E
		tst.b	d5
		bpl.s	loc_C8A58
		bsr.w	sub_C8A60
		move.b	(a4)+,d5
		bpl.s	loc_C8A58
		subq.w	#1,a4
		bra.w	sub_C8AB8
; ---------------------------------------------------------------------------

loc_C8A58:				; CODE XREF: sub_C8A2A+1Ej
					; sub_C8A2A+26j
		bsr.w	sub_C8A98
		bra.w	sub_C8AB8
; End of function sub_C8A2A


; =============== S U B	R O U T	I N E =======================================


sub_C8A60:				; CODE XREF: sub_C8A2A+20p

; FUNCTION CHUNK AT 000C8AB0 SIZE 00000008 BYTES

		subi.b	#$80,d5
		beq.s	loc_C8AB0
		add.b	8(a5),d5
		jsr	sub_C8B32
		andi.l	#$7F,d5	; ''
		divu.w	#$C,d5
		swap	d5
		lsl.w	#1,d5
		lea	word_C9A84,a0
		move.w	(a0,d5.w),d6
		swap	d5
		andi.w	#7,d5
		moveq	#$B,d0
		lsl.w	d0,d5
		or.w	d5,d6
		move.w	d6,$10(a5)
		rts
; End of function sub_C8A60


; =============== S U B	R O U T	I N E =======================================


sub_C8A98:				; CODE XREF: sub_C88AE:loc_C88E0p
					; sub_C8A2A:loc_C8A58p	...
		move.b	d5,d0
		move.b	2(a5),d1

loc_C8A9E:				; CODE XREF: sub_C8A98+Cj
		subq.b	#1,d1
		beq.s	loc_C8AA6
		add.b	d5,d0
		bra.s	loc_C8A9E
; ---------------------------------------------------------------------------

loc_C8AA6:				; CODE XREF: sub_C8A98+8j
		move.b	d0,$F(a5)
		move.b	d0,$E(a5)
		rts
; End of function sub_C8A98

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C8A60

loc_C8AB0:				; CODE XREF: sub_C8A60+4j
		bset	#1,(a5)
		clr.w	$10(a5)
; END OF FUNCTION CHUNK	FOR sub_C8A60

; =============== S U B	R O U T	I N E =======================================


sub_C8AB8:				; CODE XREF: sub_C8A2A+2Aj
					; sub_C8A2A+32j ...
		move.b	#0,$2E(a5)
		move.b	(a4),d0
		cmpi.b	#$E7,d0
		bne.w	loc_C8ACE
		move.b	#1,$2E(a5)

loc_C8ACE:				; CODE XREF: sub_C8AB8+Cj
		move.l	a4,4(a5)
		move.b	$F(a5),$E(a5)
		jsr	sub_C8B16
		btst	#4,(a5)
		bne.s	locret_C8B14
		clr.b	$C(a5)
		clr.b	$26(a5)
		clr.b	3(a5)
		btst	#7,$A(a5)
		beq.s	locret_C8B14
		movea.l	$14(a5),a0
		move.b	(a0)+,$18(a5)
		move.b	(a0)+,$19(a5)
		move.b	(a0)+,$1A(a5)
		move.b	(a0)+,d0
		lsr.b	#1,d0
		move.b	d0,$1B(a5)
		clr.w	$1C(a5)

locret_C8B14:				; CODE XREF: sub_C8AB8+2Aj
					; sub_C8AB8+3Ej
		rts
; End of function sub_C8AB8


; =============== S U B	R O U T	I N E =======================================


sub_C8B16:				; CODE XREF: sub_C8AB8+20p
		tst.b	$2D(a5)
		beq.w	loc_C8B2A
		move.b	$F(a5),d0
		sub.b	$2D(a5),d0
		move.b	d0,$13(a5)

loc_C8B2A:				; CODE XREF: sub_C8B16+4j
		move.b	$13(a5),$12(a5)
		rts
; End of function sub_C8B16


; =============== S U B	R O U T	I N E =======================================


sub_C8B32:				; CODE XREF: sub_C8A60+Ap
		cmpa.l	#Drv68Kmem+$0252,a5
		bcs.w	loc_C8B3E
		rts
; ---------------------------------------------------------------------------

loc_C8B3E:				; CODE XREF: sub_C8B32+6j
		movem.l	d0-d1/a0,-(sp)
		lea	Drv68Kmem.w,a0
		tst.b	$3E(a0)
		beq.w	loc_C8B70

loc_C8B50:				; CODE XREF: sub_C8B32+3Cj
		move.b	$40(a0),d0
		cmpi.b	#$B,d0
		beq.w	loc_C8B68
		add.b	byte_C8B76(pc,d0.w),d5
		addq.b	#1,$40(a0)
		bra.w	loc_C8B70
; ---------------------------------------------------------------------------

loc_C8B68:				; CODE XREF: sub_C8B32+26j
		move.b	#0,$40(a0)
		bra.s	loc_C8B50
; ---------------------------------------------------------------------------

loc_C8B70:				; CODE XREF: sub_C8B32+1Aj
					; sub_C8B32+32j
		movem.l	(sp)+,d0-d1/a0
		rts
; End of function sub_C8B32

; ---------------------------------------------------------------------------
byte_C8B76:	dc.b $FF, 5, 4,	2, 6, $FE, 3, $FF, 4, 1, 3, 0 ;	DATA XREF: sub_C8B32+2Ar

; =============== S U B	R O U T	I N E =======================================


sub_C8B82:				; CODE XREF: sub_C8A00:loc_C8A1Ap
					; sub_C9A9C:loc_C9AB2p
		tst.b	$12(a5)
		beq.s	locret_C8BB4
		subq.b	#1,$12(a5)
		bne.s	locret_C8BB4
		tst.b	$2E(a5)
		bne.w	locret_C8BB4
		bset	#1,(a5)
		tst.b	1(a5)
		bmi.w	loc_C8BAE
		bclr	#4,(a5)
		bsr.w	sub_C993E
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

loc_C8BAE:				; CODE XREF: sub_C8B82+1Cj
		bsr.w	sub_C9C16
		addq.w	#4,sp

locret_C8BB4:				; CODE XREF: sub_C8B82+4j sub_C8B82+Aj ...
		rts
; End of function sub_C8B82


; =============== S U B	R O U T	I N E =======================================


sub_C8BB6:				; CODE XREF: sub_C8A00+22p
					; sub_C9A9C+1Ep
		btst	#7,$A(a5)
		beq.w	locret_C8C4E
		tst.b	$18(a5)
		beq.s	loc_C8BCC
		subq.b	#1,$18(a5)
		rts
; ---------------------------------------------------------------------------

loc_C8BCC:				; CODE XREF: sub_C8BB6+Ej
		subq.b	#1,$19(a5)
		beq.s	loc_C8BD4
		rts
; ---------------------------------------------------------------------------

loc_C8BD4:				; CODE XREF: sub_C8BB6+1Aj
		movea.l	$14(a5),a0
		move.b	1(a0),$19(a5)
		tst.b	$1B(a5)
		bne.s	loc_C8C10
		move.b	3(a0),$1B(a5)
		cmpi.b	#2,$3E(a6)
		bne.w	loc_C8C0A
		cmpa.l	#Drv68Kmem+$0252,a5
		bcc.w	loc_C8C0A
		tst.b	$1B(a5)
		beq.w	loc_C8C0A
		addq.b	#2,$1B(a5)

loc_C8C0A:				; CODE XREF: sub_C8BB6+3Aj
					; sub_C8BB6+44j ...
		neg.b	$1A(a5)
		rts
; ---------------------------------------------------------------------------

loc_C8C10:				; CODE XREF: sub_C8BB6+2Cj
		subq.b	#1,$1B(a5)
		move.b	$1A(a5),d6
		cmpi.b	#2,$3E(a6)
		bne.w	loc_C8C40
		cmpa.l	#Drv68Kmem+$0252,a5
		bcc.w	loc_C8C40
		btst	#7,d6
		bne.w	loc_C8C3C
		addi.b	#$28,d6	; '('
		bra.w	loc_C8C40
; ---------------------------------------------------------------------------

loc_C8C3C:				; CODE XREF: sub_C8BB6+7Aj
		subi.b	#$28,d6	; '('

loc_C8C40:				; CODE XREF: sub_C8BB6+68j
					; sub_C8BB6+72j ...
		ext.w	d6
		add.w	$1C(a5),d6
		move.w	d6,$1C(a5)
		add.w	$10(a5),d6

locret_C8C4E:				; CODE XREF: sub_C8BB6+6j
		rts
; End of function sub_C8BB6


; =============== S U B	R O U T	I N E =======================================


sub_C8C50:				; CODE XREF: sub_C8A00+Ep

; FUNCTION CHUNK AT 000C8D4E SIZE 0000003E BYTES

		move.w	$10(a5),d6
		bne.s	loc_C8C64
		bset	#1,(a5)
		rts
; ---------------------------------------------------------------------------

loc_C8C5C:				; CODE XREF: sub_C8A00+26j
		tst.b	$A(a5)
		beq.w	locret_C8CAA

loc_C8C64:				; CODE XREF: sub_C8C50+4j
		btst	#1,(a5)
		bne.w	locret_C8CAA
		btst	#2,(a5)
		bne.w	locret_C8CAA
		bsr.w	sub_C8CAC
		tst.b	$F(a6)
		beq.s	loc_C8C88
		cmpi.b	#2,1(a5)
		beq.w	loc_C8D4E

loc_C8C88:				; CODE XREF: sub_C8C50+2Cj
		move.w	d6,d1
		lsr.w	#8,d1
		move.b	#$A4,d0
		bsr.w	WaitForZ80
		bsr.w	sub_C9980
		move.b	d6,d1
		move.b	#$A0,d0
		bsr.w	sub_C9980
		move.w	#0,($A11100).l

locret_C8CAA:				; CODE XREF: sub_C8C50+10j
					; sub_C8C50+18j ...
		rts
; End of function sub_C8C50


; =============== S U B	R O U T	I N E =======================================


sub_C8CAC:				; CODE XREF: sub_C8C50+24p
					; sub_C9B26+1Ep
		moveq	#0,d6
		move.b	$A(a5),d0
		andi.w	#$7F,d0	; ''
		beq.s	loc_C8CFC
		lea	NoiseIndex,a0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	(a0,d0.w),a0

loc_C8CC4:				; CODE XREF: sub_C8CAC+70j
					; sub_C8CAC+76j ...
		moveq	#0,d0
		move.b	$26(a5),d0
		addq.b	#1,$26(a5)
		move.b	(a0,d0.w),d6
		bpl.s	loc_C8CF2
		cmpi.b	#$80,d6
		beq.s	loc_C8D18
		cmpi.b	#$81,d6
		beq.s	loc_C8D1E
		cmpi.b	#$83,d6
		beq.s	loc_C8D24
		cmpi.b	#$82,d6
		beq.s	loc_C8D36
		cmpi.b	#$84,d6
		beq.s	loc_C8D3E

loc_C8CF2:				; CODE XREF: sub_C8CAC+26j
		ext.w	d6
		move.b	3(a5),d0
		ext.w	d0
		mulu.w	d0,d6

loc_C8CFC:				; CODE XREF: sub_C8CAC+Aj
		move.b	$1E(a5),d0
		ext.w	d0
		add.w	d0,d6
		add.w	$10(a5),d6
		tst.b	$A(a5)
		bpl.s	locret_C8D12
		add.w	$1C(a5),d6

locret_C8D12:				; CODE XREF: sub_C8CAC+60j
		rts
; ---------------------------------------------------------------------------
		addq.w	#4,sp
		rts
; ---------------------------------------------------------------------------

loc_C8D18:				; CODE XREF: sub_C8CAC+2Cj
		clr.b	$26(a5)
		bra.s	loc_C8CC4
; ---------------------------------------------------------------------------

loc_C8D1E:				; CODE XREF: sub_C8CAC+32j
		subq.b	#2,$26(a5)
		bra.s	loc_C8CC4
; ---------------------------------------------------------------------------

loc_C8D24:				; CODE XREF: sub_C8CAC+38j
		bset	#1,(a5)
		tst.b	1(a5)
		bmi.s	loc_C8D32
		bra.w	sub_C993E
; ---------------------------------------------------------------------------

loc_C8D32:				; CODE XREF: sub_C8CAC+80j
		bra.w	sub_C9C16
; ---------------------------------------------------------------------------

loc_C8D36:				; CODE XREF: sub_C8CAC+3Ej
		move.b	1(a0,d0.w),$26(a5)
		bra.s	loc_C8CC4
; ---------------------------------------------------------------------------

loc_C8D3E:				; CODE XREF: sub_C8CAC+44j
		move.b	1(a0,d0.w),d0
		add.b	d0,3(a5)
		addq.b	#1,$26(a5)
		bra.w	loc_C8CC4
; End of function sub_C8CAC

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C8C50

loc_C8D4E:				; CODE XREF: sub_C8C50+34j
		lea	byte_C8D8C,a1
		lea	$10(a6),a2
		tst.b	$E(a6)
		beq.s	loc_C8D60
		lea	$18(a6),a2

loc_C8D60:				; CODE XREF: sub_C8C50+10Aj
		moveq	#3,d5
		bsr.w	WaitForZ80

loc_C8D66:				; CODE XREF: sub_C8C50+12Ej
		move.w	d6,d1
		move.w	(a2)+,d0
		add.w	d0,d1
		move.w	d1,d3
		lsr.w	#8,d1
		move.b	(a1)+,d0
		bsr.w	sub_C998C
		move.b	d3,d1
		move.b	(a1)+,d0
		bsr.w	sub_C998C
		dbf	d5,loc_C8D66
		move.w	#0,($A11100).l
		rts
; END OF FUNCTION CHUNK	FOR sub_C8C50
; ---------------------------------------------------------------------------
byte_C8D8C:	dc.b $AD, $A9, $AC, $A8, $AE, $AA, $A6,	$A2
					; DATA XREF: sub_C8C50:loc_C8D4Eo

; =============== S U B	R O U T	I N E =======================================


sub_C8D94:				; CODE XREF: sub_C8A00+12p
		btst	#1,(a5)
		bne.s	locret_C8DA6
		moveq	#0,d0
		move.b	$1F(a5),d0
		lsl.w	#1,d0
		jmp	locret_C8DA6(pc,d0.w)

locret_C8DA6:				; CODE XREF: sub_C8D94+4j
		rts
; End of function sub_C8D94

; ---------------------------------------------------------------------------
		bra.s	loc_C8DD2
; ---------------------------------------------------------------------------
		bra.s	loc_C8DC8
; ---------------------------------------------------------------------------
		bra.s	loc_C8DC8

; =============== S U B	R O U T	I N E =======================================


sub_C8DAE:				; CODE XREF: sub_C8A00+1Ep
		btst	#1,(a5)
		bne.s	locret_C8DC0
		moveq	#0,d0
		move.b	$1F(a5),d0
		lsl.w	#1,d0
		jmp	locret_C8DC0(pc,d0.w)

locret_C8DC0:				; CODE XREF: sub_C8DAE+4j
		rts
; End of function sub_C8DAE

; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------
		bra.s	loc_C8DD2
; ---------------------------------------------------------------------------
		bra.s	loc_C8DD2
; ---------------------------------------------------------------------------

loc_C8DC8:				; CODE XREF: ROM:000C8DAAj
					; ROM:000C8DACj
		move.b	$23(a5),$24(a5)
		clr.b	$21(a5)

loc_C8DD2:				; CODE XREF: ROM:000C8DA8j
					; ROM:000C8DC4j ...
		move.b	$24(a5),d0
		cmp.b	$23(a5),d0
		bne.s	loc_C8DFA
		move.b	$22(a5),d3
		cmp.b	$21(a5),d3
		bpl.s	loc_C8DF2
		cmpi.b	#2,$1F(a5)
		beq.s	locret_C8E2A
		clr.b	$21(a5)

loc_C8DF2:				; CODE XREF: ROM:000C8DE4j
		clr.b	$24(a5)
		addq.b	#1,$21(a5)

loc_C8DFA:				; CODE XREF: ROM:000C8DDAj
		moveq	#0,d0
		move.b	$20(a5),d0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	off_C8E2C(pc,d0.w),a0
		moveq	#0,d0
		move.b	$21(a5),d0
		subq.w	#1,d0
		move.b	(a0,d0.w),d1
		move.b	$27(a5),d0
		andi.b	#$37,d0	; '7'
		or.b	d0,d1
		move.b	#$B4,d0
		bsr.w	sub_C9956
		addq.b	#1,$24(a5)

locret_C8E2A:				; CODE XREF: ROM:000C8DECj
		rts
; ---------------------------------------------------------------------------
off_C8E2C:	dc.l byte_C8E38, byte_C8E3A, byte_C8E3D	; DATA XREF: ROM:000C8E04r
byte_C8E38:	dc.b $40, $80		; DATA XREF: ROM:off_C8E2Co
byte_C8E3A:	dc.b $40, $C0, $80	; DATA XREF: ROM:off_C8E2Co
byte_C8E3D:	dc.b $C0, $80, $C0, $40, 0 ; DATA XREF:	ROM:off_C8E2Co

; =============== S U B	R O U T	I N E =======================================


OverrideFM4Freq:			; CODE XREF: sub_C8018+68Ep
					; sub_C8018+6C8p
		tst.b	$2F(a6)
		beq.w	locret_C8E88
		move.b	$3F(a6),d0
		subi.b	#$40,d0	; '@'
		bpl.w	loc_C8E58
		not.b	d0

loc_C8E58:				; CODE XREF: OverrideFM4Freq+10j
		lsr.b	#1,d0
		andi.w	#$7E,d0	; '~'
		move.w	word_C8E8A(pc,d0.w),d2
		move.w	d2,d1
		lsr.w	#8,d1
		move.b	#$A4,d0
		bsr.w	WaitForZ80
		bsr.w	sub_C99B2
		move.b	d2,d1
		move.b	#$A0,d0
		bsr.w	WaitForZ80
		bsr.w	sub_C99B2
		move.w	#0,($A11100).l

locret_C8E88:				; CODE XREF: OverrideFM4Freq+4j
		rts
; End of function OverrideFM4Freq

; ---------------------------------------------------------------------------
word_C8E8A:	dc.w $1008, $1010, $1020, $1030, $1040,	$1050, $1060, $1070
					; DATA XREF: OverrideFM4Freq+1Cr
		dc.w $1080, $1090, $10A0, $10B0, $10C0,	$10D0, $10E0, $10F0
		dc.w $1100, $1110, $1120, $1130, $1140,	$1150, $1160, $1170
		dc.w $1180, $1190, $11A0, $11B0, $11C0,	$11D0, $11E0, $11F0

; =============== S U B	R O U T	I N E =======================================


Sound_Play:				; CODE XREF: sub_C8018+66Ep
		tst.l	$A(a6)
		beq.s	locret_C8F1A
		lea	SoundPriorities,a0
		lea	$A(a6),a1
		move.b	0(a6),$30(a6)
		moveq	#3,d0

loc_C8EE0:				; CODE XREF: Sound_Play:loc_C8F10j
		move.b	(a1),d2
		move.b	d2,d3
		clr.b	(a1)+
		subq.b	#1,d2
		bcs.s	loc_C8F10
		andi.w	#$FF,d2
		move.b	(a0,d2.w),d4
		cmp.b	$30(a6),d4
		bcs.s	loc_C8F10
		tst.b	d4
		bmi.s	loc_C8F00
		move.b	d4,$30(a6)

loc_C8F00:				; CODE XREF: Sound_Play+30j
		move.b	d3,9(a6)
		movem.l	d0-a6,-(sp)
		jsr	Sound_ChkValue
		movem.l	(sp)+,d0-a6

loc_C8F10:				; CODE XREF: Sound_Play+1Ej
					; Sound_Play+2Cj
		dbf	d0,loc_C8EE0
		move.b	$30(a6),0(a6)

locret_C8F1A:				; CODE XREF: Sound_Play+4j
		rts
; End of function Sound_Play


; =============== S U B	R O U T	I N E =======================================


Sound_ChkValue:				; CODE XREF: sub_C8018+672p
					; Sound_Play+3Ep

; FUNCTION CHUNK AT 000C8720 SIZE 000000F6 BYTES
; FUNCTION CHUNK AT 000C9412 SIZE 00000062 BYTES
; FUNCTION CHUNK AT 000C9512 SIZE 000000F6 BYTES
; FUNCTION CHUNK AT 000C9754 SIZE 00000028 BYTES
; FUNCTION CHUNK AT 000C979A SIZE 00000082 BYTES

		moveq	#0,d7
		move.b	9(a6),d7
		beq.w	locret_C8F86
		clr.b	9(a6)
		cmpi.b	#$7B,d7	; '{'
		beq.w	loc_C8FC4
		cmpi.b	#$59,d7	; 'Y'
		beq.w	loc_C8FC4
		cmpi.b	#$8C,d7
		beq.w	loc_C8FC4
		cmpi.b	#$1F,d7
		bls.w	loc_C8FC4
		cmpi.b	#$20,d7	; ' '
		bcs.w	locret_C8F86
		cmpi.b	#$8F,d7
		bls.w	loc_C9176
		cmpi.b	#$90,d7
		bcs.w	locret_C8F86
		cmpi.b	#$92,d7
		bcs.w	loc_C926E
		cmpi.b	#$C0,d7
		bcs.w	PlaySample
		cmpi.b	#$CC,d7
		bls.w	Sound_DoSpecial
		cmpi.b	#$E8,d7
		bls.w	loc_C9176
		bra.w	LoadDualDriver
; ---------------------------------------------------------------------------

locret_C8F86:				; CODE XREF: Sound_ChkValue+6j
					; Sound_ChkValue+32j ...
		rts
; ---------------------------------------------------------------------------

Sound_DoSpecial:			; CODE XREF: Sound_ChkValue+5Aj
		subi.b	#$C0,d7
		add.w	d7,d7
		add.w	d7,d7
		jmp	loc_C8F94(pc,d7.w)

loc_C8F94:
		bra.w	loc_C9418
; ---------------------------------------------------------------------------
		bra.w	sub_C9310
; ---------------------------------------------------------------------------
		bra.w	sub_C93A8
; ---------------------------------------------------------------------------
		bra.w	loc_C9754
; ---------------------------------------------------------------------------
		bra.w	loc_C9512
; ---------------------------------------------------------------------------
		bra.w	loc_C9552
; ---------------------------------------------------------------------------
		bra.w	loc_C9552
; ---------------------------------------------------------------------------
		bra.w	LoadSimpleDriver
; ---------------------------------------------------------------------------
		bra.w	loc_C95D6
; ---------------------------------------------------------------------------
		bra.w	loc_C95EE
; ---------------------------------------------------------------------------
		bra.w	loc_C9412
; ---------------------------------------------------------------------------
		bra.w	loc_C944C
; ---------------------------------------------------------------------------

loc_C8FC4:				; CODE XREF: Sound_ChkValue+12j
					; Sound_ChkValue+1Aj ...
		bsr.w	sub_C9310
		bsr.w	sub_C93A8
		move.b	$41(a6),d1
		movem.l	d1,-(sp)
		bsr.w	sub_C977C
		movem.l	(sp)+,d1
		move.b	d1,$41(a6)
		lea	MusicPointers,a4
		cmpi.b	#$7B,d7	; '{'
		bne.w	loc_C8FF0
		move.b	#$20,d7	; ' '

loc_C8FF0:				; CODE XREF: Sound_ChkValue+CCj
		cmpi.b	#$59,d7	; 'Y'
		bne.w	loc_C8FFC
		move.b	#$21,d7	; '!'

loc_C8FFC:				; CODE XREF: Sound_ChkValue+D8j
		cmpi.b	#$8C,d7
		bne.w	loc_C9008
		move.b	#$22,d7	; '"'

loc_C9008:				; CODE XREF: Sound_ChkValue+E4j
		subq.b	#1,d7
		lsl.w	#2,d7
		movea.l	(a4,d7.w),a4
		moveq	#0,d0
		move.w	(a4),d0
		add.l	a4,d0
		move.l	d0,$20(a6)
		move.b	5(a4),2(a6)
		move.b	5(a4),1(a6)
		bsr.w	ClearSampleQueue
		moveq	#0,d1
		movea.l	a4,a3
		addq.w	#6,a4
		moveq	#0,d7
		move.b	2(a3),d7
		beq.s	loc_C90B0
		subq.b	#1,d7
		move.b	#$C0,d1
		move.b	#$80,d3
		move.b	4(a3),d4
		moveq	#$34,d6	; '4'
		move.b	#1,d5
		lea	$4A(a6),a1
		lea	byte_C916A,a2

loc_C9054:				; CODE XREF: Sound_ChkValue+15Ej
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
		dbf	d7,loc_C9054
		cmpi.b	#7,2(a3)
		bne.s	loc_C9090
		moveq	#$2B,d0	; '+'
		moveq	#0,d1
		bsr.w	sub_C996E
		bra.s	loc_C90B0
; ---------------------------------------------------------------------------

loc_C9090:				; CODE XREF: Sound_ChkValue+168j
		moveq	#$28,d0	; '('
		moveq	#6,d1
		bsr.w	sub_C996E
		move.b	#$B6,d0
		move.b	#$C0,d1
		bsr.w	WaitForZ80
		bsr.w	sub_C99B2
		move.w	#0,($A11100).l

loc_C90B0:				; CODE XREF: Sound_ChkValue+11Aj
					; Sound_ChkValue+172j
		moveq	#0,d7
		move.b	3(a3),d7
		beq.s	loc_C90F0
		subq.b	#1,d7
		lea	$1B6(a6),a1
		lea	byte_C9172,a2

loc_C90C2:				; CODE XREF: Sound_ChkValue+1D0j
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
		dbf	d7,loc_C90C2

loc_C90F0:				; CODE XREF: Sound_ChkValue+19Aj
		lea	$252(a6),a1
		moveq	#5,d7

loc_C90F6:				; CODE XREF: Sound_ChkValue+204j
		tst.b	(a1)
		bpl.w	loc_C911E
		moveq	#0,d0
		move.b	1(a1),d0
		bmi.w	loc_C910E
		subq.b	#2,d0
		add.b	d0,d0
		bra.w	loc_C9110
; ---------------------------------------------------------------------------

loc_C910E:				; CODE XREF: Sound_ChkValue+1E6j
		lsr.b	#4,d0

loc_C9110:				; CODE XREF: Sound_ChkValue+1EEj
		lea	BGMChannelRAM,a0
		movea.w	(a0,d0.w),a0
		adda.l	a6,a0
		bset	#2,(a0)

loc_C911E:				; CODE XREF: Sound_ChkValue+1DCj
		adda.w	d6,a1
		dbf	d7,loc_C90F6
		tst.w	$38A(a6)
		bpl.s	loc_C9130
		bset	#2,$14E(a6)

loc_C9130:				; CODE XREF: Sound_ChkValue+20Cj
		tst.w	$3BE(a6)
		bpl.s	loc_C913C
		bset	#2,$21E(a6)

loc_C913C:				; CODE XREF: Sound_ChkValue+218j
		lea	$B2(a6),a5
		moveq	#4,d4

loc_C9142:				; CODE XREF: Sound_ChkValue+22Cj
		bsr.w	sub_C993E
		adda.w	d6,a5
		dbf	d4,loc_C9142
		moveq	#2,d4

loc_C914E:				; CODE XREF: Sound_ChkValue+238j
		bsr.w	sub_C9C16
		adda.w	d6,a5
		dbf	d4,loc_C914E
		btst	#2,$21E(a6)
		bne.s	locret_C9168
		move.b	#$FF,($C00011).l

locret_C9168:				; CODE XREF: Sound_ChkValue+242j
		rts
; ---------------------------------------------------------------------------
byte_C916A:	dc.b $10, $11, 0, 1, 2,	4, 5, 6	; DATA XREF: Sound_ChkValue+134o
byte_C9172:	dc.b $80, $A0, $C0, 0	; DATA XREF: Sound_ChkValue+1A2o
; ---------------------------------------------------------------------------

loc_C9176:				; CODE XREF: Sound_ChkValue+3Aj
					; Sound_ChkValue+62j
		lea	SFXList,a0
		cmpi.b	#$E0,d7
		bcs.w	loc_C918E
		subi.b	#$E0,d7
		addi.b	#$70,d7	; 'p'
		bra.w	loc_C9192
; ---------------------------------------------------------------------------

loc_C918E:				; CODE XREF: Sound_ChkValue+262j
		subi.b	#$20,d7	; ' '

loc_C9192:				; CODE XREF: Sound_ChkValue+26Ej
		lsl.w	#2,d7
		movea.l	(a0,d7.w),a3
		movea.l	a3,a1
		moveq	#0,d1
		move.w	(a1)+,d1
		add.l	a3,d1
		move.b	(a1)+,d5
		moveq	#0,d7
		move.b	(a1)+,d7
		subq.b	#1,d7
		moveq	#$34,d6	; '4'

loc_C91AA:				; CODE XREF: Sound_ChkValue:loc_C9230j
		moveq	#0,d3
		move.b	1(a1),d3
		move.b	d3,d4
		bmi.s	loc_C91C8
		subq.b	#2,d3
		add.b	d3,d3
		lea	BGMChannelRAM,a5
		movea.w	(a5,d3.w),a5
		adda.l	a6,a5
		bset	#2,(a5)
		bra.s	loc_C91F4
; ---------------------------------------------------------------------------

loc_C91C8:				; CODE XREF: Sound_ChkValue+296j
		lsr.b	#4,d3
		lea	BGMChannelRAM,a5
		movea.w	(a5,d3.w),a5
		adda.l	a6,a5
		bset	#2,(a5)
		cmpi.b	#$C0,d4
		bne.s	loc_C91F4
		move.b	d4,d0
		ori.b	#$1F,d0
		move.b	d0,($C00011).l
		bchg	#5,d0
		move.b	d0,($C00011).l

loc_C91F4:				; CODE XREF: Sound_ChkValue+2AAj
					; Sound_ChkValue+2C0j
		movea.w	SFXChannelRAM(pc,d3.w),a5
		adda.l	a6,a5
		movea.l	a5,a2
		moveq	#$C,d0

loc_C91FE:				; CODE XREF: Sound_ChkValue+2E4j
		clr.l	(a2)+
		dbf	d0,loc_C91FE
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
		bmi.s	loc_C9230
		move.b	#$C0,$27(a5)

loc_C9230:				; CODE XREF: Sound_ChkValue+30Cj
		dbf	d7,loc_C91AA
		tst.b	$286(a6)
		bpl.s	loc_C9240
		bset	#2,$38A(a6)

loc_C9240:				; CODE XREF: Sound_ChkValue+31Cj
		tst.b	$356(a6)
		bpl.s	locret_C924C
		bset	#2,$3BE(a6)

locret_C924C:				; CODE XREF: Sound_ChkValue+328j
		rts
; ---------------------------------------------------------------------------
BGMChannelRAM:	dc.w $11A, 0, $14E, $182, $1B6,	$1EA, $21E, $21E
					; DATA XREF: Sound_ChkValue:loc_C9110o
					; Sound_ChkValue+29Co ...
SFXChannelRAM:				; DATA XREF: Sound_ChkValue:loc_C91F4r
		dc.w $252, 0, $286, $2BA, $2EE,	$322, $356, $356
; ---------------------------------------------------------------------------

loc_C926E:				; CODE XREF: Sound_ChkValue+4Aj
		lea	SpecialList_Broken,a0
		subi.b	#$90,d7
		lsl.w	#2,d7
		movea.l	(a0,d7.w),a3
		movea.l	a3,a1
		moveq	#0,d0
		move.w	(a1)+,d0
		add.l	a3,d0
		move.l	d0,$24(a6)
		move.b	(a1)+,d5
		move.b	(a1)+,d7
		subq.b	#1,d7
		moveq	#$34,d6	; '4'

loc_C9290:				; CODE XREF: Sound_ChkValue:loc_C92DEj
		move.b	1(a1),d4
		bmi.s	loc_C92A2
		bset	#2,$14E(a6)
		lea	$38A(a6),a5
		bra.s	loc_C92AC
; ---------------------------------------------------------------------------

loc_C92A2:				; CODE XREF: Sound_ChkValue+378j
		bset	#2,$21E(a6)
		lea	$3BE(a6),a5

loc_C92AC:				; CODE XREF: Sound_ChkValue+384j
		movea.l	a5,a2
		moveq	#$C,d0

loc_C92B0:				; CODE XREF: Sound_ChkValue+396j
		clr.l	(a2)+
		dbf	d0,loc_C92B0
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
		bmi.s	loc_C92DE
		move.b	#$C0,$27(a5)

loc_C92DE:				; CODE XREF: Sound_ChkValue+3BAj
		dbf	d7,loc_C9290
		tst.b	$286(a6)
		bpl.s	loc_C92EE
		bset	#2,$38A(a6)

loc_C92EE:				; CODE XREF: Sound_ChkValue+3CAj
		tst.b	$356(a6)
		bpl.s	locret_C930E
		bset	#2,$3BE(a6)
		ori.b	#$1F,d4
		move.b	d4,($C00011).l
		bchg	#5,d4
		move.b	d4,($C00011).l

locret_C930E:				; CODE XREF: Sound_ChkValue+3D6j
		rts
; End of function Sound_ChkValue


; =============== S U B	R O U T	I N E =======================================


sub_C9310:				; CODE XREF: Sound_ChkValue+7Cj
					; Sound_ChkValue:loc_C8FC4p ...
		clr.b	0(a6)
		moveq	#$27,d0	; '''
		moveq	#0,d1
		bsr.w	sub_C996E
		lea	$252(a6),a5
		moveq	#5,d6

loc_C9322:				; CODE XREF: sub_C9310+92j
		tst.b	(a5)
		bpl.w	loc_C939E
		bclr	#7,(a5)
		moveq	#0,d3
		move.b	1(a5),d3
		bmi.s	loc_C9376
		bsr.w	sub_C993E
		cmpi.b	#4,d3
		bne.s	loc_C934E
		tst.b	$38A(a6)
		bpl.s	loc_C934E
		lea	$38A(a6),a5
		movea.l	$24(a6),a1
		bra.s	loc_C9362
; ---------------------------------------------------------------------------

loc_C934E:				; CODE XREF: sub_C9310+2Cj
					; sub_C9310+32j
		subq.b	#2,d3
		add.b	d3,d3
		movea.l	a5,a3
		lea	BGMChannelRAM,a5
		movea.w	(a5,d3.w),a5
		adda.l	a6,a5
		movea.l	$20(a6),a1

loc_C9362:				; CODE XREF: sub_C9310+3Cj
		bclr	#2,(a5)
		bset	#1,(a5)
		move.b	$B(a5),d0
		bsr.w	sub_C9EB2
		movea.l	a3,a5
		bra.s	loc_C939E
; ---------------------------------------------------------------------------

loc_C9376:				; CODE XREF: sub_C9310+22j
		bsr.w	sub_C9C16
		lsr.b	#4,d3
		lea	BGMChannelRAM,a0
		movea.w	(a0,d3.w),a0
		adda.l	a6,a0
		bclr	#2,(a0)
		bset	#1,(a0)
		cmpi.b	#$E0,1(a0)
		bne.s	loc_C939E
		move.b	$25(a0),($C00011).l

loc_C939E:				; CODE XREF: sub_C9310+14j
					; sub_C9310+64j ...
		adda.w	#$34,a5	; '4'
		dbf	d6,loc_C9322
		rts
; End of function sub_C9310


; =============== S U B	R O U T	I N E =======================================


sub_C93A8:				; CODE XREF: Sound_ChkValue+80j
					; Sound_ChkValue+ACp ...
		lea	$38A(a6),a5
		tst.b	(a5)
		bpl.s	loc_C93DA
		bclr	#7,(a5)
		btst	#2,(a5)
		bne.s	loc_C93DA
		bsr.w	sub_C994A
		lea	$14E(a6),a5
		bclr	#2,(a5)
		bset	#1,(a5)
		tst.b	(a5)
		bpl.s	loc_C93DA
		movea.l	$20(a6),a1
		move.b	$B(a5),d0
		bsr.w	sub_C9EB2

loc_C93DA:				; CODE XREF: sub_C93A8+6j
					; sub_C93A8+10j ...
		lea	$3BE(a6),a5
		tst.b	(a5)
		bpl.s	locret_C9410
		bclr	#7,(a5)
		btst	#2,(a5)
		bne.s	locret_C9410
		bsr.w	sub_C9C1C
		lea	$21E(a6),a5
		bclr	#2,(a5)
		bset	#1,(a5)
		tst.b	(a5)
		bpl.s	locret_C9410
		cmpi.b	#$E0,1(a5)
		bne.s	locret_C9410
		move.b	$25(a5),($C00011).l

locret_C9410:				; CODE XREF: sub_C93A8+38j
					; sub_C93A8+42j ...
		rts
; End of function sub_C93A8

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR Sound_ChkValue

loc_C9412:				; CODE XREF: Sound_ChkValue+A0j
		move.b	#1,$47(a6)

loc_C9418:				; CODE XREF: Sound_ChkValue:loc_C8F94j
		bsr.w	sub_C9310
		bsr.s	sub_C93A8
		move.b	#$10,$2E(a6)
		move.b	#$10,$2D(a6)
		move.b	#$18,$2C(a6)
		tst.b	$47(a6)
		beq.w	loc_C943E
		move.b	#$40,$2C(a6) ; '@'

loc_C943E:				; CODE XREF: Sound_ChkValue+518j
		clr.b	$4A(a6)
		clr.b	$7E(a6)
		bsr.w	ClearSampleQueue
		rts
; ---------------------------------------------------------------------------

loc_C944C:				; CODE XREF: Sound_ChkValue+A4j
		bsr.w	sub_C9310
		bsr.w	sub_C93A8
		move.b	#1,$2E(a6)
		move.b	#1,$2D(a6)
		move.b	#$C,$2C(a6)
		clr.b	$4A(a6)
		clr.b	$7E(a6)
		bsr.w	ClearSampleQueue
		rts
; END OF FUNCTION CHUNK	FOR Sound_ChkValue

; =============== S U B	R O U T	I N E =======================================


DoFadeOut:				; CODE XREF: sub_C8018+686p
					; sub_C8018+6C0p
		moveq	#0,d0
		move.b	$2C(a6),d0
		beq.s	locret_C9486
		move.b	$2E(a6),d0
		beq.s	loc_C9488
		subq.b	#1,$2E(a6)

locret_C9486:				; CODE XREF: DoFadeOut+6j
		rts
; ---------------------------------------------------------------------------

loc_C9488:				; CODE XREF: DoFadeOut+Cj
		subq.b	#1,$2C(a6)
		bne.w	loc_C9498
		tst.b	$47(a6)
		beq.w	loc_C9754

loc_C9498:				; CODE XREF: DoFadeOut+18j
		clr.b	$E(a6)
		move.b	$2D(a6),$2E(a6)
		lea	$B2(a6),a5
		moveq	#4,d7

loc_C94A8:				; CODE XREF: DoFadeOut+6Aj
		tst.b	(a5)
		bpl.w	loc_C94DA
		addq.b	#8,9(a5)
		move.b	9(a5),d0
		cmpi.b	#$40,d0	; '@'
		bcs.w	loc_C94D6
		move.b	#$7F,9(a5) ; ''
		bsr.w	sub_C9F24
		bclr	#7,(a5)
		move.b	#1,$2C(a6)
		bra.w	loc_C94DA
; ---------------------------------------------------------------------------

loc_C94D6:				; CODE XREF: DoFadeOut+46j
		bsr.w	sub_C9F24

loc_C94DA:				; CODE XREF: DoFadeOut+36j
					; DoFadeOut+5Ej
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C94A8
		moveq	#2,d7

loc_C94E4:				; CODE XREF: DoFadeOut+98j
		tst.b	(a5)
		bpl.w	loc_C9508
		addq.b	#1,9(a5)
		cmpi.b	#$10,9(a5)
		bcs.w	loc_C9500
		bclr	#7,(a5)
		bra.w	loc_C9508
; ---------------------------------------------------------------------------

loc_C9500:				; CODE XREF: DoFadeOut+80j
		move.b	9(a5),d6
		bsr.w	sub_C9BC4

loc_C9508:				; CODE XREF: DoFadeOut+72j
					; DoFadeOut+88j
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C94E4
		rts
; End of function DoFadeOut

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR Sound_ChkValue

loc_C9512:				; CODE XREF: Sound_ChkValue+88j
		move.b	#$80,3(a6)
		moveq	#2,d2
		move.b	#$B4,d0
		moveq	#0,d1
		bsr.w	WaitForZ80

loc_C9524:				; CODE XREF: Sound_ChkValue+612j
		bsr.w	sub_C998C
		bsr.w	sub_C99B2
		addq.b	#1,d0
		dbf	d2,loc_C9524
		moveq	#2,d2
		moveq	#$28,d0	; '('

loc_C9536:				; CODE XREF: Sound_ChkValue+626j
		move.b	d2,d1
		bsr.w	sub_C998C
		addq.b	#4,d1
		bsr.w	sub_C998C
		dbf	d2,loc_C9536
		move.w	#0,($A11100).l
		bra.w	sub_C9C2C
; ---------------------------------------------------------------------------

loc_C9552:				; CODE XREF: Sound_ChkValue+8Cj
					; Sound_ChkValue+90j
		clr.b	3(a6)
		moveq	#$34,d3	; '4'
		lea	$B2(a6),a5
		moveq	#4,d4
		bsr.w	WaitForZ80

loc_C9562:				; CODE XREF: Sound_ChkValue+660j
		btst	#7,(a5)
		beq.s	loc_C957A
		btst	#2,(a5)
		bne.s	loc_C957A
		move.b	#$B4,d0
		move.b	$27(a5),d1
		bsr.w	sub_C9980

loc_C957A:				; CODE XREF: Sound_ChkValue+64Aj
					; Sound_ChkValue+650j
		adda.w	d3,a5
		dbf	d4,loc_C9562
		move.b	#$B6,d0
		move.b	#$C0,d1
		bsr.w	sub_C99B2
		lea	$252(a6),a5
		moveq	#2,d4

loc_C9592:				; CODE XREF: Sound_ChkValue+690j
		btst	#7,(a5)
		beq.s	loc_C95AA
		btst	#2,(a5)
		bne.s	loc_C95AA
		move.b	#$B4,d0
		move.b	$27(a5),d1
		bsr.w	sub_C9980

loc_C95AA:				; CODE XREF: Sound_ChkValue+67Aj
					; Sound_ChkValue+680j
		adda.w	d3,a5
		dbf	d4,loc_C9592
		lea	$38A(a6),a5
		btst	#7,(a5)
		beq.s	loc_C95CC
		btst	#2,(a5)
		bne.s	loc_C95CC
		move.b	#$B4,d0
		move.b	$27(a5),d1
		bsr.w	sub_C9980

loc_C95CC:				; CODE XREF: Sound_ChkValue+69Cj
					; Sound_ChkValue+6A2j
		move.w	#0,($A11100).l
		rts
; ---------------------------------------------------------------------------

loc_C95D6:				; CODE XREF: Sound_ChkValue+98j
		lea	$356(a6),a5
		jsr	sub_C9C16
		andi.b	#$7F,(a5) ; ''
		lea	$21E(a6),a5
		andi.b	#$FB,(a5)
		rts
; ---------------------------------------------------------------------------

loc_C95EE:				; CODE XREF: Sound_ChkValue+9Cj
		lea	$356(a6),a5
		ori.b	#$80,(a5)
		lea	$21E(a6),a5
		ori.b	#4,(a5)
		move.b	#$FF,($C00011).l
		rts
; END OF FUNCTION CHUNK	FOR Sound_ChkValue

; =============== S U B	R O U T	I N E =======================================


TempoWait:				; CODE XREF: sub_C8018+682p
					; sub_C8018+6BCp
		move.b	2(a6),d0
		beq.s	loc_C962A
		add.b	d0,1(a6)
		bcc.s	loc_C962A
		lea	$4A(a6),a0
		moveq	#$34,d0	; '4'
		moveq	#9,d1

loc_C961C:				; CODE XREF: TempoWait+1Ej
		tst.b	(a0)
		bpl.s	loc_C9624
		addq.b	#1,$E(a0)

loc_C9624:				; CODE XREF: TempoWait+16j
		adda.w	d0,a0
		dbf	d1,loc_C961C

loc_C962A:				; CODE XREF: TempoWait+4j TempoWait+Aj
		move.b	$42(a6),d0
		beq.s	locret_C968C
		move.b	$45(a6),d2
		cmp.b	$44(a6),d2
		bne.w	loc_C9656
		move.b	#0,$45(a6)
		move.b	$46(a6),d2
		cmp.b	$42(a6),d2
		beq.w	loc_C965A
		addq.b	#1,$42(a6)
		bra.w	loc_C965A
; ---------------------------------------------------------------------------

loc_C9656:				; CODE XREF: TempoWait+30j
		addq.b	#1,$45(a6)

loc_C965A:				; CODE XREF: TempoWait+42j
					; TempoWait+4Aj
		add.b	d0,$43(a6)
		bcc.s	locret_C968C
		lea	$4A(a6),a0
		moveq	#$34,d0	; '4'
		moveq	#9,d1

loc_C9668:				; CODE XREF: TempoWait+80j
		tst.b	(a0)
		bpl.s	loc_C9686
		move.b	$2C(a0),d2
		addq.b	#1,d2
		cmp.b	$E(a0),d2
		bcs.w	loc_C9682
		addq.b	#1,$2C(a0)
		bra.w	loc_C9686
; ---------------------------------------------------------------------------

loc_C9682:				; CODE XREF: TempoWait+6Ej
		sub.b	d2,$E(a0)

loc_C9686:				; CODE XREF: TempoWait+62j
					; TempoWait+76j
		adda.w	d0,a0
		dbf	d1,loc_C9668

locret_C968C:				; CODE XREF: TempoWait+26j
					; TempoWait+56j
		rts
; End of function TempoWait


; =============== S U B	R O U T	I N E =======================================


sub_C968E:				; CODE XREF: cfHandler:loc_C9DB4p
		bsr.w	WaitForZ80
		moveq	#3,d4
		moveq	#$40,d3	; '@'
		moveq	#$7F,d1	; ''

loc_C9698:				; CODE XREF: sub_C968E+12j
		move.b	d3,d0
		bsr.w	sub_C9980
		addq.b	#4,d3
		dbf	d4,loc_C9698
		moveq	#3,d4
		move.b	#$80,d3
		moveq	#$F,d1

loc_C96AC:				; CODE XREF: sub_C968E+26j
		move.b	d3,d0
		bsr.w	sub_C9980
		addq.b	#4,d3
		dbf	d4,loc_C96AC
		move.w	#0,($A11100).l
		rts
; End of function sub_C968E


; =============== S U B	R O U T	I N E =======================================


sub_C96C2:				; CODE XREF: Sound_ChkValue+856p
		moveq	#2,d2
		moveq	#$28,d0	; '('
		bsr.w	WaitForZ80

loc_C96CA:				; CODE XREF: sub_C96C2+14j
		move.b	d2,d1
		bsr.w	sub_C998C
		addq.b	#4,d1
		bsr.w	sub_C998C
		dbf	d2,loc_C96CA
		moveq	#$40,d0	; '@'
		moveq	#$7F,d1	; ''
		moveq	#2,d3

loc_C96E0:				; CODE XREF: sub_C96C2+32j
		moveq	#3,d2

loc_C96E2:				; CODE XREF: sub_C96C2+2Aj
		bsr.w	sub_C998C
		bsr.w	sub_C99B2
		addq.w	#4,d0
		dbf	d2,loc_C96E2
		subi.b	#$F,d0
		dbf	d3,loc_C96E0
		move.w	#0,($A11100).l
		rts
; End of function sub_C96C2


; =============== S U B	R O U T	I N E =======================================


ClearSampleQueue:			; CODE XREF: Sound_ChkValue+10Ap
					; Sound_ChkValue+52Ap ...
		bsr.w	WaitForZ80
		move.b	#$80,($A01FFE).l
		lea	($A01FF4).l,a0
		move.b	#$80,1(a0)
		move.b	#0,0(a0)
		move.b	#0,6(a0)
		move.b	#0,5(a0)
		lea	($A01FEA).l,a0
		move.b	#$80,1(a0)
		move.b	#0,0(a0)
		move.b	#0,6(a0)
		move.b	#0,5(a0)
		move.w	#0,($A11100).l
		rts
; End of function ClearSampleQueue

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR Sound_ChkValue

loc_C9754:				; CODE XREF: Sound_ChkValue+84j
					; DoFadeOut+20j ...
		moveq	#$2B,d0	; '+'
		move.b	#$80,d1
		bsr.w	sub_C996E
		moveq	#$27,d0	; '''
		moveq	#0,d1
		bsr.w	sub_C996E
		movea.l	a6,a0
		move.w	#$F5,d0	; 'õ'

loc_C976C:				; CODE XREF: Sound_ChkValue+852j
		clr.l	(a0)+
		dbf	d0,loc_C976C
		bsr.w	sub_C96C2
		bsr.w	sub_C9C2C
		bra.s	ClearSampleQueue
; END OF FUNCTION CHUNK	FOR Sound_ChkValue

; =============== S U B	R O U T	I N E =======================================


sub_C977C:				; CODE XREF: Sound_ChkValue+B8p
		moveq	#$27,d0	; '''
		moveq	#0,d1
		bsr.w	sub_C996E
		movea.l	a6,a0
		move.b	0(a6),d1
		move.w	#$91,d0	; '‘'

loc_C978E:				; CODE XREF: sub_C977C+14j
		clr.l	(a0)+
		dbf	d0,loc_C978E
		move.b	d1,0(a6)
		rts
; End of function sub_C977C

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR Sound_ChkValue

LoadDualDriver:				; CODE XREF: j_LoadSimpleDriverj
					; Sound_ChkValue+66j
		move.w	#$100,($A11200).l
		lea	Drv68Kmem.w,a6
		move.w	#$100,($A11100).l

loc_C97AE:				; CODE XREF: Sound_ChkValue+89Aj
		btst	#0,($A11100).l
		bne.s	loc_C97AE
		move.l	PCMDualDriver(pc),a0
		lea	($A00000).l,a1
		move.w	#filesize("drivers/dual.unc")-1,d0

loc_C97C8:				; CODE XREF: Sound_ChkValue+8AEj
		move.b	(a0)+,(a1)+
		dbf	d0,loc_C97C8
		movea.l	PCMSamples(pc),a0
		lea	($A002DC).l,a1
		move.w	#filesize("data/PCMSamples.unc")-1,d0

loc_C97DE:				; CODE XREF: Sound_ChkValue+8C4j
		move.b	(a0)+,(a1)+
		dbf	d0,loc_C97DE
		move.w	#0,($A11200).l
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
		move.w	#$100,($A11200).l
		move.w	#0,($A11100).l
		bra.w	loc_C9754
; END OF FUNCTION CHUNK	FOR Sound_ChkValue
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C8018

LoadSimpleDriver:				; CODE XREF: sub_C8018+4j
					; Sound_ChkValue+94j
		move.w	#$100,($A11200).l
		lea	Drv68Kmem.w,a6
		move.w	#$100,($A11100).l

loc_C9830:				; CODE XREF: sub_C8018+1820j
		btst	#0,($A11100).l
		bne.s	loc_C9830
		move.l	PCMSimpleDriver(pc),a0
		lea	($A00000).l,a1
		move.w	#filesize("dirvers/simple.unc")-1,d0	; 'è'

loc_C984A:				; CODE XREF: sub_C8018+1834j
		move.b	(a0)+,(a1)+
		dbf	d0,loc_C984A
		lea	$4A(a6),a5
		move.l	DACTable1(pc),a0
		move.w	DACTable2(pc),d0
		adda.w	d0,a0
		move.l	(a0)+,d0
		move.l	d0,d1
		swap	d1
		rol.l	#1,d1
		ori.b	#$80,d1
		move.b	d1,$16(a5)
		ori.w	#$8000,d0
		move.w	d0,d1
		move.b	d1,$18(a5)
		lsr.w	#8,d1
		move.b	d1,$17(a5)
		neg.w	d0
		ext.l	d0
		move.l	(a0)+,d1
		cmp.l	d1,d0
		bcs.w	loc_C988C
		move.w	d1,d0

loc_C988C:				; CODE XREF: sub_C8018+186Ej
		sub.l	d0,d1
		move.b	d0,$1A(a5)
		lsr.w	#8,d0
		move.b	d0,$19(a5)
		move.b	d1,$1D(a5)
		lsr.l	#8,d1
		move.b	d1,$1C(a5)
		lsr.w	#8,d1
		move.b	d1,$1B(a5)
		lea	($A01FF4).l,a1
		move.b	#$80,($A01FFE).l
		move.b	#$80,1(a1)
		move.b	$16(a5),2(a1)
		move.b	$18(a5),4(a1)
		move.b	$17(a5),3(a1)
		move.b	$1A(a5),6(a1)
		move.b	$19(a5),5(a1)
		move.b	$1D(a5),9(a1)
		move.b	$1C(a5),8(a1)
		move.b	$1B(a5),7(a1)
		move.w	#0,($A11200).l
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
		move.w	#$100,($A11200).l
		move.w	#0,($A11100).l
		rts
; END OF FUNCTION CHUNK	FOR sub_C8018
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C8A00

loc_C9922:				; CODE XREF: sub_C8A00+16j
		btst	#1,(a5)
		bne.s	locret_C993C
		btst	#2,(a5)
		bne.s	locret_C993C
		moveq	#$28,d0	; '('
		move.b	1(a5),d1
		ori.b	#$F0,d1
		bra.w	sub_C996E
; ---------------------------------------------------------------------------

locret_C993C:				; CODE XREF: sub_C8A00+F26j
					; sub_C8A00+F2Cj
		rts
; END OF FUNCTION CHUNK	FOR sub_C8A00

; =============== S U B	R O U T	I N E =======================================


sub_C993E:				; CODE XREF: sub_C8A2A:loc_C8A42p
					; sub_C8B82+24p ...

; FUNCTION CHUNK AT 000C9954 SIZE 00000002 BYTES

		btst	#4,(a5)
		bne.s	locret_C9954
		btst	#2,(a5)
		bne.s	locret_C9954
; End of function sub_C993E


; =============== S U B	R O U T	I N E =======================================


sub_C994A:				; CODE XREF: sub_C93A8+12p
		moveq	#$28,d0	; '('
		move.b	1(a5),d1
		bra.w	sub_C996E
; End of function sub_C994A

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C993E

locret_C9954:				; CODE XREF: sub_C993E+4j sub_C993E+Aj
		rts
; END OF FUNCTION CHUNK	FOR sub_C993E

; =============== S U B	R O U T	I N E =======================================


sub_C9956:				; CODE XREF: ROM:000C8E22p
					; cfHandler+D2j ...
		btst	#2,(a5)
		bne.s	locret_C996C
		bsr.w	WaitForZ80
		bsr.w	sub_C9980
		move.w	#0,($A11100).l

locret_C996C:				; CODE XREF: sub_C9956+4j
		rts
; End of function sub_C9956


; =============== S U B	R O U T	I N E =======================================


sub_C996E:				; CODE XREF: Sound_ChkValue+16Ep
					; Sound_ChkValue+178p ...
		bsr.w	WaitForZ80
		bsr.w	sub_C998C
		move.w	#0,($A11100).l
		rts
; End of function sub_C996E


; =============== S U B	R O U T	I N E =======================================


sub_C9980:				; CODE XREF: sub_C8C50+44p
					; sub_C8C50+4Ep ...

; FUNCTION CHUNK AT 000C99A8 SIZE 0000000A BYTES

		btst	#2,1(a5)
		bne.s	loc_C99A8
		add.b	1(a5),d0
; End of function sub_C9980


; =============== S U B	R O U T	I N E =======================================


sub_C998C:				; CODE XREF: sub_C8C50+122p
					; sub_C8C50+12Ap ...
		lea	($A04000).l,a0

loc_C9992:				; CODE XREF: sub_C998C+Aj
		btst	#7,(a0)
		bne.s	loc_C9992
		move.b	d0,(a0)
		nop

loc_C999C:				; CODE XREF: sub_C998C+14j
		btst	#7,(a0)
		bne.s	loc_C999C
		move.b	d1,1(a0)
		rts
; End of function sub_C998C

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C9980

loc_C99A8:				; CODE XREF: sub_C9980+6j
		move.b	1(a5),d2
		bclr	#2,d2
		add.b	d2,d0
; END OF FUNCTION CHUNK	FOR sub_C9980

; =============== S U B	R O U T	I N E =======================================


sub_C99B2:				; CODE XREF: OverrideFM4Freq+2Cp
					; OverrideFM4Freq+3Ap ...
		lea	($A04000).l,a0

loc_C99B8:				; CODE XREF: sub_C99B2+Aj
		btst	#7,(a0)
		bne.s	loc_C99B8
		move.b	d0,2(a0)
		nop

loc_C99C4:				; CODE XREF: sub_C99B2+16j
		btst	#7,(a0)
		bne.s	loc_C99C4
		move.b	d1,3(a0)
		rts
; End of function sub_C99B2


; =============== S U B	R O U T	I N E =======================================


WaitForZ80:				; CODE XREF: Sound_ChkValue-75Ap
					; sub_C88AE:@gotsampleentryp ...
		move.w	#$100,($A11100).l

loc_C99D8:				; CODE XREF: WaitForZ80+10j
		btst	#0,($A11100).l
		bne.s	loc_C99D8
		tst.b	($A01FFF).l
		beq.s	locret_C99FE
		move.w	#0,($A11100).l
		nop
		nop
		nop
		nop
		nop
		bra.s	WaitForZ80
; ---------------------------------------------------------------------------

locret_C99FE:				; CODE XREF: WaitForZ80+18j
		rts
; End of function WaitForZ80


; =============== S U B	R O U T	I N E =======================================


DoFade:					; CODE XREF: sub_C8018+67Ep
					; sub_C8018+6B8p
		tst.b	$28(a6)
		beq.w	locret_C9A82
		cmpi.b	#2,$28(a6)
		beq.w	locret_C9A82
		move.b	$29(a6),d6
		lea	$B2(a6),a5
		moveq	#4,d7

loc_C9A1C:				; CODE XREF: DoFade+3Aj
		tst.b	(a5)
		bpl.s	loc_C9A36
		tst.b	$28(a6)
		bpl.s	loc_C9A2C
		sub.b	d6,9(a5)
		bra.s	loc_C9A32
; ---------------------------------------------------------------------------

loc_C9A2C:				; CODE XREF: DoFade+24j
		add.b	d6,9(a5)
		bmi.s	loc_C9A36

loc_C9A32:				; CODE XREF: DoFade+2Aj
		bsr.w	sub_C9F24

loc_C9A36:				; CODE XREF: DoFade+1Ej DoFade+30j
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C9A1C
		move.b	$2A(a6),d5
		moveq	#2,d7

loc_C9A44:				; CODE XREF: DoFade+6Cj
		tst.b	(a5)
		bpl.s	loc_C9A68
		tst.b	$28(a6)
		bpl.s	loc_C9A54
		sub.b	d5,9(a5)
		bra.s	loc_C9A60
; ---------------------------------------------------------------------------

loc_C9A54:				; CODE XREF: DoFade+4Cj
		add.b	d5,9(a5)
		cmpi.b	#$10,9(a5)
		bcc.s	loc_C9A68

loc_C9A60:				; CODE XREF: DoFade+52j
		move.b	9(a5),d6
		bsr.w	sub_C9BC4

loc_C9A68:				; CODE XREF: DoFade+46j DoFade+5Ej
		adda.w	#$34,a5	; '4'
		dbf	d7,loc_C9A44
		tst.b	$28(a6)
		bmi.s	loc_C9A7E
		move.b	#2,$28(a6)
		rts
; ---------------------------------------------------------------------------

loc_C9A7E:				; CODE XREF: DoFade+74j
		clr.b	$28(a6)

locret_C9A82:				; CODE XREF: DoFade+4j	DoFade+Ej
		rts
; End of function DoFade

; ---------------------------------------------------------------------------
word_C9A84:	dc.w $25E, $284, $2AB, $2D3, $2FE, $32D, $35C, $38F, $3C5
					; DATA XREF: sub_C8A60+1Eo
		dc.w $3FF, $43C, $47C

; =============== S U B	R O U T	I N E =======================================


sub_C9A9C:				; CODE XREF: UpdateEverything+3Cp
					; UpdateEverything+66p	...
		subq.b	#1,$E(a5)
		bne.s	loc_C9AB2
		bclr	#4,(a5)
		bsr.w	sub_C9AC2
		bsr.w	sub_C9B26
		bra.w	loc_C9B7A
; ---------------------------------------------------------------------------

loc_C9AB2:				; CODE XREF: sub_C9A9C+4j
		bsr.w	sub_C8B82
		bsr.w	sub_C9B72
		bsr.w	sub_C8BB6
		bra.w	loc_C9B32
; End of function sub_C9A9C


; =============== S U B	R O U T	I N E =======================================


sub_C9AC2:				; CODE XREF: sub_C9A9C+Ap
		bclr	#1,(a5)
		movea.l	4(a5),a4

loc_C9ACA:				; CODE XREF: sub_C9AC2+16j
		moveq	#0,d5
		move.b	(a4)+,d5
		cmpi.b	#$E0,d5
		bcs.s	loc_C9ADA
		bsr.w	cfHandler
		bra.s	loc_C9ACA
; ---------------------------------------------------------------------------

loc_C9ADA:				; CODE XREF: sub_C9AC2+10j
		tst.b	d5
		bpl.s	loc_C9AEE
		bsr.w	sub_C9AF6
		move.b	(a4)+,d5
		tst.b	d5
		bpl.s	loc_C9AEE
		subq.w	#1,a4
		bra.w	sub_C8AB8
; ---------------------------------------------------------------------------

loc_C9AEE:				; CODE XREF: sub_C9AC2+1Aj
					; sub_C9AC2+24j
		bsr.w	sub_C8A98
		bra.w	sub_C8AB8
; End of function sub_C9AC2


; =============== S U B	R O U T	I N E =======================================


sub_C9AF6:				; CODE XREF: sub_C9AC2+1Cp
		subi.b	#$81,d5
		bcs.s	loc_C9B14
		add.b	8(a5),d5
		andi.w	#$7F,d5	; ''
		lsl.w	#1,d5
		lea	word_C9C44,a0
		move.w	(a0,d5.w),$10(a5)
		bra.w	sub_C8AB8
; ---------------------------------------------------------------------------

loc_C9B14:				; CODE XREF: sub_C9AF6+4j
		bset	#1,(a5)
		move.w	#$FFFF,$10(a5)
		bsr.w	sub_C8AB8
		bra.w	sub_C9C16
; End of function sub_C9AF6


; =============== S U B	R O U T	I N E =======================================


sub_C9B26:				; CODE XREF: sub_C9A9C+Ep
		move.w	$10(a5),d6
		bpl.s	loc_C9B38
		bset	#1,(a5)
		rts
; ---------------------------------------------------------------------------

loc_C9B32:				; CODE XREF: sub_C9A9C+22j
		tst.b	$A(a5)
		beq.s	locret_C9B70

loc_C9B38:				; CODE XREF: sub_C9B26+4j
		btst	#1,(a5)
		bne.s	locret_C9B70
		btst	#2,(a5)
		bne.s	locret_C9B70
		bsr.w	sub_C8CAC
		move.b	1(a5),d0
		cmpi.b	#$E0,d0
		bne.s	loc_C9B56
		move.b	#$C0,d0

loc_C9B56:				; CODE XREF: sub_C9B26+2Aj
		move.w	d6,d1
		andi.b	#$F,d1
		or.b	d1,d0
		lsr.w	#4,d6
		andi.b	#$3F,d6	; '?'
		move.b	d0,($C00011).l
		move.b	d6,($C00011).l

locret_C9B70:				; CODE XREF: sub_C9B26+10j
					; sub_C9B26+16j ...
		rts
; End of function sub_C9B26


; =============== S U B	R O U T	I N E =======================================


sub_C9B72:				; CODE XREF: sub_C9A9C+1Ap

; FUNCTION CHUNK AT 000C9BF4 SIZE 00000022 BYTES

		tst.b	$B(a5)
		beq.w	locret_C9BE4

loc_C9B7A:				; CODE XREF: sub_C9A9C+12j
		move.b	9(a5),d6
		moveq	#0,d0
		move.b	$B(a5),d0
		beq.s	sub_C9BC4
		lea	FlutterIndex,a0
		subq.w	#1,d0
		lsl.w	#2,d0
		movea.l	(a0,d0.w),a0

loc_C9B92:				; CODE XREF: sub_C9B72+9Aj
					; sub_C9B72+A0j
		moveq	#0,d0
		move.b	$C(a5),d0
		addq.b	#1,$C(a5)
		move.b	(a0,d0.w),d0
		bpl.s	loc_C9BBA
		cmpi.b	#$83,d0
		beq.s	loc_C9BF4
		cmpi.b	#$81,d0
		beq.s	loc_C9C00
		cmpi.b	#$82,d0
		beq.s	loc_C9C06
		cmpi.b	#$80,d0
		beq.s	loc_C9C0E

loc_C9BBA:				; CODE XREF: sub_C9B72+2Ej
		add.w	d0,d6
		cmpi.b	#$10,d6
		bcs.s	sub_C9BC4
		moveq	#$F,d6
; End of function sub_C9B72


; =============== S U B	R O U T	I N E =======================================


sub_C9BC4:				; CODE XREF: DoFadeOut+90p DoFade+64p	...
		btst	#1,(a5)
		bne.s	locret_C9BE4
		btst	#2,(a5)
		bne.s	locret_C9BE4
		btst	#4,(a5)
		bne.s	loc_C9BE6

loc_C9BD6:				; CODE XREF: sub_C9BC4+26j
					; sub_C9BC4+2Cj
		or.b	1(a5),d6
		addi.b	#$10,d6
		move.b	d6,($C00011).l

locret_C9BE4:				; CODE XREF: sub_C9B72+4j sub_C9BC4+4j ...
		rts
; ---------------------------------------------------------------------------

loc_C9BE6:				; CODE XREF: sub_C9BC4+10j
		tst.b	$13(a5)
		beq.s	loc_C9BD6
		tst.b	$12(a5)
		bne.s	loc_C9BD6
		rts
; End of function sub_C9BC4

; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR sub_C9B72

loc_C9BF4:				; CODE XREF: sub_C9B72+34j
		subq.b	#2,$C(a5)
		bset	#1,(a5)
		bra.w	sub_C9C16
; ---------------------------------------------------------------------------

loc_C9C00:				; CODE XREF: sub_C9B72+3Aj
		subq.b	#2,$C(a5)
		rts
; ---------------------------------------------------------------------------

loc_C9C06:				; CODE XREF: sub_C9B72+40j
		move.b	1(a0,d0.w),$C(a5)
		bra.s	loc_C9B92
; ---------------------------------------------------------------------------

loc_C9C0E:				; CODE XREF: sub_C9B72+46j
		clr.b	$C(a5)
		bra.w	loc_C9B92
; END OF FUNCTION CHUNK	FOR sub_C9B72

; =============== S U B	R O U T	I N E =======================================


sub_C9C16:				; CODE XREF: sub_C8B82:loc_C8BAEp
					; sub_C8CAC:loc_C8D32j	...
		btst	#2,(a5)
		bne.s	locret_C9C2A
; End of function sub_C9C16


; =============== S U B	R O U T	I N E =======================================


sub_C9C1C:				; CODE XREF: sub_C93A8+44p
		move.b	1(a5),d0
		ori.b	#$1F,d0
		move.b	d0,($C00011).l

locret_C9C2A:				; CODE XREF: sub_C9C16+4j
		rts
; End of function sub_C9C1C


; =============== S U B	R O U T	I N E =======================================


sub_C9C2C:				; CODE XREF: Sound_ChkValue+632j
					; Sound_ChkValue+85Ap
		lea	($C00011).l,a0
		move.b	#$9F,(a0)
		move.b	#$BF,(a0)
		move.b	#$DF,(a0)
		move.b	#$FF,(a0)
		rts
; End of function sub_C9C2C

; ---------------------------------------------------------------------------
word_C9C44:	dc.w $356, $326, $2F9, $2CE, $2A5, $280, $25C, $23A, $21A
					; DATA XREF: sub_C9AF6+10o
		dc.w $1FB, $1DF, $1C4, $1AB, $193, $17D, $167, $153, $140
		dc.w $12E, $11D, $10D, $FE, $EF, $E2, $D6, $C9,	$BE, $B4
		dc.w $A9, $A0, $97, $8F, $87, $7F, $78,	$71, $6B, $65
		dc.w $5F, $5A, $55, $50, $4B, $47, $43,	$40, $3C, $39
		dc.w $36, $33, $30, $2D, $2B, $28, $26,	$24, $22, $20
		dc.w $1F, $1D, $1B, $1A, $18, $17, $16,	$15, $13, $12
		dc.w $11, 0

; =============== S U B	R O U T	I N E =======================================


cfHandler:				; CODE XREF: sub_C88AE+16p
					; sub_C8A2A+12p ...

; FUNCTION CHUNK AT 000C9E66 SIZE 0000004C BYTES
; FUNCTION CHUNK AT 000CA0AA SIZE 0000001A BYTES
; FUNCTION CHUNK AT 000CA0CA SIZE 000000B4 BYTES
; FUNCTION CHUNK AT 000CA186 SIZE 0000001C BYTES
; FUNCTION CHUNK AT 000CA262 SIZE 00000094 BYTES

		subi.w	#$E0,d5	; 'à'
		lsl.w	#2,d5
		jmp	loc_C9CDA(pc,d5.w)

loc_C9CDA:
		bra.w	loc_C9D88
; ---------------------------------------------------------------------------
		bra.w	loc_C9DA8
; ---------------------------------------------------------------------------
		bra.w	loc_C9DAE
; ---------------------------------------------------------------------------
		bra.w	loc_C9DB4
; ---------------------------------------------------------------------------
		bra.w	loc_C9DBC
; ---------------------------------------------------------------------------
		bra.w	loc_C9DE4
; ---------------------------------------------------------------------------
		bra.w	loc_C9DF4
; ---------------------------------------------------------------------------
		bra.w	loc_C9DFE
; ---------------------------------------------------------------------------
		bra.w	loc_C9E04
; ---------------------------------------------------------------------------
		bra.w	loc_C9E14
; ---------------------------------------------------------------------------
		bra.w	loc_C9E66
; ---------------------------------------------------------------------------
		bra.w	loc_C9E70
; ---------------------------------------------------------------------------
		bra.w	loc_C9E76
; ---------------------------------------------------------------------------
		bra.w	loc_C9E7E
; ---------------------------------------------------------------------------
		bra.w	loc_C9E86
; ---------------------------------------------------------------------------
		bra.w	loc_C9E8E
; ---------------------------------------------------------------------------
		bra.w	loc_C9FAC
; ---------------------------------------------------------------------------
		bra.w	loc_C9FD0
; ---------------------------------------------------------------------------
		bra.w	loc_C9FE2
; ---------------------------------------------------------------------------
		bra.w	loc_CA0AA
; ---------------------------------------------------------------------------
		bra.w	loc_CA0C4
; ---------------------------------------------------------------------------
		bra.w	loc_CA0CA
; ---------------------------------------------------------------------------
		bra.w	loc_CA0D0
; ---------------------------------------------------------------------------
		bra.w	loc_CA0DA
; ---------------------------------------------------------------------------
		bra.w	loc_CA10C
; ---------------------------------------------------------------------------
		bra.w	loc_CA11E
; ---------------------------------------------------------------------------
		bra.w	loc_CA132
; ---------------------------------------------------------------------------
		bra.w	loc_CA138
; ---------------------------------------------------------------------------
		bra.w	loc_CA140
; ---------------------------------------------------------------------------
		bra.w	loc_CA148
; ---------------------------------------------------------------------------
		bra.w	loc_CA150
; ---------------------------------------------------------------------------
		moveq	#0,d0
		move.b	(a4)+,d0
		lsl.w	#2,d0
		jmp	metacf(pc,d0.w)

metacf:
		bra.w	loc_CA186
; ---------------------------------------------------------------------------
		bra.w	loc_CA1AA
; ---------------------------------------------------------------------------
		bra.w	loc_CA262
; ---------------------------------------------------------------------------
		bra.w	loc_CA278
; ---------------------------------------------------------------------------
		bra.w	loc_CA292
; ---------------------------------------------------------------------------
		bra.w	loc_CA29A
; ---------------------------------------------------------------------------
		bra.w	loc_CA2A0
; ---------------------------------------------------------------------------
		bra.w	loc_CA2B2
; ---------------------------------------------------------------------------
		bra.w	loc_CA2C2
; ---------------------------------------------------------------------------
		bra.w	loc_CA2DA
; ---------------------------------------------------------------------------

loc_C9D88:				; CODE XREF: cfHandler:loc_C9CDAj
		move.b	(a4)+,d1
		tst.b	1(a5)
		bmi.s	locret_C9DA6
		move.b	$27(a5),d0
		andi.b	#$37,d0	; '7'
		or.b	d0,d1
		move.b	d1,$27(a5)
		move.b	#$B4,d0
		bra.w	sub_C9956
; ---------------------------------------------------------------------------

locret_C9DA6:				; CODE XREF: cfHandler+BEj
		rts
; ---------------------------------------------------------------------------

loc_C9DA8:				; CODE XREF: cfHandler+Ej
		move.b	(a4)+,$1E(a5)
		rts
; ---------------------------------------------------------------------------

loc_C9DAE:				; CODE XREF: cfHandler+12j
		move.b	(a4)+,$2B(a6)
		rts
; ---------------------------------------------------------------------------

loc_C9DB4:				; CODE XREF: cfHandler+16j
		bsr.w	sub_C968E
		bra.w	loc_C9FE2
; ---------------------------------------------------------------------------

loc_C9DBC:				; CODE XREF: cfHandler+1Aj
		move.b	(a4)+,$1F(a5)
		beq.s	loc_C9DD8
		move.b	(a4)+,$20(a5)
		move.b	(a4)+,$21(a5)
		move.b	(a4)+,$22(a5)
		move.b	(a4),$23(a5)
		move.b	(a4)+,$24(a5)
		rts
; ---------------------------------------------------------------------------

loc_C9DD8:				; CODE XREF: cfHandler+F0j
		move.b	#$B4,d0
		move.b	$27(a5),d1
		bra.w	sub_C9956
; ---------------------------------------------------------------------------

loc_C9DE4:				; CODE XREF: cfHandler+1Ej
		move.b	(a4)+,d0
		tst.b	1(a5)
		bpl.s	loc_C9DF4
		add.b	d0,9(a5)
		addq.w	#1,a4
		rts
; ---------------------------------------------------------------------------

loc_C9DF4:				; CODE XREF: cfHandler+22j
					; cfHandler+11Aj
		move.b	(a4)+,d0
		add.b	d0,9(a5)
		bra.w	sub_C9F24
; ---------------------------------------------------------------------------

loc_C9DFE:				; CODE XREF: cfHandler+26j
		bset	#4,(a5)
		rts
; ---------------------------------------------------------------------------

loc_C9E04:				; CODE XREF: cfHandler+2Aj
		move.b	(a4),$12(a5)
		move.b	(a4)+,$13(a5)
		move.b	#0,$2D(a5)
		rts
; ---------------------------------------------------------------------------

loc_C9E14:				; CODE XREF: cfHandler+2Ej
		movea.l	$20(a6),a1
		beq.s	loc_C9E1E
		movea.l	$20(a5),a1

loc_C9E1E:				; CODE XREF: cfHandler+148j
		move.b	(a4),d3
		adda.w	#9,a0
		lea	byte_C9E62,a2
		moveq	#3,d6

loc_C9E2A:				; CODE XREF: cfHandler+16Ej
		move.b	(a1)+,d1
		move.b	(a2)+,d0
		btst	#7,d3
		beq.s	loc_C9E3C
		bset	#7,d1
		bsr.w	sub_C9956

loc_C9E3C:				; CODE XREF: cfHandler+162j
		lsl.w	#1,d3
		dbf	d6,loc_C9E2A
		move.b	(a4)+,d1
		moveq	#$22,d0	; '"'
		bsr.w	sub_C996E
		move.b	(a4)+,d1
		move.b	$27(a5),d0
		andi.b	#$C0,d0
		or.b	d0,d1
		move.b	d1,$27(a5)
		move.b	#$B4,d0
		bra.w	sub_C9956
; End of function cfHandler

; ---------------------------------------------------------------------------
byte_C9E62:	dc.b $60, $68, $64, $6C	; DATA XREF: cfHandler+154o
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR cfHandler

loc_C9E66:				; CODE XREF: cfHandler+32j
		move.b	(a4),2(a6)
		move.b	(a4)+,1(a6)
		rts
; ---------------------------------------------------------------------------

loc_C9E70:				; CODE XREF: cfHandler+36j
		move.b	(a4)+,$A(a6)
		rts
; ---------------------------------------------------------------------------

loc_C9E76:				; CODE XREF: cfHandler+3Aj
		move.b	(a4)+,d0
		add.b	d0,9(a5)
		rts
; ---------------------------------------------------------------------------

loc_C9E7E:				; CODE XREF: cfHandler+3Ej
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		bra.w	sub_C9956
; ---------------------------------------------------------------------------

loc_C9E86:				; CODE XREF: cfHandler+42j
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		bra.w	sub_C996E
; ---------------------------------------------------------------------------

loc_C9E8E:				; CODE XREF: cfHandler+46j
		moveq	#0,d0
		move.b	(a4)+,d0
		move.b	d0,$B(a5)
		btst	#2,(a5)
		bne.w	locret_C9F1A
		movea.l	$20(a6),a1
		tst.b	$E(a6)
		beq.s	sub_C9EB2
		movea.l	$20(a5),a1
		bmi.s	sub_C9EB2
		movea.l	$24(a6),a1
; END OF FUNCTION CHUNK	FOR cfHandler

; =============== S U B	R O U T	I N E =======================================


sub_C9EB2:				; CODE XREF: sub_C9310+5Ep
					; sub_C93A8+2Ep ...
		subq.w	#1,d0
		bmi.s	loc_C9EC0
		move.w	#$19,d1

loc_C9EBA:				; CODE XREF: sub_C9EB2+Aj
		adda.w	d1,a1
		dbf	d0,loc_C9EBA

loc_C9EC0:				; CODE XREF: sub_C9EB2+2j
		bsr.w	WaitForZ80
		move.b	(a1)+,d1
		move.b	d1,$25(a5)
		move.b	d1,d4
		move.b	#$B0,d0
		bsr.w	sub_C9980
		lea	byte_C9F94,a2
		moveq	#$13,d3

loc_C9EDA:				; CODE XREF: sub_C9EB2+30j
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		bsr.w	sub_C9980
		dbf	d3,loc_C9EDA
		moveq	#3,d5
		andi.w	#7,d4
		move.b	byte_C9F1C(pc,d4.w),d4
		move.b	9(a5),d3

loc_C9EF4:				; CODE XREF: sub_C9EB2+50j
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		lsr.b	#1,d4
		bcc.s	loc_C9EFE
		add.b	d3,d1

loc_C9EFE:				; CODE XREF: sub_C9EB2+48j
		bsr.w	sub_C9980
		dbf	d5,loc_C9EF4
		move.b	#$B4,d0
		move.b	$27(a5),d1
		bsr.w	sub_C9980
		move.w	#0,($A11100).l

locret_C9F1A:				; CODE XREF: cfHandler+1CAj
		rts
; End of function sub_C9EB2

; ---------------------------------------------------------------------------
byte_C9F1C:	dc.b 8,	8, 8, 8, $A, $E, $E, $F	; DATA XREF: sub_C9EB2+3Ar
					; sub_C9F24+42r

; =============== S U B	R O U T	I N E =======================================


sub_C9F24:				; CODE XREF: DoFadeOut+50p
					; DoFadeOut:loc_C94D6p	...
		btst	#2,(a5)
		bne.s	locret_C9F92
		moveq	#0,d0
		move.b	$B(a5),d0
		movea.l	$20(a6),a1
		tst.b	$E(a6)
		beq.s	loc_C9F48
		movea.l	$20(a5),a1
		tst.b	$E(a6)
		bmi.s	loc_C9F48
		movea.l	$24(a6),a1

loc_C9F48:				; CODE XREF: sub_C9F24+14j
					; sub_C9F24+1Ej
		subq.w	#1,d0
		bmi.s	loc_C9F56
		move.w	#$19,d1

loc_C9F50:				; CODE XREF: sub_C9F24+2Ej
		adda.w	d1,a1
		dbf	d0,loc_C9F50

loc_C9F56:				; CODE XREF: sub_C9F24+26j
		adda.w	#$15,a1
		lea	byte_C9FA8,a2
		move.b	$25(a5),d0
		andi.w	#7,d0
		move.b	byte_C9F1C(pc,d0.w),d4
		move.b	9(a5),d3
		bmi.s	locret_C9F92
		moveq	#3,d5
		bsr.w	WaitForZ80

loc_C9F76:				; CODE XREF: sub_C9F24:loc_C9F86j
		move.b	(a2)+,d0
		move.b	(a1)+,d1
		lsr.b	#1,d4
		bcc.s	loc_C9F86
		add.b	d3,d1
		bcs.s	loc_C9F86
		bsr.w	sub_C9980

loc_C9F86:				; CODE XREF: sub_C9F24+58j
					; sub_C9F24+5Cj
		dbf	d5,loc_C9F76
		move.w	#0,($A11100).l

locret_C9F92:				; CODE XREF: sub_C9F24+4j
					; sub_C9F24+4Aj
		rts
; End of function sub_C9F24

; ---------------------------------------------------------------------------
byte_C9F94:	dc.b $30, $38, $34, $3C, $50, $58, $54,	$5C, $60, $68
					; DATA XREF: sub_C9EB2+22o
		dc.b $64, $6C, $70, $78, $74, $7C, $80,	$88, $84, $8C
byte_C9FA8:	dc.b $40, $48, $44, $4C	; DATA XREF: sub_C9F24+36o
; ---------------------------------------------------------------------------

loc_C9FAC:				; CODE XREF: cfHandler+4Aj
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

loc_C9FD0:				; CODE XREF: cfHandler+4Ej
		move.b	(a4)+,d0
		tst.b	1(a5)
		bpl.w	loc_CA0C4
		move.b	d0,$A(a5)
		move.b	(a4)+,d0
		rts
; ---------------------------------------------------------------------------

loc_C9FE2:				; CODE XREF: cfHandler+52j
					; cfHandler+E8j
		bclr	#7,(a5)
		bclr	#4,(a5)
		tst.b	1(a5)
		bmi.s	loc_C9FFE
		tst.b	8(a6)
		bmi.w	loc_CA0A6
		bsr.w	sub_C993E
		bra.s	loc_CA002
; ---------------------------------------------------------------------------

loc_C9FFE:				; CODE XREF: ROM:000C9FEEj
		bsr.w	sub_C9C16

loc_CA002:				; CODE XREF: ROM:000C9FFCj
		tst.b	$E(a6)
		bpl.w	loc_CA0A6
		clr.b	0(a6)
		moveq	#0,d0
		move.b	1(a5),d0
		bmi.s	loc_CA06E
		lea	BGMChannelRAM,a0
		movea.l	a5,a3
		cmpi.b	#4,d0
		bne.s	loc_CA032
		tst.b	$38A(a6)
		bpl.s	loc_CA032
		lea	$38A(a6),a5
		movea.l	$24(a6),a1
		bra.s	loc_CA044
; ---------------------------------------------------------------------------

loc_CA032:				; CODE XREF: ROM:000CA020j
					; ROM:000CA026j
		subq.b	#2,d0
		add.b	d0,d0
		movea.w	(a0,d0.w),a5
		adda.l	a6,a5
		tst.b	(a5)
		bpl.s	loc_CA054
		movea.l	$20(a6),a1

loc_CA044:				; CODE XREF: ROM:000CA030j
		bclr	#2,(a5)
		bset	#1,(a5)
		move.b	$B(a5),d0
		bsr.w	sub_C9EB2

loc_CA054:				; CODE XREF: ROM:000CA03Ej
		movea.l	a3,a5
		cmpi.b	#2,1(a5)
		bne.s	loc_CA0A6
		tst.b	$F(a6)
		bne.s	loc_CA0A6
		moveq	#0,d1
		moveq	#$27,d0	; '''
		bsr.w	sub_C996E
		bra.s	loc_CA0A6
; ---------------------------------------------------------------------------

loc_CA06E:				; CODE XREF: ROM:000CA014j
		lea	$3BE(a6),a0
		tst.b	(a0)
		bpl.s	loc_CA082
		cmpi.b	#$E0,d0
		beq.s	loc_CA08E
		cmpi.b	#$C0,d0
		beq.s	loc_CA08E

loc_CA082:				; CODE XREF: ROM:000CA074j
		lea	BGMChannelRAM,a0
		lsr.b	#4,d0
		movea.w	(a0,d0.w),a0
		adda.l	a6,a0

loc_CA08E:				; CODE XREF: ROM:000CA07Aj
					; ROM:000CA080j
		bclr	#2,(a0)
		bset	#1,(a0)
		cmpi.b	#$E0,1(a0)
		bne.s	loc_CA0A6
		move.b	$25(a0),($C00011).l

loc_CA0A6:				; CODE XREF: ROM:000C9FF4j
					; ROM:000CA006j ...
		addq.w	#8,sp
		rts
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR cfHandler

loc_CA0AA:				; CODE XREF: cfHandler+56j
		move.b	#$E0,1(a5)
		move.b	(a4)+,$25(a5)
		btst	#2,(a5)
		bne.s	locret_CA0C2
		move.b	-1(a4),($C00011).l

locret_CA0C2:				; CODE XREF: cfHandler+3E8j
		rts
; END OF FUNCTION CHUNK	FOR cfHandler
; ---------------------------------------------------------------------------

loc_CA0C4:				; CODE XREF: cfHandler+5Aj
					; ROM:000C9FD6j
		move.b	(a4)+,$A(a5)
		rts
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR cfHandler

loc_CA0CA:				; CODE XREF: cfHandler+5Ej
		move.b	(a4)+,$B(a5)
		rts
; ---------------------------------------------------------------------------

loc_CA0D0:				; CODE XREF: cfHandler+62j
					; cfHandler+436j ...
		move.b	(a4)+,d0
		lsl.w	#8,d0
		move.b	(a4)+,d0
		adda.w	d0,a4
		rts
; ---------------------------------------------------------------------------

loc_CA0DA:				; CODE XREF: cfHandler+66j
		moveq	#0,d0
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		movem.l	d2,-(sp)
		move.b	$28(a5,d0.w),d2
		movem.l	(sp)+,d2
		tst.b	$28(a5,d0.w)
		bne.s	loc_CA0F6
		move.b	d1,$28(a5,d0.w)

loc_CA0F6:				; CODE XREF: cfHandler+420j
		subq.b	#1,$28(a5,d0.w)
		movem.l	d2,-(sp)
		move.b	$28(a5,d0.w),d2
		movem.l	(sp)+,d2
		bne.s	loc_CA0D0
		addq.w	#2,a4
		rts
; ---------------------------------------------------------------------------

loc_CA10C:				; CODE XREF: cfHandler+6Aj
		moveq	#0,d0
		move.b	$D(a5),d0
		subq.b	#4,d0
		move.l	a4,(a5,d0.w)
		move.b	d0,$D(a5)
		bra.s	loc_CA0D0
; ---------------------------------------------------------------------------

loc_CA11E:				; CODE XREF: cfHandler+6Ej
		moveq	#0,d0
		move.b	$D(a5),d0
		movea.l	(a5,d0.w),a4
		addq.w	#2,a4
		addq.b	#4,d0
		move.b	d0,$D(a5)
		rts
; ---------------------------------------------------------------------------

loc_CA132:				; CODE XREF: cfHandler+72j
		move.b	(a4)+,2(a5)
		rts
; ---------------------------------------------------------------------------

loc_CA138:				; CODE XREF: cfHandler+76j
		move.b	(a4)+,d0
		add.b	d0,8(a5)
		rts
; ---------------------------------------------------------------------------

loc_CA140:				; CODE XREF: cfHandler+7Aj
		bset	#7,$A(a5)
		rts
; ---------------------------------------------------------------------------

loc_CA148:				; CODE XREF: cfHandler+7Ej
		bclr	#7,$A(a5)
		rts
; ---------------------------------------------------------------------------

loc_CA150:				; CODE XREF: cfHandler+82j
		lea	$18(a6),a0
		tst.b	$E(a6)
		bne.s	loc_CA164
		lea	$10(a6),a0
		move.b	#$80,$F(a6)

loc_CA164:				; CODE XREF: cfHandler+488j
		moveq	#3,d0

loc_CA166:				; CODE XREF: cfHandler+4A0j
		moveq	#0,d1
		move.b	(a4)+,d1
		lsl.w	#1,d1
		move.w	word_CA17E(pc,d1.w),(a0)+
		dbf	d0,loc_CA166
		move.b	#$27,d0	; '''
		moveq	#$40,d1	; '@'
		bra.w	sub_C996E
; END OF FUNCTION CHUNK	FOR cfHandler
; ---------------------------------------------------------------------------
word_CA17E:	dc.w 0,	$180, $1F4, $260 ; DATA	XREF: cfHandler+49Cr
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR cfHandler

loc_CA186:				; CODE XREF: cfHandler:metacfj
		lea	byte_CA1A2,a1
		moveq	#3,d3

loc_CA18C:				; CODE XREF: cfHandler+4CCj
		move.b	(a1)+,d0
		move.b	(a4)+,d1
		bsr.w	sub_C9956
		move.b	(a1)+,d0
		moveq	#$1F,d1
		bsr.w	sub_C9956
		dbf	d3,loc_CA18C
		rts
; END OF FUNCTION CHUNK	FOR cfHandler
; ---------------------------------------------------------------------------
byte_CA1A2:	dc.b $90, $50, $98, $58, $94, $54, $9C,	$5C
					; DATA XREF: cfHandler:loc_CA186o
; ---------------------------------------------------------------------------

loc_CA1AA:				; CODE XREF: cfHandler+94j
		moveq	#$34,d3	; '4'
		move.b	(a4)+,d0
		beq.s	loc_CA206
		movea.l	a5,a3
		lea	$4A(a6),a5
		btst	#7,(a5)
		beq.s	loc_CA1C4
		bclr	#7,(a5)
		bset	#0,(a5)

loc_CA1C4:				; CODE XREF: ROM:000CA1BAj
		moveq	#4,d4

loc_CA1C6:				; CODE XREF: ROM:loc_CA1E4j
		adda.w	d3,a5
		btst	#7,(a5)
		beq.s	loc_CA1E4
		bclr	#7,(a5)
		bset	#0,(a5)
		move.b	#$B4,d0
		moveq	#0,d1
		bsr.w	sub_C9956
		bsr.w	sub_C993E

loc_CA1E4:				; CODE XREF: ROM:000CA1CCj
		dbf	d4,loc_CA1C6
		moveq	#2,d4

loc_CA1EA:				; CODE XREF: ROM:loc_CA1FEj
		adda.w	d3,a5
		btst	#7,(a5)
		beq.s	loc_CA1FE
		bclr	#7,(a5)
		bset	#0,(a5)
		bsr.w	sub_C9C16

loc_CA1FE:				; CODE XREF: ROM:000CA1F0j
		dbf	d4,loc_CA1EA
		movea.l	a3,a5
		rts
; ---------------------------------------------------------------------------

loc_CA206:				; CODE XREF: ROM:000CA1AEj
		movea.l	a5,a3
		lea	$4A(a6),a5
		btst	#0,(a5)
		beq.s	loc_CA226
		bset	#7,(a5)
		bclr	#0,(a5)
		move.b	#$B4,d0
		move.b	$27(a5),d1
		bsr.w	sub_C9956

loc_CA226:				; CODE XREF: ROM:000CA210j
		moveq	#4,d4

loc_CA228:				; CODE XREF: ROM:loc_CA244j
		adda.w	d3,a5
		btst	#0,(a5)
		beq.s	loc_CA244
		bset	#7,(a5)
		bclr	#0,(a5)
		move.b	#$B4,d0
		move.b	$27(a5),d1
		bsr.w	sub_C9956

loc_CA244:				; CODE XREF: ROM:000CA22Ej
		dbf	d4,loc_CA228
		moveq	#2,d4

loc_CA24A:				; CODE XREF: ROM:loc_CA25Aj
		adda.w	d3,a5
		btst	#0,(a5)
		beq.s	loc_CA25A
		bset	#7,(a5)
		bclr	#0,(a5)

loc_CA25A:				; CODE XREF: ROM:000CA250j
		dbf	d4,loc_CA24A
		movea.l	a3,a5
		rts
; ---------------------------------------------------------------------------
; START	OF FUNCTION CHUNK FOR cfHandler

loc_CA262:				; CODE XREF: cfHandler+98j
		lea	$4A(a6),a0
		move.b	(a4)+,d0
		moveq	#$34,d1	; '4'
		moveq	#9,d2

loc_CA26C:				; CODE XREF: cfHandler+5A2j
		move.b	d0,2(a0)
		adda.w	d1,a0
		dbf	d2,loc_CA26C
		rts
; ---------------------------------------------------------------------------

loc_CA278:				; CODE XREF: cfHandler+9Cj
		cmpi.b	#2,$28(a6)
		beq.w	locret_CA290
		move.b	#1,$28(a6)
		move.b	(a4)+,$29(a6)
		move.b	(a4)+,$2A(a6)

locret_CA290:				; CODE XREF: cfHandler+5AEj
		rts
; ---------------------------------------------------------------------------

loc_CA292:				; CODE XREF: cfHandler+A0j
		move.b	#$80,$28(a6)
		rts
; ---------------------------------------------------------------------------

loc_CA29A:				; CODE XREF: cfHandler+A4j
		move.b	(a4)+,$2F(a6)
		rts
; ---------------------------------------------------------------------------

loc_CA2A0:				; CODE XREF: cfHandler+A8j
		move.b	(a4)+,$2D(a5)
		move.b	#0,$12(a5)
		move.b	#0,$13(a5)
		rts
; ---------------------------------------------------------------------------

loc_CA2B2:				; CODE XREF: cfHandler+ACj
		tst.b	$41(a6)
		bne.w	loc_CA0D0
		adda.l	#2,a4
		rts
; ---------------------------------------------------------------------------

loc_CA2C2:				; CODE XREF: cfHandler+B0j
		btst	#6,HWVersion.w
		bne.w	loc_CA2D4
		adda.l	#1,a4
		rts
; ---------------------------------------------------------------------------

loc_CA2D4:				; CODE XREF: cfHandler+5F8j
		move.b	(a4)+,2(a6)
		rts
; ---------------------------------------------------------------------------

loc_CA2DA:				; CODE XREF: cfHandler+B4j
		btst	#6,HWVersion.w
		bne.w	loc_CA2EC
		adda.l	#1,a4
		rts
; ---------------------------------------------------------------------------

loc_CA2EC:				; CODE XREF: cfHandler+610j
		move.b	(a4),$E(a5)
		move.b	(a4)+,$F(a5)
		rts
; ---------------------------------------------------------------------------
