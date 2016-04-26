s2e_S1_SMPS	macro
smpsIsZ80 =	0
smpsNoAttack =	$E7
nMaxPSG	=	nA5
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00, sTone_00,sTone_01,sTone_02,sTone_03,sTone_04,sTone_05,sTone_06
	enum sTone_06+1, sTone_07,sTone_08,sTone_09
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81, dKick,dSnare,dTimpani
	enum $88, dHiTimpani,dMidTimpani,dLowTimpani,dVLowTimpani
    endm

s2e_S1_SMPS_smpsPan	macro direction,amsfms
	dc.b $E0,direction+amsfms
    endm

s2e_S1_SMPS_smpsAlterNote	macro val
	dc.b $E1,val
    endm

s2e_S1_SMPS_smpsNop	macro arg
	dc.b $E2,arg
    endm

s2e_S1_SMPS_smpsReturn	macro
	dc.b $E3
    endm

s2e_S1_SMPS_smpsFade	macro
	dc.b $E4
    endm

s2e_S1_SMPS_smpsTempoDiv	macro val
	dc.b $E5,val
    endm

s2e_S1_SMPS_smpsFMAlterVol	macro val
	dc.b $E6,val
    endm

s2e_S1_SMPS_smpsNoteFill	macro val
	dc.b $E8,val
    endm

s2e_S1_SMPS_smpsAlterPitch	macro val
	dc.b $E9,val
    endm

s2e_S1_SMPS_smpsSetTempo	macro mod
	dc.b $EA,mod
    endm

s2e_S1_SMPS_smpsSetTempoMod	macro val
	dc.b $EB,val
    endm

s2e_S1_SMPS_smpsPSGAlterVol	macro vol
	dc.b	$EC,vol
    endm

s2e_S1_SMPS_smpsClearPush macro
	dc.b $ED
    endm

s2e_S1_SMPS_smpsStopSpecial macro
	dc.b $EE
    endm

s2e_S1_SMPS_smpsSetvoice	macro voice
	dc.b $EF,voice
    endm

s2e_S1_SMPS_smpsModSet	macro wait,speed,change,step
	dc.b $F0,wait,speed,change,step
    endm

s2e_S1_SMPS_smpsModOn	macro
	dc.b $F1
    endm

s2e_S1_SMPS_smpsStop	macro
	dc.b $F2
    endm

s2e_S1_SMPS_smpsPSGform	macro form
	dc.b $F3,form
    endm

s2e_S1_SMPS_smpsModOff	macro
	dc.b $F4
    endm

s2e_S1_SMPS_smpsPSGvoice	macro voice
	dc.b $F5,voice
    endm

s2e_S1_SMPS_smpsJump	macro loc
	dc.b $F6
	dc.w loc-offset(*)-1
    endm

s2e_S1_SMPS_smpsLoop	macro index,loops,loc
	dc.b $F7,index,loops
	dc.w loc-offset(*)-1
    endm

s2e_S1_SMPS_smpsCall	macro loc
	dc.b $F8
	dc.w loc-offset(*)-1
    endm

s2e_S1_SMPS_smpsWeirdD1LRR	macro val
	dc.b $F9
    endm

s2e_S1_SMPS_smpsVoice	macro
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
