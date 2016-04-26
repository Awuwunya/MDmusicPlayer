GreenHill_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	GreenHill_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $03
	smpsHeaderDAC	GreenHill_DAC
	smpsHeaderFM	GreenHill_FM1, $F4, $12
	smpsHeaderFM	GreenHill_FM2, $00, $0B
	smpsHeaderFM	GreenHill_FM3, $F4, $14
	smpsHeaderFM	GreenHill_FM4, $F4, $08
	smpsHeaderFM	GreenHill_FM5, $F4, $20
	smpsHeaderPSG	GreenHill_PSG1, $D0, $01, $00, sTone_03
	smpsHeaderPSG	GreenHill_PSG2, $D0, $03, $00, sTone_06
	smpsHeaderPSG	GreenHill_PSG3, $00, $03, $00, sTone_04

GreenHill_FM1:
	smpsSetvoice	$02
	smpsPan	 panRight, $00
	smpsCall	GreenHill_Call1
	smpsPan	 panCentre, $00

GreenHill_Loop3:
	smpsPan	 panLeft, $00
	dc.b nE7, $04
	smpsPan	 panRight, $00
	dc.b nC7
	smpsFMAlterVol	$01
	smpsLoop	$00, $0D, GreenHill_Loop3
	dc.b nE7, $04, nRst, $14
	smpsFMAlterVol	$EB
	smpsPan	 panCentre, $00
	dc.b nRst, $40, nRst, nRst, nRst, nRst, nRst

GreenHill_Jump2:
	smpsSetvoice	$06
	smpsModSet	$0D, $01, $07, $04
	smpsAlterPitch	$F4
	dc.b nRst, $20
	smpsCall	GreenHill_Call2
	dc.b nC6, $38
	smpsCall	GreenHill_Call2
	dc.b nC6, $08, $08, nE6
	smpsAlterPitch	$0C
	smpsSetvoice	$06
	smpsAlterPitch	$F4
	dc.b nD6, $34, smpsNoAttack, $34, nC6, $08, nD6, nE6
	dc.b $38, smpsNoAttack, $38, nC6, $08, nC6, nE6, nEb6
	dc.b $34, smpsNoAttack, $34, nC6, $08, nEb6, nD6, $1C
	dc.b smpsNoAttack, $1C
	smpsSetvoice	$05
	smpsAlterPitch	$F4
	smpsFMAlterVol	$0A
	dc.b nRst, $08, nE7, $0C, nRst, $04
	smpsNoteFill	$0B
	dc.b nE7, $08, nF7, nE7, nG7
	smpsNoteFill	$14
	dc.b nE7, $10
	smpsNoteFill	$0B
	dc.b nC7, $08
	smpsNoteFill	$00
	smpsFMAlterVol	$F6
	smpsAlterPitch	$18
	smpsJump	GreenHill_Jump2

GreenHill_Call1:
	dc.b nA6, $04, nF6, nA6, nF6, nB6, nG6, nB6
	dc.b nG6, nC7, nA6, nC7, nA6, nD7, nB6, nD7
	dc.b nB6
	smpsReturn	

GreenHill_Call2:
	dc.b nC7, $08, nA6, $10, nC7, $08, nB6, $10
	dc.b nC7, $08, nB6, $10, nG6, $30, nA6, $08
	dc.b nE7, nD7, $10, nC7, $08, nB6, $10, nC7
	dc.b $08, nB6, $10, nG6, $38, nC7, $08, nA6
	dc.b $10, nC7, $08, nB6, $10, nC7, $08, nB6
	dc.b $10, nG6, $30, nA6, $08, $08, nF6, $10
	dc.b nA6, $08, nG6, $10, nA6, $08, nG6, $10
	smpsReturn	

GreenHill_FM2:
	smpsSetvoice	$00
	smpsNop	$01
	dc.b nRst, $08, nA2, nA3, nA2, nBb2, nBb3, nB2
	dc.b nB3
	smpsNoteFill	$04
	smpsSetvoice	$01

GreenHill_Loop4:
	dc.b nC3, $08
	smpsLoop	$00, $18, GreenHill_Loop4
	smpsNoteFill	$00
	dc.b nC3, $04, nRst, nC3, $08, nA2, $04, nRst
	dc.b nA2, $08, nBb2, $04, nRst, nBb2, $08, nB2
	dc.b $04, nRst, nB2, $08
	smpsNoteFill	$04

GreenHill_Loop5:
	dc.b nC3, $08
	smpsLoop	$00, $1D, GreenHill_Loop5
	smpsNoteFill	$00
	dc.b nC3, nD3, nE3

GreenHill_Jump3:
	smpsSetvoice	$01
	smpsCall	GreenHill_Call3
	smpsCall	GreenHill_Call4
	smpsNoteFill	$00
	dc.b nC3, nD3, nE3
	smpsCall	GreenHill_Call3
	smpsCall	GreenHill_Call4
	dc.b nC3, nC3, nC3
	smpsNoteFill	$00
	smpsSetvoice	$00
	dc.b nBb2, $18, nA2, nG2, nF2, nE2, $08, nRst
	dc.b nD2, nRst, nA2, $18, nB2, nC3, nD3, nE3
	dc.b $08, nRst, nA3, nRst, nAb3, $18, nG3, nF3
	dc.b nEb3, nD3, $08, nRst, nC3, nRst, nG2, $18
	dc.b nD3, nG2, nG3, $08, nE2, nE3, nF2, nF3
	dc.b nG2, nG3
	smpsNoteFill	$04
	smpsNop	$01
	smpsJump	GreenHill_Jump3

GreenHill_Call3:
	smpsNoteFill	$04
	dc.b nF3, $08, nF3, nF3, nF3, nF3, nF3, nF3
	smpsNoteFill	$00
	dc.b nF3
	smpsNoteFill	$04
	dc.b nE3, nE3, nE3, nE3, nE3
	smpsNoteFill	$00
	dc.b nC3, nD3, nE3
	smpsNoteFill	$04
	dc.b nF3, nF3, nF3, nF3, nF3, nF3, nF3
	smpsNoteFill	$00
	dc.b nF3
	smpsNoteFill	$04
	dc.b nE3, nE3, nE3, nE3, nE3
	smpsNoteFill	$00
	dc.b nC3, nD3, nE3
	smpsReturn	

GreenHill_Call4:
	smpsNoteFill	$04
	dc.b nF3, nF3, nF3, nF3, nF3, nF3, nF3
	smpsNoteFill	$00
	dc.b nF3
	smpsNoteFill	$04
	dc.b nE3, nE3, nE3, nE3, nE3, nE3, nE3
	smpsNoteFill	$00
	dc.b nE3
	smpsNoteFill	$04
	dc.b nD3, nD3, nD3, nD3, nD3, nD3, nD3
	smpsNoteFill	$00
	dc.b nD3
	smpsNoteFill	$04
	dc.b nC3, nC3, nC3, nC3, nC3
	smpsReturn	

GreenHill_FM3:
	smpsSetvoice	$02
	smpsPan	 panLeft, $00
	smpsCall	GreenHill_Call1
	smpsSetvoice	$08
	smpsPan	 panCentre, $00
	smpsAlterPitch	$E8
	smpsFMAlterVol	$FE
	dc.b nRst, $01

GreenHill_Loop6:
	dc.b nC6, $01, smpsNoAttack, nB5, $0F, nRst, $08, nBb5
	dc.b $01, smpsNoAttack, nA5, $0F, nRst, $08
	smpsLoop	$00, $02, GreenHill_Loop6
	dc.b nC6, $01, smpsNoAttack, nB5, $07, nRst, $08, nBb5
	dc.b $01, smpsNoAttack, nA5, $07, nRst, $08, nCs6, $01
	dc.b smpsNoAttack, nC6, $0F, nRst, $08, nC6, $01, smpsNoAttack
	dc.b nB5, $0F, nRst, $08, nBb5, $01, smpsNoAttack, nA5
	dc.b $10, smpsNoAttack, $3B, nRst, $04

GreenHill_Loop7:
	dc.b nBb5, $01, smpsNoAttack, nA5, $0F, nRst, $08, nC6
	dc.b $01, smpsNoAttack, nB5, $0F, nRst, $08, nCs6, $01
	dc.b smpsNoAttack, nC6, $07, nRst, $08
	smpsLoop	$00, $02, GreenHill_Loop7
	dc.b nCs6, $01, smpsNoAttack, nC6, $0F, nRst, $08, nC6
	dc.b $01, smpsNoAttack, nB5, $28, smpsNoAttack, $3E
	smpsFMAlterVol	$02
	smpsAlterPitch	$18

GreenHill_Jump4:
	smpsSetvoice	$05
	smpsAlterPitch	$E8
	smpsCall	GreenHill_Call5
	dc.b nA6
	smpsCall	GreenHill_Call5
	dc.b nE7
	smpsCall	GreenHill_Call5
	dc.b nA6, nRst, $24, nRst, nC7, $04, nRst, $0C
	dc.b nA6, $10, nG6, $04, nRst, nA6, nRst, nC7
	dc.b nRst
	smpsModOff	
	smpsSetvoice	$05
	smpsCall	GreenHill_Call6
	dc.b nG6, $04, nA6, nC7, $08, nA6
	smpsCall	GreenHill_Call6
	dc.b nG6, $04, nA6, nC7, $08, nE7
	smpsCall	GreenHill_Call6
	dc.b nG6, $04, nA6, nC7, $08, nA6
	smpsFMAlterVol	$06
	dc.b nC5, nA4, $04, nRst, $16, nRst
	smpsFMAlterVol	$FA
	dc.b nE7, $08, nRst, nC7, nRst, nA6, nA6, nA6
	dc.b $04, nRst, nC7, nRst, nE7, nRst
	smpsAlterPitch	$18
	smpsSetvoice	$07
	smpsPan	 panCentre, $00
	smpsNoteFill	$1E
	smpsFMAlterVol	$06
	dc.b nF5, $18, $18, $18, $18, $08, nRst, nF5
	dc.b nRst, nE5, $18, $18, $18, $18, $08, nRst
	dc.b nE5, nRst, nEb5, $18, $18, $18, $18, $08
	dc.b nRst, nEb5, nRst, nA5, $18, $18, $18, $18
	dc.b $08, nRst, nA5, nRst
	smpsFMAlterVol	$FA
	smpsNoteFill	$00
	smpsJump	GreenHill_Jump4

GreenHill_Call5:
	dc.b nRst, $34, nRst, nG6, $04, nA6, nC7, $08
	smpsReturn	

GreenHill_Call6:
	smpsFMAlterVol	$06
	dc.b nE5, $08, nC5, $04, nRst, $12, nRst, nE5
	dc.b $08, nC5, $04, nRst, nD5, $08, nB4, $04
	dc.b nRst, $0E, nRst
	smpsFMAlterVol	$FA
	smpsReturn	

GreenHill_FM4:
	smpsSetvoice	$08
	dc.b nRst, $20, nRst
	smpsPan	 panLeft, $00
	smpsAlterPitch	$E8
	smpsFMAlterVol	$0A

GreenHill_Loop8:
	dc.b nAb5, $01, smpsNoAttack, nG5, $0F, nRst, $08, nFs5
	dc.b $01, smpsNoAttack, nF5, $0F, nRst, $08
	smpsLoop	$00, $02, GreenHill_Loop8
	dc.b nAb5, $01, smpsNoAttack, nG5, $07, nRst, $08, nFs5
	dc.b $01, smpsNoAttack, nF5, $07, nRst, $08, nBb5, $01
	dc.b smpsNoAttack, nA5, $0F, nRst, $08, nAb5, $01, smpsNoAttack
	dc.b nG5, $0F, nRst, $08, nFs5, $01, smpsNoAttack, nF5
	dc.b $10, smpsNoAttack, $3C, nRst, $04

GreenHill_Loop9:
	dc.b nFs5, $01, smpsNoAttack, nF5, $0F, nRst, $08, nAb5
	dc.b $01, smpsNoAttack, nG5, $0F, nRst, $08, nBb5, $01
	dc.b smpsNoAttack, nA5, $07, nRst, $08
	smpsLoop	$00, $02, GreenHill_Loop9
	dc.b nBb5, $01, smpsNoAttack, nA5, $0F, nRst, $08, nAb5
	dc.b $01, smpsNoAttack, nG5, $28, smpsNoAttack, $3F
	smpsFMAlterVol	$F6
	smpsAlterPitch	$18
	smpsModOff	

GreenHill_Jump5:
	smpsSetvoice	$05
	smpsAlterPitch	$E8
	smpsFMAlterVol	$18
	smpsPan	 panLeft, $00
	smpsFMAlterVol	$FD
	smpsCall	GreenHill_Call7
	dc.b nD5, nD5, nE5, nE5, nC5, nC5, nA4, nA4
	dc.b nF4, nF4, nD5, nD5, nB4, nB4, nG4, nG4
	dc.b nD5, nD5
	smpsCall	GreenHill_Call7
	dc.b nE4, nE4, nC5, nC5, nA4, nA4, nF4, nF4
	dc.b nD4, nD4, nB4, nB4
	smpsFMAlterVol	$03
	smpsAlterPitch	$18
	smpsAlterPitch	$F4
	smpsSetvoice	$04
	dc.b nG6, $10, nA6, nB6
	smpsFMAlterVol	$F9
	dc.b nC7, $28, smpsNoAttack, $28, nD7, $10, nB6, nG6
	dc.b nC7, $28, smpsNoAttack, $28, nB6, $10, nG6, nB6
	dc.b nC7, $28, smpsNoAttack, $28, nD7, $10, nB6, nG6
	dc.b nC7, $40, smpsNoAttack, $40
	smpsAlterPitch	$0C
	smpsFMAlterVol	$07
	smpsFMAlterVol	$E8
	smpsSetvoice	$07
	smpsNoteFill	$1E
	smpsPan	 panCentre, $00
	smpsFMAlterVol	$12
	dc.b nD5, $18, $18, $18, $18, $08, nRst, nD5
	dc.b nRst, nC5, $18, $18, $18, $18, $08, nRst
	dc.b nC5, nRst, nC5, $18, $18, $18, $18, $08
	dc.b nRst, nC5, nRst, nF5, $18, $18, $18, $18
	dc.b $08, nRst, nF5, nRst
	smpsFMAlterVol	$EE
	smpsNoteFill	$00
	smpsJump	GreenHill_Jump5

GreenHill_Call7:
	dc.b nE5, $08, nE5, nC5, nC5, nA4, nA4, nF4
	dc.b nF4, nD5, nD5, nB4, nB4, nG4, nG4
	smpsReturn	

GreenHill_FM5:
	smpsSetvoice	$03
	dc.b nRst, $20, nRst
	smpsSetvoice	$08
	smpsPan	 panRight, $00
	smpsAlterPitch	$E8
	smpsFMAlterVol	$F2

GreenHill_Loop10:
	dc.b nF5, $01, smpsNoAttack, nE5, $0F, nRst, $08, nEb5
	dc.b $01, smpsNoAttack, nD5, $0F, nRst, $08
	smpsLoop	$00, $02, GreenHill_Loop10
	dc.b nF5, $01, smpsNoAttack, nE5, $07, nRst, $08, nEb5
	dc.b $01, smpsNoAttack, nD5, $07, nRst, $08, nFs5, $01
	dc.b smpsNoAttack, nF5, $0F, nRst, $08, nF5, $01, smpsNoAttack
	dc.b nE5, $0F, nRst, $08, nEb5, $01, smpsNoAttack, nD5
	dc.b $10, smpsNoAttack, $3C, nRst, $04

GreenHill_Loop11:
	dc.b nEb5, $01, smpsNoAttack, nD5, $0F, nRst, $08, nF5
	dc.b $01, smpsNoAttack, nE5, $0F, nRst, $08, nFs5, $01
	dc.b smpsNoAttack, nF5, $07, nRst, $08
	smpsLoop	$00, $02, GreenHill_Loop11
	dc.b nFs5, $01, smpsNoAttack, nF5, $0F, nRst, $08, nF5
	dc.b $01, smpsNoAttack, nE5, $28, smpsNoAttack, $3F
	smpsAlterPitch	$18
	smpsFMAlterVol	$0E

GreenHill_Jump6:
	smpsSetvoice	$05
	smpsAlterPitch	$E8
	smpsPan	 panRight, $00
	smpsFMAlterVol	$FD
	smpsCall	GreenHill_Call8
	dc.b nD5, nD5, nE5, nE5, nC5, nC5, nA4, nA4
	dc.b nF4, nF4, nD5, nD5, nB4, nB4, nG4, nG4
	dc.b nD5, nD5
	smpsCall	GreenHill_Call8
	dc.b nE4, nE4, nC5, nC5, nA4, nA4, nF4, nF4
	dc.b nD4, nD4, nB4, nB4
	smpsAlterPitch	$18
	smpsFMAlterVol	$03
	smpsAlterPitch	$F4
	smpsSetvoice	$04
	smpsAlterNote	$02
	dc.b nG6, $10, nA6, nB6
	smpsFMAlterVol	$F9
	dc.b nC7, $28, smpsNoAttack, $28, nD7, $10, nB6, nG6
	dc.b nC7, $28, smpsNoAttack, $28, nB6, $10, nG6, nB6
	dc.b nC7, $28, smpsNoAttack, $28, nD7, $10, nB6, nG6
	dc.b nC7, $40, smpsNoAttack, $40
	smpsAlterPitch	$0C
	smpsAlterNote	$00
	smpsSetvoice	$04
	smpsAlterPitch	$F4
	smpsFMAlterVol	$FA

GreenHill_Loop12:
	dc.b nBb6, $08, nF6, nD7, nF6, nBb6, nF6, nD7
	dc.b nF6
	smpsLoop	$00, $02, GreenHill_Loop12

GreenHill_Loop13:
	dc.b nA6, nE6, nC7, nE6, nA6, nE6, nC7, nE6
	smpsLoop	$00, $02, GreenHill_Loop13

GreenHill_Loop14:
	dc.b nAb6, nEb6, nC7, nEb6, nAb6, nEb6, nC7, nEb6
	smpsLoop	$00, $02, GreenHill_Loop14

GreenHill_Loop15:
	dc.b nC7, nA6, nE7, nA6, nC7, nA6, nE7, nA6
	smpsLoop	$00, $02, GreenHill_Loop15
	smpsFMAlterVol	$0D
	smpsAlterPitch	$0C
	smpsJump	GreenHill_Jump6

GreenHill_Call8:
	dc.b nE5, $08, nE5, nC5, nC5, nA4, nA4, nF4
	dc.b nF4, nD5, nD5, nB4, nB4, nG4, nG4
	smpsReturn	

GreenHill_PSG1:
	smpsPSGvoice	 sTone_05
	smpsModSet	$0E, $01, $01, $03
	dc.b nRst, $40
	smpsNoteFill	$10
	dc.b nE5, $18, nD5, nE5, nD5, nE5, $08, nRst
	dc.b nD5, nRst, nF5, $18, nE5
	smpsNoteFill	$00
	dc.b nD5, $28, smpsNoAttack, $28
	smpsNoteFill	$10
	dc.b nD5, $18, nE5, nF5, $10, nD5, $18, nE5
	dc.b nF5, $10, $18
	smpsNoteFill	$00
	dc.b nE5, $34, smpsNoAttack, $34
	smpsModOff	

GreenHill_Loop17:
GreenHill_Jump7:
	smpsPSGvoice	 sTone_01

GreenHill_Loop16:
	dc.b nRst, $10, nC6, $04, nRst, $14, nC6, $08
	dc.b nRst, $20, nB5, $04, nRst, $14, nB5, $08
	dc.b nRst, $10
	smpsLoop	$01, $03, GreenHill_Loop16
	dc.b nRst, $10, nA5, $04, nRst, $14, nA5, $08
	dc.b nRst, $20, nG5, $04, nRst, $14, nG5, $08
	dc.b nRst, $10
	smpsLoop	$00, $02, GreenHill_Loop17
	smpsPSGvoice	 sTone_05
	dc.b nBb6, $18, nA6, nG6, nF6, nE6, $08, nRst
	dc.b nD6, nRst, nA5, $18, nB5, nC6, nD6, nE6
	dc.b $08, nRst, nA6, nRst, nAb6, $18, nG6, nF6
	dc.b nEb6, nD6, $10, nC6, $08, nRst, nRst, $08
	dc.b nG6, nA6, nG6, $10, $08, nA6, nRst, $10
	smpsPSGAlterVol	$01
	dc.b nA5, $18, $08, nRst, nA5, nRst
	smpsPSGAlterVol	$FF
	smpsPSGvoice	 sTone_03
	smpsJump	GreenHill_Jump7

GreenHill_PSG2:
	dc.b nRst, $40
	smpsPSGAlterVol	$FE

GreenHill_Loop18:
	smpsNoteFill	$06
	dc.b nC7, $08, nB6, nA6, nG6, nC7, nB6, nA6
	dc.b nG6
	smpsLoop	$00, $08, GreenHill_Loop18
	smpsNoteFill	$00

GreenHill_Loop20:
GreenHill_Jump8:
	smpsPSGvoice	 sTone_01

GreenHill_Loop19:
	dc.b nRst, $10, nE6, $04, nRst, $14, nE6, $08
	dc.b nRst, $20, nD6, $04, nRst, $14, nD6, $08
	dc.b nRst, $10
	smpsLoop	$01, $03, GreenHill_Loop19
	dc.b nRst, $10, nC6, $04, nRst, $14, nC6, $08
	dc.b nRst, $20, nB5, $04, nRst, $14, nB5, $08
	dc.b nRst, $10
	smpsLoop	$00, $02, GreenHill_Loop20
	dc.b nD6, $34, smpsNoAttack, $34, nC6, $08, nD6, nE6
	dc.b $38, smpsNoAttack, $38, nC6, $08, nC6, nE6, nEb6
	dc.b $34, smpsNoAttack, $34, nC6, $08, nEb6, nD6
	smpsPSGvoice	 sTone_05
	dc.b nC5, $18, $18, $18, $18, $08, nRst, nC5
	dc.b nRst
	smpsPSGvoice	 sTone_03
	smpsJump	GreenHill_Jump8

GreenHill_PSG3:
	smpsPSGform	$E7
	smpsNoteFill	$06
	dc.b nA5, $10, $10, $10

GreenHill_Jump9:
	dc.b $08
	smpsJump	GreenHill_Jump9

GreenHill_DAC:
	dc.b nRst, $08, dMKick, dMSnare, dMKick, dMKick, dMSnare, dMSnare
	dc.b dMSnare
GreenHill_Loop1:
	dc.b dMKick, $10, dMSnare, $08, dMKick, $10, $08, dMSnare
	dc.b $10
	smpsLoop	$00, $07, GreenHill_Loop1
	dc.b dMKick, $10, dMSnare, $08, dMKick, $10, dMSnare, $08
	dc.b $08, $08

GreenHill_Loop2:
GreenHill_Jump1:
	dc.b dMKick, $10, dMSnare, $08, dMKick, $10, $08, dMSnare
	dc.b $10
	smpsLoop	$00, $07, GreenHill_Loop2
	dc.b dMKick, $10, dMSnare, $08, dMKick, $10, dMSnare, $08
	dc.b $08, $08
	smpsLoop	$01, $02, GreenHill_Loop2
	smpsJump	GreenHill_Jump1

GreenHill_Voices:
	; Voice $00
	; $08
	; $0A, $70, $30, $00,	$1F, $1F, $5F, $5F
	; $12, $0E, $0A, $0A,	$00, $04, $04, $03
	smpsVcAlgorithm	$00
	smpsVcFeedback	$01
	smpsVcDetune	$00, $03, $07, $00
	smpsVcCoarseFreq	$00, $00, $00, $0A
	smpsVcRateScale	$01, $01, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $0A, $0E, $12
	smpsVcDecayRate2	$03, $04, $04, $00
	smpsVcDecayLevel	$02, $02, $02, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $13, $2D, $24

	; Voice $01
	; $20
	; $36, $35, $30, $31,	$DF, $DF, $9F, $9F
	; $07, $06, $09, $06,	$07, $06, $06, $08
	smpsVcAlgorithm	$00
	smpsVcFeedback	$04
	smpsVcDetune	$03, $03, $03, $03
	smpsVcCoarseFreq	$01, $00, $05, $06
	smpsVcRateScale	$02, $02, $03, $03
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$06, $09, $06, $07
	smpsVcDecayRate2	$08, $06, $06, $07
	smpsVcDecayLevel	$0F, $01, $01, $02
	smpsVcReleaseRate	$08, $00, $00, $00
	smpsVcTotalLevel	$00, $13, $37, $19

	; Voice $02
	; $36
	; $0F, $01, $01, $01,	$1F, $1F, $1F, $1F
	; $12, $11, $0E, $00,	$00, $0A, $07, $09
	smpsVcAlgorithm	$06
	smpsVcFeedback	$06
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $01, $0F
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $0E, $11, $12
	smpsVcDecayRate2	$09, $07, $0A, $00
	smpsVcDecayLevel	$00, $01, $00, $0F
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $18

	; Voice $03
	; $3D
	; $01, $02, $02, $02,	$14, $0E, $8C, $0E
	; $08, $05, $02, $05,	$00, $0D, $0D, $0D
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$02, $02, $02, $01
	smpsVcRateScale	$00, $02, $00, $00
	smpsVcAttackRate	$0E, $0C, $0E, $14
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $02, $05, $08
	smpsVcDecayRate2	$0D, $0D, $0D, $00
	smpsVcDecayLevel	$01, $01, $01, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $1A

	; Voice $04
	; $2C
	; $72, $78, $34, $34,	$1F, $12, $1F, $12
	; $00, $0A, $00, $0A,	$00, $00, $00, $00
	smpsVcAlgorithm	$04
	smpsVcFeedback	$05
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$04, $04, $08, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$12, $1F, $12, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $00, $0A, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $00, $01, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $17, $00, $16

	; Voice $05
	; $2C
	; $74, $74, $34, $34,	$1F, $12, $1F, $1F
	; $00, $00, $00, $00,	$00, $01, $00, $01
	smpsVcAlgorithm	$04
	smpsVcFeedback	$05
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$04, $04, $04, $04
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $12, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $00, $00, $00
	smpsVcDecayRate2	$01, $00, $01, $00
	smpsVcDecayLevel	$03, $00, $03, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $17, $00, $16

	; Voice $06
	; $04
	; $72, $42, $32, $32,	$12, $12, $12, $12
	; $00, $08, $00, $08,	$00, $08, $00, $08
	smpsVcAlgorithm	$04
	smpsVcFeedback	$00
	smpsVcDetune	$03, $03, $04, $07
	smpsVcCoarseFreq	$02, $02, $02, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$12, $12, $12, $12
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$08, $00, $08, $00
	smpsVcDecayRate2	$08, $00, $08, $00
	smpsVcDecayLevel	$01, $00, $01, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $23, $00, $23

	; Voice $07
	; $3D
	; $01, $02, $02, $02,	$10, $50, $50, $50
	; $07, $08, $08, $08,	$01, $00, $00, $00
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$02, $02, $02, $01
	smpsVcRateScale	$01, $01, $01, $00
	smpsVcAttackRate	$10, $10, $10, $10
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$08, $08, $08, $07
	smpsVcDecayRate2	$00, $00, $00, $01
	smpsVcDecayLevel	$01, $01, $01, $02
	smpsVcReleaseRate	$07, $07, $07, $00
	smpsVcTotalLevel	$00, $00, $00, $1C

	; Voice $08
	; $2C
	; $74, $74, $34, $34,	$1F, $12, $1F, $1F
	; $00, $07, $00, $07,	$00, $07, $00, $07
	smpsVcAlgorithm	$04
	smpsVcFeedback	$05
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$04, $04, $04, $04
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $12, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$07, $00, $07, $00
	smpsVcDecayRate2	$07, $00, $07, $00
	smpsVcDecayLevel	$03, $00, $03, $00
	smpsVcReleaseRate	$08, $00, $08, $00
	smpsVcTotalLevel	$00, $17, $00, $16
