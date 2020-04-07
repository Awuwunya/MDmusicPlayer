SkySanctuary_Header:
	sHeaderInit						; Z80 offset is $BE80
	sHeaderPatch	SkySanctuary_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $04
	sHeaderDAC	SkySanctuary_DAC
	sHeaderFM	SkySanctuary_FM1, $E8, $0D
	sHeaderFM	SkySanctuary_FM2, $00, $17
	sHeaderFM	SkySanctuary_FM3, $00, $17
	sHeaderFM	SkySanctuary_FM4, $00, $1C
	sHeaderFM	SkySanctuary_FM5, $00, $15
	sHeaderPSG	SkySanctuary_PSG1, $F4, $05, $00, v00
	sHeaderPSG	SkySanctuary_PSG2, $F4, $05, $00, v00
	sHeaderPSG	SkySanctuary_PSG3, $00, $02, $00, v00

SkySanctuary_FM1:
	sPatFM		$00
	ssDetune	$FE

SkySanctuary_Jump1:
	dc.b nG2, $07, nRst, $04, nG2, $08, nRst, $04
	dc.b $24, nG3, nG2, nG2, $0C, nRst, nC3, $14
	dc.b nB2, $10, nG2, $08, nRst, $04, nG2, $08
	dc.b nRst, $04, $24, nG3, nG2, nG2, $0C, nRst
	dc.b $30

SkySanctuary_Loop1:
	dc.b nC3, $60, nC4, $24, nC3, nC4, $18, nBb2
	dc.b $06, nRst, $06, nBb2, $54, nBb3, $24, nBb2
	dc.b nBb3, $18, nA2, $06, nRst, $06, nA2, $48
	dc.b nG3, $06, nAb3, nA3, $24, nA2, nA3, $18
	dc.b nAb2, $06, nRst, $06, nAb2, $54, nAb3, $24
	dc.b nAb2, nBb3, $18
	sLoop		$00, $02, SkySanctuary_Loop1
	dc.b nG2, $48, nG3, $0C, nG3, $48, nG2, $24
	dc.b nAb2, $48, nAb3, $0C, nAb3, $48, nAb2, $0C
	dc.b nAb3, $18, nG2, $48, nG3, $0C, nG3, $48
	dc.b nG2, $24, nAb2, $3C, nAb3, $24, nBb2, $3C
	dc.b nBb3, $24, nC3, $60, nC4, $24, nC3, nC4
	dc.b $18, nBb2, $06, nRst, $06, nBb2, $54, nBb3
	dc.b $24, nBb2, nBb3, $18, nA2, $06, nRst, $06
	dc.b nA2, $48, nG3, $06, nAb3, nA3, $24, nA2
	dc.b nA3, $18, nAb2, $06, nRst, $06, nAb2, $54
	dc.b nBb3, $24, nBb2, nBb3, $18, nRst, $01
	sJump		SkySanctuary_Jump1
	dc.b $F2	; Unused

SkySanctuary_FM2:
	dc.b nRst, $60, nRst, nRst, nRst

SkySanctuary_Loop2:
	sPatFM		$03
	dc.b nC4, $60, sHold, $60, nBb3, sHold, $60, nA3
	dc.b sHold, $60, nAb3, sHold, $60
	sLoop		$00, $02, SkySanctuary_Loop2
	dc.b nG3, sHold, $60, nAb3, sHold, $60, nG3, sHold
	dc.b $60, nAb3, nBb3, nC4, sHold, $60, nBb3, sHold
	dc.b $60, nA3, sHold, $60, nAb3, nBb3
	sJump		SkySanctuary_FM2
	dc.b $F2	; Unused

SkySanctuary_FM3:
	sPatFM		$01
	dc.b nRst, $60, nRst, nF5, $12, nE5, nC5, $0C
	dc.b nC6, $12, nB5, nG5, $0C, nF5, $12, nE5
	saVolFM		$FF
	dc.b nC5, $0C, nRst
	saVolFM		$01
	dc.b nB4, nRst, $18
	sPatFM		$02

SkySanctuary_Loop6:
	sCall		SkySanctuary_Call1
	sLoop		$01, $02, SkySanctuary_Loop6

SkySanctuary_Loop7:
	dc.b nC3, $06, nG1, nC3, nG1, nD3, nG1, nE3
	dc.b nG1, nF3, nG1, nE3, nG1, nD3, nG1, nE3
	dc.b nG1
	sLoop		$00, $02, SkySanctuary_Loop7

SkySanctuary_Loop8:
	dc.b nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nF3, nAb1, nE3, nAb1, nD3, nAb1, nE3
	dc.b nAb1
	sLoop		$00, $02, SkySanctuary_Loop8

SkySanctuary_Loop9:
	dc.b nC3, $06, nG1, nC3, nG1, nD3, nG1, nE3
	dc.b nG1, nF3, nG1, nE3, nG1, nD3, nG1, nE3
	dc.b nG1
	sLoop		$00, $02, SkySanctuary_Loop9
	dc.b nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nF3, nAb1, nE3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nC3, $06, nBb1, nC3, nBb1, nD3, nBb1
	dc.b nE3, nBb1, nF3, nBb1, nE3, nBb1, nD3, nBb1
	dc.b nE3, nBb1
	sCall		SkySanctuary_Call1
	sJump		SkySanctuary_FM3
	dc.b $F2	; Unused

SkySanctuary_Call1:
	sPatFM		$02
	dc.b nC3, $06, nC2, nC3, nC2, nD3, nC2, nE3
	dc.b nC2, nF3, nC2, nE3, nC2, nD3, nC2, nE3
	dc.b nC2
	sLoop		$00, $02, SkySanctuary_Call1

SkySanctuary_Loop3:
	sPatFM		$02
	dc.b nC3, $06, nBb1, nC3, nBb1, nD3, nBb1, nE3
	dc.b nBb1, nF3, nBb1, nE3, nBb1, nD3, nBb1, nE3
	dc.b nBb1
	sLoop		$00, $02, SkySanctuary_Loop3

SkySanctuary_Loop4:
	sPatFM		$02
	dc.b nC3, $06, nA1, nC3, nA1, nD3, nA1, nE3
	dc.b nA1, nF3, nA1, nE3, nA1, nD3, nA1, nE3
	dc.b nA1
	sLoop		$00, $02, SkySanctuary_Loop4

SkySanctuary_Loop5:
	sPatFM		$02
	dc.b nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nF3, nAb1, nE3, nAb1, nD3, nAb1, nE3
	dc.b nAb1
	sLoop		$00, $02, SkySanctuary_Loop5
	sRet

SkySanctuary_FM5:
	ssModZ80	$24, $01, $04, $08
	sPatFM		$01

SkySanctuary_Jump2:
	dc.b nC5, $12, nB4, nG4, $0C, nG5, $12, nF5
	dc.b nE5, $0C
	sLoop		$00, $03, SkySanctuary_Jump2
	dc.b nC5, $12, nB4
	saVolFM		$FF
	dc.b nG4, $0C, nRst
	saVolFM		$01
	dc.b nG4, nRst, $18
	saVolFM		$FD

SkySanctuary_Loop10:
	dc.b nC6, $07, nRst, $05, nC6, $48, nC5, $06
	dc.b nE5, nF5, $24, nE5, $18, nC5, $24
	sLoop		$00, $02, SkySanctuary_Loop10
	dc.b nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst
	dc.b nRst, nF4, nRst, nRst, nA4, $24, nA4, $18
	dc.b nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b $18, nC5, $0C, nD5, nEb5, $18, nD5, $0C
	dc.b nC5, $18

SkySanctuary_Loop11:
	dc.b nC6, $06, nRst, nC6, $48, nC5, $06, nE5
	dc.b nF5, $24, nE5, $18, nC5, $24
	sLoop		$00, $02, SkySanctuary_Loop11
	dc.b nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst
	dc.b nRst, nF4, nRst, nRst, nA4, $24, nA4, $18
	dc.b nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b $18, nC5, $0C, nD5, nEb5, $18, nD5, $0C
	dc.b nF5, $18
	saVolFM		$FF
	dc.b nG5, $24, nEb6, nD6, $07, nRst, $05, $18
	dc.b nG5, $54, nAb5, $24, nEb6, nD6, $07, nRst
	dc.b $05, $18, nF6, $24, nEb6, $18, nD6, nG5
	dc.b $24, nEb6, nD6, $07, nRst, $05, $18, nG5
	dc.b $54, nAb5, $24, nC6, nEb6, $18, nG6, nF6
	dc.b $0C, nEb6, $18, nF6, $24, nC6, $54, nC5
	dc.b $06, nE5, nF5, $24, nE5, $18, nC5, $24
	saVolFM		$FF
	dc.b nC6, $54, nC6, $06, nE6, nF6, $24, nE6
	dc.b $18, nC6, $24
	saVolFM		$FF
	dc.b nG6, $0C, nC6, $07, nRst, $05, nRst, $24
	dc.b nC6, $0C, nG6, nC6, $07, nRst, $05, nRst
	dc.b $0C, nC6, nRst, nC6, nG6, nC6, nRst, nC6
	saVolFM		$FF
	dc.b nBb6, $24, nAb6, nG6, nF6, nEb6, $18, nF6
	saVolFM		$07
	sJump		SkySanctuary_Jump2
	dc.b $F2	; Unused

SkySanctuary_FM4:
	ssModZ80	$24, $01, $04, $07
	ssDetune	$02
	sPatFM		$01
	dc.b nRst, $0E
	sJump		SkySanctuary_Jump2
	dc.b $F2	; Unused

SkySanctuary_PSG1:
	sVolEnvPSG	v04

SkySanctuary_Loop12:
	dc.b nG4, $06, nF4, nC4, nF4
	sLoop		$00, $0E, SkySanctuary_Loop12
	dc.b nRst, $0C, nB3, nRst, $18

SkySanctuary_Loop13:
	sCall		SkySanctuary_Call2
	sLoop		$00, $08, SkySanctuary_Loop13
	saTranspose	$07
	sCall		SkySanctuary_Call2
	saTranspose	$01
	sCall		SkySanctuary_Call2
	saTranspose	$FF
	sCall		SkySanctuary_Call2
	saTranspose	$F9
	sCall		SkySanctuary_Call2

SkySanctuary_Loop14:
	sCall		SkySanctuary_Call2
	sLoop		$00, $04, SkySanctuary_Loop14
	sJump		SkySanctuary_Loop12
	dc.b $F2	; Unused

SkySanctuary_Call2:
	dc.b nC5, $06, nC4, nC5, nC4, nC5, nC4, nC5
	dc.b nC4, nC6, nC4, nC6, nC4, nC5, nC4, nC5
	dc.b nC4
	sLoop		$01, $02, SkySanctuary_Call2
	sRet

SkySanctuary_PSG2:
	sStop

SkySanctuary_PSG3:
	sNoisePSG	$E7

SkySanctuary_Jump3:
	sVolEnvPSG	v01
	dc.b nB6, $06, nB6
	sVolEnvPSG	v04
	dc.b nB6, $0C
	sJump		SkySanctuary_Jump3
	dc.b $F2	; Unused

SkySanctuary_DAC:
	sPan		spCenter
	dc.b nRst, $60, nRst, nRst, nRst, $17, nRst, $0C
	dc.b dSnare, nRst, dSnare, nRst, dKick, $06, dKick

SkySanctuary_Loop15:
	sPan		spCenter
	dc.b dKick, $05, dKick, dKick, $0E, nRst, $0C, dKickSnare
	dc.b $05, dKickSnare, dKickSnare, $0E, dKickSnare, $0C, nRst, dKick
	dc.b $06, dKick, dKick, $0C, dKick, nRst, dKickSnare, $05
	dc.b dKickSnare, dKickSnare, $0E, dKickSnare, $0C, nRst, dKick, dKick
	dc.b $0C, dKick, nRst, dKickSnare, $05, dKickSnare, dKickSnare, $0E
	dc.b dKickSnare, $0C, nRst, dKick, $06, dKick, dKick, $0C
	dc.b dKick, nRst, dKickSnare, $05, dKickSnare, dKickSnare, $08
	sPan		spLeft
	dc.b dMidElecTom, $06, dMidElecTom, dMidElecTom
	sPan		spCenter
	dc.b dLowElecTom, dLowElecTom
	sPan		spRight
	dc.b dLowerElecTom, nRst
	sLoop		$00, $08, SkySanctuary_Loop15
	dc.b nRst, $01
	sJump		SkySanctuary_DAC
	dc.b $F2	; Unused

SkySanctuary_Patches:

	; Patch $00
	; $34
	; $02, $02, $02, $02,	$1F, $5F, $1F, $5F
	; $0E, $00, $12, $00,	$00, $08, $02, $08
	; $4F, $0F, $4F, $0F,	$12, $80, $12, $80
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $02, $02, $02
	spRateScale	$00, $00, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $12, $00, $00
	spSustainLv	$04, $04, $00, $00
	spDecayRt	$00, $02, $08, $08
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$12, $12, $00, $00

	; Patch $01
	; $3D
	; $01, $01, $01, $11,	$1C, $18, $18, $1B
	; $06, $05, $04, $05,	$06, $05, $06, $06
	; $60, $89, $59, $79,	$18, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $01
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1C, $18, $18, $1B
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$06, $04, $05, $05
	spSustainLv	$06, $05, $08, $07
	spDecayRt	$06, $06, $05, $06
	spReleaseRt	$00, $09, $09, $09
	spTotalLv	$18, $00, $00, $00

	; Patch $02
	; $3D
	; $02, $01, $01, $11,	$1C, $18, $18, $1B
	; $06, $05, $04, $05,	$06, $05, $06, $06
	; $6F, $8F, $5F, $7F,	$18, $88, $88, $88
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $01
	spMultiple	$02, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1C, $18, $18, $1B
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$06, $04, $05, $05
	spSustainLv	$06, $05, $08, $07
	spDecayRt	$06, $06, $05, $06
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $08, $08, $08

	; Patch $03
	; $04
	; $02, $02, $03, $03,	$13, $10, $13, $10
	; $06, $0C, $06, $0C,	$00, $00, $00, $00
	; $4F, $2F, $4F, $2F,	$18, $90, $18, $90
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $03, $02, $03
	spRateScale	$00, $00, $00, $00
	spAttackRt	$13, $13, $10, $10
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$06, $06, $0C, $0C
	spSustainLv	$04, $04, $02, $02
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $18, $10, $10
