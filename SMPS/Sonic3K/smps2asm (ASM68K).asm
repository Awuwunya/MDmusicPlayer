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
cPSG1 =		$80
cPSG2 =		$A0
cPSG3 =		$C0
cNoise =	$E0	; Not for use in S3/S&K/S3D
cFM3 =		$02
cFM4 =		$04
cFM5 =		$05
cFM6 =		$06	; Only in S3/S&K/S3D, overrides DAC
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00,   v00,v01,v02,v03,v04,v05,v06,v07
	enum v07+1, v08,v09,v0A,v0B,v0C,v0D,v0E,v0F
	enum v0F+1, v10,v11,v12,v13,v14,v15,v16,v17
	enum v17+1, v18,v19,v1A,v1B,v1C,v1D,v1E,v1F
	enum v1F+1, v20,v21,v22,v23,v24,v25,v26,v27
; ---------------------------------------------------------------------------------------------
; PSG modulation envelope equates
	enum $00,   m00,m01,m02,m03,m04,m05,m06,m07
	enum m07+1, m08
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81,		dSnare,dHighTom,dMidTom,dLowTom,dLowerTom,dKick,dKickSnare
	enum dKickSnare+1,	dCrashCymbal,dRideCymbal,dHighMetalBlock,dLowMetalBlock,dMutedWood
	enum dMutedWood+1,	dHighCowBell,dLowCowBell,dClap,dHighElecTom
	enum dHighElecTom+1,	dMidElecTom,dLowElecTom,dLowerElecTom
	enum dLowerElecTom+1,	dHighHeavyTom,dMidHeavyTom,dLowHeavyTom,dLowerHeavyTom
	enum dLowerHeavyTom+1,	dHighTimpani,dLowTimpani,dMidTimpani,dLooseSnare
	enum dLooseSnare+1,	dVocalClick,dVocalKick,dVocalSnare
	enum dVocalSnare+1,	dJamHit,dJamHitShort,dGlassKick,dGlassSmash
	enum dGlassSmash+1,	dDanceKickSnare,dDanceKick,dComeOn,dHeavySnare,dLowKick
	enum dLowKick+1,	dLowKickShort,dWhoo,dGo,dSnareGo,dPowerTom,dHighWood,dLowWood
	enum dLowWood+1,	dHighCongo,dLowCongo,dCrashHit,dHighEchoClap
	enum dHighEchoClap+1,	dLowEchoClap,dHighOrchHit,dMidOrchHit
	enum dMidOrchHit+1,	dKickUh,dElecKick,dSynthHit,dSynthHit2
	enum dSynthHit2+1,	dReverseCrash,dScratch,dSynthHit3,dHeavyKick
	enum dHeavyKick+1,	dWhooCrash,dSideStick,dKickOh,dLowOrchHit
	enum dLowOrchHit+1,	dLowerOrchHit,dLowestOrchHit,dHigherOrchHit
	enum dHigherOrchHit+1,	dEchoedClapHit2,dLowerEchoedClapHit2
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

	Z80PtrROM \loc
    endm

; Header - Set up Patches Location as an Universal Voice Bank (S3/S&K)
; Common to music and SFX
smpsUniVoiceBank =	$17D8

sHeaderPatchUniv macro
	if sPointZero<>offset(*)
		; silently initialize song. Change this if behavior needs to be different
sPointZero =	offset(*)
;		inform 2,"Missing sHeaderInit"
	endif

	littleEndian smpsUniVoiceBank
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
	Z80PtrROM \loc

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
	Z80PtrROM \loc
	dc.b \pitch,\vol
    endm

; Header - Set up PSG Channel
sHeaderPSG	macro loc,pitch,vol,null,volenv
	Z80PtrROM \loc
	dc.b \pitch,\vol,\null,\volenv
    endm

; Header - Set up SFX Channel
sHeaderSFX	macro play,patch,loc,pitch,vol
	dc.b \play,\patch
	Z80PtrROM \loc
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
sPan		macro dir,amsfms
	if narg=2
		dc.b $E0,\dir+\amsfms
	else
		dc.b $E0,\dir
	endif
    endm

; E1xx - Set channel frequency displacement to xx (DETUNE)
ssDetune	macro val
	dc.b $E1,\val
    endm

; E2[xx] - Fade in previous song (FADE_IN_SONG)
sFade		macro val
	dc.b $E2
	if narg=1
		dc.b \val
	else
		dc.b $FF
	endif
    endm

; E3 - Stop FM (TRK_END - TEND_MUTE)
sMuteStopFM	macro
	dc.b $E3
    endm

; E4 - S3K's special set volume absolute (VOLUME - VOL_ABS_S3K)
ssVol		macro val
	dc.b $E4,-(\val)&$7F
    endm

; E5yyxx - Add xx to volume. yy is broken/ignored (VOLUME - VOL_CC_FMP2)
saVolFMP	macro psg,fm
	dc.b $E5,\psg,\fm
	; Sonic Team should be handed a dunce hat for breaking this simple command...
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

; E9 - Rev spindash once (SPINDASH_REV - SDREV_INC)
sSpDashRev	macro
	dc.b $E9
    endm

; EAxx - Play sample xx (bit7 clear) (PLAY_DAC)
sPlayDAC	macro sample
	dc.b $EA,(\sample&$7F)
    endm

; EBxxyyyy - Jump to zzzz, if loop index xx is 1 (last iteration of loop) (LOOP_EXIT)
sLoopExit	macro index,loc
	dc.b $EB,\index
	Z80PtrROM \loc
    endm

; ECxx - Add xx to PSG channel volume (VOLUME - VOL_CC_PSG)
saVolPSG	macro vol
	dc.b $EC,\vol
    endm

; EDxx - Set channel pitch to xx (TRANSPOSE - TRNSP_ADD)
ssTransposeS3K	macro val
	dc.b $ED,\val
    endm

; EExxyy - Write yy to YM port 1 reg xx (FM_COMMAND - FMW_FM1)
sYM1cmd		macro reg,val
	dc.b $EE,\reg,\val
    endm

; EFxx[yy] - Set patch id of FM channel to xx. If xx bit7 set, read from another song instead
; (INSTRUMENT - INS_C_FMP)
sPatFM		macro pat, song
	if narg=2
		dc.b $EF,\pat|$80,\song+$81
	else
		dc.b $EF,\pat
	endif
    endm

; F0wwxxyyzz - Modulation
;  ww: wait time
;  xx: modulation speed
;  yy: change per step
;  zz: number of steps
; (MOD_SETUP)
ssModZ80	macro wait,speed,change,step
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

; F480 - Turn on Modulation (MOD_SET - MODS_ON)
sModOn		macro
	dc.b $F4,$80
    endm

; F5xx - PSG volume envelope to xx (INSTRUMENT - INS_C_PSG)
sVolEnvPSG	macro voice
	dc.b $F5,voice
    endm

; F6xxxx - Jump to xxxx (GOTO)
sJump		macro loc
	dc.b $F6
	Z80PtrROM \loc
    endm

; F7xxyyzzzz - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing (LOOP)
sLoop		macro index,loops,loc
	dc.b $F7,\index,\loops
	Z80PtrROM \loc
    endm

; F8xxxx - Call pattern at xxxx, saving return point (GOSUB)
sCall		macro loc
	dc.b $F8
	Z80PtrROM \loc
    endm

; F9 - Return (RETURN)
sRet		macro
	dc.b $F9
    endm

; FA - Turn off Modulation (MOD_SET - MODS_OFF)
sModOff		macro
	dc.b $FA
    endm

; FBxx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $FB,\val
    endm

; FCxxxx -  If continous SFX counter is > 0, jump to xxxx (CONT_SFX)
sCont		macro loc
	dc.b $FC
	Z80PtrROM \loc
    endm

; FDxx - Enable raw frequency mode (RAW_FREQ)
sRawFreq	macro val
	dc.b $FD,\val
    endm

; FEwwxxyyzz - Enable special FM3 mode (broken?) (SPC_FM3)
sSpecFM3	macro ind1,ind2,ind3,ind4
	dc.b $FE,\ind1,\ind2,\ind3,\ind4
    endm

; FF00xx - Set music tempo to xx (TEMPO - TEMPO_SET)
ssTempo		macro tempo
	dc.b $FF,$00,\tempo
    endm

; FF01xx - Play sound xx (SND_CMD)
sPlaySound	macro val
	dc.b $FF,$01,\val
    endm

; FF02xx - Pause music (MUS_PAUSE - MUSP_Z80)
sMusPause	macro val
	dc.b $FF,$02,\val
    endm

; FF03xxxxyy - Copy yy bytes from xxxx to here (only in Z80 RAM) (COPY_MEM)
sCopyMem	macro loc,len
	dc.b $FF,$03
	littleEndian \loc
	dc.b \len
    endm

; FF04xx - Set global tick multiplier to xx (TICK_MULT - TMULT_ALL)
ssTickMul	macro tmul
	dc.b $FF,$04,\tmul
    endm

; FF05wwxxyyzz - Enable SSG-EG (SSG_EG - SEG_NORMAL)
sSSGEG		macro op1,op2,op3,op4
	dc.b $FF,$05,\op1,\op3,\op2,\op4
    endm

; FF06xxyy - ?? (FM_VOLENV)
sVolEnvFM	macro tone,mask
	dc.b $FF,$06,\tone,\mask
    endm

; FF07 - Reset spindash rev counter (SPINDASH_REV - SDREV_RESET)
sSpDashReset	macro
	dc.b $FF,$07
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
