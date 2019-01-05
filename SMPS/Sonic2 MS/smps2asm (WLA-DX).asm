; ===========================================================================
; ---------------------------------------------------------------------------
; Based on Flamewing's SMPS2ASM, and S1SMPS2ASM by Marc (AKA Cinossu)
; Reworked and improved by Natsumi
; Also you wanna know why this file is so messy and inconsistent?
; WLA-DX is fucking horrible piece of crap, that's why
; ---------------------------------------------------------------------------

; this macro is created to emulate enum in AS
.macro	enum	ARGS	num
; copy initial number for referencing later
.redef	_num	num

	.rept nargs-1
.def		\2	_num
.redef		_num	_num+1
	.shift
	.endr
.endm
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
; PSG4 note Equates
.def	nn0		$81
.def	nn1		$82
.def	nn2		$84
.def	nn3		$88
.def	nn4		$90
.def	nn5		$A0
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00,   v00,v01,v02,v03,v04,v05,v06,v07
	enum v07+1, v08,v09,v0A,v0B,v0C,v0D,v0E,v0F
	enum v0F+1, v10,v11,v12,v13,v14,v15
; ---------------------------------------------------------------------------------------------
; PSG modulation envelope equates
	enum $00,   m00,m01,m02,m03,m04,m05,m06,m07
	enum m07+1, m08,m09,m0A
; ---------------------------------------------------------------------------------------------
; Channel IDs for SFX
.def	cPSG1		$80
.def	cPSG2		$A0
.def	cPSG3		$C0
.def	cNoise		$E0	; Not for use in S3/S&K/S3D
.def	cFM3		$02
.def	cFM4		$04
.def	cFM5		$05
.def	cFM6		$06	; Only in S3/S&K/S3D, overrides DAC
; ---------------------------------------------------------------------------------------------
; Header Macros
.macro	sHeaderInit
.redef	sPointZero	$
.endm

; Header - Set up VolEnv Table Location
; Common to music and SFX
.macro	sHeaderVolEnv	ARGS loc
	.IFNEQ sPointZero $
		; silently initialize song. Change this if behavior needs to be different
.redef	sPointZero	*
;		.fail "Missing sHeaderInit"
	.endif

	.dw loc
.endm

; Header - Set up Universal VolEnv Table Location
; Common to music and SFX
.def	smpsUniVolEnvBank $8A2F

.macro	sHeaderVolEnvUniv
	.IFNEQ sPointZero $
		; silently initialize song. Change this if behavior needs to be different
.redef	sPointZero	*
;		.fail "Missing sHeaderInit"
	.endif

	.dw smpsUniVolEnvBank
.endm

; Header macros
; Header - Set up Channel Usage
.macro	sHeaderCh	ARGS unused,psg
	.IF nargs == 2
		.db psg
	.ELSE
		.db 0
	.ENDIF

	.db unused
.endm

; Header - Set up Tempo and Tick Multiplier
.macro	sHeaderTempo	ARGS tmul,tempo
	.db tmul,tempo
.endm

; Header - Set up Tick Multiplier
.macro	sHeaderTick	ARGS tmul
	.db tmul
.endm

; Header - Set up PSG Channel
.macro	sHeaderPSG	ARGS loc,pitch,vol
	.dw \1
	.db pitch,vol
.endm

; Header - Set up SFX Channel
.macro	sHeaderSFX	ARGS play,patch,loc,pitch,vol
	.db play,patch
	.dw \3
	.db pitch,vol
.endm
; ---------------------------------------------------------------------------------------------
; SMPS commands

; E0xx - Set channel note shape (ADSR format) (SET_ADSR - ADSR_VALUES)
.macro	ssEnvADSR	ARGS attack,decayr,decayl,sustain,release
	.db $E0,attack,decayr,decayl,sustain,release
.endm

; E1xx - Set channel frequency displacement to xx (DETUNE)
.macro	ssDetune	ARGS val
	.db $E1,val
.endm

; E2 - Duplicate of E6 (VOLUME - VOL_CC_PSG)

; E3xx - Ignore ignore ignore (IGNORE)
.macro	sNop	ARGS val
	.db $E3,val
.endm

; E4xx - Add xx to PSG noise channel volume (VOLUME - VOL_NN_PSG4)
.macro	saVolNoise	ARGS vol
	.db $E4,vol
.endm

; E5xx - Set ADSR mode to xx. 00 is normal, and 01-FF is repeating attak/decay phases (SET_ADSR - ADSR_MODE)
.macro	ssModeADSR	ARGS mode
	.db $E5,mode
.endm

; E2xx - Add xx to PSG channel volume (VOLUME - VOL_NN_PSG)
.macro	saVolPSG	ARGS vol
	.db $E6,vol
.endm

; E7 - Do not attack next note (HOLD)
.def	sHold		$E7

; E8xx - Set note duration to xx * channel tick rate (SET_NOTE_DURATION)
.macro	ssDuration	ARGS val
	.db $E8,val
.endm

; E9-EC - Duplicate of E3 (IGNORE)

; EDxx - Add xx to music tempo (TEMPO - TEMPO_ADD)
.macro	saTempo		ARGS tempo
	.db $ED,tempo
.endm

; EE-EF - Duplicate of E3 (IGNORE)

; F0wwxxyyzz - Modulation
;  ww: wait time
;  xx: modulation speed
;  yy: change per step
;  zz: number of steps
; (MOD_SETUP)
.macro	ssModMS		ARGS wait,speed,change,step
	.db $F0,wait,speed,change,step
.endm

; F1 - Duplicate of E3 (IGNORE)

; F2 - End of channel (TRK_END - TEND_STD)
.macro	sStop
	.db $F2
.endm

; F3xx - Unknown
.macro	sUnkF3		ARGS val
	.db $F3,val
.endm

; F4xx - Set channel modulation envelope to xx (MOD_ENV - MENV_GEN)
.macro	sModEnv	ARGS env
	.db $F4,env
.endm

; F5xx - Set PSG volume envelope to xx (INSTRUMENT - INS_C_PSG)
.macro	sVolEnvPSG	ARGS env
	.db $F5,env
.endm

; F6xxxx - Jump to xxxx (GOTO)
.macro	sJump		ARGS loc
	.db $F6
	.dw \1
.endm

; F7xxyyzzzz - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing (LOOP)
.macro	sLoop		ARGS index,loops,loc
	.db $F7,index,loops
	.dw \3
.endm

; F8xxxx - Call pattern at xxxx, saving return point (GOSUB)
.macro	sCall		ARGS loc
	.db $F8
	.dw \1
.endm

; F9 - Return (RETURN)
.macro	sRet
	.db $F9
.endm

; FAxx - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
.macro	ssTickMulCh	ARGS val
	.db $FA,val
.endm

; FBxx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
.macro	saTranspose	ARGS val
	.db $FB,val
.endm

; FC - Duplicate of E3 (IGNORE)

; FDxx - Enable raw frequency mode (RAW_FREQ)
.macro	sRawFreq	ARGS val
	.db $FD,val
.endm

; FE-FF - Duplicate of E3 (IGNORE)
