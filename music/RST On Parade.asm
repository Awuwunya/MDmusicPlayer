OnParade_Header:
	sHeaderInit
	sHeaderPatch	OnParade_Patches
	sHeaderCh	$07, $03
	sHeaderTempo	$01, $4A
	sHeaderDAC	OnParade_DAC1
	sHeaderDAC	OnParade_DAC2
	sHeaderFM	OnParade_FM1, $FF, $14
	sHeaderFM	OnParade_FM2, $FF, $14
	sHeaderFM	OnParade_FM3, $FF, $0E
	sHeaderFM	OnParade_FM4, $FF, $14
	sHeaderFM	OnParade_FM5, $FF, $14
	sHeaderPSG	OnParade_PSG1, $DB, $03, $00, v00
	sHeaderPSG	OnParade_PSG2, $DB, $03, $00, v00
	sHeaderPSG	OnParade_PSG3, $F7, $00, $00, v00

OnParade_FM1:
	ssPalTempo	$44
	dc.b nRst, $06, nRst, $30

OnParade_Jump1:
	sPatFM		$00
	dc.b nRst, $0C
	sCall		OnParade_Call1
	dc.b nG4, $06, nRst, $06
	sPatFM		$04
	dc.b nG5, $06, nRst, nG4, nRst
	sPatFM		$00
	sCall		OnParade_Call1
	dc.b nG4, $06
	sPatFM		$04
	dc.b nD4, $06, nD4, nD4
	sPatFM		$00
	sCall		OnParade_Call2
	dc.b nG4, $06, nRst, $12
	sGate		$00
	dc.b nB4, $12, nA4, nG4, $1E, nRst, $0C
	sPatFM		$04
	sGate		$05
	dc.b nD4, $06, nRst, nD4
	sPatFM		$00
	sCall		OnParade_Call2
	dc.b nG4, $06, nRst, $12
	sGate		$00
	dc.b nD5, $12, nC5, nB4, $0C, nG4, $18, nA4
	dc.b $06
	sPatFM		$04
	dc.b nD4, $06, nD4, nD4
	sPatFM		$00
	sCall		OnParade_Call3
	dc.b nB4, $08
	sGate		$00
	dc.b nA4, $0A, nG4, $03, nRst
	sCall		OnParade_Call3
	sGate		$06
	dc.b nB4, $0C, nA4
	sGate		$00
	dc.b nG4, $30, sHold, $1E
	sPatFM		$03
	ssMod68k	$07, $01, $04, $05
	dc.b nE5, $0A, nRst, $02, nG5, $04, nRst, $02
	dc.b nFs5, $10, nRst, $02, nD5, $1C, nRst, $02
	dc.b nE5, $16, nRst, $02, nD5, $04, nRst, $02
	dc.b nG4, $0A, nRst, $02, nA4, $04, nRst, $02
	dc.b nB4, $0A, nRst, $02, nD5, $2E, nRst, $02
	dc.b nD4, $04, nRst, $02, nD4, $06, nG4, nB4
	dc.b nE5, nG5, nFs5, $10, nRst, $02, nD5, $1C
	dc.b nRst, $02, nE5, $16, nRst, $02, nD5, $04
	dc.b nRst, $02, nB4, $0A, nRst, $02, nA4, $04
	dc.b nRst, $02, nG4, $30, sHold, $30
	ssMod68k	$01, $01, $00, $00
	sPatFM		$04
	sGate		$05
	dc.b nRst, $30, nRst, $1E, nD4, $06, nD4, nD4
	sJump		OnParade_Jump1

OnParade_FM2:
	dc.b nRst, $06, nRst, $30

OnParade_Jump2:
	saVolFM		$06
	dc.b nRst, $04
	sPatFM		$00
	dc.b nRst, $0C
	sCall		OnParade_Call4
	dc.b nG4, $06, nRst, $02
	saVolFM		$FA
	sPatFM		$05
	dc.b nG3, $06, nRst, nG2, nRst, nRst, $04
	saVolFM		$06
	sPatFM		$00
	sCall		OnParade_Call4
	dc.b nG4, $02
	saVolFM		$FA
	sPatFM		$05
	dc.b nD3, $06, nD3, nD3, nRst, $04
	saVolFM		$06
	sPatFM		$00
	sCall		OnParade_Call2
	dc.b nG4, $02
	saVolFM		$FA
	sPatFM		$01
	sGate		$05
	dc.b nD4, $06, nD4, nD4
	sGate		$0C
	dc.b nG4, $12, nE4
	sGate		$00
	dc.b nD4, $1E, nRst, $0C
	sPatFM		$05
	dc.b nD3, $06, nRst, nD3
	sGate		$03
	dc.b nRst, $04
	saVolFM		$06
	sPatFM		$00
	dc.b nG4, $06, $0C, nG4, nG4, $06, nE4
	sGate		$00
	dc.b nG4, $0B, nRst, $01, nG4, $06, nA4, $08
	saVolFM		$FA
	sPatFM		$01
	sGate		$05
	dc.b nD4, $06, nE4, nG4, nA4
	sGate		$00
	dc.b nB4, $12, nA4, nG4, $0C, nE4, $18, nFs4
	dc.b $06
	sPatFM		$05
	sGate		$05
	dc.b nD3, $06, nD3, nD3
	sGate		$00
	dc.b nRst, $04
	saVolFM		$06
	sPatFM		$00
	sCall		OnParade_Call3
	dc.b nB4, $08
	sGate		$00
	dc.b nA4, $0A, nG4, $06
	sCall		OnParade_Call3
	sGate		$06
	dc.b nB4, $0C, nA4
	sGate		$00
	dc.b nG4, $30, sHold, $1E
	sPatFM		$03
	ssMod68k	$07, $01, $04, $05
	dc.b nE5, $0B, nRst, $01, nG5, $05, nRst, $01
	dc.b nFs5, $11, nRst, $01, nD5, $1D, nRst, $01
	dc.b nE5, $17, nRst, $01, nD5, $05, nRst, $01
	dc.b nG4, $0B, nRst, $01, nA4, $05, nRst, $01
	dc.b nB4, $0B, nRst, $01, nD5, $2F, nRst, $01
	dc.b nD4, $05, nRst, $01, nD4, $06, nG4, nB4
	dc.b nE5, nG5, nFs5, $11, nRst, $01, nD5, $1D
	dc.b nRst, $01, nE5, $17, nRst, $01, nD5, $05
	dc.b nRst, $01, nB4, $0B, nRst, $01, nA4, $05
	dc.b nRst, $01, nG4, $30, sHold, $2C
	ssMod68k	$01, $01, $00, $00
	saVolFM		$FA
	sPatFM		$05
	sGate		$05
	dc.b nRst, $30, nRst, $1E, nD3, $06, nD3, nD3
	sJump		OnParade_Jump2

OnParade_FM3:
	dc.b nRst, $06, nRst, $30
	sPatFM		$02

OnParade_Loop1:
	dc.b nG3, $0C, $06, nB3, $0C, nE4, $06, nD4
	dc.b $0C, nA3, $06, $0C, $06, nD4, $0C, nD3
	sLoop		$00, $04, OnParade_Loop1
	dc.b nG3, $12, $06, $0C, nD3, $06, nE3, nG3
	dc.b $12, $06, $0C, nD3, $06, nE3, nG3, $12
	dc.b $06, $0C, nD3, $06, nE3, nG3, $12, $06
	dc.b nG3, nD3, nD3, nD3, nG3, $12, $06, $0C
	dc.b nD3, $06, nE3, nG3, $12, $06, $0C, nD3
	dc.b $06, nE3, nG3, $12, $06, nB3, $0C, nD4
	dc.b nA3, $12, $06, nA3, nD4, nD4, nD4

OnParade_Loop2:
	dc.b nG3, $14, $04, nD3, $14, nG3, $04, nA3
	dc.b $14, $04, nE3, $14, nA3, $04, nB3, $14
	dc.b $04, nFs3, $14, nB3, $04, nC4, $0C, nC4
	dc.b nD4, nD4
	sLoop		$00, $04, OnParade_Loop2

OnParade_Loop3:
	dc.b nG3, $0C, $06, nB3, $0C, nE4, $06, nD4
	dc.b $0C, nA3, $06, $0C, $06, nD4, $0C, nD3
	sLoop		$00, $06, OnParade_Loop3
	sJump		OnParade_Loop1

OnParade_FM4:
	dc.b nRst, $06, nRst, $30
	sPatFM		$06
	sGate		$07

OnParade_Loop4:
	dc.b nRst, $0C, nB4, $06
	saVolFM		$10
	dc.b nB4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nB4, $06
	saVolFM		$10
	dc.b nB4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nA4, $06
	saVolFM		$10
	dc.b nA4, $06
	saVolFM		$F0
	sLoop		$00, $04, OnParade_Loop4

OnParade_Loop5:
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $06
	saVolFM		$F0
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $06
	saVolFM		$F0
	dc.b nA4, $06
	saVolFM		$10
	dc.b nA4, $06
	saVolFM		$F0
	sLoop		$00, $02, OnParade_Loop5

OnParade_Loop6:
	dc.b nB4, $06
	saVolFM		$10
	dc.b nB4, $06, nRst, $06
	saVolFM		$F0
	dc.b nB4, $06
	saVolFM		$10
	dc.b nB4, $06, nRst, $06
	saVolFM		$F0
	dc.b nA4, $06
	saVolFM		$10
	dc.b nA4, $06
	saVolFM		$F0
	sLoop		$00, $02, OnParade_Loop6

OnParade_Loop7:
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $06
	saVolFM		$F0
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $06
	saVolFM		$F0
	dc.b nA4, $06
	saVolFM		$10
	dc.b nA4, $06
	saVolFM		$F0
	sLoop		$00, $02, OnParade_Loop7
	dc.b nRst, $0C, nB4, $06
	saVolFM		$10
	dc.b nB4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nA4, $06
	saVolFM		$10
	dc.b nA4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nD5, $06
	saVolFM		$10
	dc.b nD5, $06
	saVolFM		$F0

OnParade_Loop8:
	dc.b nRst, $0C, nB4, $06
	saVolFM		$10
	dc.b nB4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nB4, $06
	saVolFM		$10
	dc.b nB4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nC5, $06
	saVolFM		$10
	dc.b nC5, $06, nRst, $0C
	saVolFM		$F0
	dc.b nC5, $06
	saVolFM		$10
	dc.b nC5, $06, nRst, $0C
	saVolFM		$F0
	dc.b nD5, $06
	saVolFM		$10
	dc.b nD5, $06, nRst, $0C
	saVolFM		$F0
	dc.b nD5, $06
	saVolFM		$10
	dc.b nD5, $06, nRst, $0C
	saVolFM		$F0
	dc.b nE5, $06
	saVolFM		$10
	dc.b nE5, $06, nRst, $0C
	saVolFM		$F0
	dc.b nFs5, $06
	saVolFM		$10
	dc.b nFs5, $06
	saVolFM		$F0
	sLoop		$00, $04, OnParade_Loop8

OnParade_Loop9:
	dc.b nRst, $0C, nB4, $06
	saVolFM		$10
	dc.b nB4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nB4, $06
	saVolFM		$10
	dc.b nB4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nA4, $06
	saVolFM		$10
	dc.b nA4, $06
	saVolFM		$F0
	sLoop		$00, $06, OnParade_Loop9
	sJump		OnParade_Loop4

OnParade_FM5:
	dc.b nRst, $06, nRst, $30
	sPatFM		$06
	sGate		$07
	sPan		spLeft

OnParade_Loop10:
	dc.b nRst, $0C, nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nE4, $06
	saVolFM		$10
	dc.b nE4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nFs4, $06
	saVolFM		$10
	dc.b nFs4, $06
	saVolFM		$F0
	sLoop		$00, $04, OnParade_Loop10

OnParade_Loop11:
	dc.b nD4, $06
	saVolFM		$10
	dc.b nD4, $06, nRst, $06
	saVolFM		$F0
	dc.b nD4, $06
	saVolFM		$10
	dc.b nD4, $06, nRst, $06
	saVolFM		$F0
	dc.b nE4, $06
	saVolFM		$10
	dc.b nE4, $06
	saVolFM		$F0
	sLoop		$00, $02, OnParade_Loop11

OnParade_Loop12:
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $06
	saVolFM		$F0
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $06
	saVolFM		$F0
	dc.b nE4, $06
	saVolFM		$10
	dc.b nE4, $06
	saVolFM		$F0
	sLoop		$00, $02, OnParade_Loop12

OnParade_Loop13:
	dc.b nD4, $06
	saVolFM		$10
	dc.b nD4, $06, nRst, $06
	saVolFM		$F0
	dc.b nD4, $06
	saVolFM		$10
	dc.b nD4, $06, nRst, $06
	saVolFM		$F0
	dc.b nE4, $06
	saVolFM		$10
	dc.b nE4, $06
	saVolFM		$F0
	sLoop		$00, $02, OnParade_Loop13
	dc.b nRst, $0C, nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nE4, $06
	saVolFM		$10
	dc.b nE4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nFs4, $06
	saVolFM		$10
	dc.b nFs4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nA4, $06
	saVolFM		$10
	dc.b nA4, $06
	saVolFM		$F0

OnParade_Loop14:
	dc.b nRst, $0C, nD4, $06
	saVolFM		$10
	dc.b nD4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nD4, $06
	saVolFM		$10
	dc.b nD4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nE4, $06
	saVolFM		$10
	dc.b nE4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nE4, $06
	saVolFM		$10
	dc.b nE4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nFs4, $06
	saVolFM		$10
	dc.b nFs4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nFs4, $06
	saVolFM		$10
	dc.b nFs4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nA4, $06
	saVolFM		$10
	dc.b nA4, $06
	saVolFM		$F0
	sLoop		$00, $04, OnParade_Loop14

OnParade_Loop15:
	dc.b nRst, $0C, nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nG4, $06
	saVolFM		$10
	dc.b nG4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nE4, $06
	saVolFM		$10
	dc.b nE4, $06, nRst, $0C
	saVolFM		$F0
	dc.b nFs4, $06
	saVolFM		$10
	dc.b nFs4, $06
	saVolFM		$F0
	sLoop		$00, $06, OnParade_Loop15
	sJump		OnParade_Loop10

OnParade_PSG1:
	dc.b nRst, $06, nRst, $30
	sVolEnvPSG	v00
	sGate		$03
	saVolPSG	$03

OnParade_Loop16:
	sCall		OnParade_Call5
	sLoop		$00, $04, OnParade_Loop16
	saVolPSG	$FD
	sVolEnvPSG	v12
	sGate		$11
	dc.b nRst, $30, nRst, nB4, $12, nA4
	sGate		$00
	dc.b nG4, $30, nRst, $0C, nRst, $30, nRst, nD5
	dc.b $12, nC5, nB4, $0C
	sGate		$00
	dc.b nG4, $18, nA4
	sVolEnvPSG	v19
	ssMod68k	$20, $02, $01, $02
	dc.b nD6, $30, sHold, $30, sHold, $18, nC6, nB5
	dc.b nA5, nG5, $30, nG6, sHold, nG6, $18, nFs6
	dc.b nD6, nE6, nD6, $30, sHold, $30, sHold, $18
	dc.b nC6, nB5, nA5, nG5, $30, nG6, sHold, nG6
	dc.b $18, nFs6, nG6, nA6, nG6, $30, sHold, $30
	ssMod68k	$01, $01, $00, $00
	sVolEnvPSG	v00
	sGate		$03
	saVolPSG	$03

OnParade_Loop17:
	sCall		OnParade_Call5
	sLoop		$00, $05, OnParade_Loop17
	sJump		OnParade_Loop16

OnParade_PSG2:
	dc.b nRst, $06, nRst, $30
	sVolEnvPSG	v00
	sGate		$03
	ssDetune	$FF
	dc.b nRst, $04
	saVolPSG	$06
	saVolPSG	$03

OnParade_Loop18:
	sCall		OnParade_Call5
	sLoop		$00, $03, OnParade_Loop18
	dc.b nD6, $03, nRst, nD6, nRst, nD7, nRst, nD6
	dc.b nRst, nD6, nRst, $09, nD6, $03, nRst, $03
	dc.b nD6, nRst, $09, nD6, $03, nRst, $03, nD7
	dc.b nRst, nD6, nRst, nD6, nRst, $09, nD6, $03
	dc.b nRst, $05
	saVolPSG	$FA
	saVolPSG	$FD
	ssDetune	$00
	sVolEnvPSG	v12
	sGate		$11
	dc.b nRst, $30, nRst, nG4, $12, nE4
	sGate		$00
	dc.b nD4, $30, nRst, $0C, nRst, $30, nRst, nB4
	dc.b $12, nA4, nG4, $0C
	sGate		$00
	dc.b nE4, $18, nFs4
	ssDetune	$FF
	dc.b nRst, $03
	saVolPSG	$04
	sVolEnvPSG	v19
	ssMod68k	$20, $02, $01, $02
	dc.b nD6, $30, sHold, $30, sHold, $18, nC6, nB5
	dc.b nA5, nG5, $30, nG6, sHold, nG6, $18, nFs6
	dc.b nD6, nE6, nD6, $30, sHold, $30, sHold, $18
	dc.b nC6, nB5, nA5, nG5, $30, nG6, sHold, nG6
	dc.b $18, nFs6, nG6, nA6, nG6, $30, sHold, $2D
	ssMod68k	$01, $01, $00, $00
	sVolEnvPSG	v00
	sGate		$03
	saVolPSG	$FC
	saVolPSG	$06
	dc.b nRst, $04
	saVolPSG	$03

OnParade_Loop19:
	sCall		OnParade_Call5
	sLoop		$00, $05, OnParade_Loop19
	sJump		OnParade_Loop18

OnParade_PSG3:
	dc.b nRst, $06, nRst, $30
	sVolEnvPSG	v18
	sNoisePSG	$E7
	sGate		$03

OnParade_Jump3:
	sPan		spLeft
	saVolPSG	$03
	dc.b nC7, $06, nC7
	sPan		spCenter
	saVolPSG	$FD
	dc.b nC7, $06
	sPan		spRight
	saVolPSG	$03
	dc.b nC7, $06
	saVolPSG	$FD
	sJump		OnParade_Jump3

OnParade_DAC1:
	dc.b nRst, $06, nRst, $30, nRst

OnParade_Jump4:
	dc.b nRst, $24
	sPan		spLeft
	dc.b d91, $0C
	sPan		spRight
	dc.b d92, $30, nRst, $24
	sPan		spLeft
	dc.b d91, $0C
	sPan		spRight
	dc.b d92, $30, nRst, $24
	sPan		spLeft
	dc.b d91, $0C
	sPan		spRight
	dc.b d92, $30, nRst, $1E
	sPan		spCenter
	dc.b d93, $06, d93, d93, nRst, $30, nRst, d8D
	dc.b $12, d8E, d90, $1E, nRst, $0C, d93, $06
	dc.b nRst, d93, nRst, $30, nRst, d8B, $12, d8C
	dc.b d8D, $0C, d90, $18, d8E, $03, sHold, $03
	dc.b d93, $06, d93, d93
	sCall		OnParade_Call6
	dc.b d8D, $08, d8E, $0A, d8F, $06
	sCall		OnParade_Call6
	dc.b d8D, $0C, d8E, d90, $30, nRst, $30

OnParade_Loop20:
	dc.b nRst, $30, nRst
	sLoop		$00, $04, OnParade_Loop20
	dc.b nRst, $30, nRst, $18, d93, $03, nRst, d93
	dc.b nRst, d93, nRst, d93, nRst, d91, $30
	sJump		OnParade_Jump4

OnParade_DAC2:
	dc.b nRst, $06, d81, $12, d83, $02, d83, d83
	dc.b d94, $0C, d94, $0C

OnParade_Loop21:
	dc.b d81, $12, d94, $06, d81, $0C, d94, $0C
	sLoop		$00, $03, OnParade_Loop21
	dc.b d81, $12, d94, $06, d81, $06, d94, d94
	dc.b $0C

OnParade_Loop22:
	dc.b d81, $12, d94, $06, d81, $0C, d94, $0C
	sLoop		$00, $03, OnParade_Loop22
	dc.b d81, $12, d94, $06, d81, $06, d94, d94
	dc.b d94
	sLoop		$01, $0F, OnParade_Loop21

OnParade_Loop23:
	dc.b d81, $12, d94, $06, d81, $0C, d94, $0C
	sLoop		$00, $03, OnParade_Loop23
	dc.b d81, $12, d94, $06, d81, $06, d94, d94
	dc.b $0C, d81, $12, d94, $06, d81, $0C, d94
	dc.b $0C, d81, $12, d94, $06, d81, $06, d94
	dc.b d94, d94
	sLoop		$01, $02, OnParade_Loop23
	sJump		OnParade_Loop21

OnParade_Call1:
	sGate		$05
	dc.b nG4, $06, nG4, nG4, nG4, $0C
	sGate		$00
	dc.b nG4, $0B, nRst, $01
	sGate		$05
	dc.b nG4, $06, nA4, $0C, nB4, $0C
	sPatFM		$04
	dc.b nG5, $06, nRst, nG4, nRst
	sPatFM		$00
	sGate		$05
	dc.b nG4, $06, nG4, nG4, nG4, $0C
	sGate		$00
	dc.b nB4, $0B, nRst, $01
	sGate		$05
	dc.b nB4, $06, nA4, $0C
	sRet

OnParade_Call2:
	dc.b nG4, $06, $0C, nG4, nG4, $06, nE4
	sGate		$00
	dc.b nG4, $0B, nRst, $01
	sGate		$05
	dc.b nG4, $06, nA4, $0C
	sRet

OnParade_Call3:
	sGate		$06
	dc.b nRst, $0C, nD5, nB4, nRst, nRst, $0C, nE5
	dc.b nC5, nRst, nRst, $0C, nD5, nB4
	sGate		$00
	dc.b nB4, $08
	sGate		$06
	dc.b nA4, $04, nG4, $0C, $08, $04
	sGate		$00
	dc.b nG4, $0B, nRst, $01, nA4, $0B, nRst, $01
	sGate		$06
	dc.b nRst, $0C, nB4, nD5, nRst, nRst, $0C, nC5
	dc.b nE5, nRst, nRst, $0C, nD5, nB4
	sGate		$00
	dc.b nB4, $08
	sGate		$05
	dc.b nA4, $04, nB4, $08, nA4, $04, nB4, $08
	dc.b nA4, $04
	sRet

OnParade_Call4:
	sGate		$05
	dc.b nG4, $06, nG4, nG4, nG4, $0C
	sGate		$00
	dc.b nG4, $0B, nRst, $01
	sGate		$05
	dc.b nG4, $06, nA4, $0C, nB4, $08
	saVolFM		$FA
	sPatFM		$05
	dc.b nG3, $06, nRst, nG2, nRst, nRst, $04
	saVolFM		$06
	sPatFM		$00
	sGate		$05
	dc.b nG4, $06, nG4, nG4, nG4, $0C
	sGate		$00
	dc.b nB4, $0B, nRst, $01
	sGate		$05
	dc.b nB4, $06, nA4, $0C
	sRet

OnParade_Call6:
	dc.b nRst, $0C, d8B, d8D, $18, nRst, $0C, d8A
	dc.b d8C, $18, nRst, $0C, d8B, d8D, d8D, $08
	dc.b d8E, $04, d8F, $0C, $08, $04, $0C, d8E
	dc.b nRst, $0C, d8D, d8B, $18, nRst, $0C, d8C
	dc.b d8A, $18, nRst, $0C, d8B, d8D, d8D, $08
	dc.b d8E, $04, d8D, $08, d8E, $04, d8D, $08
	dc.b d8E, $04
	sRet

OnParade_Call5:
	sPan		spLeft
	dc.b nD6, $03, nRst
	sPan		spRight
	dc.b nD6, nRst
	sPan		spLeft
	dc.b nD7, nRst
	sPan		spRight
	dc.b nD6, nRst
	sPan		spLeft
	dc.b nD6, nRst, $09
	sPan		spRight
	dc.b nD6, $03, nRst
	sPan		spLeft
	dc.b nD6, nRst, $09
	sPan		spRight
	dc.b nD6, $03, nRst, $03
	sPan		spLeft
	dc.b nD7, nRst
	sPan		spRight
	dc.b nD6, nRst
	sPan		spLeft
	dc.b nD6, nRst, $09
	sPan		spRight
	dc.b nD6, $03, nRst, $09
	sRet

OnParade_Patches:

	; Patch $00
	; $64
	; $30, $75, $30, $75,	$1A, $1B, $1B, $1A
	; $10, $14, $0B, $08,	$0F, $0A, $08, $0C
	; $5F, $0F, $FF, $FF,	$0A, $80, $09, $87
	spAlgorithm	$04
	spFeedback	$04
	spDetune	$03, $03, $07, $07
	spMultiple	$00, $00, $05, $05
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1A, $1B, $1B, $1A
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$10, $0B, $14, $08
	spSustainLv	$05, $0F, $00, $0F
	spDecayRt	$0F, $08, $0A, $0C
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0A, $09, $00, $07

	; Patch $01
	; $29
	; $36, $74, $71, $31,	$13, $15, $0B, $0E
	; $12, $0E, $1F, $1F,	$04, $06, $03, $01
	; $54, $6A, $0A, $08,	$42, $34, $2D, $80
	spAlgorithm	$01
	spFeedback	$05
	spDetune	$03, $07, $07, $03
	spMultiple	$06, $01, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$13, $0B, $15, $0E
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$12, $1F, $0E, $1F
	spSustainLv	$05, $00, $06, $00
	spDecayRt	$04, $03, $06, $01
	spReleaseRt	$04, $0A, $0A, $08
	spTotalLv	$42, $2D, $34, $00

	; Patch $02
	; $38
	; $01, $00, $00, $00,	$1C, $3F, $16, $18
	; $09, $11, $0E, $0A,	$01, $01, $01, $01
	; $3F, $5F, $BF, $FF,	$20, $17, $20, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $00, $00, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1C, $16, $1F, $18
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$09, $0E, $11, $0A
	spSustainLv	$03, $0B, $05, $0F
	spDecayRt	$01, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$20, $20, $17, $00

	; Patch $03
	; $3A
	; $51, $01, $11, $01,	$21, $2C, $2D, $2E
	; $04, $07, $00, $06,	$01, $01, $01, $07
	; $6C, $7D, $F7, $F9,	$32, $25, $28, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$05, $01, $00, $00
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$01, $0D, $0C, $0E
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $00, $07, $06
	spSustainLv	$06, $0F, $07, $0F
	spDecayRt	$01, $01, $01, $07
	spReleaseRt	$0C, $07, $0D, $09
	spTotalLv	$32, $28, $25, $00

	; Patch $04
	; $3C
	; $12, $12, $20, $61,	$3D, $1F, $1F, $38
	; $04, $09, $05, $0E,	$0F, $03, $05, $10
	; $2F, $3F, $5F, $3F,	$0D, $8A, $10, $88
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$01, $02, $01, $06
	spMultiple	$02, $00, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1D, $1F, $1F, $18
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $05, $09, $0E
	spSustainLv	$02, $05, $03, $03
	spDecayRt	$0F, $05, $03, $10
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0D, $10, $0A, $08

	; Patch $05
	; $3C
	; $01, $01, $01, $01,	$1F, $1F, $1F, $1F
	; $00, $00, $00, $00,	$06, $0B, $0A, $0B
	; $FF, $FF, $FF, $FF,	$19, $80, $1F, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spDecayRt	$06, $0A, $0B, $0B
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$19, $1F, $00, $00

	; Patch $06
	; $33
	; $42, $51, $31, $61,	$1E, $1C, $1D, $19
	; $0A, $07, $10, $03,	$09, $06, $05, $04
	; $0F, $3F, $5F, $3F,	$16, $1D, $0C, $88
	spAlgorithm	$03
	spFeedback	$06
	spDetune	$04, $03, $05, $06
	spMultiple	$02, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $1D, $1C, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $10, $07, $03
	spSustainLv	$00, $05, $03, $03
	spDecayRt	$09, $05, $06, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$16, $0C, $1D, $08

	; Patch $07
	; $3C
	; $01, $11, $21, $61,	$52, $12, $4F, $14
	; $0C, $0A, $0A, $02,	$01, $01, $01, $01
	; $2F, $3F, $5F, $3F,	$20, $80, $13, $87
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $02, $01, $06
	spMultiple	$01, $01, $01, $01
	spRateScale	$01, $01, $00, $00
	spAttackRt	$12, $0F, $12, $14
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0A, $0A, $02
	spSustainLv	$02, $05, $03, $03
	spDecayRt	$01, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$20, $13, $00, $07
