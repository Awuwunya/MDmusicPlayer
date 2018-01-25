; ===========================================================================
; ---------------------------------------------------------------------------
; Based on Flamewing's SMPS2ASM, and S1SMPS2ASM by Marc (AKA Cinossu)
; Reworked and improved by Natsumi
; ---------------------------------------------------------------------------

; this macro is created to emulate enum in AS
enum	macro	num, lable
; copy initial number for referencing later
.num	= num

	rept narg-1
\lable		set .num
.num =	.num+1
	shift
	endr
    endm

; simple macro to create a Z80 pointer (relative to bank)
Z80PtrROM	macro addr
	rept narg
		dc.w	(((\addr)<<8)&$FF00)|(((\addr)>>8)&$FF)|$80
		shift
	endr
    endm

; simple macro to create little endian word values
littleEndian	macro value
	rept narg
		dc.w	(((\value)<<8)&$FF00)|(((\value)>>8)&$FF)
		shift
	endr
    endm
; ---------------------------------------------------------------------------------------------
; Note Equates
	enum $80,  nRst,nC0,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0
	enum nB0+1,	nC1,nCs1,nD1,nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1
	enum nB1+1,	nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2,nG2,nAb2,nA2,nBb2,nB2
	enum nB2+1,	nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3,nB3
	enum nB3+1,	nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4
	enum nB4+1,	nC5,nCs5,nD5,nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5
	enum nB5+1,	nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6,nG6,nAb6,nA6,nBb6,nB6
	enum nB6+1,	nC7,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7
; ---------------------------------------------------------------------------------------------
; Channel IDs for SFX
cPSG1				EQU $80
cPSG2				EQU $A0
cPSG3				EQU $C0
cNoise				EQU $E0	; Not for use in S3/S&K/S3D
cFM3				EQU $02
cFM4				EQU $04
cFM5				EQU $05
cFM6				EQU $06	; Only in S3/S&K/S3D, overrides DAC
; ---------------------------------------------------------------------------------------------
; Header Macros
sHeaderInit	macro
sPointZero =	offset(*)
    endm

; Header - Set up Patches Location
; Common to music and SFX
sHeaderPatch	macro loc
	if sPointZero<>offset(*)
		inform 2,"Missing smpsHeaderStartSong or smpsHeaderStartSongConvert"
	endif
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w loc-sPointZero
	endif
    endm

; Header - Set up Patches Location as an Universal Voice Bank (S3/S&K)
; Common to music and SFX
sHeaderPatchUniv macro
	if sPointZero<>offset(*)
		inform 2,"Missing smpsHeaderStartSong or smpsHeaderStartSongConvert"
	endif
	if smpsIsZ80=1
		littleEndian smpsUniVoiceBank
	else
		dc.w smpsUniVoiceBank-sPointZero
	endif
    endm

; Header macros
; Header - Set up Channel Usage
sHeaderCh	macro fm,psg
	dc.b \fm

	if narg=2
		dc.b \psg
	endif
    endm

; Header - Set up Tempo and Tick Multiplier
sHeaderTempo	macro tmul,tempo
	dc.b \tmul,\tempo
    endm

; Header - Set up Tick Multiplier
sHeaderTick	macro tmul
	dc.b \tmul
    endm

; Header - Set up DAC Channel
sHeaderDAC	macro loc,pitch,vol
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w \loc-sPointZero
	endif
	if narg>=2
		dc.b \pitch
		if narg>=3
			dc.b \vol
		else
			dc.b $00
		endif
	else
		dc.w $00
	endif
    endm

; Header - Set up FM Channel
sHeaderFM	macro loc,pitch,vol
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w loc-sPointZero
	endif
	dc.b \pitch,\vol
    endm

; Header - Set up PSG Channel
sHeaderPSG	macro loc,pitch,vol,null,volenv
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w \loc-sPointZero
	endif
	dc.b	\pitch,\vol,\null,\volenv
    endm

; Header - Set up SFX Channel
sHeaderSFX	macro play,patch,loc,pitch,vol
	dc.b \play,\patch
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w \loc-sPointZero
	endif
	dc.b \pitch,\vol
    endm
; ---------------------------------------------------------------------------------------------
; Command Flag Macros and Equates. Based on the original s1smps2asm, and Flamewing's smps2asm
spNone set $00
spRight set $40
spLeft set $80
spCentre set $C0
spCenter set $C0
; ---------------------------------------------------------------------------------------------
; Macros for FM instruments
; Patches - Feedback
spFeedback macro val
spFe	= val
    endm

; Patches - Algorithm
spAlgorithm macro val
spAl	= val
    endm

; Patches - Detune
spDetune macro op1,op2,op3,op4
spDe1	= op1
spDe2	= op2
spDe3	= op3
spDe4	= op4
    endm

; Patches - Multiple
spMultiple macro op1,op2,op3,op4
spMu1	= op1
spMu2	= op2
spMu3	= op3
spMu4	= op4
    endm

; Patches - Rate Scale
spRateScale macro op1,op2,op3,op4
spRS1	= op1
spRS2	= op2
spRS3	= op3
spRS4	= op4
    endm

; Patches - Attack Rate
spAttackRt macro op1,op2,op3,op4
spAR1	= op1
spAR2	= op2
spAR3	= op3
spAR4	= op4
    endm

; Patches - Amplitude Modulation
spAmpMod macro op1,op2,op3,op4
spAM1	= op1
spAM2	= op2
spAM3	= op3
spAM4	= op4
    endm

; Patches - Sustain Rate
spSustainRt macro op1,op2,op3,op4
spSR1	= op1
spSR2	= op2
spSR3	= op3
spSR4	= op4
    endm

; Patches - Sustain Level
spSustainLv macro op1,op2,op3,op4
spSL1	= op1
spSL2	= op2
spSL3	= op3
spSL4	= op4
    endm

; Patches - Decay Rate
spDecayRt macro op1,op2,op3,op4
spDR1	= op1
spDR2	= op2
spDR3	= op3
spDR4	= op4
    endm

; Patches - Release Rate
spReleaseRt macro op1,op2,op3,op4
spRR1	= op1
spRR2	= op2
spRR3	= op3
spRR4	= op4
    endm

; Patches - Total Level
spTotalLv macro op1,op2,op3,op4
spTL1	= op1
spTL2	= op2
spTL3	= op3
spTL4	= op4

	sPatch
    endm
; ===========================================================================
