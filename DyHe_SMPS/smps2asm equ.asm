s2e_DyHe_SMPS	macro
smpsIsZ80 =	0
nMaxPSG =	nA5
smpsNoAttack =	$E7
; ---------------------------------------------------------------------------------------------
; PSG volume envelope equates
	enum $00, sTone_00,sTone_01,sTone_02,sTone_03,sTone_04,sTone_05,sTone_06
	enum sTone_06+1, sTone_07,sTone_08,sTone_09
; ---------------------------------------------------------------------------------------------
; DAC Equates
	enum $81, d81,d82,d83,d84,d85,d86,d87,d88,d89,d8A,d8B,d8C,d8D,d8E,d8F
	enum $90, d90,d91,d92,d93,d94,d95,d96,d97,d98,d99,d9A,d9B,d9C,d9D,d9E,d9F
	enum $A0, dA0,dA1,dA2,dA3,dA4,dA5,dA6,dA7,dA8,dA9,dAA,dAB,dAC,dAD,dAE,dAF
	enum $B0, dB0,dB1,dB2,dB3,dB4,dB5,dB6,dB7,dB8,dB9,dBA,dBB,dBC,dBD,dBE,dBF
	enum $C0, dC0,dC1,dC2,dC3,dC4,dC5,dC6,dC7,dC8
    endm

s2e_DyHe_SMPS_smpsPan	macro direction,amsfms
	dc.b $E0,direction+amsfms
    endm

s2e_DyHe_SMPS_smpsAlterNote	macro val
	dc.b $E1,val
    endm

s2e_DyHe_SMPS_smpsSetComm	macro val
	dc.b $E2,val
    endm

s2e_DyHe_SMPS_smpsStopFM	macro
	dc.b $E3
    endm

s2e_DyHe_SMPS_smpsPanAnim	macro v1, v2, v3, v4, v5
	dc.b $E4
	if narg=1
		dc.b v1
	else
		dc.b v1, v2, v3, v4, v5
	endif
    endm

s2e_DyHe_SMPS_smpsFMAlterVol	macro val1,val2
	if narg=2
		dc.b $E5,val1,val2
	else
		dc.b $E6,val1
	endif
    endm

s2e_DyHe_SMPS_smpsNoteFill	macro val
	dc.b $E8,val
    endm

s2e_DyHe_SMPS_smpsSetLFO	macro val1, val2
	dc.b $E9,val1,val2
    endm

s2e_DyHe_SMPS_smpsSetTempo	macro val
	dc.b $EA,val
    endm

s2e_DyHe_SMPS_smpsPlaySound	macro index
	dc.b $EB,index
    endm

s2e_DyHe_SMPS_smpsPSGAlterVol	macro vol
	dc.b	$EC,vol
    endm

s2e_DyHe_SMPS_smpsFMChnWrite	macro val1, val2
	dc.b	$ED,val1,val2
    endm

s2e_DyHe_SMPS_smpsFMICommand	macro reg,val
	dc.b $EE,reg,val
    endm

s2e_DyHe_SMPS_smpsSetvoice	macro val
	dc.b $EF,val
    endm

s2e_DyHe_SMPS_smpsModSet	macro wait,speed,change,step
	dc.b $F0,wait,speed,change,step
    endm

s2e_DyHe_SMPS_smpsModChange2	macro fmmod,psgmod
	dc.b $F1,fmmod,psgmod
    endm

s2e_DyHe_SMPS_smpsStop	macro
	dc.b $F2
    endm

s2e_DyHe_SMPS_smpsPSGform	macro form
	dc.b $F3,form
    endm

s2e_DyHe_SMPS_smpsModChange	macro val
	dc.b $F4,val
    endm

s2e_DyHe_SMPS_smpsPSGvoice	macro voice
	dc.b $F5,voice
    endm

s2e_DyHe_SMPS_smpsJump	macro loc
	dc.b $F6
	dc.w loc-offset(*)-1
    endm

s2e_DyHe_SMPS_smpsLoop	macro index,loops,loc
	dc.b $F7,index,loops
	dc.w loc-offset(*)-1
    endm

s2e_DyHe_SMPS_smpsCall	macro loc
	dc.b $F8
	dc.w loc-offset(*)-1
    endm

s2e_DyHe_SMPS_smpsReturn	macro
	dc.b $F9
    endm

s2e_DyHe_SMPS_smpsTempoDiv	macro val
	dc.b $FA,val
    endm

s2e_DyHe_SMPS_smpsAlterPitch	macro val
	dc.b $FB,val
    endm

s2e_DyHe_SMPS_smpsModOn	macro
	dc.b $FC
    endm

s2e_DyHe_SMPS_smpsModOff	macro
	dc.b $FD
    endm

s2e_DyHe_SMPS_smpsFM3SpecialMode	macro ind1,ind2,ind3,ind4
	dc.b $FE,ind1,ind2,ind3,ind4
    endm

s2e_DyHe_SMPS_smpsSSGEG	macro op1,op2,op3,op4
	dc.b $FF,$00,op1,op3,op2,op4
    endm

s2e_DyHe_SMPS_smpsMusPause	macro val
	dc.b $FF,$01,val
    endm

s2e_DyHe_SMPS_smpsSetTempoMod	macro mod
	dc.b $FF,$02,mod
    endm

s2e_DyHe_SMPS_smpsFadeinOn	macro val1, val2
	dc.b $FF,$03,val1,val2
    endm

s2e_DyHe_SMPS_smpsFadeinOff	macro
	dc.b $FF,$04
    endm

s2e_DyHe_SMPS_smpsVoice	macro op1,op2,op3,op4
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
