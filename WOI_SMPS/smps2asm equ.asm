smpsIsZ80 =		1
smpsNoAttack =		$E7
nMaxPSG1 =		nBb6
nMaxPSG2 =		nB6
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
; (VOL_QUICK - VQ_SET_4B_WOI2)
ssVolWOI	macro vol
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
saDetune	macro val
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

; EBxxyyyy - Jump to zzzz, if Z80 RAM address 1C05h is not 0 (last iteration of loop) (COND_JUMP - CJMP_NZ)
sJumpNZ1C05h	macro loc
	dc.b $EB
	Z80PtrROM \loc
    endm

; E5xx - Set base volume (VOLUME - VOL_SET_BASE)
ssVolBase	macro vol
	dc.b $E5,\vol
    endm

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

; EDxx - Set music tempo to xx (TEMPO - TEMPO_SET)
ssTempo		macro val
	dc.b $ED,\val
    endm

; EExx - Set global tick multiplier to xx (TICK_MULT - TMULT_ALL)
ssTickMul	macro val
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
ssModZ80	macro wait,speed,change,step
	dc.b $F0,\wait,\speed,\change,\step
    endm

; F1xx - Add Z80 RAM 1C04h to channel pitch and eat 1 byte (TRANSPOSE - TRNSP_GADD)
saTransp1C04h	macro val
	dc.b $FB,\val
    endm

; F2 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F2
    endm

; F3xx - PSG waveform to xx (PSG_NOISE - PNOIS_SET)
sNoisePSG		macro val
	dc.b $F3,\val
    endm

; F480 - Turn on Modulation (MOD_SET - MODS_ON)
sModOn		macro
	dc.b $F4,$80
    endm

; F4xx - ?? (MOD_ENV - MENV_GEN)
sModEnv		macro val1,val1
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

; FAxx - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
ssTickMulCh	macro val
	dc.b $FA,\val
    endm

; FBxx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $FB,\val
    endm

; FCxx - Enable pitch slide (PITCH_SLIDE)
sPitchSlide	macro val
	dc.b $FC,val
    endm

; FDxx - Enable raw frequency mode (RAW_FREQ)
sRawFreq	macro val
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
	dc.b (spAM1<<7)+spDR1, (spAM3<<7)+spDR3, (spAM2<<7)+spDR2, (spAM4<<7)+spDR4
	dc.b spSR1,            spSR3,            spSR2,            spSR4
	dc.b (spSL1<<4)+spRR1, (spSL3<<4)+spRR3, (spSL2<<4)+spRR2, (spSL4<<4)+spRR4
	dc.b spTL1|spTLMask1,  spTL3|spTLMask3,  spTL2|spTLMask2,  spTL4|spTLMask4
    endm
