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
; PSG4 note Equates
nn0 =		$81
nn1 =		$82
nn2 =		$84
nn3 =		$88
nn4 =		$90
nn5 =		$A0
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

; Header - Set up VolEnv Table Location
; Common to music and SFX
sHeaderVolEnv	macro loc
	if sPointZero<>offset(*)
		; silently initialize song. Change this if behavior needs to be different
sPointZero =	offset(*)
;		inform 2,"Missing sHeaderInit"
	endif

	Z80PtrROM \loc
    endm

; Header - Set up Universal VolEnv Table Location
; Common to music and SFX
smpsUniVolEnvBank =	$8A2F

sHeaderVolEnvUniv macro
	if sPointZero<>offset(*)
		; silently initialize song. Change this if behavior needs to be different
sPointZero =	offset(*)
;		inform 2,"Missing sHeaderInit"
	endif

	littleEndian smpsUniVolEnvBank
    endm

; Header macros
; Header - Set up Channel Usage
sHeaderCh	macro unused,psg
	if narg=2
		dc.b \psg
	else
		dc.b 0
	endif

	dc.b \unused
    endm

; Header - Set up Tempo and Tick Multiplier
sHeaderTempo	macro tmul,tempo
	dc.b \tmul,\tempo
    endm

; Header - Set up Tick Multiplier
sHeaderTick	macro tmul
	dc.b \tmul
    endm

; Header - Set up PSG Channel
sHeaderPSG	macro loc,pitch,vol
	Z80PtrROM \loc
	dc.b \pitch,\vol
    endm

; Header - Set up SFX Channel
sHeaderSFX	macro play,patch,loc,pitch,vol
	dc.b \play,\patch
	Z80PtrROM \loc
	dc.b \pitch,\vol
    endm
; ---------------------------------------------------------------------------------------------
; SMPS commands

; E0xx - Set channel note shape (ADSR format) (SET_ADSR - ADSR_VALUES)
ssEnvADSR	macro attack,decayr,decayl,sustain,release
	dc.b $E0,\attack,\decayr,\decayl,\sustain,\release
    endm

; E1xx - Set channel frequency displacement to xx (DETUNE)
ssDetune	macro val
	dc.b $E1,\val
    endm

; E2xx - Add xx to PSG channel volume (VOLUME - VOL_NN_PSG)
saVolPSG	macro vol
	dc.b $E2,\vol
    endm

; E3xx - Ignore ignore ignore (IGNORE)
sNop		macro val
	dc.b $E3,\val
    endm

; E4xx - Add xx to PSG noise channel volume (VOLUME - VOL_NN_PSG4)
saVolNoise	macro vol
	dc.b $E4,\vol
    endm

; E5xx - Set ADSR mode to xx. 00 is normal, and 01-FF is repeating attak/decay phases (SET_ADSR - ADSR_MODE)
ssModeADSR	macro mode
	dc.b $E5,\mode
    endm

; E6 - Duplicate of E2 (VOLUME - VOL_CC_PSG)

; E7 - Do not attack next note (HOLD)
sHold =		$E7

; E8xx - Set note duration to xx * channel tick rate (SET_NOTE_DURATION)
ssDuration	macro val
	dc.b $E8,\val
    endm

; E9-EC - Duplicate of E3 (IGNORE)

; EDxx - Add xx to music tempo (TEMPO - TEMPO_ADD)
saTempo		macro tempo
	dc.b $ED,\tempo
    endm

; EE-EF - Duplicate of E3 (IGNORE)

; F0wwxxyyzz - Modulation
;  ww: wait time
;  xx: modulation speed
;  yy: change per step
;  zz: number of steps
; (MOD_SETUP)
ssModMS		macro wait,speed,change,step
	dc.b $F0,\wait,\speed,\change,\step
    endm

; F1 - Duplicate of E3 (IGNORE)

; F2 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F2
    endm

; F3xx - Unknown
sUnkF3	macro val
	dc.b $F3,\val
    endm

; F4xx - Set channel modulation envelope to xx (MOD_ENV - MENV_GEN)
sModEnv		macro env
	dc.b $F4,\env
    endm

; F5xx - Set PSG volume envelope to xx (INSTRUMENT - INS_C_PSG)
sVolEnvPSG	macro env
	dc.b $F5,\env
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

; FAxx - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
ssTickMulCh	macro val
	dc.b $FA,\val
    endm

; FBxx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $FB,\val
    endm

; FC - Duplicate of E3 (IGNORE)

; FDxx - Enable raw frequency mode (RAW_FREQ)
sRawFreq	macro val
	dc.b $FD,\val
    endm

; FE-FF - Duplicate of E3 (IGNORE)
