smpsIsZ80 =		1
smpsUniVoiceBank =	$17D8
; E7 - Do not attack of next note (HOLD)
sHold =			$E7
nMaxPSG1 =		nBb6
nMaxPSG2 =		nB6
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00,	  VolEnv_00,VolEnv_01,VolEnv_02,VolEnv_03,VolEnv_04,VolEnv_05
	enum VolEnv_05+1, VolEnv_06,VolEnv_07,VolEnv_08,VolEnv_09,VolEnv_0A,VolEnv_0B
	enum VolEnv_0B+1, VolEnv_0C,VolEnv_0D,VolEnv_0E,VolEnv_0F,VolEnv_10,VolEnv_11
	enum VolEnv_11+1, VolEnv_12,VolEnv_13,VolEnv_14,VolEnv_15,VolEnv_16,VolEnv_17
	enum VolEnv_17+1, VolEnv_18,VolEnv_19,VolEnv_1A,VolEnv_1B,VolEnv_1C,VolEnv_1D
	enum VolEnv_1D+1, VolEnv_1E,VolEnv_1F,VolEnv_20,VolEnv_21,VolEnv_22,VolEnv_23
	enum VolEnv_23+1, VolEnv_24,VolEnv_25,VolEnv_26
; ---------------------------------------------------------------------------------------------
; PSG modulation envelope equates
	enum $00,	  ModEnv_00,ModEnv_01,ModEnv_02,ModEnv_03,ModEnv_04,ModEnv_05
	enum VolEnv_05+1, ModEnv_06,ModEnv_07
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81, dSnare,dHighTom,dMidTom,dLowTom,dFloorTom,dKick,dMuffledSnare
	enum dMuffledSnare+1, dCrashCymbal,dRideCymbal,dLowMetalHit,dMetalHit,dHighMetalHit
	enum dHighMetalHit+1, dHigherMetalHit,dMidMetalHit,dClap,dElectricHighTom
	enum dElectricHighTom+1, dElectricMidTom,dElectricLowTom,dElectricFloorTom
	enum dElectricFloorTom+1, dTightSnare,dMidpitchSnare,dLooseSnare,dLooserSnare
	enum dLooserSnare+1, dHiTimpani,dLowTimpani,dMidTimpani,dQuickLooseSnare
	enum dQuickLooseSnare+1, dClick,dPowerKick,dQuickGlassCrash

	enum dQuickGlassCrash+1, dGlassCrashSnare,dGlassCrash,dGlassCrashKick,dQuietGlassCrash
	enum dQuietGlassCrash+1, dOddSnareKick,dKickExtraBass,dComeOn,dDanceSnare,dLooseKick
	enum dLooseKick+1, dModLooseKick,dWoo,dGo,dSnareGo,dPowerTom,dHiWoodBlock,dLowWoodBlock
	enum dLowWoodBlock+1, dHiHitDrum,dLowHitDrum,dMetalCrashHit,dEchoedClapHit
	enum dEchoedClapHit+1, dLowerEchoedClapHit,dHipHopHitKick,dHipHopHitPowerKick
	enum dHipHopHitPowerKick+1, dBassHey,dDanceStyleKick,dHipHopHitKick2,dHipHopHitKick3
	enum dHipHopHitKick3+1, dReverseFadingWind,dScratch,dLooseSnareNoise,dPowerKick2
	enum dPowerKick2+1, dCrashingNoiseWoo,dQuickHit,dKickHey,dPowerKickHit
	enum dPowerKickHit+1, dLowPowerKickHit,dLowerPowerKickHit,dLowestPowerKickHit
	enum dLowestPowerKickHit+1, dEchoedClapHit2,dLowerEchoedClapHit2
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
saDetune	macro val
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

; E5yyxx or E6xx - Add xx to volume. yy is broken/ignored (VOLUME - VOL_CC_FMP2 / VOL_CC_FM)
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

; E9xx - Set channel pitch to xx (TRANSPOSE - TRNSP_ADD)
ssTransposeS3K	macro val
	dc.b $ED,\val
    endm

; EExxyy - Write yy to YM port 1 reg xx (FM_COMMAND - FMW_FM1)
sYM1cmd		macro reg,val
	dc.b $EE,\reg,\val
    endm

; EFxx[yy] - Set patch id of FM channel to xx. If xx bit7 set, read from another song instead
; (INSTRUMENT - INS_C_FMP)
sPatFM		macro pat, songID
	if narg=2
		dc.b $EF,\pat|$80,\songID+$81
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

; F1xxyy - ?? (MOD_ENV - MENV_FMP)
; F4xx - ?? (MOD_ENV - MENV_GEN)
sModEnv		macro val1,val2
	if narg=1
		dc.b $F4,\val1
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

; FC - Keep SFX looping until stopped(?) (CONT_SFX)
sLoopSFX	macro loc
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
