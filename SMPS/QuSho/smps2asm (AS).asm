; ===========================================================================
; ---------------------------------------------------------------------------
; Based on Flamewing's SMPS2ASM, and S1SMPS2ASM by Marc (AKA Cinossu)
; Reworked and improved by Natsumi
; ---------------------------------------------------------------------------

; simple function to create a Z80 pointer (relative to bank)
Z80PtrROM	function v,littleEndian(v)|$80

; simple function to create little endian word values
littleEndian	function v,(((v)<<8)&$FF00)|(((v)>>8)&$FF)
; ---------------------------------------------------------------------------------------------
; Note Equates (QuackShot, unlike every fucking driver ever, has notes from 60 to CF)
	enum nRst=$60
	enum nC0=$61,  nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0	; $01 - $0C
	enum nC1=nB0+1,nCs1,nD1,nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1 ; $0D - $18
	enum nC2=nB1+1,nCs2,nD2,nEb2,nE2,nF2,nFs2,nG2,nAb2,nA2,nBb2,nB2	; $19 - $24
	enum nC3=nB2+1,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3,nB3	; $25 - $30
	enum nC4=nB3+1,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4	; $31 - $3C
	enum nC5=nB4+1,nCs5,nD5,nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5 ; $3D - $48
	enum nC6=nB5+1,nCs6,nD6,nEb6,nE6,nF6,nFs6,nG6,nAb6,nA6,nBb6,nB6	; $49 - $54
	enum nC7=nB6+1,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7,nB7	; $55 - $60
	enum nC8=nB7+1,nCs8,nD8,nEb8,nE8,nF8,nFs8,nG8,nAb8,nA8,nBb8,nB8	; $61 - $6C
	enum nC9=nB8+1							; $6D
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum v00=$00,   v01,v02,v03,v04,v05,v06,v07
	enum v08=v07+1, v09,v0A,v0B,v0C,v0D,v0E,v0F
	enum v10=v0F+1, v11,v12,v13,v14,v15,v16,v17
; ---------------------------------------------------------------------------------------------
; PSG modulation envelope equates
	enum m00=$00
; ---------------------------------------------------------------------------------------------
; DAC Equates

; ---------------------------------------------------------------------------------------------
; Channel IDs for SFX
cPSG1 =		$80
cPSG2 =		$A0
cPSG3 =		$C0
cNoise =	$E0	; Not for use in S3/S&K/S3D
cFM3 =		$02
cFM4 =		$04
cFM5 =		$05
cFM6 =		$06	; Only in S3/S&K/S3D, overrides DAC
; ---------------------------------------------------------------------------------------------
; Header Macros
sHeaderInit	macro
sPointZero set	*
    endm

; Header - Set up Patches Location
; Common to music and SFX
sHeaderPatch	macro loc
	if sPointZero<>*
		; silently initialize song. Change this if behavior needs to be different
sPointZero set	*
;		message "Missing sHeaderInit"
	endif

	dc.w Z80PtrROM(loc)
    endm

; Header macros
; Header - Set up Channel Usage
sHeaderCh	macro fm,psg
	dc.b fm

	if "psg"<>""
		dc.b psg
	endif
    endm

; Header - Set up Tempo and Tick Multiplier
sHeaderTempo	macro tmul,tempo
	dc.b tmul,tempo
    endm

; Header - Set up Tick Multiplier
sHeaderTick	macro tmul
	dc.b tmul
    endm

; Header - Set up DAC Channel
sHeaderDAC	macro loc,pitch,vol
	dc.w Z80PtrROM(loc)

	if "pitch"<>""
		dc.b pitch
		if "vol"<>""
			dc.b vol
		else
			dc.b $00
		endif
	else
		dc.w $00
	endif
    endm

; Header - Set up FM Channel
sHeaderFM	macro loc,pitch,vol
	dc.w Z80PtrROM(loc)
	dc.b pitch,vol
    endm

; Header - Set up PSG Channel
sHeaderPSG	macro loc,pitch,vol,null,volenv
	dc.w Z80PtrROM(loc)
	dc.b pitch,vol,null,volenv
    endm

; Header - Set up SFX Channel
sHeaderSFX	macro play,patch,loc,pitch,vol
	dc.b play,patch
	dc.w Z80PtrROM(loc)
	dc.b pitch,vol
    endm
; ---------------------------------------------------------------------------------------------
; Equates for different panning types
spNone =	$00
spRight =	$40
spLeft =	$80
spCentre =	$C0
spCenter =	$C0
; ---------------------------------------------------------------------------------------------
; SMPS commands

; Dx - World of Illusion special volume set command.
; The volume is set to x+volbase for PSG, and x+10h+volbase for FM
; (VOL_QUICK - VQ_SET_4B_QS)
ssVolQuick	macro vol
	dc.b $D0+((vol)&$F)
    endm

; E0xx - Panning, AMS, FMS (PANAFMS - PAFMS_PAN)
sPan		macro dir,amsfms
	if "amsfms"<>""
		dc.b $E0,dir|amsfms
	else
		dc.b $E0,dir
	endif
    endm

; E1xx - Set channel frequency displacement to xx (DETUNE)
ssDetune	macro val
	dc.b $E1,val
    endm

; E2xx - Set fraction mode for next note (positive) (no hold) xx (FREQ_FRAC - FRAC_POS_QS)
sFreFracP	macro val
	dc.b $E2,val
    endm

; E3xx - Set fraction mode for next note (negative) (no hold) xx (FREQ_FRAC - FRAC_NEG_QS)
sFreFracN	macro val
	dc.b $E3,val
    endm

; E4 - Duplicate of E7 (HOLD)
; E5 - Duplicate of F0 (MOD_SETUP)

; E6xx - Add xx to FM channel volume (VOLUME - VOL_NN_FM)
saVolFM		macro val
	dc.b $E6,val
    endm

; E7 - Do not attack next note (HOLD)
sHold =		$E7

; E8xx - Stop note after xx ticks (NOTE_STOP - NSTOP_MULT)
sNoteTimeOut	macro val
	dc.b $E8,val
    endm

; E9xxyy - Set LFO speed to xx and amplitude vibrate to yy (SET_LFO - LFO_NORMAL)
ssLFO		macro speed,vibrate
	dc.b $E9,speed,vibrate
    endm

; EAxxxx - Set Timer A to xxxx (TIMING - TIME_SET)
ssTimerAQu	macro timer
	dc.b $EA
	dc.w littleEndian(timer)
    endm

; EBxx - Ignore ignore ignore (IGNORE)
sNop	macro val
	dc.b $EB,val
    endm

; ECxx - Add xx to PSG channel volume (VOLUME - VOL_CC_PSG)
saVolPSG	macro vol
	dc.b $EC,vol
    endm

; EDxx - Set fraction mode for next note (positive) (hold) xx (FREQ_FRAC - FRAC_POS_HOLD_QS)
sHFreFracP	macro val
	dc.b $ED,val
    endm

; EExx - Set fraction mode for next note (negative) (hold) xx (FREQ_FRAC - FRAC_NEG_HOLD_QS)
sHFreFracN	macro val
	dc.b $EE,val
    endm

; EFxx - Set patch id of FM channel to xx (INSTRUMENT - INS_C_FM)
sPatFM		macro pat
	dc.b $EF,pat
    endm

; F0wwxxyyzz - Modulation
;  ww: wait time
;  xx: modulation speed
;  yy: change per step
;  zz: number of steps
; (MOD_SETUP)
ssModQu		macro wait,speed,change,step
	dc.b $F0,wait,speed,change,step
    endm

; F1xx - Set channel base volume to xx (VOLUME - VOL_SET_BASE)
ssVolBase	macro vol
	dc.b $F1,vol
    endm

; F2 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F2
    endm

; F3xx - PSG waveform to xx (PSG_NOISE - PNOIS_SET)
sNoisePSG	macro val
	dc.b $F3,val
    endm

; F4xx - Set channel modulation envelope to xx (MOD_ENV - MENV_GEN)
sModEnv		macro env
	dc.b $F4,env
    endm

; F5xx - Set PSG volume envelope to xx (INSTRUMENT - INS_C_PSG)
sVolEnvPSG	macro voice
	dc.b $F5,voice
    endm

; F6xxxx - Jump to xxxx (GOTO)
sJump		macro loc
	dc.b $F6
	dc.w Z80PtrROM(loc)
    endm

; F7xxyyzzzz - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing (LOOP)
sLoop		macro index,loops,loc
	dc.b $F7,index,loops
	dc.w Z80PtrROM(loc)
    endm

; F8xxxx - Call pattern at xxxx, saving return point (GOSUB)
sCall		macro loc
	dc.b $F8
	dc.w Z80PtrROM(loc)
    endm

; F9 - Return (RETURN)
sRet		macro
	dc.b $F9
    endm

; FAxx - Set channel pitch to xx (TRANSPOSE - TRNSP_SET)
ssTranspose	macro val
	dc.b $FA,val
    endm

; FBxx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $FB,val
    endm

; FCxxyyyy - Jump to zzzz, if loop index xx is 1 (last iteration of loop) (LOOP_EXIT)
sLoopExit	macro index,loc
	dc.b $FC,index
	dc.w Z80PtrROM(loc)
    endm

; EDxx - Set music tempo to xx (TEMPO - TEMPO_SET)
ssTempo		macro val
	dc.b $FD,val
    endm

; FEwwxxyyzz - Enable special FM3 mode (broken?) (SPC_FM3)
sSpecFM3	macro ind1,ind2,ind3,ind4
	dc.b $FE,ind1,ind2,ind3,ind4
    endm
; ---------------------------------------------------------------------------------------------
; Macros for FM instruments

; Patches - Feedback
spFeedback macro val
spFe set	val
    endm

; Patches - Algorithm
spAlgorithm macro val
spAl set	val
    endm

; Patches - Detune
spDetune macro op1,op2,op3,op4
spDe1 set	op1
spDe2 set	op2
spDe3 set	op3
spDe4 set	op4
    endm

; Patches - Multiple
spMultiple macro op1,op2,op3,op4
spMu1 set	op1
spMu2 set	op2
spMu3 set	op3
spMu4 set	op4
    endm

; Patches - Rate Scale
spRateScale macro op1,op2,op3,op4
spRS1 set	op1
spRS2 set	op2
spRS3 set	op3
spRS4 set	op4
    endm

; Patches - Attack Rate
spAttackRt macro op1,op2,op3,op4
spAR1 set	op1
spAR2 set	op2
spAR3 set	op3
spAR4 set	op4
    endm

; Patches - Amplitude Modulation
spAmpMod macro op1,op2,op3,op4
spAM1 set	op1
spAM2 set	op2
spAM3 set	op3
spAM4 set	op4
    endm

; Patches - Sustain Rate
spSustainRt macro op1,op2,op3,op4
spSR1 set	op1
spSR2 set	op2
spSR3 set	op3
spSR4 set	op4
    endm

; Patches - Sustain Level
spSustainLv macro op1,op2,op3,op4
spSL1 set	op1
spSL2 set	op2
spSL3 set	op3
spSL4 set	op4
    endm

; Patches - Decay Rate
spDecayRt macro op1,op2,op3,op4
spDR1 set	op1
spDR2 set	op2
spDR3 set	op3
spDR4 set	op4
    endm

; Patches - Release Rate
spReleaseRt macro op1,op2,op3,op4
spRR1 set	op1
spRR2 set	op2
spRR3 set	op3
spRR4 set	op4
    endm

; Patches - Total Level
spTotalLv macro op1,op2,op3,op4
spTL1 set	op1
spTL2 set	op2
spTL3 set	op3
spTL4 set	op4

	dc.b (spFe<<3)|spAl
;   0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
spTLMask4 set $80
spTLMask3 set ((spAl>=4)<<7)
spTLMask2 set ((spAl>=5)<<7)
spTLMask1 set ((spAl=7)<<7)

	dc.b (spDe1<<4)|spMu1, (spDe3<<4)|spMu3, (spDe2<<4)|spMu2, (spDe4<<4)|spMu4
	dc.b (spRS1<<6)|spAR1, (spRS3<<6)|spAR3, (spRS2<<6)|spAR2, (spRS4<<6)|spAR4
	dc.b (spAM1<<7)|spSR1, (spAM3<<7)|spsR3, (spAM2<<7)|spSR2, (spAM4<<7)|spSR4
	dc.b spDR1,            spDR3,            spDR2,            spDR4
	dc.b (spSL1<<4)|spRR1, (spSL3<<4)|spRR3, (spSL2<<4)|spRR2, (spSL4<<4)|spRR4
	dc.b spTL1|spTLMask1,  spTL3|spTLMask3,  spTL2|spTLMask2,  spTL4|spTLMask4
    endm
