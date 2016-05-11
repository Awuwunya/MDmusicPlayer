s2e_S2_SMPS	macro
smpsIsZ80 =		1
smpsNoAttack =		$E7
nMaxPSG1 =		nBb6
nMaxPSG2 =		nB6
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00,	  VolEnv_00,VolEnv_01,VolEnv_02,VolEnv_03,VolEnv_04,VolEnv_05
	enum VolEnv_05+1, VolEnv_06,VolEnv_07,VolEnv_08,VolEnv_09,VolEnv_0A,VolEnv_0B
	enum VolEnv_0B+1, VolEnv_0C
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81,dKick,dSnare,dClap,dScratch,dTimpani,dHiTom,dVLowClap,dHiTimpani
	enum dHiTimpani+1,dMidTimpani,dLowTimpani,dVLowTimpani,dMidTom,dLowTom
	enum dLowTom+1,dFloorTom,dHiClap,dMidClapdLowClap
    endm

s2e_S2_SMPS_smpsPan	macro direction,amsfms
	dc.b $E0,direction+amsfms
    endm

s2e_S2_SMPS_smpsAlterNote	macro val
	dc.b $E1,val
    endm

s2e_S2_SMPS_smpsSetComm	macro val
	dc.b $E2,val
    endm

s2e_S2_SMPS_smpsReturn	macro
	dc.b $E3
    endm

s2e_S2_SMPS_smpsFadeIn	macro val
	dc.b $E4,val
    endm

s2e_S2_SMPS_smpsChanTempoDiv	macro val
	dc.b $E5,val
    endm

s2e_S2_SMPS_smpsAlterVol	macro val
	dc.b $E6,val
    endm

s2e_S2_SMPS_smpsNoteFill	macro val
	dc.b $E8,val
    endm

s2e_S2_SMPS_smpsAlterPitch	macro val
	dc.b $E9,val
    endm

s2e_S2_SMPS_smpsSetTempoMod	macro mod
	dc.b $EA,mod
    endm

s2e_S2_SMPS_smpsSetTempoDiv	macro mod
	dc.b $EB,val
    endm

s2e_S2_SMPS_smpsPSGAlterVol	macro vol
	dc.b	$EC,vol
    endm

s2e_S2_SMPS_smpsNop	macro
	if narg=1
		dc.b $ED,\1
	else if narg=2
		dc.b $EE,\1,\2
	endif
    endm

s2e_S2_SMPS_smpsSetvoice	macro voice
	dc.b $EF,voice
    endm

s2e_S2_SMPS_smpsModSet	macro wait,speed,change,step
	dc.b $F0,wait,speed,change,step
    endm

s2e_S2_SMPS_smpsModOn	macro
	dc.b $F1
    endm

s2e_S2_SMPS_smpsStop	macro
	dc.b $F2
    endm

s2e_S2_SMPS_smpsPSGform	macro form
	dc.b $F3,form
    endm

s2e_S2_SMPS_smpsModOff	macro
	dc.b $F4
    endm

s2e_S2_SMPS_smpsPSGvoice	macro voice
	dc.b $F5,voice
    endm

s2e_S2_SMPS_smpsJump	macro loc
	dc.b $F6
	Z80PtrROM \loc
    endm

s2e_S2_SMPS_smpsLoop	macro index,loops,loc
	dc.b $F7,index,loops
	Z80PtrROM \loc
    endm

s2e_S2_SMPS_smpsCall	macro loc
	dc.b $F8
	Z80PtrROM \loc
    endm

s2e_S2_SMPS_smpsStopFM	macro
	dc.b $F9
    endm

s2e_S2_SMPS_smpsVoice	macro op1,op2,op3,op4
	dc.b	(vcFeedback<<3)+vcAlgorithm
;   0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
vcTLMask4 set ((vcAlgorithm=7)<<7)
vcTLMask3 set ((vcAlgorithm>=4)<<7)
vcTLMask2 set ((vcAlgorithm>=5)<<7)
vcTLMask1 set $80
	dc.b	(vcDT4<<4)+vcCF4, (vcDT2<<4)+vcCF2, (vcDT3<<4)+vcCF3, (vcDT1<<4)+vcCF1
	dc.b	(vcRS4<<6)+vcAR4, (vcRS2<<6)+vcAR2, (vcRS3<<6)+vcAR3, (vcRS1<<6)+vcAR1
	dc.b	(vcAM4<<7)+vcD1R4,(vcAM2<<7)+vcD1R2,(vcAM3<<7)+vcD1R3,(vcAM1<<7)+vcD1R1
	dc.b	vcD2R4,           vcD2R2,           vcD2R3,           vcD2R1
	dc.b	(vcDL4<<4)+vcRR4, (vcDL2<<4)+vcRR2, (vcDL3<<4)+vcRR3, (vcDL1<<4)+vcRR1
	dc.b	vcTL4|vcTLMask4,  vcTL2|vcTLMask2,  vcTL3|vcTLMask3,  vcTL1|vcTLMask1
    endm
