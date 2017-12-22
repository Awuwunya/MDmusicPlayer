smpsIsZ80 =	0
; E7 - Do not attack of next note (HOLD)
sHold =		$E7
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00, 	  VolEnv_00,VolEnv_01,VolEnv_02,VolEnv_03,VolEnv_04
	enum VolEnv_04+1, VolEnv_05,VolEnv_06,VolEnv_07,VolEnv_08,VolEnv_09
; ---------------------------------------------------------------------------------------------
; PSG modulation envelope equates
	enum $00, 	  ModEnv_00
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81, dKick,dSnare,dTimpani
	enum $88, dHiTimpani,dMidTimpani,dLowTimpani,dFloorTimpani
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

; E2xx - Set communications byte to xx (SET_COMM)
sComm		macro val
	dc.b $E2,\val
    endm

; E3 - Return (RETURN)
sRet		macro
	dc.b $E3
    endm

; E4 - Fade in previous song (FADE_IN_SONG)
sFade		macro
	dc.b $E4
    endm

; E5xx - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
ssTickMulCh	macro val
	dc.b $E5,\val
    endm

; E6xx - Add xx to FM channel volume (VOLUME - VOL_NN_FM)
saVolFM		macro val
	dc.b $E6,\val
    endm

; E8xx - Stop note after xx frames (NOTE_STOP - NSTOP_NORMAL)
sNoteTimeOut	macro val
	dc.b $E8,\val
    endm

; E9xx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $E9,\val
    endm

; EAxx - Set music tempo to xx (TEMPO - TEMPO_SET)
ssTempo		macro val
	dc.b $EA,\val
    endm

; EBxx - Set global tick multiplier to xx (TICK_MULT - TMULT_ALL)
ssTickMul	macro val
	dc.b $EB,\val
    endm

; ECxx - Add xx to PSG channel volume (VOLUME - VOL_NN_PSG)
saVolPSG	macro val
	dc.b $EC,\val
    endm

; ED - Clears pushing sound flag in S1
sClrPush	 macro
	dc.b $ED
    endm

; EE - Stops special SFX (S1 only) and restarts overridden music track
sStopSpecFM4	 macro
	dc.b $EE
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

; F1 - Turn on Modulation (MOD_SET - MODS_ON)
sModOn		macro
	dc.b $F1
    endm

; F2 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F2
    endm

; F3xx - PSG waveform to xx (PSG_NOISE - PNOIS_SET)
sNoisePSG	macro val
	dc.b $F3,\val
    endm

; F4 - Turn off Modulation (MOD_SET - MODS_OFF)
sModOff		macro
	dc.b $F4
    endm

; F5xx - PSG volume envelope to xx (INSTRUMENT - INS_N_PSG)
sVolEnvPSG	macro val
	dc.b $F5,\val
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

; F9 - Mutes FM1 (SND_OFF)
sMuteFM1	macro
	dc.b $F9
    endm

; Construct the patch finally.
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
