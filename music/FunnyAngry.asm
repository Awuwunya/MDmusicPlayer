FunnyAngry_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	FunnyAngry_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $18
	smpsHeaderDAC	FunnyAngry_DAC
	smpsHeaderFM	FunnyAngry_FM1, $00, $0E
	smpsHeaderFM	FunnyAngry_FM2, $00, $10
	smpsHeaderFM	FunnyAngry_FM3, $0C, $02
	smpsHeaderFM	FunnyAngry_FM4, $00, $18
	smpsHeaderFM	FunnyAngry_FM5, $00, $0F
	smpsHeaderPSG	FunnyAngry_PSG1, $DC, $02, $00, sTone_00
	smpsHeaderPSG	FunnyAngry_PSG2, $DC, $01, $00, sTone_00
	smpsHeaderPSG	FunnyAngry_PSG3, $00, $01, $00, sTone_03

FunnyAngry_FM1:
	dc.b nRst, $30, nRst, nRst, nRst
	smpsFMAlterVol	$F7
	smpsSetLFO	$0E, $0F
	smpsPanAnim	$01, $02, $01, $02, $01
	smpsSetvoice	$16
	smpsModSet	$08, $02, $4D, $AF
	dc.b nE2, $18
	smpsModSet	$28, $03, $F7, $A6
	dc.b smpsNoAttack, nE3, $48, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack
	dc.b $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack
	dc.b $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack
	dc.b $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	smpsFMAlterVol	$09
	smpsModOff	
	smpsPanAnim	$00
	smpsSetLFO	$0D, $4E
	smpsModSet	$0C, $01, $07, $03
	smpsFMAlterVol	$FE
	smpsSetvoice	$04
	dc.b nG4, $60, smpsNoAttack, $60
	smpsFMAlterVol	$02
	smpsSetLFO	$00, $00
	smpsModOff	

FunnyAngry_Jump2:
	smpsModSet	$30, $02, $70, $70
	smpsFMAlterVol	$03
	smpsSetvoice	$18
	dc.b nG4, $60, nF4, $60, nE4, $60, smpsNoAttack, $60
	dc.b smpsNoAttack, $30
	smpsModSet	$00, $04, $7F, $7F
	dc.b smpsNoAttack, $30
	smpsFMAlterVol	$04
	smpsModSet	$00, $03, $9F, $AF
	dc.b smpsNoAttack, $42
	smpsFMAlterVol	$FC
	smpsFMAlterVol	$FD
	smpsModOff	
	dc.b nRst, $06
	smpsAlterPitch	$F4
	smpsModSet	$10, $01, $0C, $06
	smpsSetvoice	$11
	smpsCall	FunnyAngry_Call2
	smpsAlterPitch	$0C
	smpsModOff	
	dc.b nRst, $30
	smpsSetvoice	$14
	smpsFMAlterVol	$FE
	smpsModSet	$00, $01, $0B, $04
	dc.b nG3, $30, smpsNoAttack, $30, nRst, $18, nE3, nA3
	dc.b nE3, nG3, nA3, nBb3, nE3, nG3, nA3, nB3
	dc.b nD4
	smpsFMAlterVol	$02
	smpsModOff	
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, $2A
	smpsAlterPitch	$F4
	smpsModSet	$10, $01, $0C, $06
	smpsSetvoice	$11
	smpsCall	FunnyAngry_Call2
	smpsAlterPitch	$0C
	smpsModOff	
	dc.b nRst, $30
	smpsSetvoice	$14
	smpsFMAlterVol	$FF
	smpsModSet	$00, $01, $0B, $04
	dc.b nG3, $30, smpsNoAttack, $30, nRst, $18, nE3, nA3
	dc.b nE3, nG3, nA3, nBb3, nE3, nG3, nA3, nB3
	dc.b nD4
	smpsFMAlterVol	$01
	smpsModOff	
	dc.b nRst, $1E, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b $2A
	smpsAlterPitch	$F4
	smpsModSet	$10, $01, $0C, $06
	smpsSetvoice	$11
	dc.b nD5, $06, nRst, nE5, $0C, nF5, $18, nE5
	dc.b $0C, nF5, nG5, nF5, nE5, $06, nRst, nF5
	dc.b $0C, nE5, $08, nF5, $04, nE5, $06, nD5
	dc.b $30, smpsNoAttack, $0C, nRst, $06, nC5, $0C, nB4
	dc.b $18, nA4, $10, nB4, $14, nC5, $0C, nB4
	dc.b $06, smpsNoAttack, $60, nRst, $18, nG5, $06, nF5
	dc.b nE5, nF5, $18, nF5, $06, nE5, nF5, nG5
	dc.b nD5, smpsNoAttack, $30, nRst, $12, nB5, $18, nB4
	dc.b $06, nRst, $12, nD5, $18, nE5, $0C, nD5
	dc.b nE5, $06, nD5, nB4, nE4
	smpsFMAlterVol	$FF
	dc.b nD5, nB4, nE4, nD4
	smpsFMAlterVol	$FF
	dc.b nB4, nE4, nD4, nB3
	smpsFMAlterVol	$FF
	dc.b nE4, nD4, nB3, nA3
	smpsFMAlterVol	$FF
	dc.b nD4, nB3, nA3, nE3
	smpsFMAlterVol	$04
	smpsAlterPitch	$0C
	smpsModOff	
	smpsJump	FunnyAngry_Jump2
	; Unused
	dc.b $F2

FunnyAngry_Call2:
	smpsFMAlterVol	$FE
	dc.b nD4, $0C, nE4
	smpsFMAlterVol	$02
	dc.b nG4, $30, smpsNoAttack, $30, smpsNoAttack, $30, nRst, $18
	dc.b nD4, $0C, nE4, nG4, $30, smpsNoAttack, $30, smpsNoAttack
	dc.b $30, nRst, $18, nF4, $0C, nG4, nBb4, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, nRst, $18, nF4, $0C
	dc.b nG4, nBb4, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack
	dc.b $18, nRst, $18, nE6, $06, nA5, $0C, nA4
	dc.b $30, smpsNoAttack, $1E, smpsNoAttack, $60, nRst, $18, nBb4
	dc.b nG4, nA4, nBb4, nG4, nA4, nD5, nCs5, $30
	dc.b smpsNoAttack, $48, nRst, $18, nB4, $12, nCs5, nD5
	dc.b $0C, nG4, $18, nEb4, nFs4, $30, smpsNoAttack, $48
	dc.b nRst, $18, nG5, $60, nRst, $18, nG5, nFs5
	dc.b nD5, nE5, $24, nA4, $06, nRst, nA4, $30
	dc.b smpsNoAttack, $48, nRst, $18, nG5, $60, nRst, $18
	dc.b nG5, nFs5, nD5, nE5, $24, nA4, $06, nRst
	dc.b nA4, $60
	smpsReturn	

FunnyAngry_FM2:
	smpsSetvoice	$10
	smpsNoteFill	$02

FunnyAngry_Loop14:
	dc.b nE3, $06, nE3, nE3, nE3, nE3, nE3, nE3
	dc.b nE3, nE3, nE3, nE3, nE3, nE3, nE3, nE3
	dc.b nE3
	smpsLoop	$00, $0C, FunnyAngry_Loop14

FunnyAngry_Loop15:
FunnyAngry_Jump3:
	dc.b nE3, $06, nE3, nE3, nE3, nE3, nE3, nE3
	dc.b nE3, nE3, nE3, nE3, nE3, nE3, nE3, nE3
	dc.b nE3
	smpsLoop	$00, $07, FunnyAngry_Loop15
	smpsCall	FunnyAngry_Call3
	smpsSetvoice	$15
	smpsFMAlterVol	$F6
	smpsNoteFill	$04
	dc.b nD4, $06, nD4, nD4, nD4, nD4, nD4, nD4
	dc.b nD4, nD4, nD4, nD4, nD4, nD4, nD4, nD4
	dc.b nD4, nD4, nD4, nRst, nD4, $0C, nD4
	smpsFMAlterVol	$0A
	dc.b nRst, $30, nRst
	smpsCall	FunnyAngry_Call3
	smpsSetvoice	$15
	smpsFMAlterVol	$F6
	smpsNoteFill	$04
	dc.b nD4, $06, nD4, nD4, nD4, nD4, nD4, nD4
	dc.b nD4, nD4, nD4, nD4, nD4, nD4, nD4, nD4
	dc.b nD4
	smpsFMAlterVol	$0A
	dc.b nRst, $06, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, $2A
	smpsNoteFill	$00
	smpsFMAlterVol	$FE
	smpsSetvoice	$1A
	dc.b nG4, $06, nF4, nG4, $0C, nA4, $06, nG4
	dc.b nF4, nE4
	smpsFMAlterVol	$FC
	dc.b nCs5, $01, smpsNoAttack, nD5, $06, nRst, $11, nRst
	dc.b $18
	smpsFMAlterVol	$04
	smpsFMAlterVol	$02
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	smpsSetvoice	$10
	smpsNoteFill	$02
	smpsJump	FunnyAngry_Jump3
	; Unused
	dc.b $F2

FunnyAngry_Call3:
	smpsNoteFill	$00
	smpsFMAlterVol	$01
	smpsSetvoice	$1A
	dc.b nD5, $06, nE5, nRst, nE5, $04, nRst, $08
	dc.b nE5, $06, nD5, nRst, nG5
	smpsModSet	$20, $01, $DF, $FF
	dc.b nE5, $24, nRst, $06
	smpsModOff	
	dc.b nRst, $30, nRst, nRst, $0C, nE5, $18, nD5
	dc.b $05, nRst, $07, nG4, $06, nA4, nG4, nA4
	dc.b nBb4, nA4, nG4, nE4, nG4, nE4, $0C
	smpsModSet	$20, $01, $DF, $FF
	dc.b nE5, $24
	smpsModOff	
	dc.b nRst, $2A, nRst, $30, nC5, $06, nBb4, nA4
	dc.b nG4, nBb4, nA4, nG4, nF4, nF4, nF5, nRst
	dc.b nF5, nRst, nF5, nRst, nE5, nD5, nBb4, nRst
	dc.b $24, nD4, $06, nD4, nE4, nE4, nF4, nE4
	dc.b nF4, nG4, nA4, nA4, nBb4, nB4, nC5, nB4
	dc.b nBb4, nA4
	smpsModSet	$28, $01, $EF, $FF
	dc.b nE5, $30
	smpsModOff	
	dc.b nRst, nRst, nRst
	smpsNoteFill	$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	smpsNoteFill	$0A
	dc.b nFs5, $12, nRst, $30, nRst, $06
	smpsNoteFill	$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	smpsNoteFill	$0A
	dc.b nFs5, $06
	smpsFMAlterVol	$FE
	dc.b smpsNoAttack, nG5, $08, nRst, $30, nRst, $0A
	smpsFMAlterVol	$02
	smpsNoteFill	$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	smpsNoteFill	$0A
	dc.b nFs5, $12, nRst, $30, nRst, $06
	smpsNoteFill	$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	smpsNoteFill	$0A
	dc.b nFs5, $06
	smpsFMAlterVol	$FE
	dc.b smpsNoAttack, nG5, $08, nRst, $30, nRst, $0A
	smpsFMAlterVol	$02
	smpsNoteFill	$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	smpsNoteFill	$0A
	dc.b nFs5, $12, nRst, $30, nRst, $06
	smpsNoteFill	$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	smpsNoteFill	$0A
	dc.b nFs5, $05, nRst, $01
	smpsNoteFill	$00
	smpsModSet	$1E, $01, $DF, $FF
	dc.b nG5, $28
	smpsModOff	
	dc.b nRst, $02, nA5, $18
	smpsFMAlterVol	$FF
	smpsSetvoice	$14
	smpsFMAlterVol	$FB
	smpsModSet	$00, $01, $0B, $04
	smpsSetLFO	$08, $0D
	dc.b nA3, $60, nRst, $18, nG3, nA3, nG3, nFs3
	dc.b $24, nE3, $06, nRst, nE3, $30, smpsNoAttack, $48
	dc.b nRst, $18, nA3, $60, nRst, $18, nG3, nA3
	dc.b nG3, nFs3, $24, nE3, $06, nRst, nE3, $30
	dc.b smpsNoAttack, $48, nRst, $18
	smpsFMAlterVol	$05
	smpsModOff	
	smpsSetLFO	$00, $00
	smpsNoteFill	$00
	smpsSetvoice	$1A
	smpsFMAlterVol	$FF
	dc.b nB4, $48
	smpsFMAlterVol	$01
	dc.b nB4, $06, nA4, nG4, nE4, nA4, $18, $06
	dc.b nG4, nFs4, nE4, nD4, nD4, nRst, nD4, nRst
	dc.b $18, nB3, $06, nB3, nD4, nD4, nA4, nG4
	dc.b nFs4, nE4, nRst, $30, nB3, $06, nB3, nD4
	dc.b nD4, nA4, nG4, nFs4, nE4, $1E, nG5, $06
	dc.b nA5, $06, smpsNoAttack, nAb5, $03, smpsNoAttack, nG5, $01
	dc.b smpsNoAttack, nFs5, smpsNoAttack, nE5, smpsNoAttack, nEb5, smpsNoAttack, nD5
	dc.b nRst, $04, nE5, $06, nE5, nE5, nE5, nRst
	dc.b $0C, nE5, $06, nE5, nE5, nE5, nRst, $0C
	dc.b nE5, $06, nE5, nE5, nE5, nRst, $0C, nF5
	dc.b $10, nF5, nF5, nE5, $06, nE5, nE5, nE5
	dc.b nRst, $0C, nE5, $06, nE5, nE5, nE5, nRst
	dc.b $0C, nE5, $06, nE5, nE5, nE5, nRst, $0C
	dc.b nF5, $10, nF5, nF5, nE5, $06, nE5, nE5
	dc.b nE5, nRst, $0C, nE5, $06, nE5, nE5, nE5
	dc.b nRst, $0C, nE5, $06, nE5, nE5, nE5, nRst
	dc.b $0C, nF6, $10, nF6, nF6
	smpsNoteFill	$07
	dc.b nE6, $06, nE6, nE6, nE6, nRst, $0C, nE6
	dc.b $06, nE6, nE6, nE6, nRst, $0C, nE6, $06
	dc.b nE6
	smpsNoteFill	$00
	smpsReturn	

FunnyAngry_FM3:
	dc.b nRst, $30, nRst, nRst, nRst
	smpsSetvoice	$07

FunnyAngry_Loop16:
	dc.b nE1, $0C, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1
	smpsLoop	$00, $07, FunnyAngry_Loop16
	dc.b nE1, nRst, nE1, nRst, nE1, $06, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nRst, $30, nRst
	dc.b nRst, nRst

FunnyAngry_Jump4:
	dc.b nRst, $30, nRst, nRst, nRst
	smpsSetvoice	$07
	dc.b nE1, $0C, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, $06, nRst
	dc.b nE1, nRst, nE1, nRst, nE1, nRst
	smpsCall	FunnyAngry_Call4
	dc.b nE1, $06, nE1, nE1, nE1, nRst, nB0, nE1
	dc.b nE1, nE1, nE1, nRst, nB0, nE1, nE1, nE1
	dc.b $0A, nRst, $0E, nE1, $0A, nRst, $0E, nE1
	dc.b $0A, nRst, $08, nE1, $06, nE1, nE1, nE1
	dc.b nE1, nRst, $12, nE1, $06, nRst, nE1, nRst
	smpsCall	FunnyAngry_Call4
	dc.b nE1, $06, nE1, nE1, nE1, nRst, nB0, nE1
	dc.b nE1, nE1, nE1, nRst, nB0, nE1, nE1, nE1
	dc.b nRst, $12, nE1, $0A, nRst, $0E, nE1, $0A
	dc.b nRst, $08, nE1, $06, nE1, nE1, nE1, nE1
	dc.b nG1, nRst, $12, nG1, $0C, nRst, nG1, nRst
	dc.b nG1, nF1, nG1, $06, nRst, $12, nG1, $0C
	dc.b nRst, nG1, nRst, nG1, nG1, nG1, $06, nRst
	dc.b $12, nG1, $0C, nRst, nG1, nRst, nG1, nF1
	dc.b nG1, $06, nRst, $12, nG1, $0C, nRst, nG1
	dc.b nG1, nG1, nG1, nB1, $06, nRst, $12, nB1
	dc.b $0C, nRst, nB1, nRst, nB1, nA1, nB1, $06
	dc.b nRst, $12, nB1, $0C, nRst, nB1, nRst, nB1
	dc.b nRst, nB1, $06, nRst, $12, nB1, $0C, nRst
	dc.b nB1, nRst, nB1, nRst, nE1, $06, nRst, nE1
	dc.b $0C, nE1, nE1, nE1, nE1, nE1, nE1
	smpsJump	FunnyAngry_Jump4
	; Unused
	dc.b $F2

FunnyAngry_Call4:
	dc.b nE1, $0C, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nG1, nRst, nG1, nRst, nG1, nRst, nG1
	dc.b nF1, nG1, nRst, nG1, nRst, nG1, nRst, nG1
	dc.b nF1, nG1, nRst, nG1, nRst, nG1, nRst, nG1
	dc.b nF1, nG1, nRst, nG1, nRst, nG1, $06, nRst
	dc.b nG1, nRst, nG1, nRst, nG1, nRst, nE1, $0C
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, $06, nRst, nE1, nRst
	dc.b nE1, nRst, nE1, nRst, nA1, $0C, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nRst, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nRst, nE1, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nD1, nE1, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nD1, nE1, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nD1, nE1, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nD1, nE1, $06, nE1
	dc.b nE1, nE1, nRst, nB0, nE1, nE1, nE1, nE1
	dc.b nRst, nB0, nE1, nE1, nE1, nE1, nRst, nB0
	dc.b nF1, $10, nF1, nF1, nE1, $06, nE1, nE1
	dc.b nE1, nRst, nB0, nE1, nE1, nE1, nE1, nRst
	dc.b nB0, nE1, nE1, nE1, nE1, nRst, nB0, nF1
	dc.b $10, nF1, nF1, nE1, $06, nE1, nE1, nE1
	dc.b nRst, nB0, nE1, nE1, nE1, nE1, nRst, nB0
	dc.b nE1, nE1, nE1, nE1, nRst, nB0, nF1, $10
	dc.b nF1, nF1
	smpsReturn	

FunnyAngry_FM4:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, $0C
	smpsFMAlterVol	$FB
	smpsSetLFO	$0E, $0F
	smpsPanAnim	$01, $02, $01, $02, $01
	smpsSetvoice	$16
	smpsModSet	$08, $02, $4D, $AF
	dc.b nE2, $18, smpsNoAttack
	smpsModSet	$28, $03, $F7, $A6
	dc.b nE3, $48, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	dc.b smpsNoAttack, $30, smpsNoAttack, $30, smpsNoAttack, $30
	smpsModOff	
	smpsPanAnim	$00
	smpsSetLFO	$0D, $4E
	smpsModSet	$0C, $01, $07, $03
	smpsSetvoice	$04
	dc.b nG4, $60, smpsNoAttack, $54
	smpsSetLFO	$00, $00
	smpsModOff	
	smpsFMAlterVol	$05

FunnyAngry_Jump5:
	smpsFMAlterVol	$FC
	dc.b nRst, $0C
	smpsModSet	$30, $02, $70, $70
	smpsSetvoice	$18
	dc.b nG4, $60, nF4, $60, nE4, $60, smpsNoAttack, $60
	dc.b smpsNoAttack, $30
	smpsModSet	$00, $04, $7F, $7F
	dc.b smpsNoAttack, $30
	smpsFMAlterVol	$04
	smpsModSet	$00, $03, $9F, $AF
	dc.b smpsNoAttack, $48
	smpsModOff	
	smpsFMAlterVol	$FC
	dc.b nRst, $30, nRst, $3C
	smpsFMAlterVol	$04
	smpsSetvoice	$1A
	smpsAlterNote	$01
	smpsCall	FunnyAngry_Call5
	dc.b nRst, $18, nRst, $30, nRst, nRst, nRst, nRst
	dc.b $12
	smpsSetvoice	$1A
	smpsCall	FunnyAngry_Call5
	dc.b nRst, $06, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, $2A
	smpsFMAlterVol	$FE
	smpsSetvoice	$1A
	dc.b nC5, $06, nB4, nC5, $0C, nD5, $06, nB4
	dc.b nA4, nG4
	smpsFMAlterVol	$FD
	dc.b nE5, $01, smpsNoAttack, nF5, $06, nRst, $11
	smpsFMAlterVol	$03
	smpsFMAlterVol	$02
	smpsAlterNote	$00
	dc.b nRst, $18
	smpsAlterPitch	$F4
	smpsFMAlterVol	$02
	smpsModSet	$10, $01, $0C, $06
	smpsSetvoice	$11
	dc.b nRst, $06, nF5, $18, nF5, $06, nE5, nF5
	dc.b nG5, nD5, smpsNoAttack, $30, nRst, $12, nB5, $18
	dc.b nB4, $06, nRst, $12, nD5, $18, nE5, $0C
	dc.b nD5, nE5, $06, nD5, nB4, nE4
	smpsFMAlterVol	$FE
	dc.b nD5, nB4, nE4, nD4
	smpsFMAlterVol	$FF
	dc.b nB4, nE4, nD4, nB3
	smpsFMAlterVol	$FF
	dc.b nE4, nD4, nB3, nA3
	smpsFMAlterVol	$FF
	dc.b nD4, nB3, nA3
	smpsFMAlterVol	$03
	smpsAlterPitch	$0C
	smpsModOff	
	smpsJump	FunnyAngry_Jump5
	; Unused
	dc.b $F2

FunnyAngry_Call5:
	dc.b nA4, $06, nB4, nRst, nB4, $04, nRst, $08
	dc.b nB4, $06, nA4, nRst, nD5
	smpsModSet	$20, $01, $DF, $FF
	dc.b nB4, $24, nRst, $06
	smpsModOff	
	dc.b nRst, $30, nRst, nRst, $0C, nB4, $18, nA4
	dc.b $05, nRst, $07, nD4, $06, nE4, nD4, nE4
	dc.b nF4, nE4, nD4, nB3, nD4, nB3, $0C
	smpsModSet	$20, $01, $DF, $FF
	dc.b nB4, $24
	smpsModOff	
	dc.b nRst, $2A, nRst, $30, nG4, $06, nF4, nE4
	dc.b nD4, nF4, nE4, nD4, nC4, nC4, nC5, nRst
	dc.b nC5, nRst, nC5, nRst, nB4, nA4, nF4, nRst
	dc.b $24, nA3, $06, nA3, nB3, nB3, nC4, nB3
	dc.b nC4, nD4, nE4, nE4, nF4, nFs4, nG4, nFs4
	dc.b nF4, nE4
	smpsModSet	$28, $01, $EF, $FF
	dc.b nB5, $30
	smpsModOff	
	dc.b nRst, nRst, nRst, nCs5, $04, nRst, $02, nCs5
	dc.b $04, nRst, $02, nCs5, $04, nRst, $02, nCs5
	dc.b $04, nRst, $02
	smpsNoteFill	$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	smpsNoteFill	$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	smpsNoteFill	$0A
	dc.b nCs5, $06, smpsNoAttack, nD5, $08, nRst, $30, nRst
	dc.b $0A
	smpsNoteFill	$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	smpsNoteFill	$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	smpsNoteFill	$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	smpsNoteFill	$0A
	dc.b nCs5, $06, smpsNoAttack, nD5, $08, nRst, $30, nRst
	dc.b $0A
	smpsNoteFill	$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	smpsNoteFill	$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	smpsNoteFill	$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	smpsNoteFill	$0A
	dc.b nCs5, $05, nRst, $01
	smpsModSet	$1E, $01, $DF, $FF
	smpsNoteFill	$00
	dc.b nD5, $28
	smpsModOff	
	dc.b nRst, $02, nE5, $18, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst
	smpsFMAlterVol	$FF
	dc.b nE5, smpsNoAttack, $18
	smpsFMAlterVol	$01
	dc.b nE5, $06, nD5, nCs5, nB4, nD5, $18, $06
	dc.b nCs5, nB4, nA4, nG4, nG4, nRst, nG4, nRst
	dc.b $18, nE4, $06, nE4, nG4, nG4, nD5, nCs5
	dc.b nB4, nA4, nRst, $30, nE4, $06, nE4, nG4
	dc.b nG4, nD5, nCs5, nB4, nA4, $1E, nD5, $06
	dc.b nE5, $06, smpsNoAttack, nEb5, $03, smpsNoAttack, nD5, $01
	dc.b smpsNoAttack, nCs5, smpsNoAttack, nC5, smpsNoAttack, nB4, smpsNoAttack, nBb4
	dc.b nRst, $04, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nB4, $06, nB4, nB4, nB4, nRst, $0C, nC5
	dc.b $10, nC5, nC5, nB4, $06, nB4, nB4, nB4
	dc.b nRst, $0C, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nC5, $10, nC5, nC5, nB4, $06, nB4, nB4
	dc.b nB4, nRst, $0C, nB4, $06, nB4, nB4, nB4
	dc.b nRst, $0C, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nC6, $10, nC6, nC6
	smpsNoteFill	$07
	dc.b nB5, $06, nB5, nB5, nB5, nRst, $0C, nB5
	dc.b $06, nB5, nB5, nB5, nRst, $0C, nB5, $06
	dc.b nB5
	smpsNoteFill	$00
	smpsReturn	

FunnyAngry_FM5:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsModSet	$04, $01, $8F, $FF
	smpsSetvoice	$19
	smpsFMAlterVol	$FF
	dc.b nG2, $06, nG2, nG2, nG2, nG2, $0C, nRst
	dc.b nRst, $30

FunnyAngry_Loop17:
FunnyAngry_Jump6:
	dc.b nG2, $06, nG2, nG2, nG2, nG2, $0C, nRst
	dc.b nRst, $30
	smpsLoop	$00, $16, FunnyAngry_Loop17
	smpsFMAlterVol	$01
	smpsAlterPitch	$E8
	smpsModSet	$05, $01, $8F, $FF
	smpsSetvoice	$13
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nRst, nA4, nRst, nA4, nRst, nA4, nRst, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nRst
	dc.b nA4, nRst, nA4, nRst, nA4, nRst, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nRst, nA4
	dc.b nRst, nA4, nRst, nA4, nRst, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nRst, $30, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nE4, $06
	dc.b nE4, nE4, nE4, nRst, $0C, nE4, $06, nE4
	dc.b nE4, nE4, nRst, $0C, nE4, $06, nE4, nE4
	dc.b nE4, nRst, $0C, nF3, $10, nF3, nF3, nE4
	dc.b $06, nE4, nE4, nE4, nRst, $0C, nE4, $06
	dc.b nE4, nE4, nE4, nRst, $0C, nE4, $06, nE4
	dc.b nE4, nE4, nRst, $0C, nF3, $10, nF3, nF3
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4
	dc.b $06, nE4, nE4, nE4, nRst, $0C, nE4, $06
	dc.b nE4, nE4, nE4, nRst, $0C, nF3, $10, nF3
	dc.b nF3, nE4, $06, nE4, nE4, nE4, nRst, $0C
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4
	dc.b $06, nE4, nRst, $18
	smpsAlterPitch	$18
	dc.b nRst, $18, nRst, $12
	smpsModSet	$04, $01, $8F, $FF
	smpsFMAlterVol	$FF
	smpsSetvoice	$19
	dc.b nG2, $06, nG2, nG2, nG2, nG2, nRst, $2A

FunnyAngry_Loop18:
	dc.b nG2, $06, nG2, nG2, nG2, nG2, $0C, nRst
	dc.b nRst, $30
	smpsLoop	$00, $04, FunnyAngry_Loop18

FunnyAngry_Loop19:
	dc.b nD3, $06, nD3, nD3, nD3, nD3, $0C, nRst
	dc.b nRst, $30
	smpsLoop	$00, $04, FunnyAngry_Loop19

FunnyAngry_Loop20:
	dc.b nG2, $06, nG2, nG2, nG2, nG2, $0C, nRst
	dc.b nRst, $30
	smpsLoop	$00, $08, FunnyAngry_Loop20
	smpsFMAlterVol	$01
	smpsAlterPitch	$E8
	smpsModSet	$05, $01, $8F, $FF
	smpsSetvoice	$13
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nRst, nA4, nRst, nA4, nRst, nA4, nRst, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nRst
	dc.b nA4, nRst, nA4, nRst, nA4, nRst, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nRst, nA4
	dc.b nRst, nA4, nRst, nA4, nRst, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $30, nRst, $2A, nRst
	dc.b $30, nRst, nRst, nRst, nRst, nRst, nRst, $12
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4
	dc.b $06, nE4, nE4, nE4, nRst, $0C, nE4, $06
	dc.b nE4, nE4, nE4, nRst, $0C, nF3, $10, nF3
	dc.b nF3, nE4, $06, nE4, nE4, nE4, nRst, $0C
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4
	dc.b $06, nE4, nE4, nE4, nRst, $0C, nF3, $10
	dc.b nF3, nF3, nE4, $06, nE4, nE4, nE4, nRst
	dc.b $0C, nE4, $06, nE4, nE4, nE4, nRst, $0C
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nF3
	dc.b $10, nF3, nF3, nE4, $06, nE4, nE4, nE4
	dc.b nRst, $0C, nE4, $06, nE4, nE4, nE4, nRst
	dc.b $0C, nE4, $06, nE4, nRst, nRst, $30, nRst
	dc.b $2A

FunnyAngry_Loop21:
	dc.b nA2, $06, nA2, nA2, nA2, nA2, nA2, nA2
	dc.b nA2, nA2, nA2, nA2, nA2, nA2, nA2, nA2
	dc.b nA2
	smpsLoop	$00, $08, FunnyAngry_Loop21
	smpsAlterPitch	$18
	smpsModSet	$04, $01, $8F, $FF
	smpsSetvoice	$19
	smpsFMAlterVol	$FF
	smpsJump	FunnyAngry_Jump6
	; Unused
	dc.b $F2

FunnyAngry_PSG1:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
FunnyAngry_Jump7:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst
	smpsPSGvoice	 sTone_09
	smpsCall	FunnyAngry_Call6
	dc.b nRst, $18, nRst, $30, nRst, nRst, nRst, nRst
	dc.b $12
	smpsPSGvoice	 sTone_09
	smpsCall	FunnyAngry_Call6
	dc.b nRst, $06, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, $2A
	smpsPSGvoice	 sTone_09
	dc.b nC5, $06, nB4, nC5, $0C, nD5, $06, nB4
	dc.b nA4, nG4
	smpsPSGAlterVol	$FF
	dc.b nE5, $01, smpsNoAttack, nF5, $06
	smpsPSGAlterVol	$01
	dc.b nRst, $11, nRst, $18, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst
	smpsJump	FunnyAngry_Jump7
	; Unused
	dc.b $F2

FunnyAngry_Call6:
	dc.b nA4, $06, nB4, nRst, nB4, $04, nRst, $08
	dc.b nB4, $06, nA4, nRst, nD5
	smpsModSet	$1B, $02, $20, $FF
	dc.b nB4, $24, nRst, $06
	smpsModOff	
	dc.b nRst, $30, nRst, nRst, $0C, nB4, $18, nA4
	dc.b $05, nRst, $07, nD4, $06, nE4, nD4, nE4
	dc.b nF4, nE4, nD4, nB3, nD4, nB3, $0C
	smpsModSet	$1E, $02, $20, $FF
	dc.b nB4, $24
	smpsModOff	
	dc.b nRst, $2A, nRst, $30, nG4, $06, nF4, nE4
	dc.b nD4, nF4, nE4, nD4, nC4, nC4, nC5, nRst
	dc.b nC5, nRst, nC5, nRst, nB4, nA4, nF4, nRst
	dc.b $24, nA3, $06, nA3, nB3, nB3, nC4, nB3
	dc.b nC4, nD4, nE4, nE4, nF4, nFs4, nG4, nFs4
	dc.b nF4, nE4
	smpsModSet	$26, $02, $16, $FF
	dc.b nB5, $30
	smpsModOff	
	dc.b nRst, nRst, nRst
	smpsNoteFill	$06
	dc.b nCs5, $06, nCs5, nCs5, nCs5
	smpsNoteFill	$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	smpsNoteFill	$06
	dc.b nCs5, nCs5, nCs5, nCs5, nCs5
	smpsNoteFill	$0A
	dc.b nD5, $0C, nRst, $30, nRst, $06
	smpsNoteFill	$06
	dc.b nCs5, nCs5, nCs5, nCs5
	smpsNoteFill	$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	smpsNoteFill	$06
	dc.b nCs5, nCs5, nCs5, nCs5, nCs5
	smpsNoteFill	$0A
	dc.b nD5, $0C, nRst, $30, nRst, $06
	smpsNoteFill	$06
	dc.b nCs5, nCs5, nCs5, nCs5
	smpsNoteFill	$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	smpsNoteFill	$06
	dc.b nCs5, nCs5, nCs5, nCs5
	smpsNoteFill	$0A
	dc.b nCs5, $04, nRst, $02
	smpsModSet	$1B, $02, $20, $FF
	smpsNoteFill	$00
	dc.b nD5, $28
	smpsModOff	
	dc.b nRst, $02, nE5, $18, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nE5, smpsNoAttack, $18
	dc.b $06, nD5, nCs5, nB4, nD5, $18, $06, nCs5
	dc.b nB4, nA4, nG4, nG4, nRst, nG4, nRst, $18
	dc.b nE4, $06, nE4, nG4, nG4, nD5, nCs5, nB4
	dc.b nA4, nRst, $30, nE4, $06, nE4, nG4, nG4
	dc.b nD5, nCs5, nB4, nA4, $1E, nD5, $06, nE5
	dc.b $06, smpsNoAttack, nEb5, $03, smpsNoAttack, nD5, $01, smpsNoAttack
	dc.b nCs5, smpsNoAttack, nC5, smpsNoAttack, nB4, smpsNoAttack, nBb4, nRst
	dc.b $04, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nB4, $06, nB4, nB4, nB4, nRst, $0C, nB4
	dc.b $06, nB4, nB4, nB4, nRst, $0C, nC5, $10
	dc.b nC5, nC5, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nB4, $06, nB4, nB4, nB4, nRst, $0C, nC5
	dc.b $10, nC5, nC5, nB4, $06, nB4, nB4, nB4
	dc.b nRst, $0C, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nC6, $10, nC6, nC6
	smpsNoteFill	$06
	dc.b nB5, $06, nB5, nB5, nB5, nRst, $0C, nB5
	dc.b $06, nB5, nB5, nB5, nRst, $0C, nB5, $06
	dc.b nB5
	smpsNoteFill	$00
	smpsReturn	

FunnyAngry_PSG2:
	dc.b nRst, $30, nRst, nRst, $30, nRst
	smpsPSGvoice	 sTone_05
	smpsNoteFill	$02

FunnyAngry_Loop22:
	dc.b nB4, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nRst, $06, nD5, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nD5
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nG4
	smpsPSGAlterVol	$04
	dc.b nRst, nG4
	smpsPSGAlterVol	$FC
	smpsLoop	$00, $10, FunnyAngry_Loop22
	dc.b nRst, $30, nRst, nRst, nRst

FunnyAngry_Jump8:
	dc.b nRst, $30, nRst, nRst, nRst
FunnyAngry_Loop23:
	dc.b nB4, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nRst, $06, nD5, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nD5
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nG4
	smpsPSGAlterVol	$04
	dc.b nRst, nG4
	smpsPSGAlterVol	$FC
	smpsLoop	$00, $10, FunnyAngry_Loop23
	smpsPSGvoice	$0B
	smpsNoteFill	$03
	dc.b nB3, $06, nD4, nF4, nA4, nRst, $30, nB3
	dc.b $06, nD4, nF4, nA4, nRst, $18, nB3, $06
	dc.b nD4, nF4, nA4, nRst, $30, nB3, $06, nD4
	dc.b nF4, nA4, nRst, $30, nB3, $06, nD4, nF4
	dc.b nA4, nRst, $18, nB3, $06, nD4, nF4, nA4
	dc.b nRst, $18, nB3, $06, nD4, nF4, nB3
	smpsPSGvoice	 sTone_05
	smpsNoteFill	$02

FunnyAngry_Loop24:
	dc.b nB4, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nRst, $06, nD5, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nD5
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nG4
	smpsPSGAlterVol	$04
	dc.b nRst, nG4
	smpsPSGAlterVol	$FC
	smpsLoop	$00, $10, FunnyAngry_Loop24
	smpsPSGvoice	$0B
	smpsNoteFill	$03

FunnyAngry_Loop25:
	dc.b nA4, $06, nE4, nD5, nRst, nCs5, nD5, nCs5
	dc.b nA4, nA4, nE4, nE5, nRst, nCs5, nD5, nCs5
	dc.b nA4
	smpsLoop	$00, $08, FunnyAngry_Loop25
	smpsPSGvoice	 sTone_05
	smpsNoteFill	$02

FunnyAngry_Loop26:
	dc.b nB4, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nRst, $06, nD5, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nD5
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nG4
	smpsPSGAlterVol	$04
	dc.b nRst, nG4
	smpsPSGAlterVol	$FC
	smpsLoop	$00, $08, FunnyAngry_Loop26
	smpsPSGvoice	$0B
	smpsNoteFill	$03
	smpsPSGAlterVol	$01

FunnyAngry_Loop27:
	dc.b nE5, $06, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nF5, nF5, nF5, nF5, nF5
	dc.b nF5, nF5, nF5
	smpsLoop	$00, $03, FunnyAngry_Loop27
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nRst, $60
	dc.b nRst, $12, nD5, $06, nCs5, nB4, nG4
	smpsPSGAlterVol	$FF
	smpsPSGvoice	 sTone_05
	smpsNoteFill	$02

FunnyAngry_Loop28:
	dc.b nB4, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nRst, $06, nD5, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nD5
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nG4
	smpsPSGAlterVol	$04
	dc.b nRst, nG4
	smpsPSGAlterVol	$FC
	smpsLoop	$00, $08, FunnyAngry_Loop28
	smpsPSGvoice	$0B
	smpsNoteFill	$03
	dc.b nB3, $06, nD4, nF4, nA4, nRst, $30, nB3
	dc.b $06, nD4, nF4, nA4, nRst, $18, nB3, $06
	dc.b nD4, nF4, nA4, nRst, $30, nB3, $06, nD4
	dc.b nF4, nA4, nRst, $30, nB3, $06, nD4, nF4
	dc.b nA4, nRst, $18, nB3, $06, nD4, nF4, nA4
	dc.b nRst, $18, nB3, $06, nD4, nF4, nB3
	smpsPSGvoice	 sTone_05
	smpsNoteFill	$02

FunnyAngry_Loop29:
	dc.b nB4, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nRst, $06, nD5, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nD5
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nG4
	smpsPSGAlterVol	$04
	dc.b nRst, nG4
	smpsPSGAlterVol	$FC
	smpsLoop	$00, $10, FunnyAngry_Loop29
	smpsPSGvoice	$0B
	smpsNoteFill	$03

FunnyAngry_Loop30:
	dc.b nA4, $06, nE4, nD5, nRst, nCs5, nD5, nCs5
	dc.b nA4, nA4, nE4, nE5, nRst, nCs5, nD5, nCs5
	dc.b nA4
	smpsLoop	$00, $08, FunnyAngry_Loop30
	smpsPSGvoice	 sTone_05
	smpsNoteFill	$02

FunnyAngry_Loop31:
	dc.b nB4, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nRst, $06, nD5, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nD5
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nG4
	smpsPSGAlterVol	$04
	dc.b nRst, nG4
	smpsPSGAlterVol	$FC
	smpsLoop	$00, $08, FunnyAngry_Loop31
	smpsPSGvoice	$0B
	smpsNoteFill	$03
	smpsPSGAlterVol	$01

FunnyAngry_Loop32:
	dc.b nE5, $06, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nF5, nF5, nF5, nF5, nF5
	dc.b nF5, nF5, nF5
	smpsLoop	$00, $03, FunnyAngry_Loop32
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nRst, $60
	smpsPSGAlterVol	$FF
	smpsPSGvoice	 sTone_05
	smpsNoteFill	$02

FunnyAngry_Loop33:
	dc.b nB4, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nRst, $06, nD5, $02
	smpsPSGAlterVol	$04
	dc.b nRst, nD5
	smpsPSGAlterVol	$FC
	dc.b nCs5
	smpsPSGAlterVol	$04
	dc.b nRst, nCs5
	smpsPSGAlterVol	$FC
	dc.b nB4
	smpsPSGAlterVol	$04
	dc.b nRst, nB4
	smpsPSGAlterVol	$FC
	dc.b nG4
	smpsPSGAlterVol	$04
	dc.b nRst, nG4
	smpsPSGAlterVol	$FC
	smpsLoop	$00, $10, FunnyAngry_Loop33
	smpsJump	FunnyAngry_Jump8
	; Unused
	dc.b $F2

FunnyAngry_PSG3:
	smpsPSGform	$E7
	smpsNoteFill	$02

FunnyAngry_Loop34:
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5
	smpsLoop	$00, $0C, FunnyAngry_Loop34

FunnyAngry_Loop35:
FunnyAngry_Jump9:
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5
	smpsLoop	$00, $22, FunnyAngry_Loop35
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, $06, nA5, nA5, nRst
	dc.b nA5, $06, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b $06, nRst, nA5, nA5, nA5, nRst, nA5, nA5
	dc.b nA5, nRst, nA5, nA5, nA5, nRst, nA5, nA5
	dc.b nA5, nRst, nA5, $06, nA5, nA5, nRst, nA5
	dc.b $06, nA5, nA5, nRst, nA5, nA5, nA5, nRst
	dc.b nA5, nA5, nA5, nRst, nA5, nA5, nA5, nRst
	dc.b nA5, nA5, nRst, $60, nRst, $12, nA5, $06
	dc.b nRst, nA5, nA5

FunnyAngry_Loop36:
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5
	smpsLoop	$00, $1C, FunnyAngry_Loop36
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, $06, nA5, nA5, nRst
	dc.b nA5, $06, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b $06, nRst, nA5, nA5, nA5, nRst, nA5, nA5
	dc.b nA5, nRst, nA5, nA5, nA5, nRst, nA5, nA5
	dc.b nA5, nRst, nA5, $06, nA5, nA5, nRst, nA5
	dc.b $06, nA5, nA5, nRst, nA5, nA5, nA5, nRst
	dc.b nA5, nA5, nA5, nRst, nA5, nA5, nA5, nRst
	dc.b nA5, nA5, nRst, $60

FunnyAngry_Loop37:
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5
	smpsLoop	$00, $08, FunnyAngry_Loop37
	smpsJump	FunnyAngry_Jump9
	; Unused
	dc.b $F2

FunnyAngry_DAC:
FunnyAngry_Loop1:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $04, FunnyAngry_Loop1

FunnyAngry_Loop2:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $0E, FunnyAngry_Loop2
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00
	dc.b d89, $0C, d88, d8A, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00

FunnyAngry_Loop3:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $04, FunnyAngry_Loop3

FunnyAngry_Loop4:
FunnyAngry_Jump1:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $0A, FunnyAngry_Loop4
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00
	dc.b d89, $0C, d88, d8A, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00

FunnyAngry_Loop5:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $0E, FunnyAngry_Loop5
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00
	dc.b d89, $0C, d88, d8A, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00

FunnyAngry_Loop6:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $0E, FunnyAngry_Loop6
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00
	dc.b d89, $0C, d88, d8A, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00

FunnyAngry_Loop7:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $0F, FunnyAngry_Loop7
	dc.b d81, $0C
	smpsPan	 panRight, $00
	dc.b d92, $0C
	smpsPan	 panCentre, $00
	dc.b d88, $06, d88, d89, d8A
	smpsPan	 panCentre, $00

FunnyAngry_Loop8:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $07, FunnyAngry_Loop8
	dc.b d81, $0C
	smpsPan	 panRight, $00
	dc.b d92, $0C
	smpsPan	 panCentre, $00
	dc.b d8A, $06, d8A
	smpsPan	 panLeft, $00
	dc.b d90, $06, d90, $06
	smpsPan	 panCentre, $00
	dc.b d81, $18, d81, d81, d81, d81, d81, d81
	dc.b d81, d81, d81, d81, d81, d81, d81, $18
	dc.b d81, d81, d81, d81, d81, d81, d81, d81
	dc.b d81, d81, $18, d81, d81, $0C, d88, $06
	dc.b d89, d88, d89, nRst, $0C, d8A, $06, d8A
	dc.b d89, d88, $0C, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00

FunnyAngry_Loop9:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $0E, FunnyAngry_Loop9
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00
	dc.b d89, $0C, d88, d8A, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00

FunnyAngry_Loop10:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $0E, FunnyAngry_Loop10
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00
	dc.b d89, $0C, d88, d8A, d8A, $06
	smpsPan	 panLeft, $00
	dc.b d90, $06
	smpsPan	 panCentre, $00

FunnyAngry_Loop11:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $0F, FunnyAngry_Loop11
	dc.b d81, $0C
	smpsPan	 panRight, $00
	dc.b d92, $0C
	smpsPan	 panCentre, $00
	dc.b d88, $06, d88, d89, d8A

FunnyAngry_Loop12:
	smpsCall	FunnyAngry_Call1
	smpsLoop	$00, $07, FunnyAngry_Loop12
	dc.b d81, $0C
	smpsPan	 panRight, $00
	dc.b d92, $0C
	smpsPan	 panCentre, $00
	dc.b d8A, $06, d8A
	smpsPan	 panLeft, $00
	dc.b d90, $06, d90, $06
	smpsPan	 panCentre, $00
	dc.b d81, $18, d81, d81, d81, d81, d81, d81
	dc.b d81, d81, d81, d81, d81, d81, d81, $18
	dc.b d81, d81, d81, d81, d81, d81, d81, d81
	dc.b d81, d81, $18, d81, d81, $0C, d88, $06
	dc.b d89, d88, d89, nRst, $0C

FunnyAngry_Loop13:
	dc.b d81, $0C
	smpsPan	 panLeft, $00
	dc.b d92, $0C
	smpsPan	 panCentre, $00
	dc.b d86, $0C
	smpsPan	 panRight, $00
	dc.b d90, $06, d90, $06
	smpsPan	 panCentre, $00
	smpsLoop	$00, $10, FunnyAngry_Loop13
	smpsJump	FunnyAngry_Jump1
	; Unused
	dc.b $F2

FunnyAngry_Call1:
	smpsPan	 panCentre, $00
	dc.b d81, $0C
	smpsPan	 panLeft, $00
	dc.b d90, $0C
	smpsPan	 panCentre, $00
	dc.b dB4, $0C
	smpsPan	 panRight, $00
	dc.b d92, $06, d92, $06
	smpsPan	 panCentre, $00
	smpsReturn	

FunnyAngry_Voices:
	; Voice $00
	; $3A
	; $00, $03, $00, $02,	$15, $13, $16, $12
	; $0C, $0A, $0B, $0B,	$00, $00, $00, $00
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$02, $00, $03, $00
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$12, $16, $13, $15
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0B, $0B, $0A, $0C
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$00, $00, $00, $00
	smpsVcReleaseRate	$08, $07, $07, $07
	smpsVcTotalLevel	$00, $2D, $16, $1F

	; Voice $01
	; $3D
	; $01, $21, $51, $01,	$12, $14, $14, $0F
	; $0A, $05, $05, $05,	$00, $00, $00, $00
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $05, $02, $00
	smpsVcCoarseFreq	$01, $01, $01, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0F, $14, $14, $12
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $05, $05, $0A
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $02, $02, $02
	smpsVcReleaseRate	$08, $08, $08, $06
	smpsVcTotalLevel	$00, $00, $00, $19

	; Voice $02
	; $3B
	; $71, $01, $31, $31,	$14, $0F, $0F, $0F
	; $14, $05, $05, $00,	$00, $00, $00, $00
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$03, $03, $00, $07
	smpsVcCoarseFreq	$01, $01, $01, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0F, $0F, $0F, $14
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $05, $05, $14
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$00, $00, $0F, $0F
	smpsVcReleaseRate	$07, $06, $06, $06
	smpsVcTotalLevel	$00, $32, $28, $23

	; Voice $03
	; $16
	; $7A, $74, $3C, $31,	$1F, $1F, $1F, $1F
	; $0A, $08, $0C, $0A,	$07, $0A, $07, $05
	smpsVcAlgorithm	$06
	smpsVcFeedback	$02
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$01, $0C, $04, $0A
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $0C, $08, $0A
	smpsVcDecayRate2	$05, $07, $0A, $07
	smpsVcDecayLevel	$05, $0A, $0A, $02
	smpsVcReleaseRate	$05, $07, $07, $05
	smpsVcTotalLevel	$00, $0A, $05, $14

	; Voice $04
	; $3B
	; $08, $14, $02, $11,	$5F, $CF, $08, $59
	; $0C, $02, $0C, $05,	$04, $04, $04, $07
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$01, $00, $01, $00
	smpsVcCoarseFreq	$01, $02, $04, $08
	smpsVcRateScale	$01, $00, $03, $01
	smpsVcAttackRate	$19, $08, $0F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $0C, $02, $0C
	smpsVcDecayRate2	$07, $04, $04, $04
	smpsVcDecayLevel	$02, $00, $01, $01
	smpsVcReleaseRate	$06, $05, $05, $06
	smpsVcTotalLevel	$00, $0B, $36, $1D

	; Voice $05
	; $3C
	; $01, $02, $0F, $04,	$8D, $52, $9F, $1F
	; $09, $00, $00, $0D,	$00, $00, $00, $00
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$04, $0F, $02, $01
	smpsVcRateScale	$00, $02, $01, $02
	smpsVcAttackRate	$1F, $1F, $12, $0D
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0D, $00, $00, $09
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$0F, $00, $00, $02
	smpsVcReleaseRate	$07, $02, $08, $03
	smpsVcTotalLevel	$07, $1D, $00, $15

	; Voice $06
	; $3A
	; $32, $02, $02, $72,	$8F, $8F, $4F, $4D
	; $09, $09, $00, $03,	$00, $00, $00, $00
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$07, $00, $00, $03
	smpsVcCoarseFreq	$02, $02, $02, $02
	smpsVcRateScale	$01, $01, $02, $02
	smpsVcAttackRate	$0D, $0F, $0F, $0F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$03, $00, $09, $09
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$00, $00, $0F, $01
	smpsVcReleaseRate	$08, $05, $05, $05
	smpsVcTotalLevel	$00, $19, $1F, $19

	; Voice $07
	; $30
	; $30, $30, $30, $30,	$9E, $D8, $DC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	smpsVcAlgorithm	$00
	smpsVcFeedback	$06
	smpsVcDetune	$03, $03, $03, $03
	smpsVcCoarseFreq	$00, $00, $00, $00
	smpsVcRateScale	$03, $03, $03, $02
	smpsVcAttackRate	$1C, $1C, $18, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $04, $0A, $0E
	smpsVcDecayRate2	$08, $08, $08, $08
	smpsVcDecayLevel	$0B, $0B, $0B, $0B
	smpsVcReleaseRate	$06, $06, $06, $06
	smpsVcTotalLevel	$00, $12, $2C, $14

	; Voice $08
	; $3A
	; $20, $23, $20, $01,	$1E, $1F, $1F, $1F
	; $0A, $0A, $0B, $0A,	$05, $07, $0A, $08
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$00, $02, $02, $02
	smpsVcCoarseFreq	$01, $00, $03, $00
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $0B, $0A, $0A
	smpsVcDecayRate2	$08, $0A, $07, $05
	smpsVcDecayLevel	$07, $09, $08, $0A
	smpsVcReleaseRate	$07, $06, $05, $04
	smpsVcTotalLevel	$00, $28, $25, $21

	; Voice $09
	; $3B
	; $61, $02, $23, $02,	$59, $59, $59, $4A
	; $03, $03, $03, $05,	$00, $00, $00, $00
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$00, $02, $00, $06
	smpsVcCoarseFreq	$02, $03, $02, $01
	smpsVcRateScale	$01, $01, $01, $01
	smpsVcAttackRate	$0A, $19, $19, $19
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $03, $03, $03
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$02, $02, $02, $02
	smpsVcReleaseRate	$07, $02, $02, $02
	smpsVcTotalLevel	$00, $25, $20, $1E

	; Voice $0A
	; $0C
	; $00, $00, $06, $01,	$19, $59, $D9, $59
	; $02, $06, $02, $0C,	$0A, $0A, $09, $0F
	smpsVcAlgorithm	$04
	smpsVcFeedback	$01
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $06, $00, $00
	smpsVcRateScale	$01, $03, $01, $00
	smpsVcAttackRate	$19, $19, $19, $19
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0C, $02, $06, $02
	smpsVcDecayRate2	$0F, $09, $0A, $0A
	smpsVcDecayLevel	$0A, $00, $01, $01
	smpsVcReleaseRate	$05, $02, $05, $04
	smpsVcTotalLevel	$00, $1A, $00, $14

	; Voice $0B
	; $3B
	; $61, $02, $24, $05,	$5F, $5F, $5F, $4F
	; $03, $03, $03, $07,	$00, $00, $00, $04
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$00, $02, $00, $06
	smpsVcCoarseFreq	$05, $04, $02, $01
	smpsVcRateScale	$01, $01, $01, $01
	smpsVcAttackRate	$0F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$07, $03, $03, $03
	smpsVcDecayRate2	$04, $00, $00, $00
	smpsVcDecayLevel	$02, $02, $02, $02
	smpsVcReleaseRate	$07, $02, $02, $03
	smpsVcTotalLevel	$00, $25, $20, $1F

	; Voice $0C
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
	smpsVcReleaseRate	$08, $08, $08, $04
	smpsVcTotalLevel	$09, $09, $09, $1C

	; Voice $0D
	; $3C
	; $21, $02, $01, $62,	$CF, $0D, $CF, $0C
	; $00, $04, $00, $04,	$00, $00, $00, $00
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$06, $00, $00, $02
	smpsVcCoarseFreq	$02, $01, $02, $01
	smpsVcRateScale	$00, $03, $00, $03
	smpsVcAttackRate	$0C, $0F, $0D, $0F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$04, $00, $04, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$03, $00, $03, $00
	smpsVcReleaseRate	$08, $02, $07, $02
	smpsVcTotalLevel	$00, $1F, $00, $1E

	; Voice $0E
	; $3A
	; $0C, $1F, $01, $13,	$1F, $DF, $1F, $9F
	; $0C, $02, $0C, $05,	$04, $04, $04, $07
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$01, $00, $01, $00
	smpsVcCoarseFreq	$03, $01, $0F, $0C
	smpsVcRateScale	$02, $00, $03, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $0C, $02, $0C
	smpsVcDecayRate2	$07, $04, $04, $04
	smpsVcDecayLevel	$02, $00, $0F, $01
	smpsVcReleaseRate	$07, $06, $06, $0A
	smpsVcTotalLevel	$00, $1B, $36, $1D

	; Voice $0F
	; $3E
	; $34, $00, $75, $02,	$5E, $DF, $5F, $9C
	; $0F, $04, $0F, $0A,	$02, $02, $05, $05
	smpsVcAlgorithm	$06
	smpsVcFeedback	$07
	smpsVcDetune	$00, $07, $00, $03
	smpsVcCoarseFreq	$02, $05, $00, $04
	smpsVcRateScale	$02, $01, $03, $01
	smpsVcAttackRate	$1C, $1F, $1F, $1E
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $0F, $04, $0F
	smpsVcDecayRate2	$05, $05, $02, $02
	smpsVcDecayLevel	$0F, $0F, $0A, $0A
	smpsVcReleaseRate	$06, $0A, $02, $07
	smpsVcTotalLevel	$00, $23, $00, $28

	; Voice $10
	; $3B
	; $3F, $31, $10, $34,	$0D, $1F, $0E, $1F
	; $0A, $0A, $A0, $04,	$00, $00, $00, $05
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$03, $01, $03, $03
	smpsVcCoarseFreq	$04, $00, $01, $0F
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $0E, $1F, $0D
	smpsVcAmpMod	$00, $01, $00, $00
	smpsVcDecayRate1	$04, $00, $0A, $0A
	smpsVcDecayRate2	$05, $00, $00, $00
	smpsVcDecayLevel	$0A, $01, $0A, $05
	smpsVcReleaseRate	$09, $05, $00, $03
	smpsVcTotalLevel	$00, $11, $1D, $26

	; Voice $11
	; $3C
	; $62, $24, $13, $46,	$C9, $AE, $C9, $4E
	; $03, $05, $03, $05,	$01, $00, $01, $00
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$04, $01, $02, $06
	smpsVcCoarseFreq	$06, $03, $04, $02
	smpsVcRateScale	$01, $03, $02, $03
	smpsVcAttackRate	$0E, $09, $0E, $09
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $03, $05, $03
	smpsVcDecayRate2	$00, $01, $00, $01
	smpsVcDecayLevel	$02, $02, $02, $02
	smpsVcReleaseRate	$07, $02, $06, $02
	smpsVcTotalLevel	$00, $10, $03, $11

	; Voice $12
	; $3C
	; $24, $18, $23, $26,	$59, $4A, $59, $4A
	; $03, $05, $03, $05,	$00, $00, $00, $00
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$02, $02, $01, $02
	smpsVcCoarseFreq	$06, $03, $08, $04
	smpsVcRateScale	$01, $01, $01, $01
	smpsVcAttackRate	$0A, $19, $0A, $19
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$05, $03, $05, $03
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$02, $02, $02, $02
	smpsVcReleaseRate	$07, $02, $07, $02
	smpsVcTotalLevel	$00, $19, $05, $1C

	; Voice $13
	; $3C
	; $0B, $04, $0A, $01,	$1F, $1E, $1F, $1F
	; $0F, $0E, $11, $10,	$13, $0F, $11, $0E
	smpsVcAlgorithm	$04
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $0A, $04, $0B
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1E, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$10, $11, $0E, $0F
	smpsVcDecayRate2	$0E, $11, $0F, $13
	smpsVcDecayLevel	$00, $01, $00, $02
	smpsVcReleaseRate	$08, $07, $07, $04
	smpsVcTotalLevel	$00, $0B, $00, $10

	; Voice $14
	; $06
	; $02, $34, $73, $32,	$0A, $8C, $4C, $52
	; $00, $00, $00, $00,	$01, $00, $01, $00
	smpsVcAlgorithm	$06
	smpsVcFeedback	$00
	smpsVcDetune	$03, $07, $03, $00
	smpsVcCoarseFreq	$02, $03, $04, $02
	smpsVcRateScale	$01, $01, $02, $00
	smpsVcAttackRate	$12, $0C, $0C, $0A
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $00, $00, $00
	smpsVcDecayRate2	$00, $01, $00, $01
	smpsVcDecayLevel	$00, $02, $00, $00
	smpsVcReleaseRate	$06, $06, $05, $03
	smpsVcTotalLevel	$10, $00, $05, $3D

	; Voice $15
	; $3A
	; $38, $4A, $40, $31,	$1F, $DF, $5F, $9F
	; $0C, $0A, $0C, $0F,	$04, $04, $04, $0B
	smpsVcAlgorithm	$02
	smpsVcFeedback	$07
	smpsVcDetune	$03, $04, $04, $03
	smpsVcCoarseFreq	$01, $00, $0A, $08
	smpsVcRateScale	$02, $01, $03, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0F, $0C, $0A, $0C
	smpsVcDecayRate2	$0B, $04, $04, $04
	smpsVcDecayLevel	$03, $00, $0F, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $0C, $31, $1E

	; Voice $16
	; $40
	; $01, $03, $00, $01,	$15, $13, $16, $12
	; $0C, $0A, $0B, $0B,	$00, $00, $00, $00
	smpsVcAlgorithm	$00
	smpsVcFeedback	$00
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $00, $03, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$12, $16, $13, $15
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0B, $0B, $0A, $0C
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$00, $00, $00, $00
	smpsVcReleaseRate	$08, $07, $07, $07
	smpsVcTotalLevel	$00, $2D, $16, $1F

	; Voice $17
	; $3B
	; $52, $31, $31, $51,	$0C, $14, $12, $14
	; $0C, $00, $0E, $02,	$0E, $09, $09, $01
	smpsVcAlgorithm	$03
	smpsVcFeedback	$07
	smpsVcDetune	$05, $03, $03, $05
	smpsVcCoarseFreq	$01, $01, $01, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$14, $12, $14, $0C
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$02, $0E, $00, $0C
	smpsVcDecayRate2	$01, $09, $09, $0E
	smpsVcDecayLevel	$03, $05, $00, $04
	smpsVcReleaseRate	$0A, $04, $03, $06
	smpsVcTotalLevel	$00, $1D, $18, $1C

	; Voice $18
	; $0B
	; $02, $01, $0F, $02,	$07, $1F, $09, $1F
	; $05, $02, $0C, $1F,	$00, $04, $00, $00
	smpsVcAlgorithm	$03
	smpsVcFeedback	$01
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$02, $0F, $01, $02
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $09, $1F, $07
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$1F, $0C, $02, $05
	smpsVcDecayRate2	$00, $00, $04, $00
	smpsVcDecayLevel	$00, $03, $00, $03
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $3A, $10, $0B

	; Voice $19
	; $3E
	; $0F, $02, $32, $72,	$1F, $1F, $1F, $1F
	; $00, $18, $00, $00,	$00, $0F, $0F, $0F
	smpsVcAlgorithm	$06
	smpsVcFeedback	$07
	smpsVcDetune	$07, $03, $00, $00
	smpsVcCoarseFreq	$02, $02, $02, $0F
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$00, $00, $18, $00
	smpsVcDecayRate2	$0F, $0F, $0F, $00
	smpsVcDecayLevel	$00, $00, $09, $02
	smpsVcReleaseRate	$04, $0C, $0A, $00
	smpsVcTotalLevel	$00, $00, $00, $00

	; Voice $1A
	; $3D
	; $01, $21, $51, $01,	$12, $14, $1A, $0F
	; $0A, $07, $07, $07,	$00, $00, $00, $00
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $05, $02, $00
	smpsVcCoarseFreq	$01, $01, $01, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$0F, $1A, $14, $12
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$07, $07, $07, $0A
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$01, $02, $02, $02
	smpsVcReleaseRate	$08, $0B, $0B, $0B
	smpsVcTotalLevel	$00, $00, $00, $19
