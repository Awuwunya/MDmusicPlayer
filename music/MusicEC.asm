MusicEC_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	MusicEC_Voices
	smpsHeaderChan	$07, $03
	smpsHeaderTempo	$02, $05
	smpsHeaderDAC	MusicEC_DAC
	smpsHeaderFM	MusicEC_FM1, $00, $12
	smpsHeaderFM	MusicEC_FM2, $00, $0E
	smpsHeaderFM	MusicEC_FM3, $00, $10
	smpsHeaderFM	MusicEC_FM4, $00, $1D
	smpsHeaderFM	MusicEC_FM5, $00, $1D
	smpsHeaderFM	MusicEC_FM6, $00, $1C
	smpsHeaderPSG	MusicEC_PSG1, $DC, $02, $00, VolEnv_00
	smpsHeaderPSG	MusicEC_PSG2, $DC, $02, $00, VolEnv_00
	smpsHeaderPSG	MusicEC_PSG3, $DC, $02, $00, VolEnv_00

MusicEC_FM1:
	dc.b nRst, $06
MusicEC_Jump1:
	smpsPan	 panCentre, $00
	smpsSetvoice	$00
	dc.b nAb2, $04, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nEb2, nBb2, nCs3, nF3, nG3, nBb3, nCs4
	dc.b nF4, nG4, nBb4, nCs5, nF5, nCs2, nAb2, nB2
	dc.b nEb3, nE3, nAb3, nB3, nEb4, nE4, nAb4, nB4
	dc.b nEb5, nEb2, nBb2, nCs3, nF3, nG3, nBb3, nCs4
	dc.b nF4, nG4, nBb4, nCs5, nF5, nCs2, nAb2, nB2
	dc.b nEb3, nE3, nAb3, nB3, nEb4, nE4, nAb4, nB4
	dc.b nEb5, nEb2, nBb2, nCs3, nF3, nG3, nBb3, nCs4
	dc.b nF4, nG4, nBb4, nCs5, nF5, nCs2, nAb2, nB2
	dc.b nEb3, nE3, nAb3, nB3, nEb4, nE4, nAb4, nB4
	dc.b nEb5, nEb2, nBb2, nCs3, nF3, nG3, nBb3, nCs4
	dc.b nF4, nG4, nBb4, nCs5, nF5, nCs2, nAb2, nB2
	dc.b nEb3, nE3, nAb3, nB3, nEb4, nE4, nAb4, nB4
	dc.b $08
	smpsJump	MusicEC_Jump1

MusicEC_FM2:
MusicEC_Jump2:
	smpsPan	 panCentre, $00
	smpsSetvoice	$00
	dc.b nAb2, $04, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nAb2, nEb3, nAb3, nA3, nB3, nEb4, nAb4
	dc.b nA4, nB4, nEb5, nA5, nB5, nA5, nFs5, nCs5
	dc.b nA4, nFs4, nCs4, nA3, nFs3, nCs3, nA2, nFs2
	dc.b nFs3, nEb2, nBb2, nCs3, nF3, nG3, nBb3, nCs4
	dc.b nF4, nG4, nBb4, nCs5, nF5, nCs2, nAb2, nB2
	dc.b nEb3, nE3, nAb3, nB3, nEb4, nE4, nAb4, nB4
	dc.b nEb5, nEb2, nBb2, nCs3, nF3, nG3, nBb3, nCs4
	dc.b nF4, nG4, nBb4, nCs5, nF5, nCs2, nAb2, nB2
	dc.b nEb3, nE3, nAb3, nB3, nEb4, nE4, nAb4, nB4
	dc.b nEb5, nEb2, nBb2, nCs3, nF3, nG3, nBb3, nCs4
	dc.b nF4, nG4, nBb4, nCs5, nF5, nCs2, nAb2, nB2
	dc.b nEb3, nE3, nAb3, nB3, nEb4, nE4, nAb4, nB4
	dc.b nEb5, nEb2, nBb2, nCs3, nF3, nG3, nBb3, nCs4
	dc.b nF4, nG4, nBb4, nCs5, nF5, nCs2, nAb2, nB2
	dc.b nEb3, nE3, nAb3, nB3, nEb4, nE4, nAb4, nB4
	dc.b nEb5
	smpsJump	MusicEC_Jump2

MusicEC_FM3:
MusicEC_Jump3:
	smpsPan	 panCentre, $00
	smpsSetvoice	$01
	dc.b nAb1, $10, nEb2, nB2, nA2, nCs2, nFs1, nAb1
	dc.b nEb2, nB2, nFs2, nCs2, nFs1, nAb1, nEb2, nB2
	dc.b nA2, nCs2, nFs1, nAb1, nEb2, nB2, nFs2, nCs2
	dc.b nFs1, nAb1, nEb2, nB2, nA2, nCs2, nFs1, nAb1
	dc.b nEb2, nB2, nFs2, nCs2, nFs1, nAb1, nEb2, nB2
	dc.b nA2, nCs2, nFs1, nAb1, nEb2, nB2, nFs2, nCs2
	dc.b nFs1, nEb1, nBb1, nG2, nCs1, nB1, nEb2, nEb1
	dc.b nBb1, nG2, nCs1, nB1, nEb2, nEb1, nBb1, nG2
	dc.b nCs1, nB1, nEb2, nEb1, nBb1, nG2, nCs1, nB1
	dc.b nEb2
	smpsJump	MusicEC_Jump3

MusicEC_FM4:
MusicEC_Jump4:
	smpsPan	 panRight, $00
	smpsSetvoice	$02
	dc.b nEb4, $08
	smpsPan	 panCentre, $00
	dc.b $08, nEb5, $08, $08, nB4, $08, $08, nCs5
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nE5, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs5, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb5, $08
	smpsPan	 panCentre, $00
	dc.b $08, nB4, $08, $08, nAb4, $08, $08, nA4
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nEb4, $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08
	smpsPan	 panRight, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nEb5, $08, $08, nB4, $08, $08, nCs5
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nE5, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs5, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb5, $08
	smpsPan	 panCentre, $00
	dc.b $08, nAb5, $08, $08, nFs5, $08, $08, nE5
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nEb5, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs5, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb4, $08
	smpsPan	 panCentre, $00
	dc.b $08, nEb5, $08, $08, nB4, $08, $08, nCs5
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nE5, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs5, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb5, $08
	smpsPan	 panCentre, $00
	dc.b $08, nB4, $08, $08, nAb4, $08, $08, nA4
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nEb4, $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08
	smpsPan	 panRight, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nEb5, $08, $08, nB4, $08, $08, nCs5
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nE5, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs5, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb5, $08
	smpsPan	 panCentre, $00
	dc.b $08, nAb5, $08, $08, nFs5, $08, $08, nA5
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb5, $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08, $08, $08, nCs5, $08, $08
	smpsPan	 panLeft, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nD5, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb5, $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08, $08, $08, nCs5, $08, $08
	smpsPan	 panLeft, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nD5, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb5, $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08, $08, $08, nCs5, $08, $08
	smpsPan	 panLeft, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nD5, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb5, $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08, $08, $08, nCs5, $08, $08
	smpsPan	 panLeft, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nD5, $08, $08
	smpsJump	MusicEC_Jump4

MusicEC_FM5:
	dc.b nRst, $06
MusicEC_Jump5:
	smpsPan	 panRight, $00
	smpsSetvoice	$02
	dc.b nEb4, $04
	smpsPan	 panCentre, $00
	dc.b nEb3, nEb4, nEb3, nEb5, nEb4, nEb5, nEb4, nB4
	dc.b nB3, nB4, nB3, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panLeft, $00
	dc.b nE5
	smpsPan	 panCentre, $00
	dc.b nE4, nE5, nE4, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panRight, $00
	dc.b nEb5
	smpsPan	 panCentre, $00
	dc.b nEb4, nEb5, nEb4, nB4, nB3, nB4, nB3, nAb4
	dc.b nAb3, nAb4, nAb3, nA4, nA3, nA4, nA3
	smpsPan	 panLeft, $00
	dc.b nEb4
	smpsPan	 panCentre, $00
	dc.b nEb3, nEb4, nEb3, nEb4, nEb3, nEb4, nEb3
	smpsPan	 panRight, $00
	dc.b nEb4
	smpsPan	 panCentre, $00
	dc.b nEb3, nEb4, nEb3, nEb5, nEb4, nEb5, nEb4, nB4
	dc.b nB3, nB4, nB3, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panLeft, $00
	dc.b nE5
	smpsPan	 panCentre, $00
	dc.b nE4, nE5, nE4, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panRight, $00
	dc.b nEb5
	smpsPan	 panCentre, $00
	dc.b nEb4, nEb5, nEb4, nAb5, nAb4, nAb5, nAb4, nFs5
	dc.b nFs4, nFs5, nFs4, nE5, nE4, nE5, nE4
	smpsPan	 panLeft, $00
	dc.b nEb5
	smpsPan	 panCentre, $00
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panRight, $00
	dc.b nEb4
	smpsPan	 panCentre, $00
	dc.b nEb3, nEb4, nEb3, nEb5, nEb4, nEb5, nEb4, nB4
	dc.b nB3, nB4, nB3, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panLeft, $00
	dc.b nE5
	smpsPan	 panCentre, $00
	dc.b nE4, nE5, nE4, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panRight, $00
	dc.b nEb5
	smpsPan	 panCentre, $00
	dc.b nEb4, nEb5, nEb4, nB4, nB3, nB4, nB3, nAb4
	dc.b nAb3, nAb4, nAb3, nA4, nA3, nA4, nA3
	smpsPan	 panLeft, $00
	dc.b nEb4
	smpsPan	 panCentre, $00
	dc.b nEb3, nEb4, nEb3, nEb4, nEb3, nEb4, nEb3
	smpsPan	 panRight, $00
	dc.b nEb4
	smpsPan	 panCentre, $00
	dc.b nEb3, nEb4, nEb3, nEb5, nEb4, nEb5, nEb4, nB4
	dc.b nB3, nB4, nB3, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panLeft, $00
	dc.b nE5
	smpsPan	 panCentre, $00
	dc.b nE4, nE5, nE4, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panRight, $00
	dc.b nEb5
	smpsPan	 panCentre, $00
	dc.b nEb4, nEb5, nEb4, nAb5, nAb4, nAb5, nAb4, nFs5
	dc.b nFs4, nFs5, nFs4, nA5, nA4, nA5, nA4
	smpsPan	 panLeft, $00
	dc.b nA5
	smpsPan	 panCentre, $00
	dc.b nA4, nA5, nA4, nA5, nA4, nA5, nA4
	smpsPan	 panRight, $00
	dc.b nEb5
	smpsPan	 panCentre, $00
	dc.b nEb4, nEb5, nEb4, nEb5, nEb4, nEb5, nEb4, nEb5
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panLeft, $00
	dc.b nCs5
	smpsPan	 panCentre, $00
	dc.b nCs4, nCs5, nCs4, nD5, nD4, nD5, nD4
	smpsPan	 panRight, $00
	dc.b nEb5
	smpsPan	 panCentre, $00
	dc.b nEb4, nEb5, nEb4, nEb5, nEb4, nEb5, nEb4, nEb5
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panLeft, $00
	dc.b nCs5
	smpsPan	 panCentre, $00
	dc.b nCs4, nCs5, nCs4, nD5, nD4, nD5, nD4
	smpsPan	 panRight, $00
	dc.b nEb5
	smpsPan	 panCentre, $00
	dc.b nEb4, nEb5, nEb4, nEb5, nEb4, nEb5, nEb4, nEb5
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panLeft, $00
	dc.b nCs5
	smpsPan	 panCentre, $00
	dc.b nCs4, nCs5, nCs4, nD5, nD4, nD5, nD4
	smpsPan	 panRight, $00
	dc.b nEb5
	smpsPan	 panCentre, $00
	dc.b nEb4, nEb5, nEb4, nEb5, nEb4, nEb5, nEb4, nEb5
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	smpsPan	 panLeft, $00
	dc.b nCs5
	smpsPan	 panCentre, $00
	dc.b nCs4, nCs5, nCs4, nD5, nD4, nD5, $08
	smpsJump	MusicEC_Jump5

MusicEC_FM6:
	dc.b nRst, $04
MusicEC_Jump6:
	smpsPan	 panCentre, $00
	smpsSetvoice	$02
	dc.b nEb3, $08, $08, nEb4, $08, $08
	smpsPan	 panLeft, $00
	dc.b nB3, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08
	smpsPan	 panRight, $00
	dc.b nE4, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08, nEb4, $08, $08, nB3
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nAb3, $08
	smpsPan	 panCentre, $00
	dc.b $08, nA3, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb3, $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08, $08, $08, nEb4, $08, $08
	smpsPan	 panLeft, $00
	dc.b nB3, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08
	smpsPan	 panRight, $00
	dc.b nE4, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08, nEb4, $08, $08, nAb4
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nFs4, $08
	smpsPan	 panCentre, $00
	dc.b $08, nE4, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb4, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08, nEb3, $08, $08, nEb4
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nB3, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08
	smpsPan	 panRight, $00
	dc.b nE4, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08, nEb4, $08, $08, nB3
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nAb3, $08
	smpsPan	 panCentre, $00
	dc.b $08, nA3, $08, $08
	smpsPan	 panRight, $00
	dc.b nEb3, $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08, $08, $08, nEb4, $08, $08
	smpsPan	 panLeft, $00
	dc.b nB3, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08
	smpsPan	 panRight, $00
	dc.b nE4, $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08, nEb4, $08, $08, nAb4
	dc.b $08, $08
	smpsPan	 panLeft, $00
	dc.b nFs4, $08
	smpsPan	 panCentre, $00
	dc.b $08, nA4, $08, $08
	smpsPan	 panRight, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, $08, $08, nEb4, $08, $08, $08, $08
	smpsPan	 panLeft, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08
	smpsPan	 panRight, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nD4, $08, $08, nEb4, $08, $08, $08
	dc.b $08
	smpsPan	 panLeft, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08
	smpsPan	 panRight, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nD4, $08, $08, nEb4, $08, $08, $08
	dc.b $08
	smpsPan	 panLeft, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08
	smpsPan	 panRight, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nD4, $08, $08, nEb4, $08, $08, $08
	dc.b $08
	smpsPan	 panLeft, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nCs4, $08, $08
	smpsPan	 panRight, $00
	dc.b $08
	smpsPan	 panCentre, $00
	dc.b $08, nD4, $08, $08
	smpsJump	MusicEC_Jump6

MusicEC_PSG1:
MusicEC_Jump7:
	smpsPSGvoice	VolEnv_05
	dc.b nEb4, $30, nCs4, $20, nE4, $10, nEb4, $30
	dc.b nE4, $10, nFs4, nE4, nEb4, $30, nCs4, $20
	dc.b nE4, $10, nEb4, $30, nE4, $10, nFs4, nE4
	dc.b nEb4, $30, nCs4, $20, nE4, $10, nEb4, $30
	dc.b nE4, $10, nFs4, nE4, nEb4, $30, nCs4, $20
	dc.b nE4, $10, nEb4, $30, nE4, $10, nFs4, nE4
	dc.b nRst, $05, nF4, $08, nG4, $03, nF4, $02
	dc.b nEb4, $03, nF4, $08, nG4, nAb4, nBb4, nB4
	dc.b nBb4, $03, nB4, $02, nBb4, $03, nAb4, $08
	dc.b nG4, nAb4, nBb4, nAb4, nG4, $03, nAb4, $02
	dc.b nG4, $03, nF4, $08, nEb4, nF4, nG4, nF4
	dc.b nEb4, $03, nF4, $02, nEb4, $03, nCs4, $08
	dc.b nB3, nCs4, nEb4, $03, nG4, $08, nAb4, $03
	dc.b nG4, nF4, $02, nG4, $08, nAb4, nBb4, nB4
	dc.b nCs5, nB4, $03, nCs5, nB4, $02, nBb4, $08
	dc.b nAb4, nBb4, nB4, nBb4, nAb4, $03, nBb4, nAb4
	dc.b $02, nG4, $08, nF4, nG4, nAb4, nG4, nF4
	dc.b $03, nG4, nF4, $02, nEb4, $08, nCs4, nEb4
	dc.b nE4
	smpsJump	MusicEC_Jump7

MusicEC_PSG2:
MusicEC_Jump8:
	smpsPSGvoice	VolEnv_05
	dc.b nAb4, $30, nFs4, $20, nA4, $10, nAb4, $30
	dc.b nA4, $10, nB4, nA4, nAb4, $30, nFs4, $20
	dc.b nA4, $10, nAb4, $30, nA4, $10, nB4, nA4
	dc.b nAb4, $30, nFs4, $20, nA4, $10, nAb4, $30
	dc.b nA4, $10, nB4, nA4, nAb4, $30, nFs4, $20
	dc.b nA4, $10, nAb4, $30, nA4, $10, nB4, nA4
	dc.b nF4, $08, nG4, $03, nF4, nEb4, $02, nF4
	dc.b $08, nG4, nAb4, nBb4, nB4, nBb4, $03, nB4
	dc.b nBb4, $02, nAb4, $08, nG4, nAb4, nBb4, nAb4
	dc.b nG4, $03, nAb4, nG4, $02, nF4, $08, nEb4
	dc.b nF4, nG4, nF4, nEb4, $03, nF4, nEb4, $02
	dc.b nCs4, $08, nB3, nCs4, nEb4, nEb4, nF4, $03
	dc.b nEb4, nCs4, $02, nEb4, $08, nF4, nG4, nAb4
	dc.b nBb4, nAb4, $03, nBb4, nAb4, $02, nG4, $08
	dc.b nF4, nG4, nAb4, nG4, nF4, $03, nG4, nF4
	dc.b $02, nEb4, $08, nCs4, nEb4, nF4, nEb4, nCs4
	dc.b $03, nEb4, nCs4, $02, nB3, $08, nA3, nB3
	dc.b nCs4
	smpsJump	MusicEC_Jump8

MusicEC_PSG3:
	dc.b nRst, $06
MusicEC_Jump9:
	smpsPSGvoice	VolEnv_05
	dc.b nAb4, $30, nFs4, $20, nA4, $10, nAb4, $30
	dc.b nA4, $10, nB4, nA4, nAb4, $30, nFs4, $20
	dc.b nA4, $10, nAb4, $30, nA4, $10, nB4, nA4
	dc.b nAb4, $30, nFs4, $20, nA4, $10, nAb4, $30
	dc.b nA4, $10, nB4, nA4, nAb4, $30, nFs4, $20
	dc.b nA4, $10, nAb4, $30, nA4, $10, nB4, nA4
	dc.b nF4, $08, nG4, $03, nF4, nEb4, $02, nF4
	dc.b $08, nG4, nAb4, nBb4, nB4, nBb4, $03, nB4
	dc.b nBb4, $02, nAb4, $08, nG4, nAb4, nBb4, nAb4
	dc.b nG4, $03, nAb4, nG4, $02, nF4, $08, nEb4
	dc.b nF4, nG4, nF4, nEb4, $03, nF4, nEb4, $02
	dc.b nCs4, $08, nB3, nCs4, nEb4, nEb4, nF4, $03
	dc.b nEb4, nCs4, $02, nEb4, $08, nF4, nG4, nAb4
	dc.b nBb4, nAb4, $03, nBb4, nAb4, $02, nG4, $08
	dc.b nF4, nG4, nAb4, nG4, nF4, $03, nG4, nF4
	dc.b $02, nEb4, $08, nCs4, nEb4, nF4, nEb4, nCs4
	dc.b $03, nEb4, nCs4, $02, nB3, $08, nA3, nB3
	dc.b nCs4
	smpsJump	MusicEC_Jump9

MusicEC_DAC:
	smpsStop

MusicEC_Voices:
	; Voice $00
	; $34
	; $33, $41, $7E, $74,	$5B, $9F, $5F, $1F
	; $04, $07, $07, $08,	$00, $00, $00, $00
	smpsVcAlgorithm	$04
	smpsVcFeedback	$06
	smpsVcDetune	$07, $07, $04, $03
	smpsVcCoarseFreq	$04, $0E, $01, $03
	smpsVcRateScale	$00, $01, $02, $01
	smpsVcAttackRate	$1F, $1F, $1F, $1B
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$08, $07, $07, $04
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$0F, $0E, $0F, $0F
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$07, $29, $00, $23

	; Voice $01
	; $34
	; $33, $41, $7E, $74,	$5B, $9F, $5F, $1F
	; $04, $07, $07, $08,	$00, $00, $00, $00
	smpsVcAlgorithm	$04
	smpsVcFeedback	$06
	smpsVcDetune	$07, $07, $04, $03
	smpsVcCoarseFreq	$04, $0E, $01, $03
	smpsVcRateScale	$00, $01, $02, $01
	smpsVcAttackRate	$1F, $1F, $1F, $1B
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$08, $07, $07, $04
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$0F, $0E, $0F, $0F
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$07, $29, $00, $23

	; Voice $02
	; $39
	; $0A, $D0, $00, $01,	$1F, $5F, $5F, $5F
	; $13, $12, $0D, $08,	$0C, $0F, $0F, $0C
	smpsVcAlgorithm	$01
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $0D, $00
	smpsVcCoarseFreq	$01, $00, $00, $0A
	smpsVcRateScale	$01, $01, $01, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$08, $0D, $12, $13
	smpsVcDecayRate2	$0C, $0F, $0F, $0C
	smpsVcDecayLevel	$04, $07, $08, $08
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$06, $20, $27, $28

	; Voice $03
	; $1C
	; $73, $72, $33, $32,	$94, $99, $94, $99
	; $08, $0A, $08, $0A,	$00, $05, $00, $05
	smpsVcAlgorithm	$04
	smpsVcFeedback	$03
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$02, $03, $02, $03
	smpsVcRateScale	$02, $02, $02, $02
	smpsVcAttackRate	$19, $14, $19, $14
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $08, $0A, $08
	smpsVcDecayRate2	$05, $00, $05, $00
	smpsVcDecayLevel	$04, $03, $04, $03
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $19, $00, $1E

	; Voice $04
	; $1C
	; $73, $72, $33, $32,	$94, $99, $94, $99
	; $08, $0A, $08, $0A,	$00, $05, $00, $05
	smpsVcAlgorithm	$04
	smpsVcFeedback	$03
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$02, $03, $02, $03
	smpsVcRateScale	$02, $02, $02, $02
	smpsVcAttackRate	$19, $14, $19, $14
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $08, $0A, $08
	smpsVcDecayRate2	$05, $00, $05, $00
	smpsVcDecayLevel	$04, $03, $04, $03
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $19, $00, $1E

	; Voice $05
	; $1C
	; $73, $72, $33, $32,	$94, $99, $94, $99
	; $08, $0A, $08, $0A,	$00, $05, $00, $05
	smpsVcAlgorithm	$04
	smpsVcFeedback	$03
	smpsVcDetune	$03, $03, $07, $07
	smpsVcCoarseFreq	$02, $03, $02, $03
	smpsVcRateScale	$02, $02, $02, $02
	smpsVcAttackRate	$19, $14, $19, $14
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $08, $0A, $08
	smpsVcDecayRate2	$05, $00, $05, $00
	smpsVcDecayLevel	$04, $03, $04, $03
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $19, $00, $1E
