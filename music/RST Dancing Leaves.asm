DancingLeaves_Header:
	sHeaderInit
	sHeaderPatch	DancingLeaves_Patches
	sHeaderCh	$07, $03
	sHeaderTempo	$01, $33
	sHeaderDAC	DancingLeaves_DAC1
	sHeaderDAC	DancingLeaves_DAC2
	sHeaderFM	DancingLeaves_FM1, $02, $0B
	sHeaderFM	DancingLeaves_FM2, $F6, $12
	sHeaderFM	DancingLeaves_FM3, $F6, $12
	sHeaderFM	DancingLeaves_FM4, $F6, $12
	sHeaderFM	DancingLeaves_FM5, $F6, $12
	sHeaderPSG	DancingLeaves_PSG1, $D2, $03, $00, v00
	sHeaderPSG	DancingLeaves_PSG2, $D2, $03, $00, v00
	sHeaderPSG	DancingLeaves_PSG3, $00, $02, $00, v00

DancingLeaves_FM1:
	ssPalTempo	$2D
	sPatFM		$00

DancingLeaves_Jump1:
	dc.b nC3, $2C, nF3, $0C, $28, nE3, $18, $14
	dc.b nG3, $0C, $18, nG2, $10, nC3, $2C, nF3
	dc.b $0C, $28, nD3, $18, nD3, nG3, nG2

DancingLeaves_Loop1:
	dc.b nC3, $18, nA2, nD3, nG2
	sLoop		$00, $03, DancingLeaves_Loop1
	dc.b nC3, $18, nA2, nD3, nG2, $0C, nG2
	sLoop		$01, $04, DancingLeaves_Loop1
	saVolFM		$06

DancingLeaves_Loop2:
	dc.b nC3, $18, nA2, nD3, nG2
	sLoop		$00, $03, DancingLeaves_Loop2
	dc.b nC3, $18, nA2
	saVolFM		$FA
	dc.b nD3, nG2, $0C, nG2

DancingLeaves_Loop3:
	dc.b nC3, $18, nA2, nD3, nG2
	sLoop		$00, $03, DancingLeaves_Loop3
	dc.b nC3, $0C, nC3, nA2, nA2, nD3, nD3, nG2
	dc.b nA2, $08, nB2, $04, nC3, $0C, nE3, nG3
	dc.b nE3, nC3, nC3, nA2, nG2, nCs3, nE3, nG3
	dc.b nE3, nG3, nE3, nCs3, nE3, nD3, nF3, nF3
	dc.b nD3, nG3, nG3, nD3, nCs3, nC3, nE3, nG3
	dc.b nE3, nD3, nA3, nAb3, nCs3, nC3, nE3, nA3
	dc.b nA3, nB3, nA3, nE3, nE3, nCs3, nE3, nG3
	dc.b nE3, nE3, nBb3, nA3, nE3, nD3, nF3, nF3
	dc.b nD3, nG3, nD3, nCs3, nCs3, nC3, nE3, nE3
	dc.b nG3, nA3, nB3, nB3, nB3, nE3, nEb3, nCs3
	dc.b nB2, nFs3, nFs3, nF3, nF3, nE3, nEb3, nCs3
	dc.b nB2, nFs3, nB3, nFs3, nF3, nE3, nFs3, nAb3
	dc.b nE3, nA3, nA3, nE3, nE3, nD3, nF3, nF3
	dc.b nD3, nG3, nD3, nCs3, nFs3
	sJump		DancingLeaves_Jump1

DancingLeaves_FM2:
	dc.b nRst, $0C

DancingLeaves_Jump2:
	sPatFM		$02
	sCall		DancingLeaves_Call1
	sGate		$04
	dc.b nG6, $0C, nE6, $08
	sGate		$03
	dc.b nE6, $04
	sGate		$04
	dc.b nE6, $08, $0C
	sGate		$05
	dc.b nF6, $0C, nF6
	sGate		$03
	dc.b nG6, $04
	sGate		$05
	dc.b nA6, $08, nG6, nF6
	sGate		$04
	dc.b nE6, $0C
	sCall		DancingLeaves_Call1
	sGate		$04
	dc.b nG6, $0C, nC7, $08
	sGate		$03
	dc.b nC7, $04
	sGate		$04
	dc.b nC7, $08, $0C
	sGate		$05
	dc.b nB6, $0C, nB6
	sGate		$03
	dc.b nC7, $04
	sGate		$05
	dc.b nD7, $08, nC7, nB6
	sGate		$00
	dc.b nC7, $30, sHold, $30, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, $18
	saVolFM		$FC
	sPatFM		$05
	sCall		DancingLeaves_Call2
	sGate		$1F
	dc.b nG5, $20
	ssMod68k	$03, $01, $05, $03
	sGate		$00
	dc.b nG5, $03, nRst, $01
	sCall		DancingLeaves_Call3
	dc.b sHold, nG5, $0C
	sCall		DancingLeaves_Call2
	sGate		$1F
	dc.b nG5, $20
	ssMod68k	$03, $01, $05, $03
	sGate		$00
	dc.b nG5, $03, nRst, $01
	sCall		DancingLeaves_Call3
	saVolFM		$04
	sPatFM		$02
	ssMod68k	$14, $01, $EC, $EF
	dc.b nC7, $24
	ssMod68k	$01, $01, $00, $00
	sCall		DancingLeaves_Call4
	sGate		$00
	dc.b nG6, $04, sHold, $30, sHold, $2F, nRst, $01
	sCall		DancingLeaves_Call4
	sGate		$00
	dc.b nG6, $04, sHold, $30, sHold, $07, nRst, $01
	sPatFM		$03
	saTranspose	$F4
	sGate		$07
	dc.b nG4, $04, nA4, $08, nB4, $04, nC5, $08
	dc.b nD5, $04, nE5, $08, nF5, $04
	saVolFM		$0C

DancingLeaves_Loop4:
	dc.b nG5, $04
	saVolFM		$FF
	sLoop		$00, $0C, DancingLeaves_Loop4
	sGate		$06
	saVolFM		$FC
	dc.b nG5, $13, nRst, $01
	saVolFM		$04
	dc.b nE5, $0C
	sGate		$07
	dc.b nF5, $04, nG5, $08, nF5, $04, nE5, $08
	dc.b $0C, nC5, nC5, $04
	sGate		$00
	dc.b nG4, $1F, nRst, $01, nG4, $04, nE5, $0B
	dc.b nRst, $01, nF5, $0B, nRst, $01, nRst, $0C
	sGate		$07
	dc.b nG5, $08, nC6, $04, nA5, $0C, nF5, $08
	dc.b nB5, $04, nG5, $0C, nE5, $08, nA5, $04
	dc.b nF5, $0C, nD5, $08

DancingLeaves_Loop5:
	dc.b nG5, $04
	saVolFM		$01
	sLoop		$00, $13, DancingLeaves_Loop5
	saVolFM		$ED
	sGate		$00
	saTranspose	$0C
	saVolFM		$FC
	sPatFM		$05
	sCall		DancingLeaves_Call2
	sGate		$1F
	dc.b nG5, $20
	ssMod68k	$03, $01, $05, $03
	sGate		$00
	dc.b nG5, $03, nRst, $01
	sCall		DancingLeaves_Call3
	dc.b nRst, $24
	ssMod68k	$01, $01, $00, $00
	saVolFM		$04
	sPatFM		$01
	sGate		$03

DancingLeaves_Loop6:
	dc.b nG5, $04, nG4
	saVolFM		$01
	sLoop		$00, $09, DancingLeaves_Loop6
	saVolFM		$F7
	sGate		$03
	dc.b nE5, $08, nF5, $04, nG5, $08, nF5, $04
	dc.b nE5, $14, nCs5, $10
	sGate		$00
	dc.b nG4, $0C, nRst, $0C, nRst, $08, nG4, $03
	dc.b nRst, $01, nE5, $07, nRst, $01, nCs5, $03
	dc.b nRst, $01, nAb5, $07, nRst, $01, nA5, $03
	dc.b nRst, $01
	sGate		$03
	dc.b nE5, $04, nCs5, nD5, nE5, nF5, nA5
	sGate		$0C
	dc.b nE6, $18, nE6, nB5
	sGate		$00
	dc.b nD6, $12, nRst, $02, nC6, $27, nRst, $01
	sGate		$06
	dc.b nD6, $14
	sGate		$00
	dc.b nEb6, $0F, nRst, $01
	sGate		$06
	dc.b nE6, $0C, nEb6
	sGate		$00
	dc.b nE6, $07, nRst, $01
	sGate		$06
	dc.b nEb6, $0C, nE6, $24
	sGate		$00
	dc.b nEb6, $03, nRst, $01, nE6, $07, nRst, $01
	dc.b nEb6, $03, nRst, $01
	sGate		$06
	dc.b nE6, $0C, nEb6
	sGate		$00
	dc.b nE6, $07, nRst, $01, nEb6, $03, nRst, $01
	dc.b nE6, $07, nRst, $01
	sGate		$06
	dc.b nG6, $24
	sGate		$03
	dc.b nG6, $04
	sGate		$00
	dc.b nE6, $07, nRst, $01, nF6, $03, nRst, $01
	dc.b nG6, $0C, nRst
	sGate		$04
	dc.b nG6, $04, nE6, nF6, nG6, nF6, nE6, nD6
	dc.b nC6, nB5, nA5, nG5, nFs5, nF5, nE5, nEb5
	dc.b nD5, nCs5, nAb5

DancingLeaves_Loop7:
	dc.b nA5, nE5
	saVolFM		$02
	sLoop		$00, $03, DancingLeaves_Loop7
	sGate		$00
	dc.b nA5, $0C, nRst, nRst, $18
	saVolFM		$FA
	saVolFM		$FC
	sPatFM		$02
	dc.b nAb6, $07, nRst, $01
	sGate		$04
	dc.b nB6, $0C, nB6, $04, nRst, $0C, nB6, $08
	sGate		$03
	dc.b nB6, $04
	sGate		$04
	dc.b nB6, $08, $0C, nCs7, nCs7
	sGate		$03
	dc.b nEb7, $04
	sGate		$05
	dc.b nE7, $08, nEb7, nCs7
	sGate		$00
	dc.b nB6, $17, nRst, $01, nAb6, $13, nRst, $01
	sGate		$04
	dc.b nA6, $0C, nA6
	sGate		$03
	dc.b nB6, $04
	sGate		$05
	dc.b nC7, $08, nB6, nA6
	sGate		$00
	dc.b nAb6, $17, nRst, $01, nE6, $03, nRst, nRst
	dc.b $06, nFs6, $07, nRst, $01, nG6, $1B, nRst
	dc.b $01, nFs6, $0B, nRst, $01, nE6, $0B, nRst
	dc.b $01, nF6, $17, nRst, $01, nD6, $03, nRst
	dc.b nRst, $06, nE6, $07, nRst, $01, nF6, $1B
	dc.b nRst, $01, nE6, $0B, nRst, $01, nEb6, $0B
	dc.b nRst, $01, nE6, $06, nRst
	saVolFM		$04
	sJump		DancingLeaves_Jump2

DancingLeaves_FM3:
	dc.b nRst, $0C

DancingLeaves_Jump3:
	sPatFM		$02
	sCall		DancingLeaves_Call5
	sGate		$04
	dc.b nE6, $0C, nC6, $08
	sGate		$03
	dc.b nC6, $04
	sGate		$04
	dc.b nC6, $08, $0C
	sGate		$05
	dc.b nD6, $0C, nD6
	sGate		$03
	dc.b nE6, $04
	sGate		$05
	dc.b nF6, $08, nE6, nD6
	sGate		$04
	dc.b nC6, $0C
	sCall		DancingLeaves_Call5
	sGate		$04
	dc.b nD6, $0C, nG6, $08
	sGate		$03
	dc.b nG6, $04
	sGate		$04
	dc.b nG6, $08, $0C
	sGate		$05
	dc.b nG6, $0C, nG6
	sGate		$03
	dc.b nG6, $04
	sGate		$05
	dc.b nG6, $08, nG6, nG6
	sPatFM		$04
	sGate		$04

DancingLeaves_Loop8:
	sCall		DancingLeaves_Call6
	sLoop		$00, $10, DancingLeaves_Loop8
	sGate		$00
	dc.b nRst, $30, nRst, nRst, nRst, $18
	sPatFM		$07
	sGate		$06
	dc.b nE5, $0C, nF5, nRst, nG5, $08, $0C, nG5
	dc.b nG5, nG5
	sGate		$00
	dc.b nG5, $03, nRst, $01
	sGate		$06
	dc.b nF5, $0C, nF5
	sGate		$0F
	dc.b nE5, $14, nC5, $10
	sGate		$00
	dc.b nG4, $23, nRst, $01
	ssMod68k	$16, $01, $79, $22
	dc.b nG4, $18
	ssMod68k	$01, $01, $00, $00
	dc.b nG5, $30, sHold, $13, nRst, $01, nE5, $06
	dc.b nRst, nF5, $03, nRst, $01, nG5, $07, nRst
	dc.b $01, nF5, $03, nRst, $01
	sGate		$0F
	dc.b nE5, $14, nC5, $10
	sGate		$00
	dc.b nG4, $23, nRst, $01
	sGate		$06
	dc.b nE5, $0C, nF5, nRst, nG5, $08, $0C, nG5
	dc.b nG5, nG5
	sGate		$00
	dc.b nG5, $03, nRst, $01
	sGate		$06
	dc.b nF5, $0C, nF5
	sGate		$0F
	dc.b nE5, $14, nC5, $10
	sGate		$00
	dc.b nG4, $17, nRst, $01
	saVolFM		$FA
	saTranspose	$0C
	sPatFM		$02
	dc.b nG5, $04, nRst
	sGate		$03
	dc.b nG5, $04
	sGate		$06
	dc.b nA5, $08, nC6, $0C
	sGate		$03
	dc.b nA5, $04
	saVolFM		$06
	sGate		$00
	saVolFM		$0A
	sPatFM		$06
	ssMod68k	$0E, $01, $04, $03
	dc.b nB4, $30, sHold, $18, nRst, $08, nB4, $04
	dc.b nRst, $0C, nBb4, $30, sHold, $18, nRst, $08
	dc.b nBb4, $04, nRst, $0C, nA4, $28, nRst, $08
	dc.b nAb4, $28, nRst, $08, nG4, $0C, nRst, $08
	dc.b nG4, $30, sHold, $12, nRst, $0A
	saTranspose	$F4
	saVolFM		$F6
	sPan		spLeft
	saVolFM		$FC
	sPatFM		$08
	sGate		$04
	dc.b nG4, $04
	saVolFM		$13
	dc.b nG4, $08
	saVolFM		$ED
	dc.b nFs4, $04
	saVolFM		$13
	dc.b nFs4, $08
	saVolFM		$ED
	sGate		$00
	dc.b nG4, $08
	sGate		$04
	dc.b nFs4, $04
	saVolFM		$13
	dc.b nFs4, $08
	saVolFM		$ED
	dc.b nG4, $04
	saVolFM		$13
	dc.b nG4, $20
	saVolFM		$ED
	dc.b nRst, $10
	sPan		spRight
	dc.b nG4, $04
	saVolFM		$13
	dc.b nG4, $08
	saVolFM		$ED
	dc.b nFs4, $04
	saVolFM		$13
	dc.b nFs4, $08
	saVolFM		$ED
	sGate		$00
	dc.b nG4, $08, nFs4, $04, nG4, $08
	sGate		$04
	dc.b nBb4, $04
	saVolFM		$13
	dc.b nBb4, $20
	saVolFM		$ED
	sGate		$00
	sPatFM		$07
	saVolFM		$04
	sPan		spCenter
	dc.b nBb4, $04, nRst, $0C, nA4, $28, nRst, $08
	dc.b nAb4, $28, nRst, $08, nG4, $30, sHold, $0C
	saVolFM		$FC
	saVolFM		$04
	saVolFM		$0A
	saTranspose	$0C
	sPatFM		$06
	dc.b nE4, $0C, nRst, $08, nFs4, nRst, nAb4, $30
	dc.b sHold, $08, nRst, $04, nE4, $0C, nRst, $08
	dc.b nFs4, nRst, nAb4, $30, sHold, $08, nRst, $04
	dc.b nE4, $0C, nRst, $08, nFs4, nRst, nAb4, $28
	dc.b nRst, $08, nA4, $28, nRst, $08, nA4, $28
	dc.b nRst, $08, nAb4, $28, nRst, $08, nG4, $0C
	saTranspose	$F4
	ssMod68k	$01, $01, $00, $00
	saVolFM		$F6
	sJump		DancingLeaves_Jump3

DancingLeaves_FM4:
	dc.b nRst, $0C
	saVolFM		$13
	dc.b nRst, $07

DancingLeaves_Jump4:
	sPatFM		$02
	sPan		spRight
	ssMod68k	$0C, $01, $02, $05
	sCall		DancingLeaves_Call1
	sGate		$04
	dc.b nG6, $0C, nE6, $08
	sGate		$03
	dc.b nE6, $04
	sGate		$04
	dc.b nE6, $08, $0C
	sGate		$05
	dc.b nF6, $0C, nF6
	sGate		$03
	dc.b nG6, $04
	sGate		$05
	dc.b nA6, $08, nG6, nF6
	sGate		$04
	dc.b nE6, $0C
	sCall		DancingLeaves_Call1
	sGate		$04
	dc.b nG6, $0C, nC7, $08
	sGate		$03
	dc.b nC7, $04
	sGate		$04
	dc.b nC7, $08, $0C
	sGate		$05
	dc.b nB6, $0C, nB6
	sGate		$03
	dc.b nC7, $04
	sGate		$05
	dc.b nD7, $08, nC7, $09
	saVolFM		$ED
	sGate		$00
	sPan		spCenter
	dc.b nG6, $30, sHold, $30, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, $18, nRst, $09
	saVolFM		$0E
	ssMod68k	$01, $01, $00, $00
	saVolFM		$FC
	sPatFM		$05
	sPan		spLeft
	sCall		DancingLeaves_Call2
	saVolFM		$F2
	dc.b nG5, $1B
	ssMod68k	$03, $01, $05, $03
	sCall		DancingLeaves_Call7
	dc.b sHold, nC5, $0C, nRst, $09
	saVolFM		$0E
	sCall		DancingLeaves_Call2
	saVolFM		$F2
	dc.b nG5, $1B
	ssMod68k	$03, $01, $05, $03
	sCall		DancingLeaves_Call7
	saVolFM		$04
	sPatFM		$02
	sPan		spRight
	ssMod68k	$14, $01, $EC, $EF
	saVolFM		$13
	dc.b nRst, $07, nC7, $24
	ssMod68k	$0C, $01, $02, $05
	sCall		DancingLeaves_Call4
	sGate		$00
	dc.b nG6, $04, sHold, $30, sHold, $2F, nRst, $01
	sCall		DancingLeaves_Call4
	sGate		$00
	dc.b nG6, $04, sHold, $30, sHold, $07, nRst, $01
	ssMod68k	$01, $01, $00, $00
	dc.b nRst, $02
	saVolFM		$FB
	sPatFM		$03
	sPan		spLeft
	saTranspose	$F4
	sGate		$07
	dc.b nG4, $04, nA4, $08, nB4, $04, nC5, $08
	dc.b nD5, $04, nE5, $08, nF5, $04
	saVolFM		$0C

DancingLeaves_Loop9:
	dc.b nG5, $04
	saVolFM		$FF
	sLoop		$00, $0C, DancingLeaves_Loop9
	sGate		$06
	saVolFM		$FC
	dc.b nG5, $13, nRst, $01
	saVolFM		$04
	dc.b nE5, $0C
	sGate		$07
	dc.b nF5, $04, nG5, $08, nF5, $04, nE5, $08
	dc.b $0C, nC5, nC5, $04
	sGate		$00
	dc.b nG4, $1F, nRst, $01, nG4, $04, nE5, $0B
	dc.b nRst, $01, nF5, $0B, nRst, $01, nRst, $0C
	sGate		$07
	dc.b nG5, $08, nC6, $04, nA5, $0C, nF5, $08
	dc.b nB5, $04, nG5, $0C, nE5, $08, nA5, $04
	dc.b nF5, $0C, nD5, $08

DancingLeaves_Loop10:
	dc.b nG5, $04
	saVolFM		$01
	sLoop		$00, $13, DancingLeaves_Loop10
	saVolFM		$ED
	sGate		$00
	saTranspose	$0C
	saVolFM		$FC
	sPatFM		$05
	sCall		DancingLeaves_Call2
	saVolFM		$F2
	dc.b nG5, $1B
	ssMod68k	$03, $01, $05, $03
	sCall		DancingLeaves_Call7
	dc.b nRst, $24
	ssMod68k	$01, $01, $00, $00
	saVolFM		$04
	sPan		spCenter
	saTranspose	$0C
	sPatFM		$02
	ssMod68k	$14, $01, $EC, $EF
	dc.b nC6, $18
	ssMod68k	$01, $01, $00, $00
	sPan		spLeft
	saTranspose	$F4
	dc.b nRst, $09
	saVolFM		$0E
	sPatFM		$01
	sGate		$03
	saVolFM		$03

DancingLeaves_Loop11:
	dc.b nG5, $04, nG4
	saVolFM		$01
	sLoop		$00, $06, DancingLeaves_Loop11
	saVolFM		$F7
	sGate		$03
	dc.b nE5, $08, nF5, $04, nG5, $08, nF5, $04
	dc.b nE5, $14, nCs5, $10
	sGate		$00
	dc.b nG4, $0C, nRst, $0C, nRst, $08, nG4, $03
	dc.b nRst, $01, nE5, $07, nRst, $01, nCs5, $03
	dc.b nRst, $01, nAb5, $07, nRst, $01, nA5, $03
	dc.b nRst, $01
	sGate		$03
	dc.b nE5, $04, nCs5, nD5, nE5, nF5, nA5
	sGate		$0C
	dc.b nE6, $18, nE6, nB5
	sGate		$00
	dc.b nD6, $12, nRst, $02, nC6, $27, nRst, $01
	sGate		$06
	dc.b nD6, $14
	sGate		$00
	dc.b nEb6, $0F, nRst, $01
	sGate		$06
	dc.b nE6, $0C, nEb6
	sGate		$00
	dc.b nE6, $07, nRst, $01
	sGate		$06
	dc.b nEb6, $0C, nE6, $24
	sGate		$00
	dc.b nEb6, $03, nRst, $01, nE6, $07, nRst, $01
	dc.b nEb6, $03, nRst, $01
	sGate		$06
	dc.b nE6, $0C, nEb6
	sGate		$00
	dc.b nE6, $07, nRst, $01, nEb6, $03, nRst, $01
	dc.b nE6, $07, nRst, $01
	sGate		$06
	dc.b nG6, $24
	sGate		$03
	dc.b nG6, $04
	sGate		$00
	dc.b nE6, $07, nRst, $01, nF6, $03, nRst, $01
	dc.b nG6, $0C, nRst
	sGate		$04
	dc.b nG6, $04, nE6, nF6, nG6, nF6, nE6, nD6
	dc.b nC6, nB5, nA5, nG5, nFs5, nF5, nE5, nEb5
	dc.b nD5, nCs5, nAb5

DancingLeaves_Loop12:
	dc.b nA5, nE5
	saVolFM		$02
	sLoop		$00, $03, DancingLeaves_Loop12
	sGate		$00
	dc.b nA5, $0C, nRst, nRst, $16
	saVolFM		$FA
	saVolFM		$05
	saVolFM		$FC
	ssMod68k	$0C, $01, $02, $05
	sPatFM		$02
	sPan		spRight
	dc.b nAb6, $07, nRst, $01
	sGate		$04
	dc.b nB6, $0C, $04, nRst, $0C, nB6, $08
	sGate		$03
	dc.b nB6, $04
	sGate		$04
	dc.b nB6, $08, $0C, nCs7, nCs7
	sGate		$03
	dc.b nEb7, $04
	sGate		$05
	dc.b nE7, $08, nEb7, nCs7
	sGate		$00
	dc.b nB6, $17, nRst, $01, nAb6, $13, nRst, $01
	sGate		$04
	dc.b nA6, $0C, nA6
	sGate		$03
	dc.b nB6, $04
	sGate		$05
	dc.b nC7, $08, nB6, nA6
	sGate		$00
	dc.b nAb6, $17, nRst, $01, nE6, $03, nRst, nRst
	dc.b $06, nFs6, $07, nRst, $01, nG6, $1B, nRst
	dc.b $01, nFs6, $0B, nRst, $01, nE6, $0B, nRst
	dc.b $01, nF6, $17, nRst, $01, nD6, $03, nRst
	dc.b nRst, $06, nE6, $07, nRst, $01, nF6, $1B
	dc.b nRst, $01, nE6, $0B, nRst, $01, nEb6, $0B
	dc.b nRst, $01, nE6, $06, nRst
	saVolFM		$04
	ssMod68k	$01, $01, $00, $00
	sJump		DancingLeaves_Jump4

DancingLeaves_FM5:
	dc.b nRst, $0C

DancingLeaves_Jump5:
	ssMod68k	$0C, $01, $02, $05
	sPan		spLeft
	saVolFM		$13
	dc.b nRst, $07
	sPatFM		$02
	sCall		DancingLeaves_Call5
	sGate		$04
	dc.b nE6, $0C, nC6, $08
	sGate		$03
	dc.b nC6, $04
	sGate		$04
	dc.b nC6, $08, $0C
	sGate		$05
	dc.b nD6, $0C, nD6
	sGate		$03
	dc.b nE6, $04
	sGate		$05
	dc.b nF6, $08, nE6, nD6
	sGate		$04
	dc.b nC6, $0C
	sCall		DancingLeaves_Call5
	sGate		$04
	dc.b nD6, $0C, nG6, $08
	sGate		$03
	dc.b nG6, $04
	sGate		$04
	dc.b nG6, $08, $0C
	sGate		$05
	dc.b nG6, $0C, nG6
	sGate		$03
	dc.b nG6, $04
	sGate		$05
	dc.b nG6, $08, nG6, $09
	saVolFM		$ED
	sPan		spCenter
	sGate		$04
	ssMod68k	$01, $01, $00, $00
	dc.b nRst, $01
	sPatFM		$04

DancingLeaves_Loop13:
	sCall		DancingLeaves_Call8
	sLoop		$00, $10, DancingLeaves_Loop13
	sGate		$00
	dc.b nRst, $2F, nRst, $30, nRst, nRst, $18
	saVolFM		$13
	dc.b nRst, $07
	sPatFM		$07
	sGate		$06
	dc.b nE5, $0C, nF5, nRst, nG5, $08, $0C, nG5
	dc.b nG5, nG5
	sGate		$00
	dc.b nG5, $03, nRst, $01
	sGate		$06
	dc.b nF5, $0C, nF5
	sGate		$0F
	dc.b nE5, $14, nC5, $10
	sGate		$00
	dc.b nG4, $23, nRst, $01
	ssMod68k	$16, $01, $79, $22
	dc.b nG4, $18
	ssMod68k	$01, $01, $00, $00
	dc.b nG5, $30, sHold, $13, nRst, $01, nE5, $06
	dc.b nRst, nF5, $03, nRst, $01, nG5, $07, nRst
	dc.b $01, nF5, $03, nRst, $01
	sGate		$0F
	dc.b nE5, $14, nC5, $10
	sGate		$00
	dc.b nG4, $23, nRst, $01
	sGate		$06
	dc.b nE5, $0C, nF5, nRst, nG5, $08, $0C, nG5
	dc.b nG5, nG5
	sGate		$00
	dc.b nG5, $03, nRst, $01
	sGate		$06
	dc.b nF5, $0C, nF5
	sGate		$0F
	dc.b nE5, $14, nC5, $10
	sGate		$00
	dc.b nG4, $17, nRst, $01
	saVolFM		$FA
	saTranspose	$0C
	sPatFM		$02
	dc.b nG5, $04, nRst
	sGate		$03
	dc.b nG5, $04
	sGate		$06
	dc.b nA5, $08, nC6, $09
	saVolFM		$ED
	sGate		$00
	saVolFM		$06
	saVolFM		$0A
	sPatFM		$06
	ssMod68k	$0A, $01, $04, $03
	dc.b nG4, $30, sHold, $18, nRst, $08, nG4, $04
	dc.b nRst, $0C, nG4, $30, sHold, $18, nRst, $08
	dc.b nG4, $04, nRst, $0C, nF4, $28, nRst, $08
	dc.b nF4, $28, nRst, $08, nE4, $0C, nRst, $08
	dc.b nE4, $30, sHold, $12, nRst, $0A, nB4, $30
	dc.b sHold, $18, nRst, $08, nB4, $04, nRst, $0C
	dc.b nBb4, $30, sHold, $18, nRst, $08, nBb4, $04
	dc.b nRst, $0C, nF4, $28, nRst, $08, nF4, $28
	dc.b nRst, $08, nE4, $0C, nRst, $08, nE4, $24
	dc.b nRst, $04, nCs5, $0C, nRst, $08, nEb5, nRst
	dc.b nE5, $30, sHold, $08, nRst, $04, nCs5, $0C
	dc.b nRst, $08, nEb5, nRst, nE5, $30, sHold, $08
	dc.b nRst, $04, nCs5, $0C, nRst, $08, nEb5, nRst
	dc.b nE5, $28, nRst, $08, nC5, $28, nRst, $08
	dc.b nC5, $28, nRst, $08, nB4, $28, nRst, $08
	dc.b nC5, $0C
	saTranspose	$F4
	saVolFM		$F6
	ssMod68k	$01, $01, $00, $00
	sJump		DancingLeaves_Jump5

DancingLeaves_PSG1:
	saVolPSG	$06
	dc.b nRst, $0C

DancingLeaves_Jump6:
	dc.b nRst, $07, nRst, $24, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst
	sVolEnvPSG	v04
	sGate		$04

DancingLeaves_Loop14:
	sCall		DancingLeaves_Call6
	sLoop		$00, $0F, DancingLeaves_Loop14
	dc.b nB5, $08, $0C, nB5, nB5, nB5, $04, nC6
	dc.b $08, $0C, nC6, nC6, $09
	saVolPSG	$FD

DancingLeaves_Loop15:
	dc.b nB5, $08, $0C, nB5, nB5, nB5, $04, nC6
	dc.b $08, $0C, nC6, nC6, nC6, $04
	sLoop		$00, $04, DancingLeaves_Loop15
	saVolPSG	$FE

DancingLeaves_Loop16:
	dc.b nB5, $08, $0C, nB5, nB5, nB5, $04, nC6
	dc.b $08, $0C, nC6, nC6, nC6, $04
	sLoop		$00, $04, DancingLeaves_Loop16
	saVolPSG	$02
	saVolPSG	$03
	saVolPSG	$FD
	sGate		$00
	sVolEnvPSG	v1B
	ssMod68k	$08, $02, $05, $02
	dc.b nE5, $30, sHold, $18, nRst, $08, nE5, $04
	dc.b nRst, $0C, nE5, $30, sHold, $18, nRst, $08
	dc.b nE5, $04, nRst, $0C, nE5, $28, nRst, $08
	dc.b nE5, $28, nRst, $08, nD5, $0C, nRst, $08
	dc.b nC5, $30, sHold, $12, nRst, $0A, nC5, $30
	dc.b sHold, $18, nRst, $08, nC5, $04, nRst, $0C
	dc.b nCs5, $30, sHold, $18, nRst, $08, nC5, $04
	dc.b nRst, $0C, nC5, $28, nRst, $08, nB4, $28
	dc.b nRst, $08, nB4, $0C, nRst, $08, nB4, $24
	dc.b nRst, $04, nRst, $24, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nG4, $28, nRst, $08, nE5, $28
	dc.b nRst, $08, nEb5, $28, nRst, $08, nE5, $0C
	ssMod68k	$01, $01, $00, $00
	saVolPSG	$03
	sJump		DancingLeaves_Jump6

DancingLeaves_PSG2:
	saVolPSG	$06
	dc.b nRst, $0C

DancingLeaves_Jump7:
	dc.b nRst, $06, nRst, $24, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst
	sVolEnvPSG	v04
	dc.b nRst, $01
	sGate		$04

DancingLeaves_Loop17:
	sCall		DancingLeaves_Call8
	sLoop		$00, $0F, DancingLeaves_Loop17
	dc.b nG5, $08, $0C, nG5, nG5, nG5, $04, nA5
	dc.b $08, $0C, nA5, nA5, $0A
	saVolPSG	$FD

DancingLeaves_Loop18:
	dc.b nG5, $08, $0C, nG5, nG5, nG5, $04, nA5
	dc.b $08, $0C, nA5, nA5, nA5, $04
	sLoop		$00, $04, DancingLeaves_Loop18
	saVolPSG	$FE

DancingLeaves_Loop19:
	dc.b nG5, $08, $0C, nG5, nG5, nG5, $04, nA5
	dc.b $08, $0C, nA5, nA5, nA5, $04
	sLoop		$00, $03, DancingLeaves_Loop19
	dc.b nG5, $08, $0C, nG5, nG5, nG5, $04, nA5
	dc.b $08, $0C, nA5, nA5, nA5, $03
	saVolPSG	$02
	saVolPSG	$03
	sGate		$00
	saVolPSG	$FD
	sVolEnvPSG	v1B
	ssMod68k	$0C, $02, $05, $02
	dc.b nC5, $30, sHold, $18, nRst, $08, nC5, $04
	dc.b nRst, $0C, nCs5, $30, sHold, $18, nRst, $08
	dc.b nC5, $04, nRst, $0C, nC5, $28, nRst, $08
	dc.b nB4, $28, nRst, $08, nB4, $0C, nRst, $08
	dc.b nB4, $30, sHold, $12, nRst, $0A, nE5, $30
	dc.b sHold, $18, nRst, $08, nE5, $04, nRst, $0C
	dc.b nE5, $30, sHold, $18, nRst, $08, nE5, $04
	dc.b nRst, $0C, nE5, $28, nRst, $08, nE5, $28
	dc.b nRst, $08, nD5, $0C, nRst, $08, nC5, $24
	dc.b nRst, $04, nA4, $0C, nRst, $08, nB4, nRst
	dc.b nB4, $30, sHold, $08, nRst, $04, nA4, $0C
	dc.b nRst, $08, nB4, nRst, nB4, $30, sHold, $08
	dc.b nRst, $04, nA4, $0C, nRst, $08, nB4, nRst
	dc.b nB4, $28, nRst, $08, nE5, $28, nRst, $08
	dc.b nF4, $28, nRst, $08, nF4, $28, nRst, $08
	dc.b nE4, $0C
	ssMod68k	$01, $01, $00, $00
	saVolPSG	$03
	sJump		DancingLeaves_Jump7

DancingLeaves_PSG3:
	saTranspose	$F7
	sNoisePSG	$E7

DancingLeaves_Jump8:
	sVolEnvPSG	v10
	dc.b nB6, $2C, $0C, $28, $18, $14, $0C, $18
	dc.b $10, $2C, $0C, $28, nB6, $0C
	sVolEnvPSG	v18
	dc.b nC7, $08, $04
	sVolEnvPSG	v10
	dc.b nB6, $0C
	sVolEnvPSG	v18
	dc.b nC7, $08, $04
	sVolEnvPSG	v10
	dc.b nB6, $0C, nB6, nB6, nB6

DancingLeaves_Loop20:
	sVolEnvPSG	v10
	dc.b nB6, $0C
	sVolEnvPSG	v18
	dc.b nC7, $08, $04
	sLoop		$00, $3E, DancingLeaves_Loop20
	sVolEnvPSG	v10

DancingLeaves_Loop21:
	dc.b nB6, $0C
	saVolPSG	$01
	sLoop		$00, $04, DancingLeaves_Loop21

DancingLeaves_Loop22:
	sVolEnvPSG	v10
	dc.b nB6, $0C
	sVolEnvPSG	v18
	dc.b nC7, $08, $04
	sLoop		$00, $0E, DancingLeaves_Loop22
	sVolEnvPSG	v10

DancingLeaves_Loop23:
	dc.b nB6, $0C
	saVolPSG	$FF
	sLoop		$00, $04, DancingLeaves_Loop23

DancingLeaves_Loop24:
	sVolEnvPSG	v10
	dc.b nB6, $0C
	sVolEnvPSG	v18
	dc.b nC7, $08, $04
	sLoop		$00, $40, DancingLeaves_Loop24
	sJump		DancingLeaves_Jump8

DancingLeaves_DAC1:
	dc.b d84, $2C, $0C, $28, $18, $14, $0C, $18
	dc.b $10, $2C, $0C, $28

DancingLeaves_Loop25:
	dc.b d84, $14, d82, $04
	sLoop		$00, $04, DancingLeaves_Loop25

DancingLeaves_Loop26:
	sCall		DancingLeaves_Call9
	sLoop		$00, $48, DancingLeaves_Loop26
	sJump		DancingLeaves_DAC1

DancingLeaves_DAC2:
	dc.b d94, $2C, $0C, $28, $18, $14, $0C, $18
	dc.b $10, $2C, $0C, $28
	sCall		DancingLeaves_Call10

DancingLeaves_Loop27:
	sCall		DancingLeaves_Call11
	sLoop		$00, $1E, DancingLeaves_Loop27
	sCall		DancingLeaves_Call11
	dc.b d83, $0C, $14, $04, $08, $04

DancingLeaves_Loop28:
	dc.b nRst, $30, nRst
	sLoop		$01, $03, DancingLeaves_Loop28
	dc.b d83, $0C, d83, d83, $08, $04, $08, $02
	dc.b d83, d94, $08, $0C, $04, $08, $04, $08
	dc.b $04

DancingLeaves_Loop29:
	sCall		DancingLeaves_Call11
	sLoop		$00, $06, DancingLeaves_Loop29
	sCall		DancingLeaves_Call10

DancingLeaves_Loop31:
	dc.b nRst, $0C

DancingLeaves_Loop30:
	dc.b d94, $18
	sLoop		$00, $07, DancingLeaves_Loop30
	dc.b d94, $08, $04
	sLoop		$01, $06, DancingLeaves_Loop31
	sJump		DancingLeaves_DAC2

DancingLeaves_Call1:
	sGate		$04
	dc.b nG6, $08
	sGate		$03
	dc.b nG6, $04
	sGate		$04
	dc.b nG6, $08, $0C
	sGate		$05
	dc.b nA6, $0C, nA6
	sGate		$03
	dc.b nB6, $04
	sGate		$05
	dc.b nC7, $08, nB6, nA6
	sRet

DancingLeaves_Call4:
	dc.b nRst, $08, nG5, $03, nRst, $01, nE6, $07
	dc.b nRst, $01, nG6, $03, nRst, $01
	sGate		$06
	dc.b nC7, $0C, nG6, $08, nA6, $0C, nC7, nF6
	dc.b nA6
	sRet

DancingLeaves_Call5:
	sGate		$04
	dc.b nE6, $08
	sGate		$03
	dc.b nE6, $04
	sGate		$04
	dc.b nE6, $08, $0C
	sGate		$05
	dc.b nF6, $0C, nF6
	sGate		$03
	dc.b nG6, $04
	sGate		$05
	dc.b nA6, $08, nG6, nF6
	sRet

DancingLeaves_Call2:
	ssMod68k	$16, $01, $79, $22
	dc.b nG5, $18
	ssMod68k	$16, $01, $08, $04
	dc.b nG6, $30, sHold, $13, nRst, $01
	ssMod68k	$03, $01, $05, $03
	dc.b nE6, $06, nRst, nF6, $03, nRst, $01, nG6
	dc.b $07, nRst, $01, nF6, $03, nRst, $01
	sGate		$0F
	dc.b nE6, $14, nC6, $10
	ssMod68k	$16, $01, $08, $04
	sRet

DancingLeaves_Call3:
	sGate		$06
	sPan		spCenter
	dc.b nE6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nE6, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nF6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nF6, $05
	saVolFM		$F2
	dc.b nRst, $0C
	sPan		spCenter
	dc.b nG6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nG6, $01
	saVolFM		$F2
	sPan		spCenter
	dc.b nG6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nG6, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nG6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nG6, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nG6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nG6, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nG6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nG6, $05
	saVolFM		$F2
	sGate		$00
	dc.b nG6, $04
	sGate		$06
	sPan		spCenter
	dc.b nF6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nF6, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nF6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nF6, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nE6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nE6, $0D
	saVolFM		$F2
	sPan		spCenter
	dc.b nC6, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nC6, $09
	saVolFM		$F2
	sGate		$00
	ssMod68k	$16, $01, $08, $04
	sPan		spCenter
	dc.b nG5, $18
	sRet

DancingLeaves_Call7:
	sGate		$06
	sPan		spCenter
	dc.b nG5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nG5, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nA5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nA5, $05
	saVolFM		$F2
	dc.b nRst, $0C
	sPan		spCenter
	dc.b nB5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nB5, $01
	saVolFM		$F2
	sPan		spCenter
	dc.b nB5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nB5, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nB5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nB5, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nB5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nB5, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nB5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nB5, $05
	saVolFM		$F2
	sGate		$00
	dc.b nB5, $04
	sGate		$06
	sPan		spCenter
	dc.b nA5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nA5, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nA5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nA5, $05
	saVolFM		$F2
	sPan		spCenter
	dc.b nG5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nG5, $0D
	saVolFM		$F2
	sPan		spCenter
	dc.b nE5, $07
	sPan		spLeft
	saVolFM		$0E
	dc.b nE5, $09
	saVolFM		$F2
	sGate		$00
	ssMod68k	$16, $01, $08, $04
	sPan		spCenter
	dc.b nC5, $18
	sPan		spLeft
	sRet

DancingLeaves_Call6:
	dc.b nB5, $08, $0C, nB5, nB5, nB5, $04, nC6
	dc.b $08, $0C, nC6, nC6, nC6, $04
	sRet

DancingLeaves_Call8:
	dc.b nG5, $08, $0C, nG5, nG5, nG5, $04, nA5
	dc.b $08, $0C, nA5, nA5, nA5, $04
	sRet

DancingLeaves_Call9:
	dc.b d84, $14, d82, $04, d84, $18
	sRet

DancingLeaves_Call11:
	dc.b nRst, $08, d83, $0C, $10, d94, $08, $04
	sRet

DancingLeaves_Call10:
	dc.b d94, $0C, d94, d94, $08, $04, $08, d83
	dc.b $02, d83, d94, $08, $0C, d94, d94, $04
	dc.b $08, $04
	sRet

DancingLeaves_Patches:

	; Patch $00
	; $32
	; $40, $30, $60, $30,	$1F, $1F, $1F, $1F
	; $0A, $08, $08, $09,	$0B, $0E, $0C, $0A
	; $0F, $0E, $0F, $0F,	$25, $10, $20, $80
	spAlgorithm	$02
	spFeedback	$06
	spDetune	$04, $06, $03, $03
	spMultiple	$00, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $08, $08, $09
	spSustainLv	$00, $00, $00, $00
	spDecayRt	$0B, $0C, $0E, $0A
	spReleaseRt	$0F, $0F, $0E, $0F
	spTotalLv	$25, $20, $10, $00

	; Patch $01
	; $04
	; $27, $01, $2A, $22,	$57, $57, $15, $15
	; $05, $05, $09, $09,	$03, $03, $06, $06
	; $28, $28, $28, $28,	$26, $80, $20, $80
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$02, $02, $00, $02
	spMultiple	$07, $0A, $01, $02
	spRateScale	$01, $00, $01, $00
	spAttackRt	$17, $15, $17, $15
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$05, $09, $05, $09
	spSustainLv	$02, $02, $02, $02
	spDecayRt	$03, $06, $03, $06
	spReleaseRt	$08, $08, $08, $08
	spTotalLv	$26, $20, $00, $00

	; Patch $02
	; $3A
	; $01, $01, $00, $01,	$50, $15, $0F, $52
	; $04, $0E, $0E, $0E,	$00, $00, $00, $00
	; $48, $08, $08, $09,	$1C, $43, $30, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $00, $01, $01
	spRateScale	$01, $00, $00, $01
	spAttackRt	$10, $0F, $15, $12
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $0E, $0E, $0E
	spSustainLv	$04, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$08, $08, $08, $09
	spTotalLv	$1C, $30, $43, $00

	; Patch $03
	; $2C
	; $6E, $64, $2F, $24,	$5C, $58, $5C, $58
	; $0C, $0A, $0C, $0C,	$05, $05, $05, $05
	; $FF, $EF, $DF, $EF,	$2B, $80, $31, $80
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$06, $02, $06, $02
	spMultiple	$0E, $0F, $04, $04
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1C, $1C, $18, $18
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0C, $0A, $0C
	spSustainLv	$0F, $0D, $0E, $0E
	spDecayRt	$05, $05, $05, $05
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$2B, $31, $00, $00

	; Patch $04
	; $3C
	; $3F, $33, $30, $31,	$96, $D9, $97, $D9
	; $1C, $06, $12, $04,	$01, $01, $01, $01
	; $A7, $27, $E7, $17,	$28, $8A, $1E, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$03, $03, $03, $03
	spMultiple	$0F, $00, $03, $01
	spRateScale	$02, $02, $03, $03
	spAttackRt	$16, $17, $19, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$1C, $12, $06, $04
	spSustainLv	$0A, $0E, $02, $01
	spDecayRt	$01, $01, $01, $01
	spReleaseRt	$07, $07, $07, $07
	spTotalLv	$28, $1E, $0A, $00

	; Patch $05
	; $39
	; $32, $33, $33, $31,	$DF, $DF, $DF, $9F
	; $07, $04, $04, $0D,	$04, $04, $04, $03
	; $FF, $FF, $FF, $0F,	$29, $23, $2B, $80
	spAlgorithm	$01
	spFeedback	$07
	spDetune	$03, $03, $03, $03
	spMultiple	$02, $03, $03, $01
	spRateScale	$03, $03, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$07, $04, $04, $0D
	spSustainLv	$0F, $0F, $0F, $00
	spDecayRt	$04, $04, $04, $03
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$29, $2B, $23, $00

	; Patch $06
	; $3A
	; $01, $05, $00, $01,	$0D, $15, $15, $17
	; $04, $05, $04, $03,	$00, $00, $00, $00
	; $07, $07, $17, $07,	$1B, $47, $1F, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $00, $05, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0D, $15, $15, $17
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $04, $05, $03
	spSustainLv	$00, $01, $00, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$07, $07, $07, $07
	spTotalLv	$1B, $1F, $47, $00

	; Patch $07
	; $3D
	; $01, $01, $02, $01,	$4C, $17, $50, $19
	; $0B, $05, $01, $02,	$01, $00, $00, $00
	; $2F, $2F, $2F, $1F,	$1D, $80, $86, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $02, $01, $01
	spRateScale	$01, $01, $00, $00
	spAttackRt	$0C, $10, $17, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0B, $01, $05, $02
	spSustainLv	$02, $02, $02, $01
	spDecayRt	$01, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1D, $06, $00, $00

	; Patch $08
	; $3D
	; $01, $01, $02, $01,	$5C, $17, $57, $19
	; $0B, $05, $01, $02,	$01, $00, $00, $00
	; $2F, $2F, $2F, $1F,	$1D, $80, $86, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $02, $01, $01
	spRateScale	$01, $01, $00, $00
	spAttackRt	$1C, $17, $17, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0B, $01, $05, $02
	spSustainLv	$02, $02, $02, $01
	spDecayRt	$01, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1D, $06, $00, $00
