; ===========================================================================
; ---------------------------------------------------------------------------
; Play a song
; ---------------------------------------------------------------------------

DyHe_play:
		move.l	d7,Driver68K+$1FF4	; set music pointer
		move.b	#$81,Drv68Kmem+9.w	; play music id $81
; ===========================================================================
; ---------------------------------------------------------------------------
; Enable DMA
; ---------------------------------------------------------------------------

DyHe_dmaon:
; ===========================================================================
; ---------------------------------------------------------------------------
; Disable DMA
; ---------------------------------------------------------------------------

DyHe_dmaoff:
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Update driver data
; ---------------------------------------------------------------------------

DyHe_update:	; by the way, this works almost exactly like Sonic 1
		lea	sPSG3.w,a1		; get PSG3 tick multiplier
		lea	Drv68Kmem+$1F0.w,a0	; get last channel
		moveq	#10-1,d0			; 9 channels
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

		move.b	$1A(a0),d5		; get detune
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

DyHe_load:
		move.l	#sDriverPropertyData,DisplayList.w
		move.b	#TYPE_SMPS,DriverType.w
		jsr	Driver68K+$1054

		lea	Driver68K+$17E,a0
		lea	DyHeDACBanks,a1
		move.w	#((DyHeDACBanks_End-DyHeDACBanks)/4)-1,d0

.replaceDAC	move.l	(a1)+,(a0)+
		dbf	d0,.replaceDAC		; replace all DAC bank ptr's with actual ones

		btst	#6,HWVersion.w		; is this NTSC Genesis?
		beq.s	.isNTSC			; if is, branch
		st	Driver68K+$211B		; set PAL mode
.isNTSC		rts

	opt ae-		; ae+ will screw us up
; ===========================================================================
; ---------------------------------------------------------------------------
; creates Z80 bank ID from ROM address (2 byte)
; ---------------------------------------------------------------------------

MakeShitBank	macro addr
	rept narg
		dc.b ((addr&$7F8000)/$8000)/2, (((addr&$8000)<>0)<<7)
		shift
	endr
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; simple macro to create a Z80 pointer (relative to bank)
; ---------------------------------------------------------------------------

DZ80PtrROM	macro addr
	dc.w	(((addr)<<8)&$FF00)|(((addr)>>8)&$FF)|$80
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; macro used to set up a DAC definition (pitch, length, pointer)
; ---------------------------------------------------------------------------

DyHeDAC_Setup macro dacptr
	dc.w	DyHeDAC_\dacptr\_Ptr
	dc.w	DyHeDAC_\dacptr\_Len
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; special macro for including a DAC. This not only includes the file,
; but also creates the length and pointer information for later use in DAC_Setup
; ---------------------------------------------------------------------------

DincDAC		macro name, ext
DyHeDAC_\name\_Inc =	offset(*)
	incbin 'SMPS/DyHe/DAC/\name\.\ext'
		littleEndian2 offset(*)-DyHeDAC_\name\_Inc, DyHeDAC_\name\_Len
		Z80PtrDo DyHeDAC_\name\_Inc, DyHeDAC_\name\_Ptr
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; create bank info for 68K to transfer to Z80 when necessary
; ---------------------------------------------------------------------------

DyHe68KBankInfo	macro	dacptr, pitch
	rept narg/2
		MakeShitBank DyHeDAC_\dacptr\_Setup
		DZ80PtrROM DyHeDAC_\dacptr\_Setup
		dc.b \pitch
		dc.b 0,0,0
		shift
		shift
	endr
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; DAC data (bank 0)
; ---------------------------------------------------------------------------

	Z80Bank_Start Z80BankAlign_Start,"DACDyHe00"
DyHeDAC_81_Setup:	DyHeDAC_Setup 81
DyHeDAC_82_Setup:	DyHeDAC_Setup 82
DyHeDAC_83_Setup:	DyHeDAC_Setup 83
DyHeDAC_84_Setup:	DyHeDAC_Setup 84
DyHeDAC_85_Setup:	DyHeDAC_Setup 85
DyHeDAC_86_Setup:	DyHeDAC_Setup 86
DyHeDAC_87_Setup:	DyHeDAC_Setup 87
DyHeDAC_88_Setup:	DyHeDAC_Setup 85
DyHeDAC_89_Setup:	DyHeDAC_Setup 85
DyHeDAC_8A_Setup:	DyHeDAC_Setup 85
DyHeDAC_8B_Setup:	DyHeDAC_Setup 8B
DyHeDAC_8C_Setup:	DyHeDAC_Setup 8C
DyHeDAC_8D_Setup:	DyHeDAC_Setup 8D
DyHeDAC_8E_Setup:	DyHeDAC_Setup 8D
DyHeDAC_8F_Setup:	DyHeDAC_Setup 8D
DyHeDAC_90_Setup:	DyHeDAC_Setup 90
DyHeDAC_91_Setup:	DyHeDAC_Setup 90
DyHeDAC_92_Setup:	DyHeDAC_Setup 92
DyHeDAC_93_Setup:	DyHeDAC_Setup 92
DyHeDAC_94_Setup:	DyHeDAC_Setup 94
DyHeDAC_95_Setup:	DyHeDAC_Setup 95
DyHeDAC_96_Setup:	DyHeDAC_Setup 95
DyHeDAC_97_Setup:	DyHeDAC_Setup 95
DyHeDAC_98_Setup:	DyHeDAC_Setup 95
DyHeDAC_99_Setup:	DyHeDAC_Setup 95
DyHeDAC_9A_Setup:	DyHeDAC_Setup 95
DyHeDAC_9B_Setup:	DyHeDAC_Setup 95
DyHeDAC_9C_Setup:	DyHeDAC_Setup 95
DyHeDAC_9D_Setup:	DyHeDAC_Setup 95
DyHeDAC_9E_Setup:	DyHeDAC_Setup 95
DyHeDAC_9F_Setup:	DyHeDAC_Setup 95

	DincDAC 81, bin
	DincDAC 82, bin
	DincDAC 83, bin
	DincDAC 84, bin
	DincDAC 85, bin
	DincDAC 86, bin
	DincDAC 87, bin
	DincDAC 8B, bin
	DincDAC 8C, bin
	DincDAC 8D, bin
	DincDAC 90, bin
	DincDAC 92, bin
	DincDAC 94, bin
	DincDAC 95, bin
	Z80Bank_End
; ===========================================================================
; ---------------------------------------------------------------------------
; DAC data (bank 1)
; ---------------------------------------------------------------------------

	Z80Bank_Start Z80BankAlign_Start,"DACDyHe01"
DyHeDAC_A0_Setup:	DyHeDAC_Setup A0
DyHeDAC_A1_Setup:	DyHeDAC_Setup A1
DyHeDAC_A2_Setup:	DyHeDAC_Setup A2
DyHeDAC_A3_Setup:	DyHeDAC_Setup A3
DyHeDAC_A4_Setup:	DyHeDAC_Setup A4
DyHeDAC_A5_Setup:	DyHeDAC_Setup A4
DyHeDAC_A6_Setup:	DyHeDAC_Setup A4
DyHeDAC_A7_Setup:	DyHeDAC_Setup A4
DyHeDAC_A8_Setup:	DyHeDAC_Setup A4
DyHeDAC_A9_Setup:	DyHeDAC_Setup A9
DyHeDAC_AA_Setup:	DyHeDAC_Setup A9
DyHeDAC_AB_Setup:	DyHeDAC_Setup A9
DyHeDAC_AC_Setup:	DyHeDAC_Setup A9
DyHeDAC_AD_Setup:	DyHeDAC_Setup A9
DyHeDAC_AE_Setup:	DyHeDAC_Setup A9
DyHeDAC_AF_Setup:	DyHeDAC_Setup A9
DyHeDAC_B0_Setup:	DyHeDAC_Setup A9
DyHeDAC_B1_Setup:	DyHeDAC_Setup A9
DyHeDAC_B2_Setup:	DyHeDAC_Setup A9
DyHeDAC_B3_Setup:	DyHeDAC_Setup A9
DyHeDAC_B4_Setup:	DyHeDAC_Setup B4
DyHeDAC_B5_Setup:	DyHeDAC_Setup B5
DyHeDAC_B6_Setup:	DyHeDAC_Setup B5
DyHeDAC_B7_Setup:	DyHeDAC_Setup B5
DyHeDAC_B8_Setup:	DyHeDAC_Setup B5
DyHeDAC_B9_Setup:	DyHeDAC_Setup B5
DyHeDAC_BA_Setup:	DyHeDAC_Setup BA
DyHeDAC_BB_Setup:	DyHeDAC_Setup BB
DyHeDAC_C4_Setup:	DyHeDAC_Setup B5
DyHeDAC_C5_Setup:	DyHeDAC_Setup B5
DyHeDAC_C6_Setup:	DyHeDAC_Setup B5
DyHeDAC_C7_Setup:	DyHeDAC_Setup B5
DyHeDAC_C8_Setup:	DyHeDAC_Setup B5

	DincDAC A0, bin
	DincDAC A1, bin
	DincDAC A2, bin
	DincDAC A3, bin
	DincDAC A4, bin
	DincDAC A9, bin
	DincDAC B4, bin
	DincDAC B5, bin
	DincDAC BA, bin
	DincDAC BB, bin
	Z80Bank_End
; ===========================================================================
; ---------------------------------------------------------------------------
; DAC data (bank 2)
; ---------------------------------------------------------------------------

	Z80Bank_Start Z80BankAlign_Start,"DACDyHe02"
DyHeDAC_BC_Setup:	DyHeDAC_Setup BC
DyHeDAC_BD_Setup:	DyHeDAC_Setup BD
DyHeDAC_BE_Setup:	DyHeDAC_Setup BE
DyHeDAC_BF_Setup:	DyHeDAC_Setup BF
DyHeDAC_C0_Setup:	DyHeDAC_Setup C0
DyHeDAC_C1_Setup:	DyHeDAC_Setup C1
DyHeDAC_C2_Setup:	DyHeDAC_Setup C1
DyHeDAC_C3_Setup:	DyHeDAC_Setup C1
	DincDAC BC, bin
	DincDAC BD, bin
	DincDAC BE, bin
	DincDAC BF, bin
	DincDAC C0, bin
	DincDAC C1, bin
	Z80Bank_End
	even
; ===========================================================================
; ---------------------------------------------------------------------------
; DAC bank data
; ---------------------------------------------------------------------------

DyHeDACBanks:
	DyHe68KBankInfo 81, $02, 82, $01, 83, $02, 84, $02
	DyHe68KBankInfo 85, $01, 86, $08, 87, $01, 88, $02
	DyHe68KBankInfo 89, $11, 8A, $1E, 8B, $06, 8C, $01
	DyHe68KBankInfo 8D, $01, 8E, $08, 8F, $14, 90, $10
	DyHe68KBankInfo 91, $13, 92, $13, 93, $1A, 94, $02
	DyHe68KBankInfo 95, $03, 96, $04, 97, $05, 98, $06
	DyHe68KBankInfo 99, $07, 9A, $08, 9B, $09, 9C, $0A
	DyHe68KBankInfo 9D, $0B, 9E, $0C, 9F, $0D, A0, $01
	DyHe68KBankInfo A1, $02, A2, $03, A3, $03, A4, $01
	DyHe68KBankInfo A5, $02, A6, $03, A7, $04, A8, $05
	DyHe68KBankInfo A9, $02, AA, $03, AB, $04, AC, $05
	DyHe68KBankInfo AD, $06, AE, $07, AF, $08, B0, $09
	DyHe68KBankInfo B1, $0A, B2, $0B, B3, $0C, B4, $01
	DyHe68KBankInfo B5, $01, B6, $02, B7, $03, B8, $04
	DyHe68KBankInfo B9, $05, BA, $01, BB, $02, BC, $01
	DyHe68KBankInfo BD, $01, BE, $01, BF, $03, C0, $01
	DyHe68KBankInfo C1, $01, C2, $03, C3, $06, C4, $06
	DyHe68KBankInfo C5, $07, C6, $08, C7, $09, C8, $0A
DyHeDACBanks_End:
	opt ae+		; return automatic evens because yes
; ===========================================================================
