; ===============================================
; Based on Flamewing's SMPS2ASM, and S1SMPS2ASM by Marc (AKA Cinossu)
; Reworked and improved by Natsumi
; ===============================================

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
	dc.w	(((addr)<<8)&$FF00)|(((addr)>>8)&$FF)|$80
    endm

; simple macro to create little endian word values
littleEndian	macro value
	dc.w	(((value)<<8)&$FF00)|(((value)>>8)&$FF)
    endm
; ---------------------------------------------------------------------------------------------
; Standard Octave Pitch Equates
smpsPitch10lo	equ $88
smpsPitch09lo	equ $94
smpsPitch08lo	equ $A0
smpsPitch07lo	equ $AC
smpsPitch06lo	equ $B8
smpsPitch05lo	equ $C4
smpsPitch04lo	equ $D0
smpsPitch03lo	equ $DC
smpsPitch02lo	equ $E8
smpsPitch01lo	equ $F4
smpsPitch00	equ $00
smpsPitch01hi	equ $0C
smpsPitch02hi	equ $18
smpsPitch03hi	equ $24
smpsPitch04hi	equ $30
smpsPitch05hi	equ $3C
smpsPitch06hi	equ $48
smpsPitch07hi	equ $54
smpsPitch08hi	equ $60
smpsPitch09hi	equ $6C
smpsPitch10hi	equ $78
; ---------------------------------------------------------------------------------------------
; Note Equates
	enum $80+0, nRst,nC0,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0,nC1,nCs1,nD1
	enum nD1+1, nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1,nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2
	enum nFs2+1, nG2,nAb2,nA2,nBb2,nB2,nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3
	enum nBb3+1, nB3,nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4,nC5,nCs5,nD5
	enum nD5+1, nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5,nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6
	enum nFs6+1, nG6,nAb6,nA6,nBb6,nB6,nC7,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7
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
sHeaderPSG	macro loc,pitch,vol,modenv,volenv
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w \loc-sPointZero
	endif
	dc.b	\pitch,\vol,\modenv,\volenv
    endm

; Header - Set up SFX Channel
smpsHeaderSFX	macro play,patch,loc,pitch,vol
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
sPan		macro dir,amsfms
	s2e_\smpsdrv\_sPan \_
    endm

saDetune	macro val
	s2e_\smpsdrv\_saDetune \_
    endm

sComm		macro val
	s2e_\smpsdrv\_sComm \_
    endm

smpsPanAnim	macro v1, v2, v3, v4, v5
	s2e_\smpsdrv\_smpsPanAnim \_
    endm

sRet		macro
	s2e_\smpsdrv\_sRet \_
    endm

sFade		macro val
	s2e_\smpsdrv\_sFade \_
    endm

ssTickMulCh	macro val
	s2e_\smpsdrv\_ssTickMulCh \_
    endm

smpsSetLFO	macro val1, val2
	s2e_\smpsdrv\_smpsSetLFO  \_
    endm

saVolFM		macro val
	s2e_\smpsdrv\_saVolFM \_
    endm

sNoteStop	macro val
	s2e_\smpsdrv\_sNoteStop \_
    endm

saTranspose	macro val
	s2e_\smpsdrv\_saTranspose \_
    endm

ssTempo		macro mod
	s2e_\smpsdrv\_ssTempo \_
    endm

ssTickMul	macro val
	s2e_\smpsdrv\_ssTickMul \_
    endm

saVolPSG	macro val
	s2e_\smpsdrv\_saVolPSG \_
    endm

smpsSetVol	macro vol
	s2e_\smpsdrv\_smpsSetVol \_
    endm

sClrPush	macro
	s2e_\smpsdrv\_sClrPush \_
    endm

sStopSpecFM4	macro
	s2e_\smpsdrv\_sStopSpecFM4 \_
    endm

sPatFM		macro pat
	s2e_\smpsdrv\_sPatFM \_
    endm

ssMod68k	macro wait,speed,change,step
	s2e_\smpsdrv\_ssMod68k \_
    endm

ssModZ80	macro wait,speed,change,step
	s2e_\smpsdrv\_ssModZ80 \_
    endm

sModOn macro
	s2e_\smpsdrv\_sModOn \_
    endm

sStop macro
	s2e_\smpsdrv\_sStop \_
    endm

sNoisePSG macro form
	s2e_\smpsdrv\_sNoisePSG \_
    endm

sModOff macro
	s2e_\smpsdrv\_sModOff \_
    endm

sVolEnvPSG macro volenv
	s2e_\smpsdrv\_sVolEnvPSG \_
    endm

sJump macro loc
	s2e_\smpsdrv\_sJump \_
    endm

sLoop macro index,loops,loc
	s2e_\smpsdrv\_sLoop \_
    endm

sCall macro loc
	s2e_\smpsdrv\_sCall \_
    endm

sMute macro
	s2e_\smpsdrv\_sMute \_
    endm

; S3/S&K/S3D-only coordination flags
; Silences FM channel then stops as per smpsStop
smpsStopFM macro
	s2e_\smpsdrv\_smpsStopFM \_
    endm

; Spindash Rev
smpsSpindashRev macro
	s2e_\smpsdrv\_smpsSpindashRev \_
    endm

smpsPlayDACSample macro sample
	s2e_\smpsdrv\_smpsPlayDACSample \_
    endm

smpsConditionalJump macro index,loc
	s2e_\smpsdrv\_smpsConditionalJump \_
    endm

; Set note values to xx-$40
smpsSetNote macro val
	s2e_\smpsdrv\_smpsSetNote \_
    endm

smpsFMICommand macro reg,val
	s2e_\smpsdrv\_smpsFMICommand \_
    endm

; Set Modulation
smpsModChange2 macro fmmod,psgmod
	s2e_\smpsdrv\_smpsModChange2 \_
    endm

; Set Modulation
smpsModChange macro val
	s2e_\smpsdrv\_smpsModChange \_
    endm

; FCxxxx - Jump to xxxx
smpsContinuousLoop macro loc
	s2e_\smpsdrv\_smpsContinuousLoop \_
    endm

smpsAlternateSMPS macro flag
	s2e_\smpsdrv\_smpsAlternateSMPS \_
    endm

smpsFM3SpecialMode macro ind1,ind2,ind3,ind4
	s2e_\smpsdrv\_smpsFM3SpecialMode \_
    endm

smpsPlaySound macro index
	s2e_\smpsdrv\_smpsPlaySound \_
    endm

smpsHaltMusic macro flag
	s2e_\smpsdrv\_smpsHaltMusic \_
    endm

smpsCopyData macro data,len
	s2e_\smpsdrv\_smpsCopyData \_
    endm

smpsSSGEG macro op1,op2,op3,op4
	s2e_\smpsdrv\_smpsSSGEG \_
    endm

smpsFMVolEnv macro tone,mask
	s2e_\smpsdrv\_smpsFMVolEnv \_
    endm

smpsFMFlutter macro tone,mask
	s2e_\smpsdrv\_smpsFMFlutter \_
    endm

smpsResetSpindashRev macro
	s2e_\smpsdrv\_smpsResetSpindashRev \_
    endm
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

; Patches - Decay Rate
spDecayRt macro op1,op2,op3,op4
spDR1	= op1
spDR2	= op2
spDR3	= op3
spDR4	= op4
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

	s2e_\smpsdrv\_sPatch
    endm

