; ===============================================
; Created by Flamewing, based on S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; converted to work on ASM68K by Natsumi
; ===============================================

; this macro is created to emulate enum in AS
enum	macro	num, lable
; copy initial number for referencing later
.num	= num

	rept narg-1
\lable		equ .num
.num =		.num+1
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
smpsHeaderStartSong macro
songStart =	offset(*)
    endm

smpsHeaderVoiceNull macro
	if songStart<>offset(*)
		inform 2,"Missing smpsHeaderStartSong or smpsHeaderStartSongConvert"
	endif
	dc.w	$0000
    endm

; Header - Set up Voice Location
; Common to music and SFX
smpsHeaderVoice macro loc
	if songStart<>offset(*)
		inform 2,"Missing smpsHeaderStartSong or smpsHeaderStartSongConvert"
	endif
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w	loc-songStart
	endif
    endm

; Header - Set up Voice Location as S3's Universal Voice Bank
; Common to music and SFX
smpsHeaderVoiceUVB macro
	if songStart<>offset(*)
		inform 2,"Missing smpsHeaderStartSong or smpsHeaderStartSongConvert"
	endif
	if smpsIsZ80=1
		littleEndian smpsUniVoiceBank
	else
		dc.w	smpsUniVoiceBank-songStart
	endif
    endm

; Header macros for music (not for SFX)
; Header - Set up Channel Usage
smpsHeaderChan macro fm,psg
	dc.b	fm,psg
    endm

; Header - Set up Tempo
smpsHeaderTempo macro div,mod
	dc.b	\div, \mod
    endm

; Header - Set up DAC Channel
smpsHeaderDAC macro loc,pitch,vol
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w	loc-songStart
	endif
	if narg>=2
		dc.b	\pitch
		if narg>=3
			dc.b	\vol
		else
			dc.b	$00
		endif
	else
		dc.w	$00
	endif
    endm

; Header - Set up FM Channel
smpsHeaderFM macro loc,pitch,vol
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w	loc-songStart
	endif
	dc.b	\pitch,\vol
    endm

; Header - Set up PSG Channel
smpsHeaderPSG macro loc,pitch,vol,mod,voice
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w	loc-songStart
	endif
	dc.b	\pitch,\vol,\mod,\voice
    endm

; Header macros for SFX (not for music)
; Header - Set up Tempo
smpsHeaderTempoSFX macro div
	dc.b	div
    endm

; Header - Set up Channel Usage
smpsHeaderChanSFX macro chan
	dc.b	\chan
    endm

; Header - Set up FM Channel
smpsHeaderSFXChannel macro chanid,loc,pitch,vol
	dc.b	$80,\chanid
	if smpsIsZ80=1
		Z80PtrROM \loc
	else
		dc.w	loc-songStart
	endif
	dc.b	\pitch, \vol
    endm
; ---------------------------------------------------------------------------------------------
; Co-ord Flag Macros and Equates
; E0xx - Panning, AMS, FMS
panNone set $00
panRight set $40
panLeft set $80
panCentre set $C0
panCenter set $C0 ; silly Americans :U
smpsPan macro direction,amsfms
	s2e_\smpsdrv\_smpsPan \_
    endm

; E1xx - Set channel frequency displacement to xx
smpsAlterNote macro val
	s2e_\smpsdrv\_smpsAlterNote \_
    endm

; E2xx - Useless
smpsNop macro val
	s2e_\smpsdrv\_smpsNop \_
    endm


smpsSetComm macro val
	s2e_\smpsdrv\_smpsSetComm \_
    endm

smpsPanAnim macro v1, v2, v3, v4, v5
	s2e_\smpsdrv\_smpsSetComm \_
    endm

; Return (used after smpsCall)
smpsReturn macro
	s2e_\smpsdrv\_smpsReturn \_
    endm

; Fade in previous song (ie. 1-Up)
smpsFade macro val
	s2e_\smpsdrv\_smpsFade \_
    endm

smpsTempo macro val
	s2e_\smpsdrv\_smpsChanTempoDiv \_
    endm

smpsTempo macro val
	s2e_\smpsdrv\_smpsChanTempoDiv \_
    endm

smpsSetLFO macro val1, val2
	s2e_\smpsdrv\_smpsSetLFO  \_
    endm

; E6xx - Alter Volume by xx
smpsAlterVol macro val
	s2e_\smpsdrv\_smpsAlterVol \_
    endm

; E7 - Prevent attack of next note
; defined by "smps2asm equ.asm" by the sound driver

; E8xx - Set note fill to xx
smpsNoteFill macro val
	s2e_\smpsdrv\_smpsNoteFill \_
    endm

; Add xx to channel pitch
smpsAlterPitch macro val
	s2e_\smpsdrv\_smpsAlterPitch \_
    endm

; Set music tempo modifier to xx
smpsSetTempoMod macro mod
	s2e_\smpsdrv\_smpsSetTempoMod \_
    endm

; Set music tempo divider to xx
smpsSetTempoDiv macro val
	s2e_\smpsdrv\_smpsSetTempoDiv \_
    endm

; ECxx - Set Volume to xx
smpsSetVol macro val
	s2e_\smpsdrv\_smpsSetVol \_
    endm

; Works on all drivers
smpsPSGAlterVol macro vol
	s2e_\smpsdrv\_smpsPSGAlterVol \_
    endm

; Clears pushing sound flag in S1
smpsClearPush macro
	s2e_\smpsdrv\_smpsClearPush \_
    endm

; Stops special SFX (S1 only) and restarts overridden music track
smpsStopSpecial macro
	s2e_\smpsdrv\_smpsStopSpecial \_
    endm

; EFxx[yy] - Set Voice of FM channel to xx; xx < 0 means yy present
smpsSetvoice macro voice
	s2e_\smpsdrv\_smpsSetvoice \_
    endm

; F0wwxxyyzz - Modulation - ww: wait time - xx: modulation speed - yy: change per step - zz: number of steps
smpsModSet macro wait,speed,change,step
	s2e_\smpsdrv\_smpsModSet \_
    endm

; Turn on Modulation
smpsModOn macro
	s2e_\smpsdrv\_smpsModOn \_
    endm

; F2 - End of channel
smpsStop macro
	s2e_\smpsdrv\_smpsStop \_
    endm

; F3xx - PSG waveform to xx
smpsPSGform macro form
	s2e_\smpsdrv\_smpsPSGform \_
    endm

; Turn off Modulation
smpsModOff macro
	s2e_\smpsdrv\_smpsModOff \_
    endm

; F5xx - PSG voice to xx
smpsPSGvoice macro voice
	s2e_\smpsdrv\_smpsPSGvoice \_
    endm

; F6xxxx - Jump to xxxx
smpsJump macro loc
	s2e_\smpsdrv\_smpsJump \_
    endm

; F7xxyyzzzz - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing
smpsLoop macro index,loops,loc
	s2e_\smpsdrv\_smpsLoop \_
    endm

; F8xxxx - Call pattern at xxxx, saving return point
smpsCall macro loc
	s2e_\smpsdrv\_smpsCall \_
    endm
; ---------------------------------------------------------------------------------------------
; Alter Volume
smpsFMAlterVol macro val1,val2
	s2e_\smpsdrv\_smpsFMAlterVol \_
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
; S1/S2 only coordination flag
; Sets D1L to maximum volume (minimum attenuation) and RR to maximum for operators 3 and 4 of FM1
smpsWeirdD1LRR macro
	s2e_\smpsdrv\_smpsWeirdD1LRR \_
    endm
; ---------------------------------------------------------------------------------------------
; Macros for FM instruments
; Voices - Feedback
smpsVcFeedback macro val
vcFeedback set val
    endm

; Voices - Algorithm
smpsVcAlgorithm macro val
vcAlgorithm set val
    endm

smpsVcUnusedBits macro val
vcUnusedBits set val
    endm

; Voices - Detune
smpsVcDetune macro op1,op2,op3,op4
vcDT1 set op1
vcDT2 set op2
vcDT3 set op3
vcDT4 set op4
    endm

; Voices - Coarse-Frequency
smpsVcCoarseFreq macro op1,op2,op3,op4
vcCF1 set op1
vcCF2 set op2
vcCF3 set op3
vcCF4 set op4
    endm

; Voices - Rate Scale
smpsVcRateScale macro op1,op2,op3,op4
vcRS1 set op1
vcRS2 set op2
vcRS3 set op3
vcRS4 set op4
    endm

; Voices - Attack Rate
smpsVcAttackRate macro op1,op2,op3,op4
vcAR1 set op1
vcAR2 set op2
vcAR3 set op3
vcAR4 set op4
    endm

; Voices - Amplitude Modulation
smpsVcAmpMod macro op1,op2,op3,op4
vcAM1 set op1
vcAM2 set op2
vcAM3 set op3
vcAM4 set op4
    endm

; Voices - First Decay Rate
smpsVcDecayRate1 macro op1,op2,op3,op4
vcD1R1 set op1
vcD1R2 set op2
vcD1R3 set op3
vcD1R4 set op4
    endm

; Voices - Second Decay Rate
smpsVcDecayRate2 macro op1,op2,op3,op4
vcD2R1 set op1
vcD2R2 set op2
vcD2R3 set op3
vcD2R4 set op4
    endm

; Voices - Decay Level
smpsVcDecayLevel macro op1,op2,op3,op4
vcDL1 set op1
vcDL2 set op2
vcDL3 set op3
vcDL4 set op4
    endm

; Voices - Release Rate
smpsVcReleaseRate macro op1,op2,op3,op4
vcRR1 set op1
vcRR2 set op2
vcRR3 set op3
vcRR4 set op4
    endm

; Voices - Total Level
smpsVcTotalLevel macro op1,op2,op3,op4
	s2e_\smpsdrv\_smpsVcTotalLevel \_
    endm

