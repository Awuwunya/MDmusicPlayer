smpsIsZ80 =	0
sHold =		$E7
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00,	  VolEnv_00,VolEnv_01,VolEnv_02,VolEnv_03,VolEnv_04,VolEnv_05,VolEnv_06
	enum VolEnv_06+1, VolEnv_07,VolEnv_08,VolEnv_09,VolEnv_0A,VolEnv_0B,VolEnv_0C,VolEnv_0D
	enum VolEnv_0D+1, VolEnv_0E,VolEnv_0F,VolEnv_10,VolEnv_11,VolEnv_12,VolEnv_13,VolEnv_14
	enum VolEnv_14+1, VolEnv_15,VolEnv_16,VolEnv_17
; ---------------------------------------------------------------------------------------------
; PSG modulation envelope equates
	enum $00, 	  ModEnv_00,ModEnv_01,ModEnv_02,ModEnv_03,ModEnv_04,ModEnv_05,ModEnv_06
	enum ModEnv_06+1, ModEnv_07,ModEnv_08,ModEnv_09
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81, d81,d82,d83,d84,d85,d86,d87,d88,d89,d8A,d8B,d8C,d8D,d8E,d8F
	enum $90, d90,d91,d92,d93,d94,d95,d96,d97,d98,d99,d9A,d9B,d9C,d9D,d9E,d9F
	enum $A0, dA0,dA1,dA2,dA3,dA4,dA5,dA6,dA7,dA8,dA9,dAA,dAB,dAC,dAD,dAE,dAF
	enum $B0, dB0,dB1,dB2,dB3,dB4,dB5,dB6,dB7,dB8,dB9,dBA,dBB,dBC,dBD,dBE,dBF
	enum $C0, dC0,dC1,dC2,dC3,dC4,dC5,dC6,dC7,dC8
; ---------------------------------------------------------------------------------------------
; SMPS commands

; E0xx - Panning, AMS, FMS (PANAFMS - PAFMS_PAN)
sPan	macro dir,amsfms
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

; E5yyxx or E6xx - Add xx to volume. yy is broken/ignored (VOLUME - VOL_NN_FMP / VOL_NN_FM)
saVolFM		macro val1,val2
	if narg=2
		dc.b $E5,\val1,\val2
	else
		dc.b $E6,\val1
	endif
    endm

; E8xx - Stop note after xx ticks (NOTE_STOP - NSTOP_MULT)
sNoteTimeOut	macro val
	dc.b $E8,\val
    endm

; E9xxyy - Set LFO speed to xx and amplitude vibrate to yy (SET_LFO - LFO_AMSEN)
ssLFO		macro val1, val2
	dc.b $E9,\val1,\val2
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
sPatFM		macro val
	dc.b $EF,\val
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

; F1xx[yy] - ?? (MOD_ENV - MENV_FMP)
; F4xx[yy] - ?? (MOD_ENV - MENV_GEN)
sModEnv		macro val1,val1
	if narg=1
		dc.b $F4,\val
	else
		dc.b $F1,\val1,\val2
	endif
    endm

; F2 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F2
    endm

; F3xx - PSG waveform to xx (PSG_NOISE - PNOIS_SET)
sNoisePSG		macro val
	dc.b $F3,\val
    endm

; F5xx - PSG volume envelope to xx (INSTRUMENT - INS_C_PSG)
sVolEnvPSG	macro voice
	dc.b $F5,voice
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

sFadeSPCTRS	macro val1, val2
	dc.b $FF
	if narg=0
		dc.b $04,\val1,\val2
	else
		dc.b $03
	endif
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
	dc.b (spAM1<<7)+spDR1, (spAM3<<7)+spDR3, (spAM2<<7)+spDR2, (spAM4<<7)+spDR4
	dc.b spSR1,            spSR3,            spSR2,            spSR4
	dc.b (spSL1<<4)+spRR1, (spSL3<<4)+spRR3, (spSL2<<4)+spRR2, (spSL4<<4)+spRR4
	dc.b spTL1|spTLMask1,  spTL3|spTLMask3,  spTL2|spTLMask2,  spTL4|spTLMask4
    endm
