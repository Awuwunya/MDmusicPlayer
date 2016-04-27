s2e_S3K_SMPS	macro
smpsIsZ80 =		1
smpsUniVoiceBank =	$17D8
smpsNoAttack =		$E7
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
	enum VolEnv_23+1, VolEnv_24,VolEnv_25,VolEnv_26,VolEnv_27
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
    endm

s2e_S3K_SMPS_smpsPan	macro direction,amsfms
	dc.b $E0,direction+amsfms
    endm

s2e_S3K_SMPS_smpsAlterNote	macro val
	dc.b $E1,val
    endm

s2e_S3K_SMPS_smpsReturn	macro
	dc.b $F9
    endm

s2e_S3K_SMPS_smpsFade	macro val
	dc.b	$E2
	if narg=1
		dc.b	val
	else
		dc.b	$FF
	endif
    endm

s2e_S3K_SMPS_smpsAlterVol	macro val
	dc.b $E6,val
    endm

s2e_S3K_SMPS_smpsNoteFill	macro val
	dc.b $E8,val
    endm

s2e_S3K_SMPS_smpsAlterPitch	macro val
	dc.b $FB,val
    endm

s2e_S3K_SMPS_smpsSetTempoMod	macro mod
	dc.b $FF,$00,mod
    endm

s2e_S3K_SMPS_smpsSetTempoDiv	macro mod
	dc.b $FF,$04,val
    endm

s2e_S3K_SMPS_smpsSetVol	macro val
	dc.b $E4,val
    endm

s2e_S3K_SMPS_smpsPSGAlterVol	macro vol
	dc.b	$EC,vol
    endm

s2e_S3K_SMPS_smpsSetvoice	macro voice,songID
	if narg=2
		dc.b	$EF,voice|$80,songID+$81
	else
		dc.b	$EF,voice
	endif
    endm

s2e_S3K_SMPS_smpsModSet	macro wait,speed,change,step
	dc.b $F0,wait,speed,change,step
    endm

s2e_S3K_SMPS_smpsModOn	macro
	dc.b $F4,$80
    endm

s2e_S3K_SMPS_smpsStop	macro
	dc.b $F2
    endm

s2e_S3K_SMPS_smpsPSGform	macro form
	dc.b $F3,form
    endm

s2e_S3K_SMPS_smpsModOff	macro
	dc.b $FA
    endm

s2e_S3K_SMPS_smpsPSGvoice	macro voice
	dc.b $F5,voice
    endm

s2e_S3K_SMPS_smpsJump	macro loc
	dc.b $F6
	Z80PtrROM \loc
    endm

s2e_S3K_SMPS_smpsLoop	macro index,loops,loc
	dc.b $F7,index,loops
	Z80PtrROM \loc
    endm

s2e_S3K_SMPS_smpsCall	macro loc
	dc.b $F8
	Z80PtrROM \loc
    endm

s2e_S3K_SMPS_smpsFMAlterVol	macro val1,val2
	if narg=2
		dc.b $E5,val1,val2
	else
		dc.b $E6,val1
	endif
    endm

s2e_S3K_SMPS_smpsStopFM	macro
	dc.b $E3
    endm

s2e_S3K_SMPS_smpsSpindashRev	macro
	dc.b $E9
    endm

s2e_S3K_SMPS_smpsPlayDACSample	macro sample
	dc.b $EA,(sample&$7F)
    endm

s2e_S3K_SMPS_smpsConditionalJump macro index,loc
	dc.b $EB,index
	Z80PtrROM \loc
    endm

s2e_S3K_SMPS_smpsSetNote	macro val
	dc.b $ED,val
    endm

s2e_S3K_SMPS_smpsFMICommand	macro reg,val
	dc.b $EE,reg,val
    endm

s2e_S3K_SMPS_smpsModChange2	macro fmmod,psgmod
	dc.b $F1,fmmod,psgmod
    endm

s2e_S3K_SMPS_smpsModChange	macro val
	dc.b $F4,val
    endm

s2e_S3K_SMPS_smpsContinuousLoop	macro loc
	dc.b $FC
	Z80PtrROM \loc
    endm

s2e_S3K_SMPS_smpsAlternateSMPS	macro flag
	dc.b $FD,flag
    endm

s2e_S3K_SMPS_smpsFM3SpecialMode	macro ind1,ind2,ind3,ind4
	dc.b $FE,ind1,ind2,ind3,ind4
    endm

s2e_S3K_SMPS_smpsPlaySound	macro index
	dc.b $FF,$01,index
    endm

s2e_S3K_SMPS_smpsHaltMusic	macro flag
	dc.b $FF,$02,flag
    endm

s2e_S3K_SMPS_smpsMusPause	macro val
	dc.b $FF,$03,val
    endm

s2e_S3K_SMPS_smpsSSGEG	macro op1,op2,op3,op4
	dc.b $FF,$05,op1,op3,op2,op4
    endm

s2e_S3K_SMPS_smpsFMVolEnv	macro tone,mask
	dc.b $FF,$06,tone,mask
    endm

s2e_S3K_SMPS_smpsFMFlutter	macro tone,mask
	s2e_S3K_SMPS_smpsFMVolEnv tone,mask
    endm

s2e_S3K_SMPS_smpsResetSpindashRev	macro
	dc.b $FF,$07
    endm

s2e_S3K_SMPS_smpsVoice	macro op1,op2,op3,op4
	dc.b	(vcFeedback<<3)+vcAlgorithm
;   0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
vcTLMask4 set ((vcAlgorithm=7)<<7)
vcTLMask3 set ((vcAlgorithm>=4)<<7)
vcTLMask2 set ((vcAlgorithm>=5)<<7)
vcTLMask1 set $80
	dc.b	(vcDT4<<4)+vcCF4, (vcDT3<<4)+vcCF3, (vcDT2<<4)+vcCF2, (vcDT1<<4)+vcCF1
	dc.b	(vcRS4<<6)+vcAR4, (vcRS3<<6)+vcAR3, (vcRS2<<6)+vcAR2, (vcRS1<<6)+vcAR1
	dc.b	(vcAM4<<7)+vcD1R4,(vcAM3<<7)+vcD1R3,(vcAM2<<7)+vcD1R2,(vcAM1<<7)+vcD1R1
	dc.b	vcD2R4,           vcD2R3,           vcD2R2,           vcD2R1
	dc.b	(vcDL4<<4)+vcRR4, (vcDL3<<4)+vcRR3, (vcDL2<<4)+vcRR2, (vcDL1<<4)+vcRR1
	dc.b	vcTL4|vcTLMask4,  vcTL3|vcTLMask3,  vcTL2|vcTLMask2,  vcTL1|vcTLMask1
    endm
