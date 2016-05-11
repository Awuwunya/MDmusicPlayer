s2e_WOI_SMPS	macro
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
; DAC Equates
    endm

s2e_WOI_SMPS_VolQuick	macro vol
	dc.b $D0+(vol&$F)
    endm

s2e_WOI_SMPS_smpsPan	macro direction,amsfms
	dc.b $E0,direction+amsfms
    endm

s2e_WOI_SMPS_smpsAlterNote	macro val
	dc.b $E1,val
    endm

s2e_WOI_SMPS_smpsSetComm	macro val
	dc.b	$E2,val
    endm

s2e_WOI_SMPS_smpsStopFM	macro
	dc.b $E3
    endm

s2e_WOI_SMPS_smpsCondJump macro loc
	dc.b $E4
	Z80PtrROM \loc
    endm

s2e_WOI_SMPS_smpsBaseVolSet	macro vol
	dc.b $E5,vol
    endm

s2e_WOI_SMPS_smpsFMAlterVol	macro val
	dc.b $E6,val
    endm

s2e_WOI_SMPS_smpsNoteFill	macro val
	dc.b $E8,val
    endm

s2e_WOI_SMPS_smpsLF0	macro val1,val2
	dc.b $F9,val1,val2
    endm

s2e_WOI_SMPS_smpsPlayDACSample	macro sample
	dc.b $EA,(sample&$7F)
    endm

s2e_WOI_SMPS_smpsCondJump macro index,loc
	dc.b $EB,index
	Z80PtrROM \loc
    endm

s2e_WOI_SMPS_smpsPSGAlterVol	macro vol
	dc.b	$EC,vol
    endm

s2e_WOI_SMPS_smpsSetTempoMod	macro mod
	dc.b $ED,mod
    endm

s2e_WOI_SMPS_smpsSetTempoDiv	macro mod
	dc.b $EE,val
    endm

s2e_WOI_SMPS_smpsSetvoice	macro voice
	dc.b	$EF,voice
    endm

s2e_WOI_SMPS_smpsModSet	macro wait,speed,change,step
	dc.b $F0,wait,speed,change,step
    endm

s2e_WOI_SMPS_smpsAlterPitch2	macro val
	dc.b $F1,val
    endm

s2e_WOI_SMPS_smpsStop	macro
	dc.b $F2
    endm

s2e_WOI_SMPS_smpsPSGform	macro form
	dc.b $F3,form
    endm

s2e_WOI_SMPS_smpsModOn	macro
	dc.b $F4,$80
    endm

s2e_WOI_SMPS_smpsModChange	macro val
	dc.b $F4,val
    endm

s2e_WOI_SMPS_smpsPSGvoice	macro voice
	dc.b $F5,voice
    endm

s2e_WOI_SMPS_smpsJump	macro loc
	dc.b $F6
	Z80PtrROM \loc
    endm

s2e_WOI_SMPS_smpsLoop	macro index,loops,loc
	dc.b $F7,index,loops
	Z80PtrROM \loc
    endm

s2e_WOI_SMPS_smpsChanTempoDiv	macro mod
	dc.b $FA,val
    endm

s2e_WOI_SMPS_smpsAlterPitch	macro val
	dc.b $FB,val
    endm

s2e_WOI_SMPS_smpsPitchSlide	macro val
	dc.b $FC,val
    endm

s2e_WOI_SMPS_smpsAlternateSMPS	macro flag
	dc.b $FD,flag
    endm

s2e_WOI_SMPS_smpsFM3SpecialMode	macro ind1,ind2,ind3,ind4
	dc.b $FE,ind1,ind2,ind3,ind4
    endm

s2e_WOI_SMPS_smpsVoice	macro op1,op2,op3,op4
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
