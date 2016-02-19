IceCap1_Header:
	smpsHeaderStartSong	
	smpsHeaderVoice	IceCap1_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $14
	smpsHeaderDAC	IceCap1_DAC
	smpsHeaderFM	IceCap1_FM1, $00, $02
	smpsHeaderFM	IceCap1_FM2, $F4, $08
	smpsHeaderFM	IceCap1_FM3, $F4, $08
	smpsHeaderFM	IceCap1_FM4, $F4, $08
	smpsHeaderFM	IceCap1_FM5, $F4, $08
	smpsHeaderPSG	IceCap1_PSG1, $E8, $01, $00, sTone_06
	smpsHeaderPSG	IceCap1_PSG2, $E8, $02, $00, sTone_06
	smpsHeaderPSG	IceCap1_PSG3, $00, $03, $00, sTone_02

IceCap1_FM1:
IceCap1_Jump2:
	smpsSetvoice	$00

IceCap1_Loop5:
	dc.b nC3, $0C, $18, $06, nC3, nBb2, $0C, $18
	dc.b $06, nBb2, nAb2, $0C, $18, $06, nAb2, nG2
	dc.b $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C
	dc.b $18, $06, nBb2, nBb2, $0C, $18, $06, nBb2
	smpsLoop	$01, $04, IceCap1_Loop5
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, nBb2, nBb2, nBb2
	dc.b nG2, $0C, $06, nG2, nG2, $0C, $06, nG2
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	dc.b nG2, $0C, $06, nG2, nG2, $0C, $06, nG2
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, nBb2, nBb2, nBb2
	dc.b nG2, $0C, $06, nG2, nG2, $0C, $06, nG2
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2

IceCap1_Loop6:
	dc.b nC3, $0C, $18, $06, nC3, nBb2, $0C, $18
	dc.b $06, nBb2, nAb2, $0C, $18, $06, nAb2, nG2
	dc.b $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C
	dc.b $18, $06, nBb2, nBb2, $0C, $18, $06, nBb2
	smpsLoop	$01, $02, IceCap1_Loop6

IceCap1_Loop7:
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, nBb2, nBb2, nBb2
	dc.b nG2, $0C, $06, nG2, nG2, $0C, $06, nG2
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	dc.b nG2, $0C, $06, nG2, nG2, $0C, $06, nG2
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, nBb2, nBb2, nBb2
	dc.b nG2, $0C, $06, nG2, nG2, $0C, $06, nG2
	dc.b nC3, $0C, $06, nC3, nC3, $0C, $06, nC3
	dc.b nAb2, $0C, $06, nAb2, nAb2, $0C, $06, nAb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	dc.b nBb2, $0C, $06, nBb2, nBb2, $0C, $06, nBb2
	smpsLoop	$01, $02, IceCap1_Loop7
	smpsJump	IceCap1_Jump2

IceCap1_FM2:
IceCap1_Jump3:
	smpsAlterPitch	$0C
	smpsSetvoice	$01
	smpsModSet	$01, $01, $03, $03

IceCap1_Loop8:
	dc.b nG4, $30, smpsNoAttack, $30, smpsNoAttack, nG4, nF4, nG4
	dc.b smpsNoAttack, $30, nF4, smpsNoAttack, $30
	smpsLoop	$01, $04, IceCap1_Loop8
	smpsAlterPitch	$F4
	smpsSetvoice	$02

IceCap1_Loop9:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, smpsNoAttack, $30
	smpsLoop	$01, $02, IceCap1_Loop9
	smpsSetvoice	$01
	smpsAlterPitch	$0C

IceCap1_Loop10:
	dc.b nG4, $30, smpsNoAttack, $30, smpsNoAttack, nG4, nF4, nG4
	dc.b smpsNoAttack, $30, nF4, smpsNoAttack, $30
	smpsLoop	$01, $02, IceCap1_Loop10
	smpsAlterPitch	$F4
	smpsSetvoice	$02

IceCap1_Loop11:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, smpsNoAttack, $30
	smpsLoop	$01, $04, IceCap1_Loop11
	smpsJump	IceCap1_Jump3

IceCap1_FM3:
IceCap1_Loop13:
IceCap1_Jump4:
	smpsSetvoice	$04
	smpsModSet	$01, $01, $A1, $FF
	smpsPan	 panLeft, $00
	dc.b nG6, $09, nRst, $27, nRst, $06
	smpsSetvoice	$05
	smpsFMAlterVol	$2C
	smpsPan	 panRight, $00

IceCap1_Loop12:
	dc.b nBb2, $01
	smpsFMAlterVol	$FD
	smpsLoop	$00, $12, IceCap1_Loop12
	smpsFMAlterVol	$0A
	dc.b nRst, $18
	smpsSetvoice	$01
	smpsModSet	$01, $01, $03, $03
	smpsPan	 panCentre, $00
	dc.b nAb3, $30, nG3, nRst, nRst, nRst, nRst
	smpsLoop	$01, $04, IceCap1_Loop13

IceCap1_Loop14:
	dc.b nEb4, $30, nC4, nD4, nBb3, nEb4, nC4, nD4
	dc.b smpsNoAttack, $30
	smpsLoop	$01, $02, IceCap1_Loop14
	smpsSetvoice	$01
	smpsModSet	$01, $01, $03, $03
	smpsPan	 panCentre, $00
	dc.b nRst, nRst, nAb3, $30, nG3, nRst, nRst
	smpsSetvoice	$04
	smpsModSet	$01, $01, $A1, $FF
	smpsPan	 panLeft, $00
	dc.b nG6, $09, nRst, $27, nRst, $06
	smpsSetvoice	$05
	smpsFMAlterVol	$2C
	smpsPan	 panRight, $00

IceCap1_Loop15:
	dc.b nBb2, $01
	smpsFMAlterVol	$FD
	smpsLoop	$00, $12, IceCap1_Loop15
	smpsFMAlterVol	$0A
	dc.b nRst, $18
	smpsSetvoice	$01
	smpsModSet	$01, $01, $03, $03
	smpsPan	 panCentre, $00
	dc.b nRst, $30, nRst, nAb3, nG3, nRst, nRst, nRst
	dc.b nRst

IceCap1_Loop16:
	dc.b nEb4, $30, nC4, nD4, nBb3, nEb4, nC4, nD4
	dc.b smpsNoAttack, $30
	smpsLoop	$01, $04, IceCap1_Loop16
	smpsJump	IceCap1_Jump4

IceCap1_FM4:
IceCap1_Jump5:
	smpsAlterPitch	$0C
	smpsSetvoice	$01
	smpsModSet	$01, $01, $03, $03

IceCap1_Loop17:
	dc.b nC4, $30, nBb3, nC4, nBb3, nC4, nBb3, smpsNoAttack
	dc.b nBb3, smpsNoAttack, $30
	smpsLoop	$00, $04, IceCap1_Loop17
	smpsAlterPitch	$F4
	smpsSetvoice	$03
	smpsModSet	$00, $00, $00, $00
	smpsPan	 panRight, $00

IceCap1_Loop18:
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4
	dc.b nG4
	smpsLoop	$00, $03, IceCap1_Loop18
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5
	smpsPan	 panCentre, $00
	smpsSetvoice	$01
	smpsAlterPitch	$0C
	smpsModSet	$01, $01, $03, $03

IceCap1_Loop19:
	dc.b nC4, $30, nBb3, nC4, nBb3, nC4, nBb3, smpsNoAttack
	dc.b nBb3, smpsNoAttack, $30
	smpsLoop	$00, $02, IceCap1_Loop19
	smpsAlterPitch	$F4
	smpsSetvoice	$03
	smpsModSet	$00, $00, $00, $00
	smpsPan	 panRight, $00

IceCap1_Loop20:
IceCap1_Loop21:
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4
	dc.b nG4
	smpsLoop	$01, $03, IceCap1_Loop20
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5
	smpsLoop	$00, $02, IceCap1_Loop21
	smpsPan	 panCentre, $00
	smpsJump	IceCap1_Jump5

IceCap1_FM5:
IceCap1_Jump6:
	smpsAlterPitch	$0C
	smpsSetvoice	$01
	smpsModSet	$01, $01, $03, $03

IceCap1_Loop22:
	dc.b nEb4, $30, smpsNoAttack, $30, smpsNoAttack, nEb4, nD4, nEb4
	dc.b smpsNoAttack, $30, nD4, smpsNoAttack, $30
	smpsLoop	$01, $04, IceCap1_Loop22
	smpsAlterPitch	$F4
	smpsSetvoice	$03
	smpsModSet	$00, $00, $00, $00

IceCap1_Loop23:
	dc.b nC4, $06, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4
	dc.b nBb4, nC4, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4
	smpsLoop	$01, $02, IceCap1_Loop23
	smpsSetvoice	$01
	smpsAlterPitch	$0C
	smpsModSet	$01, $01, $03, $03

IceCap1_Loop24:
	dc.b nEb4, $30, smpsNoAttack, $30, smpsNoAttack, nEb4, nD4, nEb4
	dc.b smpsNoAttack, $30, nD4, smpsNoAttack, $30
	smpsLoop	$01, $02, IceCap1_Loop24
	smpsAlterPitch	$F4
	smpsSetvoice	$03
	smpsModSet	$00, $00, $00, $00

IceCap1_Loop25:
	dc.b nC4, $06, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4
	dc.b nBb4, nC4, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4
	smpsLoop	$01, $04, IceCap1_Loop25
	smpsJump	IceCap1_Jump6

IceCap1_PSG1:
IceCap1_Jump7:
	smpsPSGvoice	 sTone_02
	smpsAlterPitch	$18
	smpsNoteFill	$09

IceCap1_Loop26:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	smpsLoop	$01, $10, IceCap1_Loop26
	smpsAlterPitch	$E8
	smpsNoteFill	$00
	smpsPSGvoice	 sTone_16

IceCap1_Loop27:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, smpsNoAttack, $30
	smpsLoop	$01, $02, IceCap1_Loop27
	smpsPSGvoice	 sTone_02
	smpsAlterPitch	$18
	smpsNoteFill	$09

IceCap1_Loop28:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	smpsLoop	$01, $07, IceCap1_Loop28
	dc.b nRst, $30, nRst
	smpsAlterPitch	$E8
	smpsNoteFill	$00
	smpsPSGvoice	 sTone_16

IceCap1_Loop29:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, smpsNoAttack, $30
	smpsLoop	$01, $04, IceCap1_Loop29
	smpsJump	IceCap1_Jump7

IceCap1_PSG2:
	smpsAlterNote	$01

IceCap1_Jump8:
	smpsPSGvoice	 sTone_01
	smpsAlterPitch	$18
	smpsNoteFill	$09
	smpsModSet	$00, $01, $01, $02

IceCap1_Loop30:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	smpsLoop	$01, $10, IceCap1_Loop30
	smpsAlterPitch	$E8
	smpsNoteFill	$00
	smpsPSGvoice	 sTone_16
	smpsPSGAlterVol	$02
	dc.b nRst, $18
	smpsModSet	$00, $01, $01, $03
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, smpsNoAttack, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b nC5, $18, nC6, nBb5, $30, nD5, smpsNoAttack, $18
	smpsPSGAlterVol	$FE
	smpsModSet	$00, $00, $00, $00
	smpsPSGvoice	 sTone_01
	smpsAlterPitch	$18
	smpsModSet	$00, $01, $01, $02
	smpsNoteFill	$09

IceCap1_Loop31:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	smpsLoop	$01, $07, IceCap1_Loop31
	dc.b nRst, $30, nRst
	smpsAlterPitch	$E8
	smpsNoteFill	$00
	smpsPSGvoice	 sTone_16
	smpsPSGAlterVol	$02
	dc.b nRst, $18
	smpsModSet	$00, $01, $01, $03

IceCap1_Loop32:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, smpsNoAttack, $30
	smpsLoop	$01, $03, IceCap1_Loop32
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, smpsNoAttack, $18
	smpsPSGAlterVol	$FE
	smpsModSet	$00, $00, $00, $00
	smpsJump	IceCap1_Jump8

IceCap1_PSG3:
	smpsPSGform	$E7
	smpsPSGvoice	 sTone_02

IceCap1_Loop33:
IceCap1_Jump9:
	dc.b nRst, $0C, nB6, $18, nB6, nB6, nB6, $0C
	smpsLoop	$01, $1F, IceCap1_Loop33
	dc.b nRst, $0C, nB6, $18, nB6, nRst, $24

IceCap1_Loop34:
	dc.b nRst, $0C, nB6, $18, nB6, nB6, nB6, $0C
	smpsLoop	$01, $10, IceCap1_Loop34
	smpsJump	IceCap1_Jump9

IceCap1_DAC:
IceCap1_Loop1:
IceCap1_Jump1:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick
	dc.b $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick
	dc.b $0C, dBassHey, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12
	dc.b dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit
	dc.b dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit
	dc.b dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit
	smpsLoop	$00, $04, IceCap1_Loop1

IceCap1_Loop2:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b dReverseFadingWind, $0C, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $06
	dc.b dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, dHipHopHitKick3, $0C, $06, dDanceStyleKick
	dc.b $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit
	dc.b $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18
	dc.b dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C
	dc.b dQuickHit, $06, dQuickHit
	smpsLoop	$00, $02, IceCap1_Loop2

IceCap1_Loop3:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit
	dc.b dDanceStyleKick, $0C, dBassHey, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst
	dc.b $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit
	dc.b dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit
	dc.b dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick
	dc.b $18, dDanceStyleKick, dDanceStyleKick, $0C, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick
	smpsLoop	$00, $02, IceCap1_Loop3

IceCap1_Loop4:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b dReverseFadingWind, $0C, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $06
	dc.b dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, dHipHopHitKick3, $0C, $06, dDanceStyleKick
	dc.b $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit
	dc.b $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18
	dc.b dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C
	dc.b dQuickHit, $06, dQuickHit
	smpsLoop	$00, $04, IceCap1_Loop4
	smpsJump	IceCap1_Jump1

IceCap1_Voices:
	dc.b $20, $34, $38, $30, $31, $DF, $DF, $9F, $9F, $07, $08, $08, $0A, $07, $0E, $0A, $11, $20, $1F, $1F, $1F, $22, $37, $14, $80
	dc.b $35, $02, $04, $02, $01, $10, $0A, $0C, $0E, $07, $04, $04, $04, $01, $0A, $0A, $0A, $28, $1B, $1B, $1B, $1D, $8E, $8D, $8E
	dc.b $2D, $02, $02, $02, $02, $10, $10, $10, $10, $07, $08, $08, $08, $01, $05, $05, $05, $28, $1B, $1B, $1B, $20, $86, $86, $89
	dc.b $06, $04, $04, $03, $34, $1F, $1F, $1F, $1F, $0F, $0F, $0F, $0F, $0D, $12, $11, $10, $1F, $0F, $1F, $0F, $1D, $84, $96, $80
	dc.b $3D, $00, $04, $07, $0A, $1F, $1F, $1F, $1F, $1F, $1D, $1D, $1D, $05, $06, $16, $00, $09, $1F, $1F, $1F, $34, $8D, $87, $86
	dc.b $32, $38, $46, $4F, $32, $1F, $1F, $1F, $1F, $0E, $1C, $16, $02, $00, $00, $00, $00, $60, $60, $40, $39, $05, $04, $18, $80
