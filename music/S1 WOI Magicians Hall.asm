Magicians_Hall_Header:
	sHeaderInit
	sHeaderPatch	Magicians_Hall_Patches
	sHeaderCh	$07, $03
	sHeaderTempo	$02, $05
	sHeaderDAC	Magicians_Hall_DAC
	sHeaderFM	Magicians_Hall_FM1, $00, $12
	sHeaderFM	Magicians_Hall_FM2, $00, $0E
	sHeaderFM	Magicians_Hall_FM3, $00, $10
	sHeaderFM	Magicians_Hall_FM4, $00, $1D
	sHeaderFM	Magicians_Hall_FM5, $00, $1D
	sHeaderFM	Magicians_Hall_FM6, $00, $1C
	sHeaderPSG	Magicians_Hall_PSG1, $DC, $02, $00, v00
	sHeaderPSG	Magicians_Hall_PSG2, $DC, $02, $00, v00
	sHeaderPSG	Magicians_Hall_PSG3, $DC, $02, $00, v00

Magicians_Hall_FM1:
	dc.b nRst, $06

Magicians_Hall_Jump1:
	sPan		spCenter
	sPatFM		$00
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
	sJump		Magicians_Hall_Jump1

Magicians_Hall_FM2:
	sPan		spCenter
	sPatFM		$00
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
	sJump		Magicians_Hall_FM2

Magicians_Hall_FM3:
	sPan		spCenter
	sPatFM		$01
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
	sJump		Magicians_Hall_FM3

Magicians_Hall_FM4:
	sPan		spRight
	sPatFM		$02
	dc.b nEb4, $08
	sPan		spCenter
	dc.b $08, nEb5, $08, $08, nB4, $08, $08, nCs5
	dc.b $08, $08
	sPan		spLeft
	dc.b nE5, $08
	sPan		spCenter
	dc.b $08, nCs5, $08, $08
	sPan		spRight
	dc.b nEb5, $08
	sPan		spCenter
	dc.b $08, nB4, $08, $08, nAb4, $08, $08, nA4
	dc.b $08, $08
	sPan		spLeft
	dc.b nEb4, $08
	sPan		spCenter
	dc.b $08, $08, $08
	sPan		spRight
	dc.b $08
	sPan		spCenter
	dc.b $08, nEb5, $08, $08, nB4, $08, $08, nCs5
	dc.b $08, $08
	sPan		spLeft
	dc.b nE5, $08
	sPan		spCenter
	dc.b $08, nCs5, $08, $08
	sPan		spRight
	dc.b nEb5, $08
	sPan		spCenter
	dc.b $08, nAb5, $08, $08, nFs5, $08, $08, nE5
	dc.b $08, $08
	sPan		spLeft
	dc.b nEb5, $08
	sPan		spCenter
	dc.b $08, nCs5, $08, $08
	sPan		spRight
	dc.b nEb4, $08
	sPan		spCenter
	dc.b $08, nEb5, $08, $08, nB4, $08, $08, nCs5
	dc.b $08, $08
	sPan		spLeft
	dc.b nE5, $08
	sPan		spCenter
	dc.b $08, nCs5, $08, $08
	sPan		spRight
	dc.b nEb5, $08
	sPan		spCenter
	dc.b $08, nB4, $08, $08, nAb4, $08, $08, nA4
	dc.b $08, $08
	sPan		spLeft
	dc.b nEb4, $08
	sPan		spCenter
	dc.b $08, $08, $08
	sPan		spRight
	dc.b $08
	sPan		spCenter
	dc.b $08, nEb5, $08, $08, nB4, $08, $08, nCs5
	dc.b $08, $08
	sPan		spLeft
	dc.b nE5, $08
	sPan		spCenter
	dc.b $08, nCs5, $08, $08
	sPan		spRight
	dc.b nEb5, $08
	sPan		spCenter
	dc.b $08, nAb5, $08, $08, nFs5, $08, $08, nA5
	dc.b $08, $08
	sPan		spLeft
	dc.b $08
	sPan		spCenter
	dc.b $08, $08, $08
	sPan		spRight
	dc.b nEb5, $08
	sPan		spCenter
	dc.b $08, $08, $08, $08, $08, nCs5, $08, $08
	sPan		spLeft
	dc.b $08
	sPan		spCenter
	dc.b $08, nD5, $08, $08
	sPan		spRight
	dc.b nEb5, $08
	sPan		spCenter
	dc.b $08, $08, $08, $08, $08, nCs5, $08, $08
	sPan		spLeft
	dc.b $08
	sPan		spCenter
	dc.b $08, nD5, $08, $08
	sPan		spRight
	dc.b nEb5, $08
	sPan		spCenter
	dc.b $08, $08, $08, $08, $08, nCs5, $08, $08
	sPan		spLeft
	dc.b $08
	sPan		spCenter
	dc.b $08, nD5, $08, $08
	sPan		spRight
	dc.b nEb5, $08
	sPan		spCenter
	dc.b $08, $08, $08, $08, $08, nCs5, $08, $08
	sPan		spLeft
	dc.b $08
	sPan		spCenter
	dc.b $08, nD5, $08, $08
	sJump		Magicians_Hall_FM4

Magicians_Hall_FM5:
	dc.b nRst, $06

Magicians_Hall_Jump2:
	sPan		spRight
	sPatFM		$02
	dc.b nEb4, $04
	sPan		spCenter
	dc.b nEb3, nEb4, nEb3, nEb5, nEb4, nEb5, nEb4, nB4
	dc.b nB3, nB4, nB3, nCs5, nCs4, nCs5, nCs4
	sPan		spLeft
	dc.b nE5
	sPan		spCenter
	dc.b nE4, nE5, nE4, nCs5, nCs4, nCs5, nCs4
	sPan		spRight
	dc.b nEb5
	sPan		spCenter
	dc.b nEb4, nEb5, nEb4, nB4, nB3, nB4, nB3, nAb4
	dc.b nAb3, nAb4, nAb3, nA4, nA3, nA4, nA3
	sPan		spLeft
	dc.b nEb4
	sPan		spCenter
	dc.b nEb3, nEb4, nEb3, nEb4, nEb3, nEb4, nEb3
	sPan		spRight
	dc.b nEb4
	sPan		spCenter
	dc.b nEb3, nEb4, nEb3, nEb5, nEb4, nEb5, nEb4, nB4
	dc.b nB3, nB4, nB3, nCs5, nCs4, nCs5, nCs4
	sPan		spLeft
	dc.b nE5
	sPan		spCenter
	dc.b nE4, nE5, nE4, nCs5, nCs4, nCs5, nCs4
	sPan		spRight
	dc.b nEb5
	sPan		spCenter
	dc.b nEb4, nEb5, nEb4, nAb5, nAb4, nAb5, nAb4, nFs5
	dc.b nFs4, nFs5, nFs4, nE5, nE4, nE5, nE4
	sPan		spLeft
	dc.b nEb5
	sPan		spCenter
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	sPan		spRight
	dc.b nEb4
	sPan		spCenter
	dc.b nEb3, nEb4, nEb3, nEb5, nEb4, nEb5, nEb4, nB4
	dc.b nB3, nB4, nB3, nCs5, nCs4, nCs5, nCs4
	sPan		spLeft
	dc.b nE5
	sPan		spCenter
	dc.b nE4, nE5, nE4, nCs5, nCs4, nCs5, nCs4
	sPan		spRight
	dc.b nEb5
	sPan		spCenter
	dc.b nEb4, nEb5, nEb4, nB4, nB3, nB4, nB3, nAb4
	dc.b nAb3, nAb4, nAb3, nA4, nA3, nA4, nA3
	sPan		spLeft
	dc.b nEb4
	sPan		spCenter
	dc.b nEb3, nEb4, nEb3, nEb4, nEb3, nEb4, nEb3
	sPan		spRight
	dc.b nEb4
	sPan		spCenter
	dc.b nEb3, nEb4, nEb3, nEb5, nEb4, nEb5, nEb4, nB4
	dc.b nB3, nB4, nB3, nCs5, nCs4, nCs5, nCs4
	sPan		spLeft
	dc.b nE5
	sPan		spCenter
	dc.b nE4, nE5, nE4, nCs5, nCs4, nCs5, nCs4
	sPan		spRight
	dc.b nEb5
	sPan		spCenter
	dc.b nEb4, nEb5, nEb4, nAb5, nAb4, nAb5, nAb4, nFs5
	dc.b nFs4, nFs5, nFs4, nA5, nA4, nA5, nA4
	sPan		spLeft
	dc.b nA5
	sPan		spCenter
	dc.b nA4, nA5, nA4, nA5, nA4, nA5, nA4
	sPan		spRight
	dc.b nEb5
	sPan		spCenter
	dc.b nEb4, nEb5, nEb4, nEb5, nEb4, nEb5, nEb4, nEb5
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	sPan		spLeft
	dc.b nCs5
	sPan		spCenter
	dc.b nCs4, nCs5, nCs4, nD5, nD4, nD5, nD4
	sPan		spRight
	dc.b nEb5
	sPan		spCenter
	dc.b nEb4, nEb5, nEb4, nEb5, nEb4, nEb5, nEb4, nEb5
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	sPan		spLeft
	dc.b nCs5
	sPan		spCenter
	dc.b nCs4, nCs5, nCs4, nD5, nD4, nD5, nD4
	sPan		spRight
	dc.b nEb5
	sPan		spCenter
	dc.b nEb4, nEb5, nEb4, nEb5, nEb4, nEb5, nEb4, nEb5
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	sPan		spLeft
	dc.b nCs5
	sPan		spCenter
	dc.b nCs4, nCs5, nCs4, nD5, nD4, nD5, nD4
	sPan		spRight
	dc.b nEb5
	sPan		spCenter
	dc.b nEb4, nEb5, nEb4, nEb5, nEb4, nEb5, nEb4, nEb5
	dc.b nEb4, nEb5, nEb4, nCs5, nCs4, nCs5, nCs4
	sPan		spLeft
	dc.b nCs5
	sPan		spCenter
	dc.b nCs4, nCs5, nCs4, nD5, nD4, nD5, $08
	sJump		Magicians_Hall_Jump2

Magicians_Hall_FM6:
	dc.b nRst, $04

Magicians_Hall_Jump3:
	sPan		spCenter
	sPatFM		$02
	dc.b nEb3, $08, $08, nEb4, $08, $08
	sPan		spLeft
	dc.b nB3, $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08
	sPan		spRight
	dc.b nE4, $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08, nEb4, $08, $08, nB3
	dc.b $08, $08
	sPan		spLeft
	dc.b nAb3, $08
	sPan		spCenter
	dc.b $08, nA3, $08, $08
	sPan		spRight
	dc.b nEb3, $08
	sPan		spCenter
	dc.b $08, $08, $08, $08, $08, nEb4, $08, $08
	sPan		spLeft
	dc.b nB3, $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08
	sPan		spRight
	dc.b nE4, $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08, nEb4, $08, $08, nAb4
	dc.b $08, $08
	sPan		spLeft
	dc.b nFs4, $08
	sPan		spCenter
	dc.b $08, nE4, $08, $08
	sPan		spRight
	dc.b nEb4, $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08, nEb3, $08, $08, nEb4
	dc.b $08, $08
	sPan		spLeft
	dc.b nB3, $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08
	sPan		spRight
	dc.b nE4, $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08, nEb4, $08, $08, nB3
	dc.b $08, $08
	sPan		spLeft
	dc.b nAb3, $08
	sPan		spCenter
	dc.b $08, nA3, $08, $08
	sPan		spRight
	dc.b nEb3, $08
	sPan		spCenter
	dc.b $08, $08, $08, $08, $08, nEb4, $08, $08
	sPan		spLeft
	dc.b nB3, $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08
	sPan		spRight
	dc.b nE4, $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08, nEb4, $08, $08, nAb4
	dc.b $08, $08
	sPan		spLeft
	dc.b nFs4, $08
	sPan		spCenter
	dc.b $08, nA4, $08, $08
	sPan		spRight
	dc.b $08
	sPan		spCenter
	dc.b $08, $08, $08, nEb4, $08, $08, $08, $08
	sPan		spLeft
	dc.b $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08
	sPan		spRight
	dc.b $08
	sPan		spCenter
	dc.b $08, nD4, $08, $08, nEb4, $08, $08, $08
	dc.b $08
	sPan		spLeft
	dc.b $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08
	sPan		spRight
	dc.b $08
	sPan		spCenter
	dc.b $08, nD4, $08, $08, nEb4, $08, $08, $08
	dc.b $08
	sPan		spLeft
	dc.b $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08
	sPan		spRight
	dc.b $08
	sPan		spCenter
	dc.b $08, nD4, $08, $08, nEb4, $08, $08, $08
	dc.b $08
	sPan		spLeft
	dc.b $08
	sPan		spCenter
	dc.b $08, nCs4, $08, $08
	sPan		spRight
	dc.b $08
	sPan		spCenter
	dc.b $08, nD4, $08, $08
	sJump		Magicians_Hall_Jump3

Magicians_Hall_PSG1:
	sVolEnvPSG	v05
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
	sJump		Magicians_Hall_PSG1

Magicians_Hall_PSG2:
	sVolEnvPSG	v05
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
	sJump		Magicians_Hall_PSG2

Magicians_Hall_PSG3:
	dc.b nRst, $06

Magicians_Hall_Jump4:
	sVolEnvPSG	v05
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
	sJump		Magicians_Hall_Jump4

Magicians_Hall_DAC:
	sStop

Magicians_Hall_Patches:

	; Patch $00
	; $34
	; $33, $41, $7E, $74,	$5B, $9F, $5F, $1F
	; $04, $07, $07, $08,	$00, $00, $00, $00
	; $FF, $FF, $EF, $FF,	$23, $80, $29, $87
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$03, $07, $04, $07
	spMultiple	$03, $0E, $01, $04
	spRateScale	$01, $01, $02, $00
	spAttackRt	$1B, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $07, $07, $08
	spSustainLv	$0F, $0E, $0F, $0F
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$23, $29, $00, $07

	; Patch $01
	; $34
	; $33, $41, $7E, $74,	$5B, $9F, $5F, $1F
	; $04, $07, $07, $08,	$00, $00, $00, $00
	; $FF, $FF, $EF, $FF,	$23, $80, $29, $87
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$03, $07, $04, $07
	spMultiple	$03, $0E, $01, $04
	spRateScale	$01, $01, $02, $00
	spAttackRt	$1B, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $07, $07, $08
	spSustainLv	$0F, $0E, $0F, $0F
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$23, $29, $00, $07

	; Patch $02
	; $39
	; $0A, $D0, $00, $01,	$1F, $5F, $5F, $5F
	; $13, $12, $0D, $08,	$0C, $0F, $0F, $0C
	; $8F, $8F, $7F, $4F,	$28, $27, $20, $06
	spAlgorithm	$01
	spFeedback	$07
	spDetune	$00, $00, $0D, $00
	spMultiple	$0A, $00, $00, $01
	spRateScale	$00, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$13, $0D, $12, $08
	spSustainLv	$08, $07, $08, $04
	spDecayRt	$0C, $0F, $0F, $0C
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$28, $20, $27, $06

	; Patch $03
	; $1C
	; $73, $72, $33, $32,	$94, $99, $94, $99
	; $08, $0A, $08, $0A,	$00, $05, $00, $05
	; $3F, $4F, $3F, $4F,	$1E, $80, $19, $80
	spAlgorithm	$04
	spFeedback	$03
	spDetune	$07, $03, $07, $03
	spMultiple	$03, $03, $02, $02
	spRateScale	$02, $02, $02, $02
	spAttackRt	$14, $14, $19, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$08, $08, $0A, $0A
	spSustainLv	$03, $03, $04, $04
	spDecayRt	$00, $00, $05, $05
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1E, $19, $00, $00

	; Patch $04
	; $1C
	; $73, $72, $33, $32,	$94, $99, $94, $99
	; $08, $0A, $08, $0A,	$00, $05, $00, $05
	; $3F, $4F, $3F, $4F,	$1E, $80, $19, $80
	spAlgorithm	$04
	spFeedback	$03
	spDetune	$07, $03, $07, $03
	spMultiple	$03, $03, $02, $02
	spRateScale	$02, $02, $02, $02
	spAttackRt	$14, $14, $19, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$08, $08, $0A, $0A
	spSustainLv	$03, $03, $04, $04
	spDecayRt	$00, $00, $05, $05
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1E, $19, $00, $00

	; Patch $05
	; $1C
	; $73, $72, $33, $32,	$94, $99, $94, $99
	; $08, $0A, $08, $0A,	$00, $05, $00, $05
	; $3F, $4F, $3F, $4F,	$1E, $80, $19, $80
	spAlgorithm	$04
	spFeedback	$03
	spDetune	$07, $03, $07, $03
	spMultiple	$03, $03, $02, $02
	spRateScale	$02, $02, $02, $02
	spAttackRt	$14, $14, $19, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$08, $08, $0A, $0A
	spSustainLv	$03, $03, $04, $04
	spDecayRt	$00, $00, $05, $05
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1E, $19, $00, $00
