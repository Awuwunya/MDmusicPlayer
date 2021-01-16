; ===========================================================================
; ---------------------------------------------------------------------------
; Based on Flamewing's SMPS2ASM, and S1SMPS2ASM by Marc (AKA Cinossu)
; Reworked and improved by Natsumi
; ---------------------------------------------------------------------------

; this macro is created to emulate enum in AS
enum	macro	num, lable
; copy initial number for referencing later
.num =	num

	rept narg-1
\lable		set .num
.num =	.num+1
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
; PSG volume envelope equates
	enum $00,   v00,v01,v02,v03,v04,v05,v06,v07
	enum v07+1, v08,v09,v0A,v0B,v0C,v0D,v0E,v0F
	enum v0F+1, v10,v11,v12,v13,v14,v15,v16,v17
; ---------------------------------------------------------------------------------------------
; PSG modulation envelope equates
	enum $00,   m00,m01,m02,m03,m04,m05,m06,m07
	enum m07+1, m08,m09
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81,	d81,d82,d83,d84,d85,d86,d87,d88,d89,d8A,d8B,d8C,d8D,d8E,d8F
	enum d8F+1, d90,d91,d92,d93,d94,d95,d96,d97,d98,d99,d9A,d9B,d9C,d9D,d9E,d9F
	enum d9F+1, dA0,dA1,dA2,dA3,dA4,dA5,dA6,dA7,dA8,dA9,dAA,dAB,dAC,dAD,dAE,dAF
	enum dAF+1, dB0,dB1,dB2,dB3,dB4,dB5,dB6,dB7,dB8,dB9,dBA,dBB,dBC,dBD,dBE,dBF
	enum dBF+1, dC0,dC1,dC2,dC3,dC4,dC5,dC6,dC7,dC8
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
sPointZero =	offset(*)
    endm

; Header - Set up Patches Location
; Common to music and SFX
sHeaderPatch	macro loc
	if sPointZero<>offset(*)
		; silently initialize song. Change this if behavior needs to be different
sPointZero =	offset(*)
;		inform 2,"Missing sHeaderInit"
	endif

	dc.w \loc-sPointZero
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
	dc.w \loc-sPointZero

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
	dc.w \loc-sPointZero
	dc.b \pitch,\vol
    endm

; Header - Set up PSG Channel
sHeaderPSG	macro loc,pitch,vol,null,volenv
	dc.w \loc-sPointZero
	dc.b \pitch,\vol,\null,\volenv
    endm

; Header - Set up SFX Channel
sHeaderSFX	macro play,patch,loc,pitch,vol
	dc.b \play,\patch
	dc.w \loc-sPointZero
	dc.b \pitch,\vol
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

; E0xx - Panning, AMS, FMS (PANAFMS - PAFMS_PAN)
sPan	macro dir,amsfms
	if narg=2
		dc.b $E0,\dir|\amsfms
	else
		dc.b $E0,\dir
	endif
    endm

; E1xx - Set channel frequency displacement to xx (DETUNE)
ssDetune	macro val
	dc.b $E1,\val
    endm

; E2xx - Set communications byte to xx (SET_COMM)
sComm		macro val
	dc.b $E2,\val
    endm

; E3 - Stop FM (TRK_END - TEND_MUTE)
sMuteStopFM	macro
	dc.b $E3
    endm

sPanAni		macro v1, v2, v3, v4, v5
	dc.b $E4

	if narg=0
		dc.b 0
	else
		dc.b \v1, \v2, \v3, \v4, \v5
	endif
    endm

; E5yyxx - For FM channels, add xx to channel volume. For PSG, add yy (VOLUME - VOL_CC_FMP)
saVolFMP	macro psg,fm
	dc.b $E5,\psg,\fm
    endm

; E6xx - Add xx to volume. (VOLUME - VOL_CC_FM)
saVolFM		macro vol
	dc.b $E6,\vol
    endm

; E7 - Do not attack next note (HOLD)
sHold =		$E7

; E8xx - Stop note after xx ticks (NOTE_STOP - NSTOP_MULT)
sGate		macro val
	dc.b $E8,\val
    endm

; E9xxyy - Set LFO speed to xx and amplitude vibrate to yy (SET_LFO - LFO_AMSEN)
ssLFO		macro speed,vibrate
	dc.b $E9,\speed,\vibrate
    endm

; EAxx - Set music tempo to xx (TEMPO - TEMPO_SET)
ssTempo		macro val
	dc.b $EA,\val
    endm

; EBxx - Play sound xx (SND_CMD)
sPlaySound	macro val
	dc.b $EB,\val
    endm

; ECxx - Add xx to PSG channel volume (VOLUME - VOL_NN_PSG)
saVolPSG	macro val
	dc.b $EC,\val
    endm

; EDxxyy - Write yy to YM reg xx (FM_COMMAND - FMW_CHN)
sYMcmd		macro reg,val
	dc.b $ED,\reg,\val
    endm

; EExxyy - Write yy to YM port 1 reg xx (FM_COMMAND - FMW_FM1)
sYM1cmd		macro reg,val
	dc.b $EE,\reg,\val
    endm

; EFxx - Set patch id of FM channel to xx (INSTRUMENT - INS_N_FM)
sPatFM		macro pat
	dc.b $EF,\pat
    endm

; F0wwxxyyzz - Modulation
;  ww: wait time
;  xx: modulation speed
;  yy: change per step
;  zz: number of steps
; (MOD_SETUP)
ssMod68k	macro wait,speed,change,step
	dc.b $F0,\wait,\speed,\change,\step
    endm

; F1yyxx - For FM channels, set channel modulation envelope to xx. For PSG, use yy (MOD_ENV - MENV_FMP)
; F4xx - Set channel modulation envelope to xx  (MOD_ENV - MENV_GEN)
sModEnv		macro psg,fm
	if narg=1
		dc.b $F4,\psg
	else
		dc.b $F1,\psg,\fm
	endif
    endm

; F2 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F2
    endm

; F3xx - PSG waveform to xx (PSG_NOISE - PNOIS_SET)
sNoisePSG	macro val
	dc.b $F3,\val
    endm

; F5xx - PSG volume envelope to xx (INSTRUMENT - INS_C_PSG)
sVolEnvPSG	macro env
	dc.b $F5,\env
    endm

; F6xxxx - Jump to xxxx (GOTO)
sJump		macro loc
	dc.b $F6
	dc.w \loc-offset(*)-1
    endm

; F7xxyyzzzz - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing (LOOP)
sLoop		macro index,loops,loc
	dc.b $F7,\index,\loops
	dc.w \loc-offset(*)-1
    endm

; F8xxxx - Call pattern at xxxx, saving return point (GOSUB)
sCall		macro loc
	dc.b $F8
	dc.w \loc-offset(*)-1
    endm

; F9 - Return (RETURN)
sRet		macro
	dc.b $F9
    endm

; FAxx - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
ssTickMulCh	macro val
	dc.b $FA,\val
    endm

; FBxx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $FB,\val
    endm

; FC - Turn on Modulation (MOD_SET - MODS_ON)
sModOn		macro
	dc.b $FC
    endm

; FD - Turn off Modulation (MOD_SET - MODS_OFF)
sModOff		macro
	dc.b $FD
    endm

; FEwwxxyyzz - Enable special FM3 mode (broken?) (SPC_FM3)
sSpecFM3	macro ind1,ind2,ind3,ind4
	dc.b $FE,\ind1,\ind2,\ind3,\ind4
    endm

; FF00wwxxyyzz - Enable SSG-EG (SSG_EG - SEG_FULLATK)
sSSGEG		macro op1,op2,op3,op4
	dc.b $FF,$00,\op1,\op3,\op2,\op4
    endm

; FF01xx - Pause music (MUS_PAUSE - MUSP_68K)
sMusPause	macro val
	dc.b $FF,$01,\val
    endm

; FF02xx - Set global tick multiplier to xx (TICK_MULT - TMULT_ALL)
ssTickMul	macro tmul
	dc.b $FF,$02,\tmul
    endm

; FF03xxyy - Enable special fade (todo: Checkout what it does) (FADE_SPC - FDSPC_FMPSG)
; FF04 - Disable special fade (FADE_SPC - FDSPC_STOP)
sFadeSpec	macro val1, val2
	dc.b $FF

	if narg=0
		dc.b $04
	else
		dc.b $03,\val1,\val2
	endif
    endm
; ---------------------------------------------------------------------------------------------
; Macros for FM instruments

; Patches - Feedback
spFeedback macro val
spFe =	\val
    endm

; Patches - Algorithm
spAlgorithm macro val
spAl =	\val
    endm

; Patches - Detune
spDetune macro op1,op2,op3,op4
spDe1 =	\op1
spDe2 =	\op2
spDe3 =	\op3
spDe4 =	\op4
    endm

; Patches - Multiple
spMultiple macro op1,op2,op3,op4
spMu1 =	\op1
spMu2 =	\op2
spMu3 =	\op3
spMu4 =	\op4
    endm

; Patches - Rate Scale
spRateScale macro op1,op2,op3,op4
spRS1 =	\op1
spRS2 =	\op2
spRS3 =	\op3
spRS4 =	\op4
    endm

; Patches - Attack Rate
spAttackRt macro op1,op2,op3,op4
spAR1 =	\op1
spAR2 =	\op2
spAR3 =	\op3
spAR4 =	\op4
    endm

; Patches - Amplitude Modulation
spAmpMod macro op1,op2,op3,op4
spAM1 =	\op1
spAM2 =	\op2
spAM3 =	\op3
spAM4 =	\op4
    endm

; Patches - Sustain Rate
spSustainRt macro op1,op2,op3,op4
spSR1 =	\op1
spSR2 =	\op2
spSR3 =	\op3
spSR4 =	\op4
    endm

; Patches - Sustain Level
spSustainLv macro op1,op2,op3,op4
spSL1 =	\op1
spSL2 =	\op2
spSL3 =	\op3
spSL4 =	\op4
    endm

; Patches - Decay Rate
spDecayRt macro op1,op2,op3,op4
spDR1 =	\op1
spDR2 =	\op2
spDR3 =	\op3
spDR4 =	\op4
    endm

; Patches - Release Rate
spReleaseRt macro op1,op2,op3,op4
spRR1 =	\op1
spRR2 =	\op2
spRR3 =	\op3
spRR4 =	\op4
    endm

; Patches - Total Level
spTotalLv macro op1,op2,op3,op4
spTL1 =	\op1
spTL2 =	\op2
spTL3 =	\op3
spTL4 =	\op4

	dc.b (spFe<<3)|spAl
;   0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
spTLMask4 = $80
spTLMask3 = ((spAl>=4)<<7)
spTLMask2 = ((spAl>=5)<<7)
spTLMask1 = ((spAl=7)<<7)

	dc.b (spDe1<<4)|spMu1, (spDe3<<4)|spMu3, (spDe2<<4)|spMu2, (spDe4<<4)|spMu4
	dc.b (spRS1<<6)|spAR1, (spRS3<<6)|spAR3, (spRS2<<6)|spAR2, (spRS4<<6)|spAR4
	dc.b (spAM1<<7)|spSR1, (spAM3<<7)|spsR3, (spAM2<<7)|spSR2, (spAM4<<7)|spSR4
	dc.b spDR1,            spDR3,            spDR2,            spDR4
	dc.b (spSL1<<4)|spRR1, (spSL3<<4)|spRR3, (spSL2<<4)|spRR2, (spSL4<<4)|spRR4
	dc.b spTL1|spTLMask1,  spTL3|spTLMask3,  spTL2|spTLMask2,  spTL4|spTLMask4
    endm
