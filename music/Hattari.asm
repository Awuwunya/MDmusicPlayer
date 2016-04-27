Hattari_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	Hattari_Voices
	smpsHeaderChan	$07, $03
	smpsHeaderTempo	$01, $29
	smpsHeaderDAC	Hattari_DAC
	smpsHeaderFM	Hattari_FM1, $FF, $04
	smpsHeaderFM	Hattari_FM2, $FF, $08
	smpsHeaderFM	Hattari_FM3, $FF, $08
	smpsHeaderFM	Hattari_FM4, $00, $23
	smpsHeaderFM	Hattari_FM5, $00, $23
	smpsHeaderFM	Hattari_FM6, $00, $0D
	smpsHeaderPSG	Hattari_PSG1, $DC, $09, $00, VolEnv_00
	smpsHeaderPSG	Hattari_PSG2, $DC, $09, $00, VolEnv_00
	smpsHeaderPSG	Hattari_PSG3, $00, $02, $00, VolEnv_03

Hattari_PSG3:
	smpsPSGform	$E7
	dc.b nRst, $30, nRst, nRst, $24

Hattari_Loop3:
Hattari_Jump4:
	smpsNoteFill	$01
	dc.b nRst, $12
	smpsPSGvoice	VolEnv_01
	dc.b nA5, $06
	smpsPSGvoice	VolEnv_02
	dc.b nA5
	smpsPSGvoice	VolEnv_04
	dc.b nA5, nA5, nA5
	smpsLoop	$00, $10, Hattari_Loop3
	dc.b nRst, $30, nRst, nRst, nRst
	smpsJump	Hattari_Jump4
	; Unused
	dc.b $F2

Hattari_DAC:
	dc.b nRst, $18, dC1, $12, d81, $06, dBE, $06
	dc.b dBE, dBE, dBE, d8C, $18, d87, $04, d87
	dc.b d87, dBE, $06, dBE, $0C, dBB, $06
Hattari_Jump1:
	dc.b d8B, $12, d81, $06, dBC, $18, nRst, $06
	smpsPan	 panCentre, $00
	dc.b dB6
	smpsPan	 panCentre, $00
	dc.b d8B, $0C, d86, $18, d81, dBE, nRst, $06
	dc.b dB4, d8B, $0C, d86, d96, d8B, $12, d81
	dc.b $06, dBC, $18, nRst, $06
	smpsPan	 panCentre, $00
	dc.b dB6
	smpsPan	 panCentre, $00
	dc.b d8B, $0C, d86, $18, d81, dBE, nRst, $06
	dc.b dB4, d8B, $0C, d86, d96, d8B, $12, d81
	dc.b $06, dBC, $18, nRst, $06
	smpsPan	 panCentre, $00
	dc.b dB6
	smpsPan	 panCentre, $00
	dc.b d8B, $0C, d86, $18, d81, dBE, nRst, $06
	dc.b dB4, d8B, $0C, d86, d96, d8B, $12, d81
	dc.b $06, dBC, $18, nRst, $06
	smpsPan	 panCentre, $00
	dc.b dB6
	smpsPan	 panCentre, $00
	dc.b d8B, $0C, d86, $18, d81, dBE, nRst, $06
	dc.b dB4, d8B, $0C, d86, $06, d86, d96, $0C
	dc.b dB6, $09, nRst, $03, nRst, $0C, dB6, $09
	dc.b nRst, $03, nRst, $0C, dB6, $09, nRst, $03
	dc.b nRst, $0C, dB6, $09, nRst, $03, nRst, $0C
	dc.b dAF, $06, dAF, dAF, dAF, d98, $0C, dAD
	dc.b $06, dAD, dAD, dAD, d96, $0C, dAA, $06
	dc.b dAA, dAA, dAA
	smpsJump	Hattari_Jump1
	; Unused
	dc.b $F2

Hattari_FM1:
	dc.b nRst, $30, nRst, nRst, $24
	smpsAlterNote	$F6
	smpsSetvoice	$06

Hattari_Jump2:
	smpsCall	Hattari_Call1
	smpsNoteFill	$04
	dc.b nG4, $06
	smpsSetvoice	$01
	smpsFMAlterVol	$FB
	smpsNoteFill	$01
	dc.b nG4, $06, nG3
	smpsFMAlterVol	$05
	smpsSetvoice	$06
	smpsNoteFill	$03
	dc.b nG4, $06, nG4, nD4, nE4, nRst, nF4
	smpsSetvoice	$01
	smpsFMAlterVol	$FB
	smpsNoteFill	$01
	dc.b nG3, $06, nG4
	smpsFMAlterVol	$05
	smpsSetvoice	$06
	smpsNoteFill	$03
	dc.b nRst, $06, nRst, $0C
	smpsSetvoice	$01
	smpsFMAlterVol	$FB
	smpsNoteFill	$01
	dc.b nG3, $06, nG4
	smpsFMAlterVol	$05
	smpsFMAlterVol	$FF
	smpsNoteFill	$02
	dc.b nG3, $06
	smpsFMAlterVol	$01
	smpsSetvoice	$06
	smpsNoteFill	$0A
	dc.b nG4, $06
	smpsFMAlterVol	$03
	dc.b nFs4, $03
	smpsFMAlterVol	$04
	dc.b nF4
	smpsFMAlterVol	$04
	dc.b nE4
	smpsFMAlterVol	$05
	dc.b nEb4, $01, nRst, $02
	smpsFMAlterVol	$F0
	smpsNoteFill	$02
	dc.b nD4, $06, nRst, nE4, nRst
	smpsNoteFill	$03
	dc.b nF4, nRst, nF4, nRst
	smpsNoteFill	$00
	dc.b nF4, $06, nF4, $02, smpsNoAttack, nFs4
	smpsModSet	$01, $01, $DD, $88
	dc.b smpsNoAttack, nG4, $06, smpsNoAttack, nFs4, $02
	smpsFMAlterVol	$01
	dc.b smpsNoAttack, nF4
	smpsFMAlterVol	$02
	dc.b smpsNoAttack, nE4
	smpsFMAlterVol	$02
	dc.b smpsNoAttack, nEb4
	smpsModOff
	smpsFMAlterVol	$FB
	smpsCall	Hattari_Call1
	smpsNoteFill	$04
	dc.b nG4, $06
	smpsSetvoice	$01
	smpsFMAlterVol	$FB
	smpsNoteFill	$01
	dc.b nG4, $06, nG3
	smpsFMAlterVol	$05
	smpsSetvoice	$06
	smpsNoteFill	$03
	dc.b nG4, $06, nG4, nD4, nE4, nRst, nF4
	smpsSetvoice	$01
	smpsFMAlterVol	$FB
	smpsNoteFill	$01
	dc.b nG3, $06, nG4
	smpsFMAlterVol	$05
	smpsSetvoice	$06
	smpsNoteFill	$03
	dc.b nRst, $06, nRst, $0C
	smpsSetvoice	$01
	smpsFMAlterVol	$FB
	smpsNoteFill	$01
	dc.b nG3, $06, nG4
	smpsFMAlterVol	$05

Hattari_Loop1:
	smpsFMAlterVol	$FF
	smpsNoteFill	$02
	dc.b nG3, $06
	smpsFMAlterVol	$01
	smpsSetvoice	$06
	smpsNoteFill	$09
	dc.b nG4, $0C
	smpsNoteFill	$03
	dc.b nG4, $06
	smpsAlterPitch	$01
	smpsLoop	$00, $03, Hattari_Loop1
	smpsAlterPitch	$01
	smpsFMAlterVol	$FF
	smpsNoteFill	$02
	dc.b nG3, $06
	smpsFMAlterVol	$01
	smpsSetvoice	$06
	smpsNoteFill	$00
	dc.b nG4, $0C, nFs4, $02, nF4, nE4
	smpsAlterPitch	$FC
	dc.b nRst, $30, nRst, nRst, nRst
	smpsJump	Hattari_Jump2
	; Unused
	dc.b $F2

Hattari_Call1:
	smpsNoteFill	$04
	dc.b nG4, $06
	smpsSetvoice	$01
	smpsFMAlterVol	$FB
	smpsNoteFill	$01
	dc.b nG4, $06, nG3
	smpsFMAlterVol	$05
	smpsSetvoice	$06
	smpsNoteFill	$03
	dc.b nG4, $06, nG4, nD4, nE4, nRst, nF4
	smpsSetvoice	$01
	smpsFMAlterVol	$FB
	smpsNoteFill	$01
	dc.b nG3, $06, nG4
	smpsFMAlterVol	$05
	smpsSetvoice	$06
	smpsNoteFill	$03
	dc.b nRst, $06, nRst, $0C
	smpsSetvoice	$01
	smpsFMAlterVol	$FB
	smpsNoteFill	$01
	dc.b nG3, $06, nG4
	smpsFMAlterVol	$05
	smpsFMAlterVol	$FF
	smpsNoteFill	$02
	dc.b nG3, $06
	smpsFMAlterVol	$01
	smpsSetvoice	$06
	smpsNoteFill	$0A
	dc.b nG4, $06
	smpsFMAlterVol	$03
	dc.b nFs4, $03
	smpsFMAlterVol	$04
	dc.b nF4
	smpsFMAlterVol	$04
	dc.b nE4
	smpsFMAlterVol	$05
	dc.b nEb4, $01, nRst, $02
	smpsFMAlterVol	$F0
	smpsNoteFill	$02
	dc.b nD4, $06, nRst, nE4, nRst
	smpsNoteFill	$03
	dc.b nF4, nRst, $0C, nRst, $06, nRst, $0C
	smpsSetvoice	$01
	smpsFMAlterVol	$FF
	smpsNoteFill	$02
	dc.b nG3, $06, nG4
	smpsFMAlterVol	$01
	smpsSetvoice	$06
	smpsReturn

Hattari_FM2:
	dc.b nRst, $30, nRst, nRst, $24
	smpsAlterNote	$F6
	smpsAlterPitch	$F4
	smpsSetvoice	$08
	dc.b nFs3, $02, nG3, $10
	smpsSetvoice	$07
	dc.b nG4, $06
	smpsNoteFill	$05
	smpsSetvoice	$08
	dc.b nF4, nE4, nB3, nC4, nD4, nCs4, nC4, nB3
	dc.b nBb3
	smpsNoteFill	$00
	dc.b nF3, $12
	smpsNoteFill	$05
	smpsSetvoice	$08
	dc.b nG3, $06, nG3
	smpsSetvoice	$07
	dc.b nG4, $0C
	smpsSetvoice	$08
	dc.b nA3, $06, nA3
	smpsSetvoice	$07
	dc.b nA4, $0C
	smpsSetvoice	$08
	dc.b nBb3, $06, nBb3
	smpsSetvoice	$07
	dc.b nBb4, $0C
	smpsSetvoice	$08
	dc.b nB3, $06
	smpsNoteFill	$00
	smpsSetvoice	$07
	dc.b nB4, $12
	smpsSetvoice	$08
	dc.b nC4, $12
	smpsSetvoice	$07
	dc.b nC5, $06, nRst, nC5, nRst
	smpsNoteFill	$06
	smpsSetvoice	$08
	dc.b nC4
	smpsSetvoice	$07
	dc.b nC5
	smpsSetvoice	$08
	dc.b nC4, nBb4, nB4, nFs4, nG4, nB3, nC4, nD4
	dc.b nD4
	smpsSetvoice	$07
	dc.b nD5
	smpsSetvoice	$08
	dc.b nD4, nE4
	smpsSetvoice	$07
	dc.b nE5
	smpsSetvoice	$08
	dc.b nE4, nE4
	smpsSetvoice	$07
	dc.b nF5
	smpsSetvoice	$08
	dc.b nF4, nF4
	smpsNoteFill	$00
	smpsSetvoice	$07
	dc.b nFs5, $06, smpsNoAttack, $18
	smpsStop

Hattari_FM3:
	dc.b nRst, $30, nRst, nRst, $24
	smpsAlterNote	$F6
	smpsSetvoice	$01

Hattari_Loop2:
Hattari_Jump3:
	smpsNoteFill	$01
	dc.b nG3, $06, nRst, nG3, nG4
	smpsLoop	$00, $20, Hattari_Loop2
	dc.b nRst, $30, nRst, nRst, nRst
	smpsJump	Hattari_Jump3
	; Unused
	dc.b $F2

Hattari_FM4:
	smpsStop

Hattari_FM5:
	smpsStop

Hattari_FM6:
	smpsStop

Hattari_PSG1:
	smpsStop

Hattari_PSG2:
	smpsStop

Hattari_Voices:
	; Voice $00
	; $38
	; $08, $03, $03, $01,	$5F, $5F, $5F, $1F
	; $0A, $0A, $0A, $14,	$00, $00, $00, $05
	smpsVcAlgorithm	$00
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $03, $03, $08
	smpsVcRateScale	$00, $01, $01, $01
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$14, $0A, $0A, $0A
	smpsVcDecayRate2	$05, $00, $00, $00
	smpsVcDecayLevel	$03, $0F, $0F, $0F
	smpsVcReleaseRate	$07, $05, $05, $05
	smpsVcTotalLevel	$00, $23, $1E, $28

	; Voice $01
	; $3C
	; $73, $08, $41, $01,	$8F, $AF, $0F, $AF
	; $10, $1F, $0A, $0F,	$06, $00, $00, $00
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$00, $04, $00, $07
	smpsVcCoarseFreq	$01, $01, $08, $03
	smpsVcRateScale	$02, $00, $02, $02
	smpsVcAttackRate	$0F, $0F, $0F, $0F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0F, $0A, $1F, $10
	smpsVcDecayRate2	$00, $00, $00, $06
	smpsVcDecayLevel	$0F, $0F, $00, $00
	smpsVcReleaseRate	$0F, $0C, $0A, $0F
	smpsVcTotalLevel	$0A, $33, $00, $03

	; Voice $02
	; $38
	; $02, $01, $01, $03,	$1F, $1F, $1F, $1F
	; $0A, $14, $0A, $0C,	$00, $03, $00, $00
	smpsVcAlgorithm	$00
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$03, $01, $01, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0C, $0A, $14, $0A
	smpsVcDecayRate2	$00, $00, $03, $00
	smpsVcDecayLevel	$0F, $0F, $05, $0F
	smpsVcReleaseRate	$07, $05, $07, $05
	smpsVcTotalLevel	$00, $1E, $0A, $1C

	; Voice $03
	; $38
	; $58, $33, $53, $31,	$5F, $5F, $1C, $5F
	; $09, $0A, $06, $02,	$00, $00, $00, $08
	smpsVcAlgorithm	$00
	smpsVcFeedback	$07
	smpsVcDetune	$03, $05, $03, $05
	smpsVcCoarseFreq	$01, $03, $03, $08
	smpsVcRateScale	$01, $00, $01, $01
	smpsVcAttackRate	$1F, $1C, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$02, $06, $0A, $09
	smpsVcDecayRate2	$08, $00, $00, $00
	smpsVcDecayLevel	$00, $0F, $0F, $0F
	smpsVcReleaseRate	$08, $08, $09, $06
	smpsVcTotalLevel	$01, $22, $1D, $27

	; Voice $04
	; $38
	; $05, $07, $02, $01,	$1F, $1F, $1F, $1F
	; $10, $10, $0F, $0A,	$03, $03, $03, $01
	smpsVcAlgorithm	$00
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $02, $07, $05
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $0F, $10, $10
	smpsVcDecayRate2	$01, $03, $03, $03
	smpsVcDecayLevel	$0A, $0F, $0F, $0F
	smpsVcReleaseRate	$08, $02, $03, $03
	smpsVcTotalLevel	$00, $27, $25, $27

	; Voice $05
	; $21
	; $12, $73, $43, $21,	$DC, $5F, $DF, $9F
	; $05, $07, $03, $02,	$04, $04, $04, $01
	smpsVcAlgorithm	$01
	smpsVcFeedback	$04
	smpsVcDetune	$02, $04, $07, $01
	smpsVcCoarseFreq	$01, $03, $03, $02
	smpsVcRateScale	$02, $03, $01, $03
	smpsVcAttackRate	$1F, $1F, $1F, $1C
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$02, $03, $07, $05
	smpsVcDecayRate2	$01, $04, $04, $04
	smpsVcDecayLevel	$01, $02, $02, $0F
	smpsVcReleaseRate	$04, $01, $01, $03
	smpsVcTotalLevel	$00, $23, $25, $2A

	; Voice $06
	; $2A
	; $21, $38, $31, $74,	$BE, $AF, $1F, $1F
	; $15, $14, $02, $05,	$05, $08, $03, $06
	smpsVcAlgorithm	$02
	smpsVcFeedback	$05
	smpsVcDetune	$07, $03, $03, $02
	smpsVcCoarseFreq	$04, $01, $08, $01
	smpsVcRateScale	$00, $00, $02, $02
	smpsVcAttackRate	$1F, $1F, $0F, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $02, $14, $15
	smpsVcDecayRate2	$06, $03, $08, $05
	smpsVcDecayLevel	$06, $00, $03, $03
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$08, $1C, $0C, $51

	; Voice $07
	; $3A
	; $60, $66, $60, $61,	$1F, $94, $DF, $5F
	; $0F, $10, $05, $0D,	$07, $06, $06, $07
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$06, $06, $06, $06
	smpsVcCoarseFreq	$01, $00, $06, $00
	smpsVcRateScale	$01, $03, $02, $00
	smpsVcAttackRate	$1F, $1F, $14, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0D, $05, $10, $0F
	smpsVcDecayRate2	$07, $06, $06, $07
	smpsVcDecayLevel	$05, $01, $04, $05
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $1D, $0E, $1E

	; Voice $08
	; $3A
	; $06, $06, $00, $72,	$12, $12, $12, $1E
	; $00, $00, $00, $08,	$00, $00, $00, $00
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$07, $00, $00, $00
	smpsVcCoarseFreq	$02, $00, $06, $06
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1E, $12, $12, $12
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$08, $00, $00, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $01, $03, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$08, $18, $27, $34
