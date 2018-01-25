smpsIsZ80 =		1
smpsNoAttack =		$E7
; ---------------------------------------------------------------------------------------------
; Note Equates (QuackShot, unlike every fucking driver ever, has notes from 60 to CF)
	enum $60,  nRst,nC0,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0
	enum nB0+1,	nC1,nCs1,nD1,nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1
	enum nB1+1,	nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2,nG2,nAb2,nA2,nBb2,nB2
	enum nB2+1,	nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3,nB3
	enum nB3+1,	nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4
	enum nB4+1,	nC5,nCs5,nD5,nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5
	enum nB5+1,	nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6,nG6,nAb6,nA6,nBb6,nB6
	enum nB6+1,	nC7,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7,nB7
	enum nB7+1,	nC8,nCs8,nD8,nEb8,nE8,nF8,nFs8,nG8,nAb8,nA8,nBb8,nB8
	enum nB8+1,	nC9
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00,	  VolEnv_00,VolEnv_01,VolEnv_02,VolEnv_03,VolEnv_04,VolEnv_05
	enum VolEnv_05+1, VolEnv_06,VolEnv_07,VolEnv_08,VolEnv_09,VolEnv_0A,VolEnv_0B
	enum VolEnv_0B+1, VolEnv_0C,VolEnv_0D,VolEnv_0E,VolEnv_0F,VolEnv_10,VolEnv_11
	enum VolEnv_11+1, VolEnv_12,VolEnv_13,VolEnv_14,VolEnv_15,VolEnv_16,VolEnv_17
; ---------------------------------------------------------------------------------------------
; PSG modulation envelope equates
	enum $00, 	  ModEnv_00
; ---------------------------------------------------------------------------------------------
; DAC Equates
; ---------------------------------------------------------------------------------------------
; SMPS commands

; Dx - World of Illusion special volume set command.
; The volume is set to x+volbase for PSG, and x+10h+volbase for FM
; (VOL_QUICK - VQ_SET_4B_QS)
ssVolQuick	macro vol
	dc.b $D0+(vol&$F)
    endm

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

; E2xx - Set fraction mode for next note (positive) (no hold) xx (FREQ_FRAC - FRAC_POS_QS)
sFreFracP	macro val
	dc.b $E2,\val
    endm

; E3xx - Set fraction mode for next note (negative) (no hold) xx (FREQ_FRAC - FRAC_NEG_QS)
sFreFracN	macro val
	dc.b $E3,\val
    endm

; E4 - Duplicate of E7 (HOLD)
; E5 - Duplicate of F0 (MOD_SETUP)

; E6xx - Add xx to FM channel volume (VOLUME - VOL_NN_FM)
saVolFM		macro val
	dc.b $E6,\val
    endm

; E8xx - Stop note after xx ticks (NOTE_STOP - NSTOP_MULT)
sNoteTimeOut	macro val
	dc.b $E8,\val
    endm

; E9xxyy - Set LFO speed to xx and amplitude vibrate to yy (SET_LFO - LFO_NORMAL)
ssLFO		macro val1, val2
	dc.b $E9,\val1,\val2
    endm

; EAxxxx - Set timer A to xxxx (bit7 clear) (TIMING - TIME_SET)
sTimerA		macro timer
	dc.b $EA
	dw \timer
    endm

; EBxx - Ignore ignore ignore (IGNORE)
sNop	macro val
	dc.b $EB, \val
    endm

; ECxx - Add xx to PSG channel volume (VOLUME - VOL_CC_PSG)
saVolPSG	macro vol
	dc.b $EC,\vol
    endm

; EDxx - Set fraction mode for next note (positive) (hold) xx (FREQ_FRAC - FRAC_POS_HOLD_QS)
sHFreFracP	macro val
	dc.b $ED,\val
    endm

; EExx - Set fraction mode for next note (negative) (hold) xx (FREQ_FRAC - FRAC_NEG_HOLD_QS)
sHFreFracN	macro val
	dc.b $EE,\val
    endm

; EFxx - Set patch id of FM channel to xx (INSTRUMENT - INS_C_FM)
sPatFM		macro val
	dc.b $EF,\val
    endm

; F0wwxxyyzz - Modulation
;  ww: wait time
;  xx: modulation speed
;  yy: change per step
;  zz: number of steps
; (MOD_SETUP)
ssModQu	macro wait,speed,change,step
	dc.b $F0,\wait,\speed,\change,\step
    endm

; F1xx - Set base volume (VOLUME - VOL_SET_BASE)
ssVolBase	macro vol
	dc.b $F1,\vol
    endm

; F2 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F2
    endm

; F3xx - PSG waveform to xx (PSG_NOISE - PNOIS_SET)
sNoisePSG	macro val
	dc.b $F3,\val
    endm

; F4xx - ?? (MOD_ENV - MENV_GEN)
sModEnv		macro val1
		dc.b $F4,\val
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

; FBxx - Set channel pitch to xx (TRANSPOSE - TRNSP_SET)
ssTranspose	macro val
	dc.b $FB,\val
    endm

; FBxx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $FB,\val
    endm

; FCxxyyyy - Jump to zzzz, if loop index xx is 1 (last iteration of loop) (LOOP_EXIT)
sLoopExit	macro index,loc
	dc.b $FC,\index
	Z80PtrROM \loc
    endm

; EDxx - Set music tempo to xx (TEMPO - TEMPO_SET)
ssTempo		macro val
	dc.b $FD,\val
    endm

; FEwwxxyyzz - Enable special FM3 mode (broken?) (SPC_FM3)
sSpecFM3	macro ind1,ind2,ind3,ind4
	dc.b $FE,\ind1,\ind2,\ind3,\ind4
    endm

sPatch		macro
	dc.b	(spFe<<3)+spAl
;   0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
spTLMask4 set $80
spTLMask2 set ((spAl>=5)<<7)
spTLMask3 set ((spAl>=4)<<7)
spTLMask1 set ((spAl=7)<<7)

	dc.b (spDe1<<4)+spMu1, (spDe3<<4)+spMu3, (spDe2<<4)+spMu2, (spDe4<<4)+spMu4
	dc.b (spRS1<<6)+spAR1, (spRS3<<6)+spAR3, (spRS2<<6)+spAR2, (spRS4<<6)+spAR4
	dc.b (spAM1<<7)+spSR1, (spAM3<<7)+spsR3, (spAM2<<7)+spSR2, (spAM4<<7)+spSR4
	dc.b spDR1,            spDR3,            spDR2,            spDR4
	dc.b (spSL1<<4)+spRR1, (spSL3<<4)+spRR3, (spSL2<<4)+spRR2, (spSL4<<4)+spRR4
	dc.b spTL1|spTLMask1,  spTL3|spTLMask3,  spTL2|spTLMask2,  spTL4|spTLMask4
    endm
