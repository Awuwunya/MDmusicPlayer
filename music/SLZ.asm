StarLight_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	StarLight_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$02, $06
	smpsHeaderDAC	StarLight_DAC
	smpsHeaderFM	StarLight_FM1, $E8, $00
	smpsHeaderFM	StarLight_FM2, $E8, $06
	smpsHeaderFM	StarLight_FM3, $DC, $1A
	smpsHeaderFM	StarLight_FM4, $DC, $1A
	smpsHeaderFM	StarLight_FM5, $F4, $20
	smpsHeaderPSG	StarLight_PSG1, $C4, $06, $00, sTone_05
	smpsHeaderPSG	StarLight_PSG2, $C4, $06, $00, sTone_05
	smpsHeaderPSG	StarLight_PSG3, $00, $04, $00, sTone_04

StarLight_FM1:
	smpsSetvoice	$00
	dc.b nRst, $0C, nG5, nA5, nG6

StarLight_Jump2:
	smpsCall	StarLight_Call1
	dc.b nE6, $1E

StarLight_Loop1:
	dc.b nE7, $06, nC7, $3C, nRst, $1E
	smpsLoop	$00, $03, StarLight_Loop1
	dc.b nE7, $06, nC7, $18, nG5, $0C, nA5, nG6
	smpsJump	StarLight_Jump2

StarLight_Call1:
	smpsCall	StarLight_Call2
	dc.b nE6, $1E, nF6, $06, nE6, nD6, $12, nG5
	dc.b $0C, nA5, nG6
	smpsCall	StarLight_Call2
	smpsReturn	

StarLight_Call2:
	dc.b nE6, $2A, nE6, $03, nF6, nG6, $09, nA6
	dc.b nBb6, $06, nA6, $0C, nG6, nF6, $1E, nF6
	dc.b $06, nE6, nF6, $1E, nD6, $0C, nE6, nF6
	dc.b $2A, nD6, $03, nE6, nF6, $09, nG6, nAb6
	dc.b $06, nG6, $0C, nF6
	smpsReturn	

StarLight_FM2:
	smpsSetvoice	$01
	smpsNop	$01
	dc.b nRst, $30

StarLight_Jump3:
	smpsCall	StarLight_Call3
	dc.b nRst, $06, nB3, $02, nRst, $01, nB3, $02
	dc.b nRst, $01, nC4, $06, nRst, $03, nC4, nRst
	dc.b $06, nC4, $12, nRst, $06, nC4, $02, nRst
	dc.b $01, nC4, $02, nRst, $01, nD4, $06, nRst
	dc.b $03, nD4, nRst, $06, nG3, $12, nD4, $06
	dc.b nG3
	smpsCall	StarLight_Call3
	dc.b nRst, $06, nD4, $02, nRst, $01, nB3, $02
	dc.b nRst, $01
	smpsCall	StarLight_Call4
	dc.b nB3, $02, nRst, $01, nE4, $02, nRst, $01
	dc.b nF4, $06, nRst, $03, nF4, nRst, $06, nF4
	dc.b $12, nRst, $06, nG4, $02, nRst, $01, nF4
	dc.b $02, nRst, $01
	smpsCall	StarLight_Call4
	dc.b nE4, $02, nRst, $01, nF4, $02, nRst, $01
	dc.b nG4, $06, nRst, nG3, $24
	smpsNop	$01
	smpsJump	StarLight_Jump3

StarLight_Call3:
	dc.b nC4, $06, nRst, $03, nC4, nRst, $06, nC4
	dc.b $12, nRst, $06, nC4, $02, nRst, $01, nC4
	dc.b $02, nRst, $01, nBb3, $06, nRst, $03, nBb3
	dc.b $03, nRst, $06, nA3, $12, nRst, $06, nA3
	dc.b $02, nRst, $01, nA3, $02, nRst, $01
StarLight_Loop2:
	dc.b nD4, $06, nRst, $03, nD4, $06, nRst, $03
	dc.b nD4, $02, nRst, $01, nD4, $02, nRst, $01
	smpsAlterPitch	$FF
	smpsLoop	$00, $04, StarLight_Loop2
	smpsAlterPitch	$04
	dc.b nG3, $06, nRst, $03, nG3, nRst, $06, nG3
	dc.b $12, nRst, $06, nG3, $02, nRst, $01, nG3
	dc.b $02, nRst, $01, nB3, $06, nRst, $03, nB3
	dc.b nRst, $06, nB3, $12
	smpsReturn	

StarLight_Call4:
	dc.b nC4, $06, nRst, $03, nC4, nRst, $06, nC4
	dc.b $12, nRst, $06, nG3, $02, nRst, $01, nC4
	dc.b $02, nRst, $01, nD4, $06, nRst, $03, nD4
	dc.b nRst, $06, nD4, $12, nRst, $06, nA3, $02
	dc.b nRst, $01, nD4, $02, nRst, $01, nE4, $06
	dc.b nRst, $03, nE4, nRst, $06, nE4, $12, nRst
	dc.b $06
	smpsReturn	

StarLight_FM3:
	smpsSetvoice	$02
	smpsPan	 panLeft, $00

StarLight_PSG1:
	dc.b nRst, $30
StarLight_Jump4:
	smpsCall	StarLight_Call5
	dc.b nG6, $06, nRst, $03, nG6, nRst, $06, nG6
	dc.b $12, nRst, $06, nB6, $09, nRst, $03, nB6
	dc.b nRst, nA6, $09, nRst, $03, nG6, nRst, nF6
	dc.b $0C, nRst, $06
	smpsCall	StarLight_Call5
	smpsCall	StarLight_Call6
	smpsNoteFill	$08
	dc.b nRst, $06, nE7, $09, $09, $09, nD7, $09
	dc.b nC7, $06
	smpsCall	StarLight_Call6
	smpsNoteFill	$00
	dc.b nRst, $0C, nA6, $24
	smpsJump	StarLight_Jump4

StarLight_Call5:
	dc.b nG6, $06, nRst, $03, nG6, nRst, $06, nG6
	dc.b $18, nRst, $06, nF6, nRst, $03, nF6, nRst
	dc.b $06, nE6, $18, nRst, $06, nA6, nRst, $03
	dc.b nG6, $06, nRst, $03, nF6, nRst, nA6, $06
	dc.b nRst, $03, nG6, $06, nRst, $03, nF6, nRst
	dc.b nA6, $06, nRst, $03, nG6, $06, nRst, $03
	dc.b nF6, $18, nRst, $06, nF6, nRst, $03, nF6
	dc.b nRst, $06, nF6, $18, nRst, $06, nAb6, nRst
	dc.b $03, nAb6, nRst, $06, nAb6, $18, nRst, $06
	smpsReturn	

StarLight_Call6:
	smpsNoteFill	$08
	dc.b nRst, $06, nB6, $09, $09, $09, $09
	smpsNoteFill	$05
	dc.b $03, $03
	smpsNoteFill	$08
	dc.b nRst, $06, nC7, $09, $09, $09, $09
	smpsNoteFill	$05
	dc.b $03, $03
	smpsNoteFill	$08
	dc.b nRst, $06, nD7, $09, $09, $09, $09
	smpsNoteFill	$05
	dc.b $03, $03
	smpsReturn	

StarLight_FM4:
	smpsSetvoice	$02
	smpsPan	 panRight, $00

StarLight_PSG2:
	dc.b nRst, $30
StarLight_Jump5:
	smpsCall	StarLight_Call7
	dc.b nE6, $06, nRst, $03, nE6, nRst, $06, nE6
	dc.b $12, nRst, $06, nG6, $09, nRst, $03, nG6
	dc.b nRst, nF6, $09, nRst, $03, nE6, nRst, nD6
	dc.b $0C, nRst, $06
	smpsCall	StarLight_Call7
	smpsCall	StarLight_Call8
	smpsNoteFill	$08
	dc.b nRst, $06, nC7, $09, $09, $09, nB6, $09
	dc.b nA6, $06
	smpsNoteFill	$08
	smpsCall	StarLight_Call8
	smpsNoteFill	$00
	dc.b nRst, $0C, nF6, $24
	smpsJump	StarLight_Jump5

StarLight_Call7:
	dc.b nE6, $06, nRst, $03, nE6, nRst, $06, nE6
	dc.b $18, nRst, $06, nD6, nRst, $03, nD6, nRst
	dc.b $06, nCs6, $18, nRst, $06, nF6, nRst, $03
	dc.b nE6, $06, nRst, $03, nD6, nRst, nF6, $06
	dc.b nRst, $03, nE6, $06, nRst, $03, nD6, nRst
	dc.b nF6, $06, nRst, $03, nE6, $06, nRst, $03
	dc.b nD6, $18, nRst, $06, nD6, nRst, $03, nD6
	dc.b nRst, $06, nD6, $18, nRst, $06, nF6, nRst
	dc.b $03, nF6, nRst, $06, nF6, $18, nRst, $06
	smpsReturn	

StarLight_Call8:
	smpsNoteFill	$08
	dc.b nRst, $06, nG6, $09, $09, $09, $09
	smpsNoteFill	$05
	dc.b $03, $03
	smpsNoteFill	$08
	dc.b nRst, $06, nA6, $09, $09, $09, $09
	smpsNoteFill	$05
	dc.b $03, $03
	smpsNoteFill	$08
	dc.b nRst, $06, nB6, $09, $09, $09, $09
	smpsNoteFill	$05
	dc.b $03, $03
	smpsReturn	

StarLight_FM5:
	smpsSetvoice	$04
	dc.b nRst, $0C, nG5, nA5, nG6

StarLight_Jump6:
	smpsSetvoice	$04
	smpsCall	StarLight_Call1
	dc.b nE6, $06
	smpsSetvoice	$03
	smpsFMAlterVol	$EC
	smpsCall	StarLight_Call9
	smpsAlterNote	$14
	dc.b nA5, $01, smpsNoAttack
	smpsAlterNote	$00
	dc.b nA5, $05
	smpsCall	StarLight_Call11
	dc.b nEb4
	smpsFMAlterVol	$07
	dc.b nEb4
	smpsSetvoice	$03
	smpsFMAlterVol	$E8
	smpsAlterPitch	$CD
	dc.b nRst, $06
	smpsAlterNote	$14
	dc.b nE6, $01, smpsNoAttack
	smpsAlterNote	$00
	dc.b nE6, $05, nF6, $06, nE6, nF6, nG6, nRst
	dc.b nC6, nRst, $06
	smpsCall	StarLight_Call9
	smpsNoteFill	$05
	dc.b nA5, $03, $03
	smpsNoteFill	$00
	smpsCall	StarLight_Call11
	smpsSetvoice	$03
	smpsFMAlterVol	$EF
	smpsAlterPitch	$CD
	dc.b nE6, $03, nF6, nG6, $03, nRst, $09
	smpsAlterNote	$EC
	dc.b nC7, $01, smpsNoAttack
	smpsAlterNote	$00
	smpsModSet	$2C, $01, $04, $04
	dc.b nC7, $23
	smpsModOff	
	smpsFMAlterVol	$14
	smpsJump	StarLight_Jump6

StarLight_Call9:
	smpsCall	StarLight_Call10
	dc.b nEb4
	smpsFMAlterVol	$07
	dc.b nEb4
	smpsSetvoice	$03
	smpsFMAlterVol	$E8
	smpsAlterPitch	$CD
	dc.b nRst, $06
	smpsAlterNote	$14
	dc.b nE6, $01, smpsNoAttack
	smpsAlterNote	$00
	dc.b $05, nRst, $06
	smpsAlterNote	$14
	dc.b nC6, $01, smpsNoAttack
	smpsAlterNote	$00
	dc.b $05, nRst, $06
	smpsReturn	

StarLight_Call11:
	dc.b nC6, $06, nA5, nRst, $06
StarLight_Call10:
	smpsAlterNote	$14
	dc.b nG5, $01, smpsNoAttack
	smpsAlterNote	$00
	dc.b $02, nA5, $03
	smpsNoteFill	$05
	dc.b nC6, $03, nC6, $06, nA5, $03, nC6, $03
	smpsNoteFill	$00
	dc.b nC6, nRst
	smpsFMAlterVol	$FC
	smpsAlterPitch	$33
	smpsSetvoice	$05
	dc.b nEb4, $03
	smpsFMAlterVol	$07
	dc.b nEb4
	smpsFMAlterVol	$07
	dc.b nEb4
	smpsFMAlterVol	$07
	smpsReturn	
	; Unused
	dc.b $F6, $FF, $FE, $F6, $FF, $FE

StarLight_PSG3:
	smpsPSGform	$E7
	smpsNoteFill	$02
	dc.b nRst, $24

StarLight_Jump7:
	dc.b nA5, $03, $03
	smpsPSGAlterVol	$02
	smpsPSGvoice	 sTone_08
	smpsNoteFill	$08
	dc.b $06
	smpsPSGvoice	 sTone_04
	smpsNoteFill	$03
	smpsPSGAlterVol	$FE
	smpsJump	StarLight_Jump7

StarLight_DAC:
	dc.b nRst, $30
StarLight_Jump1:
	dc.b dKick, $0C
	smpsJump	StarLight_Jump1

StarLight_Voices:
	dc.b $34, $33, $41, $7E, $74, $5B, $9F, $5F, $1F, $04, $07, $07, $08, $00, $00, $00, $00, $FF, $FF, $EF, $FF, $23, $90, $29, $97
	dc.b $3A, $61, $3C, $14, $31, $9C, $DB, $9C, $DA, $04, $09, $04, $03, $03, $01, $03, $00, $1F, $0F, $0F, $AF, $21, $47, $31, $80
	dc.b $04, $72, $42, $32, $32, $1F, $1F, $1F, $1F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $00, $07, $23, $80, $23, $80
	dc.b $3A, $01, $07, $01, $01, $8E, $8E, $8D, $53, $0E, $0E, $0E, $03, $00, $00, $00, $00, $1F, $FF, $1F, $0F, $18, $28, $27, $80
	dc.b $3C, $38, $74, $76, $33, $10, $10, $10, $10, $02, $07, $04, $07, $03, $09, $03, $09, $2F, $2F, $2F, $2F, $1E, $80, $1E, $80
	dc.b $F4, $06, $04, $0F, $0E, $1F, $1F, $1F, $1F, $00, $00, $0B, $0B, $00, $00, $05, $08, $0F, $0F, $FF, $FF, $15, $85, $02, $8A
	dc.b $00
