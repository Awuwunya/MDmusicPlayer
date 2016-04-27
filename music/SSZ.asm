SkySanctuary_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	SkySanctuary_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $04
	smpsHeaderDAC	SkySanctuary_DAC
	smpsHeaderFM	SkySanctuary_FM1, $E8, $0D
	smpsHeaderFM	SkySanctuary_FM2, $00, $17
	smpsHeaderFM	SkySanctuary_FM3, $00, $17
	smpsHeaderFM	SkySanctuary_FM4, $00, $1C
	smpsHeaderFM	SkySanctuary_FM5, $00, $15
	smpsHeaderPSG	SkySanctuary_PSG1, $F4, $05, $00, VolEnv_00
	smpsHeaderPSG	SkySanctuary_PSG2, $F4, $05, $00, VolEnv_00
	smpsHeaderPSG	SkySanctuary_PSG3, $00, $02, $00, VolEnv_00

SkySanctuary_FM1:
	smpsSetvoice	$00
	smpsAlterNote	$FE

SkySanctuary_Jump2:
	dc.b nG2, $07, nRst, $04, nG2, $08, nRst, $04
	dc.b $24, nG3, nG2, nG2, $0C, nRst, nC3, $14
	dc.b nB2, $10, nG2, $08, nRst, $04, nG2, $08
	dc.b nRst, $04, $24, nG3, nG2, nG2, $0C, nRst
	dc.b $30
SkySanctuary_Loop2:
	dc.b nC3, $60, nC4, $24, nC3, nC4, $18, nBb2
	dc.b $06, nRst, $06, nBb2, $54, nBb3, $24, nBb2
	dc.b nBb3, $18, nA2, $06, nRst, $06, nA2, $48
	dc.b nG3, $06, nAb3, nA3, $24, nA2, nA3, $18
	dc.b nAb2, $06, nRst, $06, nAb2, $54, nAb3, $24
	dc.b nAb2, nBb3, $18
	smpsLoop	$00, $02, SkySanctuary_Loop2
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
	smpsJump	SkySanctuary_Jump2
	; Unused
	dc.b $F2

SkySanctuary_FM2:
SkySanctuary_Jump3:
	dc.b nRst, $60, nRst, nRst, nRst
SkySanctuary_Loop3:
	smpsSetvoice	$03
	dc.b nC4, $60, smpsNoAttack, $60, nBb3, smpsNoAttack, $60, nA3
	dc.b smpsNoAttack, $60, nAb3, smpsNoAttack, $60
	smpsLoop	$00, $02, SkySanctuary_Loop3
	dc.b nG3, smpsNoAttack, $60, nAb3, smpsNoAttack, $60, nG3, smpsNoAttack
	dc.b $60, nAb3, nBb3, nC4, smpsNoAttack, $60, nBb3, smpsNoAttack
	dc.b $60, nA3, smpsNoAttack, $60, nAb3, nBb3
	smpsJump	SkySanctuary_Jump3
	; Unused
	dc.b $F2

SkySanctuary_FM3:
SkySanctuary_Jump4:
	smpsSetvoice	$01
	dc.b nRst, $60, nRst, nF5, $12, nE5, nC5, $0C
	dc.b nC6, $12, nB5, nG5, $0C, nF5, $12, nE5
	smpsFMAlterVol	$FF
	dc.b nC5, $0C, nRst
	smpsFMAlterVol	$01
	dc.b nB4, nRst, $18
	smpsSetvoice	$02

SkySanctuary_Loop8:
	smpsCall	SkySanctuary_Call1
	smpsLoop	$01, $02, SkySanctuary_Loop8

SkySanctuary_Loop9:
	dc.b nC3, $06, nG1, nC3, nG1, nD3, nG1, nE3
	dc.b nG1, nF3, nG1, nE3, nG1, nD3, nG1, nE3
	dc.b nG1
	smpsLoop	$00, $02, SkySanctuary_Loop9

SkySanctuary_Loop10:
	dc.b nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nF3, nAb1, nE3, nAb1, nD3, nAb1, nE3
	dc.b nAb1
	smpsLoop	$00, $02, SkySanctuary_Loop10

SkySanctuary_Loop11:
	dc.b nC3, $06, nG1, nC3, nG1, nD3, nG1, nE3
	dc.b nG1, nF3, nG1, nE3, nG1, nD3, nG1, nE3
	dc.b nG1
	smpsLoop	$00, $02, SkySanctuary_Loop11
	dc.b nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nF3, nAb1, nE3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nC3, $06, nBb1, nC3, nBb1, nD3, nBb1
	dc.b nE3, nBb1, nF3, nBb1, nE3, nBb1, nD3, nBb1
	dc.b nE3, nBb1
	smpsCall	SkySanctuary_Call1
	smpsJump	SkySanctuary_Jump4
	; Unused
	dc.b $F2

SkySanctuary_Call1:
SkySanctuary_Loop4:
	smpsSetvoice	$02
	dc.b nC3, $06, nC2, nC3, nC2, nD3, nC2, nE3
	dc.b nC2, nF3, nC2, nE3, nC2, nD3, nC2, nE3
	dc.b nC2
	smpsLoop	$00, $02, SkySanctuary_Loop4

SkySanctuary_Loop5:
	smpsSetvoice	$02
	dc.b nC3, $06, nBb1, nC3, nBb1, nD3, nBb1, nE3
	dc.b nBb1, nF3, nBb1, nE3, nBb1, nD3, nBb1, nE3
	dc.b nBb1
	smpsLoop	$00, $02, SkySanctuary_Loop5

SkySanctuary_Loop6:
	smpsSetvoice	$02
	dc.b nC3, $06, nA1, nC3, nA1, nD3, nA1, nE3
	dc.b nA1, nF3, nA1, nE3, nA1, nD3, nA1, nE3
	dc.b nA1
	smpsLoop	$00, $02, SkySanctuary_Loop6

SkySanctuary_Loop7:
	smpsSetvoice	$02
	dc.b nC3, $06, nAb1, nC3, nAb1, nD3, nAb1, nE3
	dc.b nAb1, nF3, nAb1, nE3, nAb1, nD3, nAb1, nE3
	dc.b nAb1
	smpsLoop	$00, $02, SkySanctuary_Loop7
	smpsReturn

SkySanctuary_FM5:
	smpsModSet	$24, $01, $04, $08
	smpsSetvoice	$01

SkySanctuary_Jump5:
SkySanctuary_Loop12:
	dc.b nC5, $12, nB4, nG4, $0C, nG5, $12, nF5
	dc.b nE5, $0C
	smpsLoop	$00, $03, SkySanctuary_Loop12
	dc.b nC5, $12, nB4
	smpsFMAlterVol	$FF
	dc.b nG4, $0C, nRst
	smpsFMAlterVol	$01
	dc.b nG4, nRst, $18
	smpsFMAlterVol	$FD

SkySanctuary_Loop13:
	dc.b nC6, $07, nRst, $05, nC6, $48, nC5, $06
	dc.b nE5, nF5, $24, nE5, $18, nC5, $24
	smpsLoop	$00, $02, SkySanctuary_Loop13
	dc.b nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst
	dc.b nRst, nF4, nRst, nRst, nA4, $24, nA4, $18
	dc.b nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b $18, nC5, $0C, nD5, nEb5, $18, nD5, $0C
	dc.b nC5, $18

SkySanctuary_Loop14:
	dc.b nC6, $06, nRst, nC6, $48, nC5, $06, nE5
	dc.b nF5, $24, nE5, $18, nC5, $24
	smpsLoop	$00, $02, SkySanctuary_Loop14
	dc.b nRst, $0C, nRst, nA4, nRst, nRst, nC5, nRst
	dc.b nRst, nF4, nRst, nRst, nA4, $24, nA4, $18
	dc.b nRst, $24, nAb4, $0C, nC5, nBb4, nAb4, nEb5
	dc.b $18, nC5, $0C, nD5, nEb5, $18, nD5, $0C
	dc.b nF5, $18
	smpsFMAlterVol	$FF
	dc.b nG5, $24, nEb6, nD6, $07, nRst, $05, $18
	dc.b nG5, $54, nAb5, $24, nEb6, nD6, $07, nRst
	dc.b $05, $18, nF6, $24, nEb6, $18, nD6, nG5
	dc.b $24, nEb6, nD6, $07, nRst, $05, $18, nG5
	dc.b $54, nAb5, $24, nC6, nEb6, $18, nG6, nF6
	dc.b $0C, nEb6, $18, nF6, $24, nC6, $54, nC5
	dc.b $06, nE5, nF5, $24, nE5, $18, nC5, $24
	smpsFMAlterVol	$FF
	dc.b nC6, $54, nC6, $06, nE6, nF6, $24, nE6
	dc.b $18, nC6, $24
	smpsFMAlterVol	$FF
	dc.b nG6, $0C, nC6, $07, nRst, $05, nRst, $24
	dc.b nC6, $0C, nG6, nC6, $07, nRst, $05, nRst
	dc.b $0C, nC6, nRst, nC6, nG6, nC6, nRst, nC6
	smpsFMAlterVol	$FF
	dc.b nBb6, $24, nAb6, nG6, nF6, nEb6, $18, nF6
	smpsFMAlterVol	$07
	smpsJump	SkySanctuary_Jump5
	; Unused
	dc.b $F2

SkySanctuary_FM4:
	smpsModSet	$24, $01, $04, $07
	smpsAlterNote	$02
	smpsSetvoice	$01
	dc.b nRst, $0E
	smpsJump	SkySanctuary_Jump5
	; Unused
	dc.b $F2

SkySanctuary_PSG1:
	smpsPSGvoice	VolEnv_04

SkySanctuary_Loop15:
SkySanctuary_Jump6:
	dc.b nG4, $06, nF4, nC4, nF4
	smpsLoop	$00, $0E, SkySanctuary_Loop15
	dc.b nRst, $0C, nB3, nRst, $18

SkySanctuary_Loop17:
	smpsCall	SkySanctuary_Call2
	smpsLoop	$00, $08, SkySanctuary_Loop17
	smpsAlterPitch	$07
	smpsCall	SkySanctuary_Call2
	smpsAlterPitch	$01
	smpsCall	SkySanctuary_Call2
	smpsAlterPitch	$FF
	smpsCall	SkySanctuary_Call2
	smpsAlterPitch	$F9
	smpsCall	SkySanctuary_Call2

SkySanctuary_Loop18:
	smpsCall	SkySanctuary_Call2
	smpsLoop	$00, $04, SkySanctuary_Loop18
	smpsJump	SkySanctuary_Jump6
	; Unused
	dc.b $F2

SkySanctuary_Call2:
SkySanctuary_Loop16:
	dc.b nC5, $06, nC4, nC5, nC4, nC5, nC4, nC5
	dc.b nC4, nC6, nC4, nC6, nC4, nC5, nC4, nC5
	dc.b nC4
	smpsLoop	$01, $02, SkySanctuary_Loop16
	smpsReturn

SkySanctuary_PSG2:
	smpsStop

SkySanctuary_PSG3:
	smpsPSGform	$E7

SkySanctuary_Jump7:
	smpsPSGvoice	VolEnv_01
	dc.b nB6, $06, nB6
	smpsPSGvoice	VolEnv_04
	dc.b nB6, $0C
	smpsJump	SkySanctuary_Jump7
	; Unused
	dc.b $F2

SkySanctuary_DAC:
SkySanctuary_Jump1:
	smpsPan	 panCentre, $00
	dc.b nRst, $60, nRst, nRst, nRst, $17, nRst, $0C
	dc.b dSnare, nRst, dSnare, nRst, dKick, $06, dKick

SkySanctuary_Loop1:
	smpsPan	 panCentre, $00
	dc.b dKick, $05, dKick, dKick, $0E, nRst, $0C, dMuffledSnare
	dc.b $05, dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKick
	dc.b $06, dKick, dKick, $0C, dKick, nRst, dMuffledSnare, $05
	dc.b dMuffledSnare, dMuffledSnare, $0E, dMuffledSnare, $0C, nRst, dKick, dKick
	dc.b $0C, dKick, nRst, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $0E
	dc.b dMuffledSnare, $0C, nRst, dKick, $06, dKick, dKick, $0C
	dc.b dKick, nRst, dMuffledSnare, $05, dMuffledSnare, dMuffledSnare, $08
	smpsPan	 panLeft, $00
	dc.b dElectricMidTom, $06, dElectricMidTom, dElectricMidTom
	smpsPan	 panCentre, $00
	dc.b dElectricLowTom, dElectricLowTom
	smpsPan	 panRight, $00
	dc.b dElectricFloorTom, nRst
	smpsLoop	$00, $08, SkySanctuary_Loop1
	dc.b nRst, $01
	smpsJump	SkySanctuary_Jump1
	; Unused
	dc.b $F2

SkySanctuary_Voices:
	; Voice $00
	; $34
	; $02, $02, $02, $02,	$1F, $5F, $1F, $5F
	; $0E, $00, $12, $00,	$00, $08, $02, $08
	smpsVcAlgorithm	$04
	smpsVcFeedback	$06
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$02, $02, $02, $02
	smpsVcRateScale	$01, $00, $01, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $12, $00, $0E
	smpsVcDecayRate2	$08, $02, $08, $00
	smpsVcDecayLevel	$00, $04, $00, $04
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $12, $00, $12

	; Voice $01
	; $3D
	; $01, $01, $01, $11,	$1C, $18, $18, $1B
	; $06, $05, $04, $05,	$06, $05, $06, $06
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$01, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $01, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1B, $18, $18, $1C
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $04, $05, $06
	smpsVcDecayRate2	$06, $06, $05, $06
	smpsVcDecayLevel	$07, $05, $08, $06
	smpsVcReleaseRate	$09, $09, $09, $00
	smpsVcTotalLevel	$00, $00, $00, $18

	; Voice $02
	; $3D
	; $02, $01, $01, $11,	$1C, $18, $18, $1B
	; $06, $05, $04, $05,	$06, $05, $06, $06
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$01, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $01, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1B, $18, $18, $1C
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $04, $05, $06
	smpsVcDecayRate2	$06, $06, $05, $06
	smpsVcDecayLevel	$07, $05, $08, $06
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$08, $08, $08, $18

	; Voice $03
	; $04
	; $02, $02, $03, $03,	$13, $10, $13, $10
	; $06, $0C, $06, $0C,	$00, $00, $00, $00
	smpsVcAlgorithm	$04
	smpsVcFeedback	$00
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$03, $03, $02, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$10, $13, $10, $13
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0C, $06, $0C, $06
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$02, $04, $02, $04
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$10, $18, $10, $18
