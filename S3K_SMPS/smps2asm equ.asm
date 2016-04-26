s2e_S3K_SMPS	macro
smpsIsZ80 =		1
smpsUniVoiceBank =	$17D8
smpsNoAttack =		$E7
nMaxPSG1 =		nBb6
nMaxPSG2 =		nB6
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $01, sTone_01,sTone_02,sTone_03,sTone_04,sTone_05,sTone_06
	enum sTone_06+1, sTone_07,sTone_08,sTone_09,sTone_0A,sTone_0B,sTone_0C
	enum sTone_0C+1, sTone_0D,sTone_0E,sTone_0F,sTone_10,sTone_11,sTone_12
	enum sTone_12+1, sTone_13,sTone_14,sTone_15,sTone_16,sTone_17,sTone_18
	enum sTone_18+1, sTone_19,sTone_1A,sTone_1B,sTone_1C,sTone_1D,sTone_1E
	enum sTone_1E+1, sTone_1F,sTone_20,sTone_21,sTone_22,sTone_23,sTone_24
	enum sTone_24+1, sTone_25,sTone_26,sTone_27
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81, dSnareS3,dHighTom,dMidTomS3,dLowTomS3,dFloorTomS3,dKickS3,dMuffledSnare
	enum dMuffledSnare+1, dCrashCymbal,dRideCymbal,dLowMetalHit,dMetalHit,dHighMetalHit
	enum dHighMetalHit+1, dHigherMetalHit,dMidMetalHit,dClapS3,dElectricHighTom
	enum dElectricHighTom+1, dElectricMidTom,dElectricLowTom,dElectricFloorTom
	enum dElectricFloorTom+1, dTightSnare,dMidpitchSnare,dLooseSnare,dLooserSnare
	enum dLooserSnare+1, dHiTimpaniS3,dLowTimpaniS3,dMidTimpaniS3,dQuickLooseSnare
	enum dQuickLooseSnare+1, dClick,dPowerKick,dQuickGlassCrash

	enum dQuickGlassCrash+1, dGlassCrashSnare,dGlassCrash,dGlassCrashKick,dQuietGlassCrash
	enum dQuietGlassCrash+1, dOddSnareKick,dKickExtraBass,dComeOn,dDanceSnare,dLooseKick
	enum dLooseKick+1, dModLooseKick,dWoo,dGo,dSnareGo,dPowerTom,dHiWoodBlock,dLowWoodBlock
	enum dLowWoodBlock+1, dHiHitDrum,dLowHitDrum,dMetalCrashHit,dEchoedClapHit
	enum dEchoedClapHit+1, dLowerEchoedClapHit,dHipHopHitKick,dHipHopHitPowerKick
	enum dHipHopHitPowerKick+1, dBassHey,dDanceStyleKick,dHipHopHitKick2,dHipHopHitKick3
	enum dHipHopHitKick3+1, dReverseFadingWind,dScratchS3,dLooseSnareNoise,dPowerKick2
	enum dPowerKick2+1, dCrashingNoiseWoo,dQuickHit,dKickHey,dPowerKickHit
	enum dPowerKickHit+1, dLowPowerKickHit,dLowerPowerKickHit,dLowestPowerKickHit
	enum dLowestPowerKickHit+1, dEchoedClapHit_S3,dLowerEchoedClapHit_S3
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
