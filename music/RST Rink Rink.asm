RinkRink_Header:
	sHeaderInit
	sHeaderPatch	RinkRink_Patches
	sHeaderCh	$07, $03
	sHeaderTempo	$01, $45
	sHeaderDAC	RinkRink_DAC1
	sHeaderDAC	RinkRink_DAC2
	sHeaderFM	RinkRink_FM1, $F4, $07
	sHeaderFM	RinkRink_FM2, $0C, $0E
	sHeaderFM	RinkRink_FM3, $00, $1A
	sHeaderFM	RinkRink_FM4, $00, $1A
	sHeaderFM	RinkRink_FM5, $0C, $11
	sHeaderPSG	RinkRink_PSG1, $DC, $04, $00, v00
	sHeaderPSG	RinkRink_PSG2, $E8, $04, $00, v00
	sHeaderPSG	RinkRink_PSG3, $E8, $04, $00, v00

RinkRink_FM1:
	ssPalTempo	$3F
	sPatFM		$00
	dc.b nRst, $30, nRst, nRst, nRst
	saVolFM		$06
	sCall		RinkRink_Call1
	saVolFM		$FD
	sCall		RinkRink_Call2
	saVolFM		$FD

RinkRink_Loop1:
	sCall		RinkRink_Call1
	sLoop		$00, $03, RinkRink_Loop1
	sCall		RinkRink_Call2
	sLoop		$01, $02, RinkRink_Loop1

RinkRink_Loop3:
	dc.b nG3, $18, nG3, nG3, nG3, nC4, nC4, nC4
	dc.b nC4, $0C, nC4

RinkRink_Loop2:
	sCall		RinkRink_Call1
	sLoop		$00, $02, RinkRink_Loop2
	sLoop		$01, $02, RinkRink_Loop3
	sPatFM		$06

RinkRink_Loop4:
	sCall		RinkRink_Call3
	dc.b nC4, $06, nC4, nRst
	saVolFM		$08
	dc.b nC4
	saVolFM		$F8
	dc.b nC5, $0C, nC4, $06, nC5, nRst, nC5, nC4
	saVolFM		$08
	dc.b nC4
	saVolFM		$F8
	dc.b nC5, $0C, nBb3
	sLoop		$00, $03, RinkRink_Loop4
	sCall		RinkRink_Call3
	dc.b nC4, $06, nC4, nRst, $0C, nC5, nC4, $06
	dc.b nC5, nRst, nC5, nC4
	saVolFM		$08
	dc.b nC4
	saVolFM		$F8
	dc.b nC5, $0C, nC5
	sPatFM		$00

RinkRink_Loop5:
	sCall		RinkRink_Call1
	sLoop		$00, $03, RinkRink_Loop5
	sCall		RinkRink_Call2
	sLoop		$01, $02, RinkRink_Loop5
	sJump		RinkRink_Loop1

RinkRink_FM2:
	sPatFM		$01

RinkRink_Loop6:
	dc.b nF4, $18, nC4, nD4, nA3
	saVolFM		$06
	sLoop		$00, $04, RinkRink_Loop6
	saVolFM		$E8

RinkRink_Jump1:
	sPatFM		$02
	sCall		RinkRink_Call4
	dc.b nC3, $0B, nRst, $01
	sCall		RinkRink_Call4
	sPatFM		$05
	ssMod68k	$09, $01, $04, $03
	sCall		RinkRink_Call5
	dc.b nA3, $18, nF3, $12
	sGate		$00
	dc.b nG3, $0B, nRst, $01
	sGate		$05
	dc.b nF3, $06, nE3, nF3, nE3, nD3
	sGate		$00
	dc.b nC3, $30, sHold, $24, sHold, $30, sHold, $24
	sCall		RinkRink_Call5
	dc.b nA3, $12, nF3, $0C, nC4, $06, nD4, nC4
	dc.b nF4, nE4, nD4
	sGate		$00
	dc.b nC4, sHold, nC4, $30, sHold, $30, nRst, $30
	dc.b nRst, $0C
	ssMod68k	$01, $01, $00, $00
	sPatFM		$02
	sCall		RinkRink_Call6
	dc.b nC3, $0C, nF3, nE3
	sGate		$00
	dc.b nF3, $30, sHold, $0B, nRst, $01
	sGate		$0B
	dc.b nF3, $0C, nG3, nA3
	sGate		$00
	dc.b nG3, $11, nRst, $01
	sGate		$05
	dc.b nC4, $0C, $06, $0C, nC4, $0C
	sCall		RinkRink_Call6
	dc.b nC3, $0C, nF3, nG3
	sGate		$11
	dc.b nBb3, $12, nA3
	sGate		$0B
	dc.b nF3, $0C
	sGate		$11
	dc.b nBb3, $12, nA3
	sGate		$0B
	dc.b nF3, $0C
	sGate		$00
	dc.b nG3, $30
	sGate		$05
	dc.b nRst, $06, nC4, nD4, nC4, nF4, nE4, nD4
	dc.b nC4
	sGate		$00
	dc.b nF4, $30, sHold, $1E
	sPatFM		$05
	ssMod68k	$09, $01, $04, $03
	sCall		RinkRink_Call7
	dc.b nRst, $30, nRst, nRst, nRst, $1E
	sCall		RinkRink_Call7
	dc.b nRst, $30, nRst
	ssMod68k	$01, $01, $00, $00
	sJump		RinkRink_Jump1

RinkRink_FM3:
	sPatFM		$03
	saVolFM		$10

RinkRink_Loop7:
	sCall		RinkRink_Call8
	saVolFM		$FC
	sLoop		$00, $03, RinkRink_Loop7
	sCall		RinkRink_Call9
	saVolFM		$FC

RinkRink_Loop8:
	sCall		RinkRink_Call8
	sLoop		$00, $03, RinkRink_Loop8
	sCall		RinkRink_Call9
	sLoop		$01, $02, RinkRink_Loop8

RinkRink_Loop11:
	saTranspose	$F9
	sCall		RinkRink_Call10
	saTranspose	$07

RinkRink_Loop10:
	sCall		RinkRink_Call8
	sLoop		$01, $02, RinkRink_Loop10
	sLoop		$02, $02, RinkRink_Loop11
	saVolFM		$FE
	sPatFM		$04
	sPan		spLeft
	sCall		RinkRink_Call11
	saVolFM		$F1
	dc.b nC5, $06, $0C, nC4, nC4, $06
	sGate		$00
	dc.b nC4, $30, sHold, $03
	sCall		RinkRink_Call12
	dc.b nC5, $06, $0C, nC6, nC6, $06
	sGate		$00
	dc.b nC6, $18

RinkRink_Loop12:
	sGate		$06
	dc.b nA5, $0C, nG5
	sGate		$12
	dc.b nF5, $18
	sLoop		$00, $02, RinkRink_Loop12

RinkRink_Loop13:
	sGate		$06
	dc.b nBb5, $0C, nA5
	sGate		$12
	dc.b nG5, $18
	sLoop		$00, $02, RinkRink_Loop13
	sGate		$06
	dc.b nC6, $0C, nD6
	sGate		$12
	dc.b nC6, $18
	sGate		$06
	dc.b nBb5, $0C, nA5
	sGate		$12
	dc.b nBb5, $18
	sGate		$06
	dc.b nC6, $0C, nD6
	sGate		$00
	dc.b nC6, $0C, sHold, $30, sHold, $0B, nRst, $01
	dc.b nF6, $18, nE6, $0C
	saVolFM		$02
	sPan		spCenter
	saVolFM		$0F
	sPatFM		$03

RinkRink_Loop14:
	sCall		RinkRink_Call8
	sLoop		$00, $03, RinkRink_Loop14
	sCall		RinkRink_Call9
	sLoop		$01, $02, RinkRink_Loop14
	sJump		RinkRink_Loop8

RinkRink_FM4:
	sPatFM		$03
	saVolFM		$10

RinkRink_Loop15:
	sCall		RinkRink_Call13
	saVolFM		$FC
	sLoop		$00, $02, RinkRink_Loop15
	saVolFM		$FC
	sCall		RinkRink_Call14
	sCall		RinkRink_Call15
	saVolFM		$FC

RinkRink_Loop16:
	sCall		RinkRink_Call13
	sLoop		$00, $02, RinkRink_Loop16
	sCall		RinkRink_Call14
	sCall		RinkRink_Call15
	sLoop		$01, $02, RinkRink_Loop16

RinkRink_Loop18:
	sCall		RinkRink_Call10

RinkRink_Loop17:
	sCall		RinkRink_Call13
	sLoop		$01, $02, RinkRink_Loop17
	sLoop		$02, $02, RinkRink_Loop18
	sPatFM		$07
	saVolFM		$FE

RinkRink_Loop19:
	sGate		$2F
	dc.b nC5, $30, nD5
	sGate		$11
	dc.b nF5, $12, nE5, $12
	sGate		$00
	dc.b nD5, $0B, nRst, $01, nC5, $2F, nRst, $01
	sLoop		$00, $03, RinkRink_Loop19
	sGate		$2F
	dc.b nC5, $30, nD5
	sGate		$11
	dc.b nF5, $12, nE5
	sGate		$00
	dc.b nA5, $23, nRst, $01, nG5, $17, nRst, $01
	saVolFM		$02
	sPatFM		$03

RinkRink_Loop20:
	sCall		RinkRink_Call13
	sLoop		$00, $02, RinkRink_Loop20
	sCall		RinkRink_Call14
	sCall		RinkRink_Call15
	sLoop		$01, $02, RinkRink_Loop20
	sJump		RinkRink_Loop16

RinkRink_FM5:
	sPatFM		$01
	dc.b nRst, $09
	saVolFM		$09
	sPan		spLeft

RinkRink_Loop21:
	dc.b nF4, $18, nC4, nD4, nA3
	saVolFM		$06
	sLoop		$00, $04, RinkRink_Loop21
	saVolFM		$E8

RinkRink_Jump2:
	sPatFM		$02
	sCall		RinkRink_Call4
	dc.b nC3, $0C
	sCall		RinkRink_Call4
	sPatFM		$05
	sCall		RinkRink_Call5
	dc.b nA3, $18, nF3, $12
	sGate		$00
	dc.b nG3, $0B, nRst, $01, nF3, $06, nE3, $03
	saVolFM		$F7
	sPan		spCenter
	sPatFM		$01
	sCall		RinkRink_Call16
	dc.b nF4, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nF4, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	dc.b nC4, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nC4, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	dc.b nD4, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nD4, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	dc.b nA3, $15
	sPan		spCenter
	saVolFM		$F2
	saVolFM		$09
	sPatFM		$05
	sCall		RinkRink_Call5
	dc.b nA3, $12, nF3, $0C, nC4, $06, nD4, nC4
	dc.b nF4, nE4
	sGate		$00
	dc.b nD4, $03
	sPan		spCenter
	saVolFM		$F7
	sPatFM		$01
	sCall		RinkRink_Call16
	dc.b nF4, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nF4, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	dc.b nC4, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nC4, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	dc.b nD4, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nD4, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	dc.b nA4, $0F
	saVolFM		$F2
	sPatFM		$04
	sPan		spLeft
	saVolFM		$F8
	saTranspose	$F4
	sCall		RinkRink_Call12
	dc.b nRst, $06
	saVolFM		$0F
	dc.b nC5, $06, $0C, nC4, nC4, $06
	sGate		$00
	dc.b nC4, $30, sHold, $03
	sCall		RinkRink_Call12
	dc.b nC5, $06, $0C, nC6, nC6, $06
	sGate		$00
	dc.b nC6, $18

RinkRink_Loop22:
	sGate		$06
	dc.b nA5, $0C, nG5
	sGate		$12
	dc.b nF5, $18
	sLoop		$00, $02, RinkRink_Loop22

RinkRink_Loop23:
	sGate		$06
	dc.b nBb5, $0C, nA5
	sGate		$12
	dc.b nG5, $18
	sLoop		$00, $02, RinkRink_Loop23
	sGate		$06
	dc.b nC6, $0C, nD6
	sGate		$12
	dc.b nC6, $18
	sGate		$06
	dc.b nBb5, $0C, nA5
	sGate		$12
	dc.b nBb5, $18
	sGate		$06
	dc.b nC6, $0C, nD6
	sGate		$00
	dc.b nC6, $0C, sHold, $30, sHold, $0B, nRst, $01
	dc.b nF6, $17, nRst, $01, nE6, $06
	saVolFM		$F1
	dc.b nF6, $18
	saVolFM		$02
	dc.b sHold, $18
	saVolFM		$02
	dc.b sHold, $18
	saVolFM		$02
	dc.b sHold, $06
	saVolFM		$FA
	saVolFM		$08
	saTranspose	$0C
	dc.b nRst, $0F
	sPan		spLeft
	saVolFM		$0C
	sPatFM		$05
	ssMod68k	$09, $01, $04, $03
	sCall		RinkRink_Call7
	dc.b nRst, $30, nRst, nRst, nRst, $1E
	sCall		RinkRink_Call7
	dc.b nRst, $30, nRst, $2A
	ssMod68k	$01, $01, $00, $00
	saVolFM		$FD
	sJump		RinkRink_Jump2

RinkRink_PSG1:
	sVolEnvPSG	v08
	saVolPSG	$08

RinkRink_Loop24:
	sCall		RinkRink_Call17
	saVolPSG	$FE
	sLoop		$00, $02, RinkRink_Loop24
	saVolPSG	$FE
	sCall		RinkRink_Call18
	sCall		RinkRink_Call19
	saVolPSG	$FE

RinkRink_Loop25:
	sCall		RinkRink_Call17
	sLoop		$00, $02, RinkRink_Loop25
	sCall		RinkRink_Call18
	sCall		RinkRink_Call19
	sLoop		$01, $02, RinkRink_Loop25

RinkRink_Loop27:
	saTranspose	$FD
	sCall		RinkRink_Call10
	saTranspose	$03

RinkRink_Loop26:
	sCall		RinkRink_Call17
	sLoop		$01, $02, RinkRink_Loop26
	sLoop		$02, $02, RinkRink_Loop27

RinkRink_Loop28:
	sGate		$2F
	dc.b nA4, $30, nBb4
	sGate		$11
	dc.b nC5, $12, nC5, $12
	sGate		$00
	dc.b nC5, $0B, nRst, $01, nG4, $2F, nRst, $01
	sLoop		$00, $03, RinkRink_Loop28
	sGate		$2F
	dc.b nA4, $30, nBb4
	sGate		$11
	dc.b nC5, $12, nC5
	sGate		$00
	dc.b nF5, $23, nRst, $01, nE5, $17, nRst, $01

RinkRink_Loop29:
	sCall		RinkRink_Call17
	sLoop		$02, $02, RinkRink_Loop29
	sCall		RinkRink_Call18
	sCall		RinkRink_Call19
	sLoop		$01, $02, RinkRink_Loop29
	sJump		RinkRink_Loop25

RinkRink_PSG2:
	sVolEnvPSG	v19
	ssMod68k	$20, $02, $01, $02
	dc.b nC5, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, sHold, $30, nRst, $18
	dc.b nC4

RinkRink_Jump3:
	sCall		RinkRink_Call20
	sCall		RinkRink_Call20
	dc.b nC5, $30, sHold, $30, sHold, $24, nF5, nE5
	dc.b $18, nC5, $30, sHold, $30, sHold, $30, nA4
	dc.b $18, nBb4, nC5, $30, sHold, $30, sHold, $24
	dc.b nF5, nE5, $18, nC6, $30, sHold, $30, sHold
	dc.b $30, sHold, $0C, nRst, $07
	sVolEnvPSG	v08
	sCall		RinkRink_Call6
	dc.b nC3, $0C, nF3, nE3
	sGate		$00
	dc.b nF3, $30, sHold, $0B, nRst, $01
	sGate		$0B
	dc.b nF3, $0C, nG3, nA3
	sGate		$00
	dc.b nG3, $11, nRst, $01
	sGate		$05
	dc.b nC4, $0C, $06, $0C, nC4, $0C
	sCall		RinkRink_Call6
	dc.b nC3, $0C, nF3, nG3
	sGate		$11
	dc.b nBb3, $12, nA3
	sGate		$0B
	dc.b nF3, $0C
	sGate		$11
	dc.b nBb3, $12, nA3
	sGate		$0B
	dc.b nF3, $0C
	sGate		$00
	dc.b nG3, $30
	sGate		$05
	dc.b nRst, $06, nC4, nD4, nC4, nF4, nE4, nD4
	dc.b $05
	sGate		$00
	sVolEnvPSG	v19
	dc.b nF4, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, sHold, $30, sHold, $18
	dc.b nC4, $18, nC5, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $30
	sJump		RinkRink_Jump3

RinkRink_PSG3:
	sVolEnvPSG	v19
	dc.b nRst, $0A, nC5, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b nRst, $18, nC4

RinkRink_Jump4:
	sCall		RinkRink_Call20
	sCall		RinkRink_Call20
	dc.b nC5, $30, sHold, $30, sHold, $24, nF5, nE5
	dc.b $18, nC5, $30, sHold, $30, sHold, $30, nA4
	dc.b $18, nBb4, nC5, $30, sHold, $30, sHold, $24
	dc.b nF5, nE5, $18, nC6, $30, sHold, $30, sHold
	dc.b $30, sHold, $26
	ssMod68k	$20, $02, $01, $02
	saVolPSG	$FD
	dc.b nRst, $30, nRst, nRst, $30, nRst, nRst, $30
	dc.b nRst, nRst, $30, nRst, $18, nC5, $18, nC6
	dc.b $30, sHold, $30, sHold, $30, sHold, $30, sHold
	dc.b $30, sHold, $30, sHold, $30, sHold, $30
	ssMod68k	$01, $01, $00, $00
	saVolPSG	$03
	dc.b nRst, $0A, nF4, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $18, nC4, $18, nC5, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30
	sJump		RinkRink_Jump4

RinkRink_DAC1:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, $12, d88, $06, d87, $0C, d88, $06
	dc.b d88, $06

RinkRink_Loop30:
	sCall		RinkRink_Call21
	sLoop		$00, $07, RinkRink_Loop30
	dc.b d81, $12, d81, $06, d87, $0C, d81, $06
	dc.b d88, $0C, d81, $0C, d81, $06, d87, d88
	dc.b d87, d87

RinkRink_Loop31:
	sCall		RinkRink_Call21
	sLoop		$00, $07, RinkRink_Loop31
	dc.b d81, $12, d81, $06, d87, $0C, d81, $06
	dc.b d88, $03, d88, d87, $06, d87, d88, $06
	dc.b d88, $03, $03, d87, $0C, d87, $06, d87

RinkRink_Loop32:
	sCall		RinkRink_Call21
	sLoop		$00, $07, RinkRink_Loop32
	dc.b d81, $12, d81, $06, d87, $0C, d81, $06
	dc.b d88, $0C, d81, $0C, d81, $06, d87, d88
	dc.b d87, d87
	sLoop		$01, $02, RinkRink_Loop32
	sJump		RinkRink_Loop30

RinkRink_DAC2:
	dc.b nRst, $30, nRst, nRst, nRst

RinkRink_Jump5:
	dc.b d96, $06, d96, d96, d96, d95, d96, d96
	dc.b d96, d96, d96, d96, d96, d95, d96, d96
	dc.b d96
	sJump		RinkRink_Jump5

RinkRink_Call1:
	dc.b nF3, $24, $1E, nC4, $06, nG4, nRst, nF4
	dc.b nC4
	sRet

RinkRink_Call2:
	dc.b nF3, $12, nF3, nC4, nRst, $06, nC4, nRst
	dc.b $0C, nC4, $12
	sRet

RinkRink_Call3:
	dc.b nA3, $06, nA3, nRst
	saVolFM		$08
	dc.b nA3
	saVolFM		$F8
	dc.b nA4, $0C, nA3, $06, nA4, nRst, nBb4, nBb3
	dc.b nRst, nBb4, nBb3, nRst, nBb4
	sRet

RinkRink_Call8:
	sGate		$05
	dc.b nRst, $0C, nC4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nC4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nC4, $11, nRst, $01
	sGate		$05
	dc.b nC4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nC4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nC4, $11, nRst, $01
	sGate		$05
	dc.b nC4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nC4
	saVolFM		$F8
	sPan		spCenter
	dc.b nC4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nC4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	sRet

RinkRink_Call17:
	dc.b nRst, $0C
	sGate		$05
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nF4, $11, nRst, $01
	sGate		$05
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nF4, $11, nRst, $01
	sGate		$05
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	dc.b nE4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nE4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	sRet

RinkRink_Call18:
	dc.b nRst, $0C
	sGate		$05
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nF4, $11, nRst, $01
	sGate		$05
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nF4, $11, nRst, $01
	sGate		$05
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	sRet

RinkRink_Call13:
	dc.b nRst, $0C
	sGate		$05
	dc.b nA4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nA4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nBb4, $11, nRst, $01
	sGate		$05
	dc.b nA4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nA4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nBb4, $11, nRst, $01
	sGate		$05
	dc.b nA4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nA4
	saVolFM		$F8
	sPan		spCenter
	dc.b nG4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nG4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	sRet

RinkRink_Call14:
	dc.b nRst, $0C
	sGate		$05
	dc.b nA4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nA4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nBb4, $11, nRst, $01
	sGate		$05
	dc.b nA4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nA4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	dc.b nBb4, $11, nRst, $01
	sGate		$05
	dc.b nA4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nA4
	saVolFM		$F8
	sPan		spCenter
	dc.b nBb4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nBb4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	sRet

RinkRink_Call9:
	sGate		$05
	dc.b nC4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nC4
	saVolFM		$F8
	sPan		spCenter
	dc.b nRst, nC4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nC4
	saVolFM		$F8
	sPan		spCenter
	dc.b nRst
	sGate		$00
	dc.b nC4, $30, sHold, $0B, nRst, $01
	sRet

RinkRink_Call15:
	sGate		$05
	dc.b nA4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nA4
	saVolFM		$F8
	sPan		spCenter
	dc.b nRst, nG4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nG4
	saVolFM		$F8
	sPan		spCenter
	dc.b nRst
	sGate		$00
	dc.b nG4, $30, sHold, $0B, nRst, $01
	sRet

RinkRink_Call19:
	sGate		$05
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	dc.b nRst, nE4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nE4
	saVolFM		$F8
	sPan		spCenter
	dc.b nRst
	sGate		$00
	dc.b nE4, $30, sHold, $0B, nRst, $01
	sRet

RinkRink_Call10:
	dc.b nF4, $11, nRst, $01
	sGate		$05

RinkRink_Loop9:
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	dc.b nRst
	sLoop		$00, $06, RinkRink_Loop9
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	dc.b nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	dc.b nRst, nF4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nF4
	saVolFM		$F8
	sPan		spCenter
	dc.b nG4, $06
	saVolFM		$08
	sPan		spRight
	dc.b nG4
	saVolFM		$F8
	sPan		spCenter
	sGate		$00
	sRet

RinkRink_Call4:
	dc.b nF3, $17, nRst, $01
	sGate		$0B
	dc.b nE3, $0C, nF3
	sGate		$11
	dc.b nG3, $12, nF3
	sGate		$0B
	dc.b nE3, $0C, nF3, nF3, nE3, nF3
	sGate		$11
	dc.b nG3, $12, nF3
	sGate		$03
	dc.b nC4, $09, nC4, $03
	sGate		$06
	dc.b nF4, $0C, nE4, nD4, nC4, nBb3, nA3, nG3
	dc.b nF3
	sGate		$11
	dc.b nC4, $12, nC4
	sGate		$00
	dc.b nG3, $2F, nRst, $01
	sRet

RinkRink_Call16:
	sPan		spRight
	dc.b nF4, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nF4, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	dc.b nC4, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nC4, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	dc.b nD4, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nD4, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	dc.b nA3, $12
	sPan		spCenter
	saVolFM		$06
	dc.b nA3, $06
	saVolFM		$FA
	saVolFM		$02
	sPan		spRight
	sRet

RinkRink_Call7:
	sGate		$02
	dc.b nF2, $03, nC3, nG2, nF2, nC2, nF2
	sGate		$00
	dc.b nG2, $30, sHold, $20, nRst, $01
	sGate		$02
	dc.b nC3, $03, nF3, nC3, nF3
	sGate		$00
	dc.b nC3, $03, sHold, $30, sHold, $2F, nRst, $01
	sRet

RinkRink_Call5:
	sGate		$05
	dc.b nF3, $06, nE3
	sGate		$00
	dc.b nF3, $1D, nRst, $01
	sGate		$05
	dc.b nF3, $06, nG3, nA3, nG3, nF3, nE3, nF3
	dc.b $0C, $06, nG3, nF3, nC4, $18
	sRet

RinkRink_Call6:
	sGate		$0B
	dc.b nC3, $0C, nF3, nE3
	sGate		$00
	dc.b nF3, $30, sHold, $0B, nRst, $01
	sGate		$0B
	dc.b nF3, $0C, nG3, nA3
	sGate		$11
	dc.b nG3, $12, nE3
	sGate		$0B
	dc.b nD3, $0C, nC3
	sRet

RinkRink_Call12:
	sGate		$02
	dc.b nC5, $03, nD5, nE5
	sGate		$03
	dc.b nF5, $0C, nE5, nD5, nC5
	sGate		$06
	dc.b nD5, $12, nA4, nBb4, $0C
	sRet

RinkRink_Call11:
	sGate		$03
	dc.b nD4, $03, nE5, nF5, $0C, nE5, nD5, nC5
	sGate		$06
	dc.b nD5, $12, nA4, nBb4, $06
	sRet

RinkRink_Call20:
	dc.b nC5, $30, sHold, $30, sHold, $30, sHold, $18
	dc.b nA5, nF5, $30, sHold, $30, nC5, $30, sHold
	dc.b $18, nD5
	sRet

RinkRink_Call21:
	dc.b d81, $12, d81, $06, d87, $0C, d81, $0C
	dc.b d88, $06, d88, $06, d81, $0C, d87, $12
	dc.b d88, $06
	sRet

RinkRink_Patches:

	; Patch $00
	; $3A
	; $70, $76, $30, $70,	$1F, $95, $1F, $1F
	; $0E, $0F, $05, $0C,	$07, $06, $06, $07
	; $2F, $4F, $1F, $5F,	$21, $12, $30, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$07, $03, $07, $07
	spMultiple	$00, $00, $06, $00
	spRateScale	$00, $00, $02, $00
	spAttackRt	$1F, $1F, $15, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $05, $0F, $0C
	spSustainLv	$02, $01, $04, $05
	spDecayRt	$07, $06, $06, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$21, $30, $12, $00

	; Patch $01
	; $05
	; $0E, $74, $01, $39,	$DF, $2F, $5F, $5F
	; $12, $12, $12, $12,	$03, $04, $06, $07
	; $2C, $3B, $4A, $59,	$15, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$00
	spDetune	$00, $00, $07, $03
	spMultiple	$0E, $01, $04, $09
	spRateScale	$03, $01, $00, $01
	spAttackRt	$1F, $1F, $0F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$12, $12, $12, $12
	spSustainLv	$02, $04, $03, $05
	spDecayRt	$03, $06, $04, $07
	spReleaseRt	$0C, $0A, $0B, $09
	spTotalLv	$15, $00, $00, $00

	; Patch $02
	; $24
	; $39, $51, $05, $01,	$5F, $9B, $9E, $9E
	; $0F, $07, $0F, $08,	$06, $0A, $0B, $0A
	; $18, $88, $F8, $F8,	$39, $83, $39, $83
	spAlgorithm	$04
	spFeedback	$04
	spDetune	$03, $00, $05, $00
	spMultiple	$09, $05, $01, $01
	spRateScale	$01, $02, $02, $02
	spAttackRt	$1F, $1E, $1B, $1E
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0F, $0F, $07, $08
	spSustainLv	$01, $0F, $08, $0F
	spDecayRt	$06, $0B, $0A, $0A
	spReleaseRt	$08, $08, $08, $08
	spTotalLv	$39, $39, $03, $03

	; Patch $03
	; $33
	; $71, $54, $33, $61,	$1D, $1A, $3C, $18
	; $0C, $0A, $0F, $0B,	$09, $06, $03, $07
	; $08, $08, $19, $3A,	$32, $13, $26, $80
	spAlgorithm	$03
	spFeedback	$06
	spDetune	$07, $03, $05, $06
	spMultiple	$01, $03, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1D, $1C, $1A, $18
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0F, $0A, $0B
	spSustainLv	$00, $01, $00, $03
	spDecayRt	$09, $03, $06, $07
	spReleaseRt	$08, $09, $08, $0A
	spTotalLv	$32, $26, $13, $00

	; Patch $04
	; $3A
	; $01, $02, $01, $01,	$50, $10, $0E, $52
	; $04, $1F, $1F, $1F,	$00, $00, $00, $00
	; $48, $08, $08, $09,	$1C, $45, $30, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $02, $01
	spRateScale	$01, $00, $00, $01
	spAttackRt	$10, $0E, $10, $12
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $1F, $1F, $1F
	spSustainLv	$04, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$08, $08, $08, $09
	spTotalLv	$1C, $30, $45, $00

	; Patch $05
	; $3B
	; $04, $31, $04, $02,	$13, $0F, $2F, $4F
	; $06, $12, $10, $12,	$03, $03, $00, $03
	; $0A, $5A, $49, $29,	$00, $30, $27, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $03, $00
	spMultiple	$04, $04, $01, $02
	spRateScale	$00, $00, $00, $01
	spAttackRt	$13, $0F, $0F, $0F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$06, $10, $12, $12
	spSustainLv	$00, $04, $05, $02
	spDecayRt	$03, $00, $03, $03
	spReleaseRt	$0A, $09, $0A, $09
	spTotalLv	$00, $27, $30, $00

	; Patch $06
	; $3A
	; $70, $76, $30, $70,	$1F, $95, $1F, $1F
	; $0E, $0F, $05, $0C,	$07, $06, $06, $07
	; $2F, $4F, $1F, $5F,	$21, $12, $28, $84
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$07, $03, $07, $07
	spMultiple	$00, $00, $06, $00
	spRateScale	$00, $00, $02, $00
	spAttackRt	$1F, $1F, $15, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $05, $0F, $0C
	spSustainLv	$02, $01, $04, $05
	spDecayRt	$07, $06, $06, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$21, $28, $12, $04

	; Patch $07
	; $33
	; $71, $54, $31, $61,	$1D, $1A, $3C, $18
	; $0C, $0A, $0B, $08,	$09, $06, $03, $07
	; $08, $08, $1A, $3A,	$12, $23, $46, $80
	spAlgorithm	$03
	spFeedback	$06
	spDetune	$07, $03, $05, $06
	spMultiple	$01, $01, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1D, $1C, $1A, $18
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0B, $0A, $08
	spSustainLv	$00, $01, $00, $03
	spDecayRt	$09, $03, $06, $07
	spReleaseRt	$08, $0A, $08, $0A
	spTotalLv	$12, $46, $23, $00
	even
