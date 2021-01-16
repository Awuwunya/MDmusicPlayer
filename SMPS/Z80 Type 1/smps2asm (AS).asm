; ===========================================================================
; ---------------------------------------------------------------------------
; Example SMPS2ASM macro file for Z80 type 1; Meant to be derived from,
; when creating a game-specific definition
; ---------------------------------------------------------------------------

; simple function to create a Z80 pointer (relative to bank)
Z80PtrROM	function v,littleEndian(v)|$80

; simple function to create little endian word values
littleEndian	function v,(((v)<<8)&$FF00)|(((v)>>8)&$FF)
; ---------------------------------------------------------------------------------------------
; Note Equates
	enum nRst=$80
	enum nC0=$81,  nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0	; $01 - $0C
	enum nC1=nB0+1,nCs1,nD1,nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1 ; $0D - $18
	enum nC2=nB1+1,nCs2,nD2,nEb2,nE2,nF2,nFs2,nG2,nAb2,nA2,nBb2,nB2	; $19 - $24
	enum nC3=nB2+1,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3,nB3	; $25 - $30
	enum nC4=nB3+1,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4	; $31 - $3C
	enum nC5=nB4+1,nCs5,nD5,nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5 ; $3D - $48
	enum nC6=nB5+1,nCs6,nD6,nEb6,nE6,nF6,nFs6,nG6,nAb6,nA6,nBb6,nB6	; $49 - $54
	enum nC7=nB6+1,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7	; $55 - $5F
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum v00=$00,   v01,v02,v03,v04,v05,v06,v07
	enum v08=v07+1, v09,v0A,v0B,v0C,v0D,v0E,v0F
	enum v10=v0F+1, v11,v12,v13,v14,v15,v16,v17
	enum v18=v17+1, v19,v1A,v1B,v1C,v1D,v1E,v1F
	enum v20=v1F+1, v21,v22,v23,v24,v25,v26,v27
	enum v28=v27+1, v29,v2A,v2B,v2C,v2D,v2E,v2F
	enum v30=v2F+1, v31,v32,v33,v34,v35,v36,v37
	enum v38=v37+1, v39,v3A,v3B,v3C,v3D,v3E,v3F
; ---------------------------------------------------------------------------------------------
; Modulation envelope equates
	enum m00=$00,   m01,m02,m03,m04,m05,m06,m07
	enum m08=m07+1, m09,m0A,m0B,m0C,m0D,m0E,m0F
	enum m10=m0F+1, m11,m12,m13,m14,m15,m16,m17
	enum m18=m17+1, m19,m1A,m1B,m1C,m1D,m1E,m1F
	enum m20=m1F+1, m21,m22,m23,m24,m25,m26,m27
	enum m28=m27+1, m29,m2A,m2B,m2C,m2D,m2E,m2F
	enum m30=m2F+1, m31,m32,m33,m34,m35,m36,m37
	enum m38=m37+1, m39,m3A,m3B,m3C,m3D,m3E,m3F
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum d81=$81,   d82,d83,d84,d85,d86,d87,d88,d89,d8A,d8B,d8C,d8D,d8E,d8F
	enum d90=d8F+1, d91,d92,d93,d94,d95,d96,d97,d98,d99,d9A,d9B,d9C,d9D,d9E,d9F
	enum dA0=d9F+1, dA1,dA2,dA3,dA4,dA5,dA6,dA7,dA8,dA9,dAA,dAB,dAC,dAD,dAE,dAF
	enum dB0=dAF+1, dB1,dB2,dB3,dB4,dB5,dB6,dB7,dB8,dB9,dBA,dBB,dBC,dBD,dBE,dBF
	enum dC0=dBF+1, dC1,dC2,dC3,dC4,dC5,dC6,dC7,dC8,dC9,dCA,dCB,dCC,dCD,dCE,dCF
	enum dD0=dCF+1, dD1,dD2,dD3,dD4,dD5,dD6,dD7,dD8,dD9,dDA,dDB,dDC,dDD,dDE,dDF
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

; E0xx - Set channel Panning, AMS & FMS (PANAFMS - PAFMS_PAN)
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

; E2xx - Set communications byte to xx (SET_COMM)
sComm		macro val
	dc.b $E2,val
    endm

; E3 - Stop FM (TRK_END - TEND_MUTE)
sMuteStopFM	macro
	dc.b $E3
    endm

; E400 - Disable pan animation (PAN_ANIM)
; E4vvwwxxyyzz - Enable pan animation (todo: Checkout what params do) (PAN_ANIM)
sPanAni		macro v1, v2, v3, v4, v5
	dc.b $E4

	if v1==""
		dc.b 0
	else
		dc.b v1,v2,v3,v4,v5
	endif
    endm

; E5yyxx - For FM channels, add xx to channel volume. For PSG, add yy (VOLUME - VOL_CN_FMP)
saVolFMP	macro psg,fm
	dc.b $E5,psg,fm
    endm

; E6xx - Add xx to volume. (VOLUME - VOL_CN_FM)
saVolFM		macro vol
	dc.b $E6,vol
    endm

; E7 - Do not attack next note (HOLD)
sHold =		$E7

; E8xx - Stop note after xx ticks (NOTE_STOP - NSTOP_MULT)
sGate		macro val
	dc.b $E8,val
    endm

; E9xxyy - Set LFO speed to xx and amplitude vibrate to yy (SET_LFO - LFO_AMSEN)
ssLFO		macro speed,vibrate
	dc.b $E9,speed,vibrate
    endm

; EAxxxxyy - Set timer A to xxxx. yy is unused (TIMING - TIME_SET)
ssTimerA	macro timer, val
	dc.b $EA
	dc.w littleEndian(timer)
	dc.b val
    endm

; EBxxxxyy - Add xxxx to Timer A. yy is unused (TIMING - TIME_SET)
saTimerA	macro timer, val
	dc.b $EB
	dc.w littleEndian(timer)
	dc.b val
    endm

; ECxx - Add xx to PSG channel volume (VOLUME - VOL_CC_PSG)
saVolPSG	macro vol
	dc.b $EC,vol
    endm

; EDxxyy - Write yy to YM reg xx (FM_COMMAND - FMW_CHN)
sYMcmd		macro reg,val
	dc.b $ED,reg,val
    endm

; EExxyy - Write yy to YM port 1 reg xx (FM_COMMAND - FMW_FM1)
sYM1		macro reg,val
	dc.b $EE,reg,val
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
ssModZ80	macro wait,speed,change,step
	dc.b $F0,wait,speed,change,step
    endm

; F1yyxx - For FM channels, set channel modulation envelope to xx. For PSG, use yy (MOD_ENV - MENV_FMP)
; F4xx - Set channel modulation envelope to xx  (MOD_ENV - MENV_GEN)
sModEnv		macro psg,fm
	if fm==""
		dc.b $F4,psg
	else
		dc.b $F1,psg,fm
	endif
    endm

; F2 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F2
    endm

; F3xx - Set PSG waveform to xx (PSG_NOISE - PNOIS_SET)
sNoisePSG	macro val
	dc.b $F3,val
    endm

; F5xx - Set PSG volume envelope to xx (INSTRUMENT - INS_C_PSG)
sVolEnvPSG	macro env
	dc.b $F5,env
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

; FAxx - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
ssTickMulCh	macro val
	dc.b $FA,val
    endm

; FBxx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $FB,val
    endm

; FCxx - Enable or disable pitch slide (PITCH_SLIDE)
sPitchSlide	macro val
	dc.b $FC,val
    endm

; FDxx - Enable raw frequency mode (RAW_FREQ)
sRawFreq	macro val
	dc.b $FD,val
    endm

; FEwwxxyyzz - Enable special FM3 mode (SPC_FM3)
sSpecFM3	macro ind1,ind2,ind3,ind4
	dc.b $FE,ind1,ind2,ind3,ind4
    endm

; FF00xx - Set SFX timing flag to xx (TIMING_MODE)
ssTimingSFX	macro timing
	dc.b $FF,$00,timing
    endm

; FF01xx - Add xx to music tempo (TEMPO - TEMPO_ADD)
saTempo		macro tempo
	dc.b $FF,$01,tempo
    endm

; FF02xx - Play sound xx (SND_CMD)
sPlaySound	macro val
	dc.b $FF,$02,val
    endm

; FF03xx - Pause music (MUS_PAUSE - MUSP_Z80)
sMusPause	macro val
	dc.b $FF,$03,val
    endm

; FF04xxxxyy - Copy yy bytes from xxxx to here (only in Z80 RAM) (COPY_MEM)
sCopyMem	macro loc,len
	dc.b $FF,$04
	dc.w Z80PtrROM(loc)
	dc.b len
    endm

; FF05xx - Set global tick multiplier to xx (TICK_MULT - TMULT_ALL)
ssTickMul	macro tmul
	dc.b $FF,$05,tmul
    endm

; FF06wwxxyyzz - Enable SSG-EG (SSG_EG - SEG_NORMAL)
sSSGEG		macro op1,op2,op3,op4
	dc.b $FF,$06,op1,op3,op2,op4
    endm

; FF07xxyy - Set FM volume envelope to xx, with operator mask yy (FM_VOLENV)
sVolEnvFM	macro voice,mask
	dc.b $FF,$07,tone,mask
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
