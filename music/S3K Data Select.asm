DataSelect_Header:
	sHeaderInit						; Z80 offset is $F027
	sHeaderPatchUniv
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $40
	sHeaderDAC	DataSelect_DAC
	sHeaderFM	DataSelect_FM1, $0C, $12
	sHeaderFM	DataSelect_FM2, $0C, $19
	sHeaderFM	DataSelect_FM3, $0C, $19
	sHeaderFM	DataSelect_FM4, $0C, $19
	sHeaderFM	DataSelect_FM5, $0C, $19
	sHeaderPSG	DataSelect_PSG1, $00, $06, $00, v0C
	sHeaderPSG	DataSelect_PSG2, $00, $06, $00, v0C
	sHeaderPSG	DataSelect_PSG3, $00, $04, $00, v0C
	dc.b $F2, $F2	; Unused

DataSelect_Call6:
	dc.b dKick, $12, dKick, $06, dKick, dHighElecTom, $0C, dKick
	dc.b $06, dKick, $12, dKick, $06, dKick, dMidElecTom, dLowElecTom
	dc.b $0C
	sRet

DataSelect_DAC:
	dc.b nRst, $2A

DataSelect_Loop6:
	sCall		DataSelect_Call6
	sLoop		$01, $03, DataSelect_Loop6
	dc.b dKick, $12, dKick, $06, dKick, dHighElecTom, $0C, dKick
	dc.b $06, dKick, $02, dHighCowBell, $03, dHighCowBell, $01, dHighCowBell
	dc.b $0C, dHighCowBell, $06, dHighCowBell, $08, dHighCowBell, dLowCowBell

DataSelect_Loop7:
	sCall		DataSelect_Call6
	sLoop		$01, $03, DataSelect_Loop7
	dc.b dLowElecTom, $06, dLowElecTom, dLowElecTom, $12, dLowElecTom, $06, dLowElecTom
	dc.b dLowElecTom, $1E, dMidElecTom, $18

DataSelect_Loop8:
	sCall		DataSelect_Call6
	sLoop		$01, $07, DataSelect_Loop8
	dc.b dKick, $12, dKick, $06, dKick, dHighElecTom, $0C, dKick
	dc.b $06, dKick, dHighCowBell, $0C, dHighCowBell, $06, dHighCowBell, $0C
	dc.b dLowElecTom

DataSelect_Loop9:
	sCall		DataSelect_Call6
	sLoop		$01, $02, DataSelect_Loop9
	dc.b dKick, $12, dKick, $06, dKick, dHighElecTom, $0C, dKick
	dc.b $06, dKick, $12, dKick, $06, dKick, dMidElecTom, dLowElecTom
	dc.b $0C, dLowElecTom, $06, dLowElecTom, dLowElecTom, $12, dLowElecTom, $06
	dc.b dLowElecTom, dLowElecTom, $1E, dMidElecTom, $18

DataSelect_Loop10:
	sCall		DataSelect_Call6
	sLoop		$01, $03, DataSelect_Loop10
	dc.b dLowElecTom, $06, dKick, $0C, dLowElecTom, $06, dKick, dLowElecTom
	dc.b dLowElecTom, dMidElecTom, $0C, dKick, $12, dKick, $06, dKick
	dc.b dHighElecTom, $0C

DataSelect_Loop11:
	sCall		DataSelect_Call6
	sLoop		$01, $02, DataSelect_Loop11
	dc.b dKick, $12, dKick, $06, dKick, dHighElecTom, $0C, dKick
	dc.b $06, dKick, $12, dKick, $06, dKick, dMidElecTom, dLowElecTom
	dc.b $0C, dLowElecTom, dKick, $06, dLowElecTom, $0C, dKick, $06
	dc.b dLowElecTom, nRst, $36
	sJump		DataSelect_Loop6
	dc.b $F2	; Unused

DataSelect_FM1:
	dc.b nRst, $2A

DataSelect_Jump1:
	sPatFM		$00
	dc.b nC1, $12, nG1, nC2, $0C, nF1, $12, nC2
	dc.b nF2, $0C, nBb0, $12, nF1, nBb1, $0C, nG0
	dc.b $12, nD1, nG1, $0C, nC1, $12, nG1, nC2
	dc.b $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12
	dc.b nC1, nD1, $0C, nRst, $30, nC1, $12, nG1
	dc.b nC2, $0C, nF1, $12, nC2, nF2, $0C, nBb0
	dc.b $12, nF1, nBb1, $0C, nG1, $12, nD2, nG2
	dc.b $0C, nC1, $12, nG1, nC2, $0C, nF1, $12
	dc.b nC2, nF2, $0C, nBb0, $06, nBb0, nBb0, nRst
	dc.b $0C, nBb0, $06, nBb0, nBb0, nRst, $30, nF1
	dc.b $12, nC2, nF2, $0C, nBb0, $12, nF1, nBb1
	dc.b $0C, nEb1, $12, nBb1, nEb2, $0C, nEb1, $12
	dc.b nBb1, nEb2, $0C, nF1, $12, nC2, nF2, $0C
	dc.b nBb0, $12, nF1, nBb1, $0C, nEb1, $12, nBb1
	dc.b nEb2, $0C, nEb1, $12, nF1, nFs1, $0C, nG1
	dc.b $12, nD2, nG2, $0C, nC1, $12, nG1, nC2
	dc.b $0C, nF1, $12, nC2, nF2, $0C, nD1, $12
	dc.b nA1, nD2, $0C, nG1, $12, nD2, nG2, $0C
	dc.b nC1, $12, nG1, nC2, $0C, nF1, $12, nC1
	dc.b nF0, $0C, nRst, $30, nC1, $12, nG1, nC2
	dc.b $0C, nF1, $12, nC2, nF2, $0C, nBb0, $12
	dc.b nF1, nBb1, $0C, nG1, $12, nD2, nG2, $0C
	dc.b nC1, $12, nG1, nC2, $0C, nF1, $12, nC2
	dc.b nF2, $0C, nBb0, $06, nBb0, nBb0, nRst, $0C
	dc.b nBb0, $06, nBb0, nBb0, nRst, $30, nF1, $12
	dc.b nC2, nF2, $0C, nF1, $12, nC2, nF2, $0C
	dc.b nF1, $12, nC2, nF2, $0C, nG1, $18, nFs1
	dc.b nF1, $12, nC2, nF2, $0C, nF1, $12, nC2
	dc.b nF2, $0C, nBb1, $12, nBb1, $06, nRst, nF1
	dc.b nFs1, nG1, $0C, nG1, $06, nD2, $0C, nG2
	dc.b $06, nD2, nG1, $0C, nF1, $12, nC2, nF2
	dc.b $0C, nF1, $12, nC2, nF2, $0C, nF1, $12
	dc.b nC2, nF2, $0C, nG1, $18, nFs1, nF1, $12
	dc.b nC2, nF2, $0C, nF1, $12, nC2, nF2, $0C
	dc.b nBb0, $12, nC1, nD1, $0C, nRst, $30
	sJump		DataSelect_Jump1
	dc.b $F2	; Unused

DataSelect_FM2:
	sPatFM		$12
	ssDetune	$00
	ssModZ80	$03, $01, $FC, $05
	sPan		spCenter
	dc.b nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3

DataSelect_Jump2:
	dc.b nA3, $03, nBb3, nA3, $0C, nG3, $26, nA3
	dc.b $08, nBb3, nC4, nA3, nG3, nG3, $03, nA3
	dc.b nG3, $0C, nF3, $21, nCs3, $03, nD3, $0C
	dc.b nEb3, $06, nF3, $08, nG3, nD3, nF3, $12
	dc.b nEb3, $0F, nA3, $03, nBb3, $0C, nA3, $12
	dc.b nG3, nA3, $0C, nG3, $03, nA3, nG3, $0C
	dc.b nF3, $24, nBb3, $0C, nBb3, $06, nBb3, $08
	dc.b nA3, nBb3, nA3, $03, nBb3, nA3, $0C, nG3
	dc.b $26, nA3, $08, nBb3, nC4, nA3, nG3, nG3
	dc.b $03, nA3, nG3, $0C, nF3, $22, nFs3, $04
	dc.b nG3, $08, nA3, nB3, nC4, nD4, nEb4, $12
	dc.b nG3, nBb3, $0C, nA3, $12, nG3, nA3, $0C
	dc.b nBb3, $06, nBb3, nBb3, $12, nBb3, $06, nBb3
	dc.b nBb3, $2A
	sPatFM		$0F
	ssDetune	$04
	ssModZ80	$0F, $01, $06, $05
	dc.b nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4
	dc.b nEb5, $0C, nD5, $18, nRst, $0C, nBb4, $03
	dc.b nRst, nC5, nRst, nD5, $12, nG5, nD5, $0C
	dc.b nC5, $18, nRst, $0C, nC5, $03, nRst, nD5
	dc.b nRst, nEb5, $12, nAb4, nEb5, $0C, nD5, $12
	dc.b nF5, nD5, $0C, nC5, $03, nD5, nC5, $0C
	dc.b nBb4, $36, nRst, $0C, nD5, $03, nRst, nE5
	dc.b nRst, nF5, $12, nBb4, nF5, $0C, nE5, $18
	dc.b nRst, $0C, nC5, $03, nRst, nD5, nRst, nE5
	dc.b $12, nA5, nE5, $0C, nD5, $18, nRst, $0C
	dc.b nA4, $06, nBb4, nC5, $03, nRst, $09, nD5
	dc.b $03, nRst, nBb4, nRst, $09, nC5, $03, nRst
	dc.b $09, nA4, $03, nRst, $09, nBb4, $03, nRst
	dc.b $09, nG4, $03, nRst, $09, nA4, $0C, nAb4
	dc.b $02, nG4, nFs4, nF4, $06, nRst, $30
	sPatFM		$12
	ssDetune	$00
	ssModZ80	$03, $01, $FC, $05
	sPan		spCenter
	dc.b nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3
	dc.b nA3, $03, nBb3, nA3, $0C, nG3, $26, nA3
	dc.b $08, nBb3, nC4, nA3, nG3, nG3, $03, nA3
	dc.b nG3, $0C, nF3, $22, nFs3, $04, nG3, $08
	dc.b nA3, nB3, nC4, nD4, nEb4, $12, nG3, nBb3
	dc.b $0C, nA3, $12, nG3, nA3, $0C, nBb3, $06
	dc.b nBb3, nBb3, $12, nBb3, $06, nBb3, nBb3, $3C
	sPatFM		$0D
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4
	dc.b nRst, $09, nC4, $03, nRst, nD4, nRst, $09
	dc.b nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4
	dc.b nRst, $09, nBb3, $03, nRst, nC4, nRst, $09
	dc.b nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	sPatFM		$0B
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nG3, $03, nRst, nA3, $06, nBb3, $0C
	sPatFM		$0D
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nEb3, $06, nG3, $03, nRst, nBb3, nRst, nD4
	dc.b nRst, $09, nC4, $03, nRst, nD4, nRst, $09
	dc.b nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	sPatFM		$0F
	ssDetune	$04
	ssModZ80	$0F, $01, $06, $05
	dc.b nBb4, $06, nA4, nF4, nD4, nBb3, nA3, nG3
	dc.b $0C, nRst, $30
	sPatFM		$0D
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4
	dc.b nRst, $09, nC4, $03, nRst, nD4, nRst, $09
	dc.b nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4
	dc.b nRst, $09, nBb3, $03, nRst, nC4, nRst, $09
	dc.b nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	sPatFM		$0B
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nG3, $03, nRst, nA3, $06, nBb3, $0C
	sPatFM		$0D
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4
	dc.b nRst, $09, nC4, $03, nRst, nD4, nRst, $09
	dc.b nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	sPatFM		$0F
	ssDetune	$04
	ssModZ80	$0F, $01, $06, $05
	dc.b nBb4, $06, nA4, nF4, nD4, nBb3, nA3, nG3
	dc.b $0C
	sPatFM		$12
	ssDetune	$00
	ssModZ80	$03, $01, $FC, $05
	sPan		spCenter
	dc.b nBb3, $0C, nBb3, $06, nBb3, $08, nA3, nBb3
	sJump		DataSelect_Jump2
	dc.b $F2	; Unused

DataSelect_FM3:
	sPatFM		$12
	ssDetune	$FD
	ssModZ80	$03, $01, $04, $05
	sPan		spCenter
	dc.b nBb2, $0C, nBb2, $06, nBb2, $08, nA2, nBb2

DataSelect_Jump3:
	sPatFM		$12
	ssDetune	$FD
	ssModZ80	$03, $01, $04, $05
	sPan		spCenter
	dc.b nA2, $03, nBb2, nA2, $0C, nG2, $26, nA2
	dc.b $08, nBb2, nC3, nA2, nG2, nG2, $03, nA2
	dc.b nG2, $0C, nF2, $21, nCs2, $03, nD2, $0C
	dc.b nEb2, $06, nF2, $08, nG2, nD2, nF2, $12
	dc.b nEb2, $0F, nA2, $03, nBb2, $0C, nA2, $12
	dc.b nG2, nA2, $0C, nG2, $03, nA2, nG2, $0C
	dc.b nF2, $24, nBb2, $0C, nBb2, $06, nBb2, $08
	dc.b nA2, nBb2, nA2, $03, nBb2, nA2, $0C, nG2
	dc.b $26, nA2, $08, nBb2, nC3, nA2, nG2, nG2
	dc.b $03, nA2, nG2, $0C, nF2, $22, nFs2, $04
	dc.b nG2, $08, nA2, nB2, nC3, nD3, nEb3, $12
	dc.b nG2, nBb2, $0C, nA2, $12, nG2, nA2, $0C
	dc.b nBb2, $06, nBb2, nBb2, $12, nBb2, $06, nBb2
	dc.b nBb2, $30
	sPatFM		$0F
	ssDetune	$04
	ssModZ80	$0F, $01, $06, $05
	saVolFM		$14
	dc.b nC5, $03, nRst, nD5, nRst, nEb5, $12, nAb4
	dc.b nEb5, $0C, nD5, $18, nRst, $0C, nBb4, $03
	dc.b nRst, nC5, nRst, nD5, $12, nG5, nD5, $0C
	dc.b nC5, $18, nRst, $0C, nC5, $03, nRst, nD5
	dc.b nRst, nEb5, $12, nAb4, nEb5, $0C, nD5, $12
	dc.b nF5, nD5, $0C, nC5, $03, nD5, nC5, $0C
	dc.b nBb4, $36, nRst, $0C, nD5, $03, nRst, nE5
	dc.b nRst, nF5, $12, nBb4, nF5, $0C, nE5, $18
	dc.b nRst, $0C, nC5, $03, nRst, nD5, nRst, nE5
	dc.b $12, nA5, nE5, $0C, nD5, $18, nRst, $0C
	dc.b nA4, $06, nBb4, nC5, $03, nRst, $09, nD5
	dc.b $03, nRst, nBb4, nRst, $09, nC5, $03, nRst
	dc.b $09, nA4, $03, nRst, $09, nBb4, $03, nRst
	dc.b $09, nG4, $03, nRst, $09, nA4, $0C, nAb4
	dc.b $02, nG4, nFs4, nF4, $06, nRst, $2A
	saVolFM		$EC
	sPatFM		$12
	ssDetune	$FD
	ssModZ80	$03, $01, $04, $05
	sPan		spCenter
	dc.b nBb2, $0C, nBb2, $06, nBb2, $08, nA2, nBb2
	dc.b nA2, $03, nBb2, nA2, $0C, nG2, $26, nA2
	dc.b $08, nBb2, nC3, nA2, nG2, nG2, $03, nA2
	dc.b nG2, $0C, nF2, $22, nFs2, $04, nG2, $08
	dc.b nA2, nB2, nC3, nD3, nEb3, $12, nG2, nBb2
	dc.b $0C, nA2, $12, nG2, nA2, $0C, nBb2, $06
	dc.b nBb2, nBb2, $12, nBb2, $06, nBb2, nBb2, $3C
	sPatFM		$0D
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3
	dc.b nRst, $09, nA3, $03, nRst, nBb3, nRst, $09
	dc.b nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3
	dc.b nRst, $09, nG3, $03, nRst, nA3, nRst, $09
	dc.b nG3, $03, nRst, nA3, nRst, nG3, $0C
	sPatFM		$0B
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nEb3, $03, nRst, nF3, $06, nG3, $0C
	sPatFM		$0D
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nC3, $06, nEb3, $03, nRst, nG3, nRst, nBb3
	dc.b nRst, $09, nA3, $03, nRst, nBb3, nRst, $09
	dc.b nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	sPatFM		$0F
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	dc.b nG4, $06, nF4, nD4, nBb3, nG3, nF3, nD3
	dc.b $0C, nRst, $30
	sPatFM		$0D
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3
	dc.b nRst, $09, nA3, $03, nRst, nBb3, nRst, $09
	dc.b nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3
	dc.b nRst, $09, nG3, $03, nRst, nA3, nRst, $09
	dc.b nG3, $03, nRst, nA3, nRst, nG3, $0C
	sPatFM		$0B
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nEb3, $03, nRst, nF3, $06, nG3, $0C
	sPatFM		$0D
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3
	dc.b nRst, $09, nA3, $03, nRst, nBb3, nRst, $09
	dc.b nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	sPatFM		$0F
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	dc.b nG4, $06, nF4, nD4, nBb3, nG3, nF3, nD3
	dc.b $0C
	sPatFM		$12
	ssDetune	$FD
	ssModZ80	$03, $01, $04, $05
	sPan		spCenter
	dc.b nBb2, $08, nRst, $04, nBb2, $06, nBb2, $08
	dc.b nA2, nBb2
	sJump		DataSelect_Jump3
	dc.b $F2	; Unused

DataSelect_FM4:
	dc.b nRst, $2A
	sPatFM		$0B
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft

DataSelect_Jump4:
	dc.b nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst
	dc.b nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3
	dc.b nRst, nEb3, nRst, nBb3, nG3, nRst, nD4, nRst
	dc.b nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b nRst, nD3, nRst, $0C, nEb3, $06, nRst, $0C
	dc.b nF3, $06, nRst, $0C
	sPatFM		$10
	saVolFM		$06
	dc.b nG4, $06, nG5, nG4, nRst, $18
	saVolFM		$FA
	sPatFM		$0B
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst
	dc.b nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3
	dc.b nRst, nEb3, nRst, nBb3, nG3, nRst, nD4, nRst
	dc.b nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b nRst, nF3, nF3, nF3, nRst, $0C, nF3, $06
	dc.b nF3, nF3, nRst, $3C
	sPatFM		$08
	ssDetune	$03
	ssModZ80	$03, $01, $FD, $05
	sPan		spLeft
	dc.b nEb3, $03, nRst, $0F, nEb3, $03, nRst, $0F
	dc.b nD3, $0C, nRst, $06, nD3, $03, nRst, $0F
	dc.b nD3, $0C, nRst, nD3, $03, nRst, $0F, nD3
	dc.b $03, nRst, $0F, nC3, $0C, nRst, $06, nD3
	dc.b $0C, nRst, $06, nEb3, $0C, nRst, nEb3, $03
	dc.b nRst, $0F, nEb3, $03, nRst, $0F, nD3, $0C
	dc.b nRst, $06, nD3, $03, nRst, $0F, nD3, $0C
	dc.b nRst, $06, nG3, $03, nRst, nAb3, nRst, nBb3
	dc.b nRst, nEb4, nRst, nD4, nRst, nBb3, nRst, nG3
	dc.b $12, nRst, $30
	sPatFM		$08
	ssDetune	$03
	ssModZ80	$03, $01, $FD, $05
	sPan		spLeft
	dc.b nF3, $03, nRst, $0F, nF3, $03, nRst, $0F
	dc.b nE3, $0C, nRst, $06, nE3, $03, nRst, $0F
	dc.b nE3, $0C, nRst, nE3, $03, nRst, $0F, nE3
	dc.b $03, nRst, $0F, nD3, $0C, nRst, $06, nE3
	dc.b $0C, nRst, $06, nF3, $0C, nRst, nF3, $03
	dc.b nRst, $0F, nF3, $03, nRst, $0F, nE3, $0C
	dc.b nRst, $06, nE3, $03, nRst, $0F, nE3, $0C
	dc.b nF3, nRst, $06, nF3, $0C, nRst, $06, nF3
	dc.b nRst, $36
	sPatFM		$0B
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst
	dc.b nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3
	dc.b nRst, nEb3, nRst, nBb3, nG3, nRst, nD4, nRst
	dc.b nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b nRst, nF3, nF3, nF3, nRst, $0C, nF3, $06
	dc.b nF3, nF3, nRst, $36
	sPatFM		$08
	ssDetune	$03
	ssModZ80	$03, $01, $FD, $05
	sPan		spLeft
	dc.b nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4
	dc.b nRst, $09, nC4, $03, nRst, nD4, nRst, $09
	dc.b nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4
	dc.b nRst, $09, nBb3, $03, nRst, nC4, nRst, $09
	dc.b nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	sPatFM		$0B
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nG3, $03, nRst, nA3, nRst, nBb3, nRst, $09
	sPatFM		$08
	ssDetune	$03
	ssModZ80	$03, $01, $FD, $05
	sPan		spLeft
	dc.b nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4
	dc.b nRst, $09, nC4, $03, nRst, nD4, nRst, $09
	dc.b nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b $0C
	sPatFM		$0B
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nD3, $06, nRst, $0C, nEb3, $06, nRst, $0C
	dc.b nF3, $06, nRst, $3C
	sPatFM		$08
	ssDetune	$03
	ssModZ80	$03, $01, $FD, $05
	sPan		spLeft
	dc.b nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4
	dc.b nRst, $09, nC4, $03, nRst, nD4, nRst, $09
	dc.b nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b nD3, $03, nRst, nF3, nRst, nA3, nRst, nC4
	dc.b nRst, $09, nBb3, $03, nRst, nC4, nRst, $09
	dc.b nBb3, $03, nRst, nC4, nRst, nBb3, $0C
	sPatFM		$0B
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nG3, $03, nRst, nA3, nRst, nBb3, nRst, $09
	sPatFM		$08
	ssDetune	$03
	ssModZ80	$03, $01, $FD, $05
	sPan		spLeft
	dc.b nEb3, $03, nRst, nG3, nRst, nBb3, nRst, nD4
	dc.b nRst, $09, nC4, $03, nRst, nD4, nRst, $09
	dc.b nC4, $03, nRst, nD4, nRst, nC4, $12, nRst
	dc.b $0C
	sPatFM		$0B
	ssDetune	$04
	ssModZ80	$0F, $01, $FA, $05
	sPan		spLeft
	dc.b nD3, $06, nRst, $0C, nEb3, $06, nRst, $0C
	dc.b nF3, $06, nRst, $36
	sJump		DataSelect_Jump4
	dc.b $F2	; Unused

DataSelect_FM5:
	dc.b nRst, $2A

DataSelect_Jump5:
	sPatFM		$0B
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nEb2, $06, nRst, nBb2, nG2, nRst, nD3, nRst
	dc.b nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b nRst, nD2, nRst, nA2, nF2, nRst, nC3, nRst
	dc.b nD2, nRst, nA2, nRst, nG2, nRst, nD3, nD2
	dc.b nRst, nEb2, nRst, nBb2, nG2, nRst, nD3, nRst
	dc.b nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b nRst, nBb2, nRst, $0C, nC3, $06, nRst, $0C
	dc.b nD3, $06, nRst, $0C
	sPatFM		$10
	saVolFM		$08
	dc.b nG4, $06, nG5, nG4, nRst, $18
	saVolFM		$FA
	sPatFM		$0B
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nEb2, $06, nRst, nBb2, nG2, nRst, nD3, nRst
	dc.b nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b nRst, nD2, nRst, nA2, nF2, nRst, nC3, nRst
	dc.b nD2, nRst, nA2, nRst, nG2, nRst, nD3, nD2
	dc.b nRst, nEb2, nRst, nBb2, nG2, nRst, nD3, nRst
	dc.b nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b nRst, nD3, nD3, nD3, nRst, $0C, nD3, $06
	dc.b nD3, nD3, nRst, $3C
	sPatFM		$08
	ssDetune	$FD
	ssModZ80	$03, $01, $03, $05
	sPan		spRight
	dc.b nAb2, $03, nRst, $0F, nAb2, $03, nRst, $0F
	dc.b nAb2, $0C, nRst, $06, nAb2, $03, nRst, $0F
	dc.b nAb2, $0C, nRst, nG2, $03, nRst, $0F, nG2
	dc.b $03, nRst, $0F, nG2, $0C, nRst, $06, nF2
	dc.b $0C, nRst, $06, nG2, $0C, nRst, nAb2, $03
	dc.b nRst, $0F, nAb2, $03, nRst, $0F, nAb2, $0C
	dc.b nRst, $06, nAb2, $03, nRst, $0F, nAb2, $0C
	dc.b nRst, $06, nBb2, $03, nRst, nC3, nRst, nD3
	dc.b nRst, nG3, nRst, nF3, nRst, nD3, nRst, nBb2
	dc.b $12, nRst, $30
	sPatFM		$08
	ssDetune	$FD
	ssModZ80	$03, $01, $03, $05
	sPan		spRight
	dc.b nBb2, $03, nRst, $0F, nBb2, $03, nRst, $0F
	dc.b nBb2, $0C, nRst, $06, nBb2, $03, nRst, $0F
	dc.b nBb2, $0C, nRst, nA2, $03, nRst, $0F, nA2
	dc.b $03, nRst, $0F, nA2, $0C, nRst, $06, nG2
	dc.b $0C, nRst, $06, nA2, $0C, nRst, nBb2, $03
	dc.b nRst, $0F, nBb2, $03, nRst, $0F, nBb2, $0C
	dc.b nRst, $06, nBb2, $03, nRst, $0F, nBb2, $0C
	dc.b nA2, nRst, $06, nA2, $0C, nRst, $06, nA2
	dc.b nRst, $36
	sPatFM		$0B
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nEb2, $06, nRst, nBb2, nG2, nRst, nD3, nRst
	dc.b nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b nRst, nD2, nRst, nA2, nF2, nRst, nC3, nRst
	dc.b nD2, nRst, nA2, nRst, nG2, nRst, nD3, nD2
	dc.b nRst, nEb2, nRst, nBb2, nG2, nRst, nD3, nRst
	dc.b nEb2, nRst, nA2, nRst, nG2, nRst, nD3, nEb2
	dc.b nRst, nD3, nD3, nD3, nRst, $0C, nD3, $06
	dc.b nD3, nD3, nRst, $36
	sPatFM		$08
	ssDetune	$FD
	ssModZ80	$03, $01, $03, $05
	sPan		spRight
	dc.b nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3
	dc.b nRst, $09, nA3, $03, nRst, nBb3, nRst, $09
	dc.b nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3
	dc.b nRst, $09, nG3, $03, nRst, nA3, nRst, $09
	dc.b nG3, $03, nRst, nA3, nRst, nG3, $0C
	sPatFM		$0B
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nEb3, $03, nRst, nF3, nRst, nG3, nRst, $09
	sPatFM		$08
	ssDetune	$FD
	ssModZ80	$03, $01, $03, $05
	sPan		spRight
	dc.b nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3
	dc.b nRst, $09, nA3, $03, nRst, nBb3, nRst, $09
	dc.b nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b $0C
	sPatFM		$0B
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nBb2, $06, nRst, $0C, nC3, $06, nRst, $0C
	dc.b nD3, $06, nRst, $3C
	sPatFM		$08
	ssDetune	$FD
	ssModZ80	$03, $01, $03, $05
	sPan		spRight
	dc.b nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3
	dc.b nRst, $09, nA3, $03, nRst, nBb3, nRst, $09
	dc.b nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b nBb2, $03, nRst, nD3, nRst, nF3, nRst, nA3
	dc.b nRst, $09, nG3, $03, nRst, nA3, nRst, $09
	dc.b nG3, $03, nRst, nA3, nRst, nG3, $0C
	sPatFM		$0B
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nEb3, $03, nRst, nF3, nRst, nG3, nRst, $09
	sPatFM		$08
	ssDetune	$FD
	ssModZ80	$03, $01, $03, $05
	sPan		spRight
	dc.b nC3, $03, nRst, nEb3, nRst, nG3, nRst, nBb3
	dc.b nRst, $09, nA3, $03, nRst, nBb3, nRst, $09
	dc.b nA3, $03, nRst, nBb3, nRst, nA3, $12, nRst
	dc.b $0C
	sPatFM		$0B
	ssDetune	$FC
	ssModZ80	$0F, $01, $06, $05
	sPan		spRight
	dc.b nBb2, $06, nRst, $0C, nC3, $06, nRst, $0C
	dc.b nD3, $06, nRst, $36
	sJump		DataSelect_Jump5
	dc.b $F2	; Unused

DataSelect_PSG1:
	sVolEnvPSG	v04
	ssDetune	$00
	dc.b nRst, $2A

DataSelect_Jump6:
	sVolEnvPSG	v04
	sCall		DataSelect_Call1
	dc.b nD3, nRst, $0C, nEb3, $06, nRst, $0C, nF3
	dc.b $06, nRst, $0C, nG4, $06, nG5, nG4, nRst
	dc.b $18
	sCall		DataSelect_Call1
	dc.b nF3, nF3, nF3, nRst, $0C, nF3, $06, nF3
	dc.b nF3, nRst, $3C, nEb3, $03, nRst, $0F, nEb3
	dc.b $03, nRst, $0F, nD3, $0C, nRst, $06, nD3
	dc.b $03, nRst, $0F, nD3, $0C, nRst, nD3, $03
	dc.b nRst, $0F, nD3, $03, nRst, $0F, nC3, $0C
	dc.b nRst, $06, nD3, $0C, nRst, $06, nEb3, $0C
	dc.b nRst, nEb3, $03, nRst, $0F, nEb3, $03, nRst
	dc.b $0F, nD3, $0C, nRst, $06, nD3, $03, nRst
	dc.b $0F, nD3, $0C, nRst, $06, nG3, $03, nRst
	dc.b nAb3, nRst, nBb3, nRst, nEb4, nRst, nD4, nRst
	dc.b nBb3, nRst, nG3, $12, nRst, $30, nF3, $03
	dc.b nRst, $0F, nF3, $03, nRst, $0F, nE3, $0C
	dc.b nRst, $06, nE3, $03, nRst, $0F, nE3, $0C
	dc.b nRst, nE3, $03, nRst, $0F, nE3, $03, nRst
	dc.b $0F, nD3, $0C, nRst, $06, nE3, $0C, nRst
	dc.b $06, nF3, $0C, nRst, nF3, $03, nRst, $0F
	dc.b nF3, $03, nRst, $0F, nE3, $0C, nRst, $06
	dc.b nE3, $03, nRst, $0F, nE3, $0C, nF3, nRst
	dc.b $06, nF3, $0C, nRst, $06, nF3, nRst, $36
	sCall		DataSelect_Call1
	sCall		DataSelect_Call2
	dc.b nF4, $02, nRst, $04, nF5, $06, nF4, $02
	dc.b nRst, $0A, nF4, $06, nF5, $06, nF4, $02
	dc.b nRst, $0A, nF4, $06, nF5, $06, nF4, $02
	dc.b nRst, $0A
	sCall		DataSelect_Call3
	sJump		DataSelect_Jump6

DataSelect_Call1:
	dc.b nEb3, $06, nRst, nBb3, nG3, nRst, nD4, nRst
	dc.b nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b nRst, nD3, nRst, nA3, nF3, nRst, nC4, nRst
	dc.b nD3, nRst, nA3, nRst, nG3, nRst, nD4, nD3
	dc.b nRst, nEb3, nRst, nBb3, nG3, nRst, nD4, nRst
	dc.b nEb3, nRst, nA3, nRst, nG3, nRst, nD4, nEb3
	dc.b nRst
	sRet

DataSelect_Call2:
	dc.b nF3, $06, nF3, nF3, nRst, $0C, nF3, $06
	dc.b nF3, nF3, nRst, $36
	sRet

DataSelect_Call3:
	dc.b nF4, $06, nF5, nF4, $0C, nF4, $06, nF5
	dc.b nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4
	dc.b $06, nF5, nF4, $0C, nF4, $06, nF5, nF4
	dc.b $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C
	dc.b nF4, $06, nF5, nF4, $0C, nF4, $06, nF5
	dc.b nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4
	dc.b $06, nF5, nF4, $0C, nF4, $06, nF5, nF4
	dc.b $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C
	dc.b nF4, $06, nF5, nF4, $0C, nF4, $06, nF5
	dc.b nF4, $0C, nF4, $06, nF5, nF4, $0C, nF4
	dc.b $06, nF5, nF4, $0C, nF4, $06, nF5, nF4
	dc.b $0C, nF4, $06, nF5, nF4, $0C, nF4, $06
	dc.b nF5, nF4, $0C, nF4, $06, nF5, nF4, $0C
	dc.b nF4, $06, nF5, nF4, $0C, nF4, $06, nF5
	dc.b nF4, $0C, nF4, $06, nF5, nF4, $36
	sRet
	dc.b $F2	; Unused

DataSelect_PSG2:
	sVolEnvPSG	v04
	ssDetune	$FF
	dc.b nRst, $2A

DataSelect_Jump7:
	sVolEnvPSG	v04
	sCall		DataSelect_Call1
	dc.b nBb3, nRst, $0C, nC4, $06, nRst, $0C, nD4
	dc.b $06, nRst, $0C, nG5, $06, nG6, nG5, nRst
	dc.b $18
	sCall		DataSelect_Call1
	dc.b nD4, nD4, nD4, nRst, $0C, nD4, $06, nD4
	dc.b nD4, nRst, $3C, nAb2, $03, nRst, $0F, nAb2
	dc.b $03, nRst, $0F, nAb2, $0C, nRst, $06, nAb2
	dc.b $03, nRst, $0F, nAb2, $0C, nRst, nG2, $03
	dc.b nRst, $0F, nG2, $03, nRst, $0F, nG2, $0C
	dc.b nRst, $06, nF2, $0C, nRst, $06, nG2, $0C
	dc.b nRst, nAb2, $03, nRst, $0F, nAb2, $03, nRst
	dc.b $0F, nAb2, $0C, nRst, $06, nAb2, $03, nRst
	dc.b $0F, nAb2, $0C, nRst, $06, nBb2, $03, nRst
	dc.b nC3, nRst, nD3, nRst, nG3, nRst, nF3, nRst
	dc.b nD3, nRst, nBb2, $12, nRst, $30, nBb2, $03
	dc.b nRst, $0F, nBb2, $03, nRst, $0F, nBb2, $0C
	dc.b nRst, $06, nBb2, $03, nRst, $0F, nBb2, $0C
	dc.b nRst, nA2, $03, nRst, $0F, nA2, $03, nRst
	dc.b $0F, nA2, $0C, nRst, $06, nG2, $0C, nRst
	dc.b $06, nA2, $0C, nRst, nBb2, $03, nRst, $0F
	dc.b nBb2, $03, nRst, $0F, nBb2, $0C, nRst, $06
	dc.b nBb2, $03, nRst, $0F, nBb2, $0C, nA2, nRst
	dc.b $06, nA2, $0C, nRst, $06, nA2, nRst, $36
	sCall		DataSelect_Call1
	sCall		DataSelect_Call2
	dc.b nF4, $06, nF5, nF4, $0C, nF4, $06, nF5
	dc.b nF4, $0C, nF4, $06, nF5, nF4, $0C
	sCall		DataSelect_Call3
	sJump		DataSelect_Jump7
	dc.b $F2	; Unused

DataSelect_PSG3:
	sVolEnvPSG	v02
	sNoisePSG	$E7
	dc.b nRst, $2A

DataSelect_Jump8:
	sCall		DataSelect_Call4
	sCall		DataSelect_Call4
	sCall		DataSelect_Call4
	saVolFMP	$FD, $D3
	dc.b $06
	saVolFMP	$03, $D3
	dc.b $03, nBb6, nBb6, $06, nBb6, nBb6, nBb6, nBb6
	dc.b nBb6, $0C
	saVolFMP	$FD, $D3
	dc.b $0C, nBb6, $06, nBb6, $08, nBb6, nBb6, $02
	saVolFMP	$03, $80
	dc.b $06
	sCall		DataSelect_Call4
	sCall		DataSelect_Call4
	saVolFMP	$FD, $D3
	dc.b $06
	saVolFMP	$03, $D3
	dc.b $03, nBb6

DataSelect_Loop2:
	dc.b nBb6, $06
	sLoop		$00, $0D, DataSelect_Loop2
	dc.b nBb6, $32, nBb6, $34
	sCall		DataSelect_Call5
	sCall		DataSelect_Call5
	sCall		DataSelect_Call5
	sCall		DataSelect_Call5
	sCall		DataSelect_Call5
	sCall		DataSelect_Call5
	sCall		DataSelect_Call5
	dc.b nBb6, $06, nBb6, $03, nBb6, nBb6, $06, nBb6
	dc.b nBb6, nBb6, nBb6, nBb6, $36
	sCall		DataSelect_Call4
	sCall		DataSelect_Call4
	saVolFMP	$FD, $D3
	dc.b $06
	saVolFMP	$03, $D3
	dc.b $03, nBb6

DataSelect_Loop4:
	dc.b nBb6, $06
	sLoop		$00, $0D, DataSelect_Loop4
	dc.b nBb6, $32, nBb6, $34, nBb6, $06, nBb6, $03
	dc.b nBb6, nBb6, $06
	saVolFMP	$FD, $D3
	saVolFMP	$03, $D3
	dc.b nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6
	dc.b nBb6

DataSelect_Loop5:
	dc.b nBb6, $06, nBb6, $03, nBb6, nBb6, $06
	saVolFMP	$FD, $D3
	saVolFMP	$03, $D3
	dc.b nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6
	dc.b nBb6, nBb6, nBb6
	sLoop		$00, $06, DataSelect_Loop5
	dc.b nBb6, $06, nBb6, $03, nBb6, nBb6, $06
	saVolFMP	$FD, $D3
	saVolFMP	$03, $D3
	dc.b nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6
	dc.b nBb6, nBb6, nBb6, nBb6, nBb6, $03, nBb6, nBb6
	dc.b $06
	saVolFMP	$FD, $D3
	saVolFMP	$03, $D3
	dc.b nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6, nBb6
	dc.b nBb6, nBb6, nBb6, nBb6, nBb6, $03, nBb6, nBb6
	dc.b $06
	saVolFMP	$FD, $D3
	dc.b nBb6
	sJump		DataSelect_Jump8

DataSelect_Call4:
	saVolFMP	$FD, $D3
	dc.b $06
	saVolFMP	$03, $D3
	dc.b $03, nBb6

DataSelect_Loop1:
	dc.b nBb6, $06
	sLoop		$01, $0E, DataSelect_Loop1
	sRet

DataSelect_Call5:
	dc.b nBb6, $06, nBb6, $03, nBb6

DataSelect_Loop3:
	dc.b nBb6, $06
	sLoop		$01, $0E, DataSelect_Loop3
	sRet
