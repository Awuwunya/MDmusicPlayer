; NOTE: This port would be more accurate if I enabled custom volume envelopes.
; However, because I restricted myself to stock ones, it sounds a bit different.
; If you want to make it better, copy volume envelope 0A from S3K to Sonic 1.
; It is the file "S3K_SMPS\VolEnv\0A.bin", and must be copied to folder "S1_SMPS\VolEnv\".
; You must then include it after "VolEnv_09" in Sonic 1's 68k.asm and add to the array as "VolEnv_0A".
; Then you must change each v03 to v0A in this file!
InvinciblityK_Header:
	sHeaderInit
	sHeaderPatch	InvinciblityK_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $02
	sHeaderDAC	InvinciblityK_DAC
	sHeaderFM	InvinciblityK_FM1, $00, $15
	sHeaderFM	InvinciblityK_FM2, $00, $0A
	sHeaderFM	InvinciblityK_FM3, $00, $1F
	sHeaderFM	InvinciblityK_FM4, $00, $13
	sHeaderFM	InvinciblityK_FM5, $00, $13
	sHeaderPSG	InvinciblityK_PSG1, $00, $05, $00, v00
	sHeaderPSG	InvinciblityK_PSG2, $00, $05, $00, v00
	sHeaderPSG	InvinciblityK_PSG3, $E8, $01, $00, v00

InvinciblityK_FM1:
	ssMod68k	$14, $01, $06, $06
	ssDetune	$FE
	sPan		spCenter

InvinciblityK_Jump4:
	sPatFM		$00
	dc.b nRst, $18

InvinciblityK_Jump2:
	dc.b nA4, $0C, nFs4, $06, nE4, nA4, nFs4, nD4
	dc.b nE4, sHold, nE4, $12, nD5, $0C
	sGate		$05
	dc.b $06, $06, $06
	sGate		$00
	dc.b nCs5, $0C, nA4, $06, nE4, nFs4, $02, nRst
	dc.b $04, nA4, $0C, nB4, $06, sHold, nB4, $24
	dc.b nRst, $0C
	sJump		InvinciblityK_Jump2
	; Unused
	sStop

InvinciblityK_FM2:
	dc.b nRst, $18
	sPatFM		$01

InvinciblityK_Jump3:
	dc.b nA1, $03, nA1, nRst, nA1, nRst, nA1, nA1
	dc.b sHold, nA1, nFs1, $06, nFs1, sHold, nFs1, nE1
	dc.b nE1, $03, nE1, nRst, nE1, nRst, nE1, nD1
	dc.b sHold, nD1, nRst, nD1, nRst, nD2, sHold, nD2
	dc.b nD1, nD1, nD1, nA1, nA1, nRst, nA1, nRst
	dc.b nA1, nA1, sHold, nA1, nFs1, $06, nFs1, sHold
	dc.b nFs1, nG1, nG1, $03, nG1, nRst, nG1, nRst
	dc.b nG1, nE1, sHold, nE1, nRst, nE1, nRst, nE2
	dc.b sHold, nE2, nE1, nE1, nE1
	sJump		InvinciblityK_Jump3
	; Unused
	sStop

InvinciblityK_FM3:
	dc.b nRst, $0B
	ssDetune	$02
	ssMod68k	$14, $01, $05, $06
	sPan		spLeft
	sJump		InvinciblityK_Jump4
	; Unused
	sStop

InvinciblityK_FM4:
	sPan		spRight
	sPatFM		$02
	dc.b nRst, $18

InvinciblityK_Jump5:
	sGate		$05
	dc.b nRst, $0C, nA5, $12, nA5, nRst, $0C, nB5
	dc.b $12
	sGate		$00
	dc.b nA5
	sGate		$05
	dc.b nRst, $0C, nA5, $12, nA5, nG5, $06
	sGate		$00
	dc.b nG5, $0C, nE5, $18, nRst, $06
	sJump		InvinciblityK_Jump5
	; Unused
	sStop

InvinciblityK_FM5:
	sPan		spLeft
	sPatFM		$02
	dc.b nRst, $18

InvinciblityK_Jump6:
	sGate		$05
	dc.b nRst, $0C, nE5, $12, nE5, nRst, $0C, nE5
	dc.b $12
	sGate		$00
	dc.b nD5
	sGate		$05
	dc.b nRst, $0C, nE5, $12, nE5, nD5, $06
	sGate		$00
	dc.b nD5, $0C, nB4, $18, nRst, $06
	sJump		InvinciblityK_Jump6
	; Unused
	sStop

InvinciblityK_PSG1:
	dc.b nRst, $18
	sVolEnvPSG	v03

InvinciblityK_Jump7:
	dc.b nE4, $06, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nD4, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, $06, nB3, nE4, nB3, nE4, nB3
	dc.b nE4, nB3, nD4, nB3, nD4, nB3, nD5, nB4
	dc.b nD5, nB4, nE4, $06, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, nB3, nD4, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, nB3, nE4, $06, nB3, nE4, nB3
	dc.b nE4, nB3, nE4, nB3, nE3, nG3, nFs3, nA3
	dc.b nAb3, nB3, nB3, nD4
	sJump		InvinciblityK_Jump7
	; Unused
	sStop

InvinciblityK_PSG2:
	dc.b nRst, $18
	sVolEnvPSG	v03
	dc.b nRst, $03

InvinciblityK_Jump8:
	dc.b nCs4, $06, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, $06, nA3, nCs4, nA3, nCs4, nA3
	dc.b nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs5, nA4
	dc.b nCs5, nA4, nCs4, $06, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, $06, nA3, nCs4, nA3
	dc.b nCs4, nA3, nCs4, nA3, nFs3, nA3, nG3, nB3
	dc.b nA3, nCs4, nCs4, nE4
	sJump		InvinciblityK_Jump8
	; Unused
	sStop

InvinciblityK_PSG3:
	sVolEnvPSG	v03
	ssMod68k	$14, $01, $02, $06
	dc.b nRst, $18
	sJump		InvinciblityK_Jump2
	; Unused
	sStop

InvinciblityK_DAC:
	dc.b dSnare, $06, dSnare, dSnare, $03, dSnare, dSnare, dSnare
InvinciblityK_Jump1:
	dc.b dKick, $0C, dSnare, dKick, $06, dKick, dSnare, nRst
	dc.b dKick, $0C, dSnare, $09, $03, dKick, $06, dKick
	dc.b dSnare, nRst, dKick, $0C, dSnare, dKick, $06, dKick
	dc.b dSnare, nRst, dKick, $0C, dSnare, $09, $03, dKick
	dc.b $06, dKick, dSnare, $03, nRst, dSnare, dSnare
	sJump		InvinciblityK_Jump1
	; Unused
	sStop

InvinciblityK_Patches:
	; Patch $00
	; $3D
	; $61, $02, $12, $52,	$1F, $18, $18, $1B
	; $04, $02, $01, $02,	$00, $00, $00, $00
	; $5F, $4F, $3F, $4F,	$17, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$06, $01, $00, $05
	spMultiple	$01, $02, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $18, $18, $1B
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $01, $02, $02
	spSustainLv	$05, $03, $04, $04
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$17, $00, $00, $00

	; Patch $01
	; $2D
	; $01, $51, $31, $21,	$1F, $1F, $1F, $1F
	; $0B, $09, $00, $0B,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$0C, $90, $90, $90
	spAlgorithm	$05
	spFeedback	$05
	spDetune	$00, $03, $05, $02
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0B, $00, $09, $0B
	spSustainLv	$0F, $0F, $0F, $0F
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0C, $10, $10, $10
	; Patch $02
	; $3D
	; $00, $01, $01, $01,	$94, $19, $19, $19
	; $0F, $0D, $0D, $0D,	$07, $04, $04, $04
	; $25, $1A, $1A, $1A,	$10, $84, $84, $84
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $01, $01, $01
	spRateScale	$02, $00, $00, $00
	spAttackRt	$14, $19, $19, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0F, $0D, $0D, $0D
	spSustainLv	$02, $01, $01, $01
	spDecayRt	$07, $04, $04, $04
	spReleaseRt	$05, $0A, $0A, $0A
	spTotalLv	$10, $04, $04, $04
