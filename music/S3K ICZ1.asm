IceCap_Header:
	sHeaderInit	; Z80 offset is $86AA
	sHeaderPatch	IceCap_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $14
	sHeaderDAC	IceCap_DAC
	sHeaderFM	IceCap_FM1, $00, $02
	sHeaderFM	IceCap_FM2, $F4, $08
	sHeaderFM	IceCap_FM3, $F4, $08
	sHeaderFM	IceCap_FM4, $F4, $08
	sHeaderFM	IceCap_FM5, $F4, $08
	sHeaderPSG	IceCap_PSG1, $E8, $01, ModEnv_00, VolEnv_06
	sHeaderPSG	IceCap_PSG2, $E8, $02, ModEnv_00, VolEnv_06
	sHeaderPSG	IceCap_PSG3, $00, $03, ModEnv_00, VolEnv_02

IceCap_FM1:
IceCap_Jump2:
	sPatFM		$00

IceCap_Loop5:
	dc.b nC3, $0C, $18, $06, nC3, nBb2, $0C, $18
	dc.b $06, nBb2, nAb2, $0C, $18, $06, nAb2, nG2
	dc.b $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C
	dc.b $18, $06, nBb2, nBb2, $0C, $18, $06, nBb2
	sLoop		$01, $04, IceCap_Loop5
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

IceCap_Loop6:
	dc.b nC3, $0C, $18, $06, nC3, nBb2, $0C, $18
	dc.b $06, nBb2, nAb2, $0C, $18, $06, nAb2, nG2
	dc.b $0C, $18, $06, nG2, nC3, $0C, $18, $06
	dc.b nC3, nEb3, $0C, $18, $06, nEb3, nBb2, $0C
	dc.b $18, $06, nBb2, nBb2, $0C, $18, $06, nBb2
	sLoop		$01, $02, IceCap_Loop6

IceCap_Loop7:
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
	sLoop		$01, $02, IceCap_Loop7
	sJump		IceCap_Jump2

IceCap_FM2:
IceCap_Jump3:
	saTranspose	$0C
	sPatFM		$01
	ssModZ80	$01, $01, $03, $03

IceCap_Loop8:
	dc.b nG4, $30, sHold, $30, sHold, nG4, nF4, nG4
	dc.b sHold, $30, nF4, sHold, $30
	sLoop		$01, $04, IceCap_Loop8
	saTranspose	$F4
	sPatFM		$02

IceCap_Loop9:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30
	sLoop		$01, $02, IceCap_Loop9
	sPatFM		$01
	saTranspose	$0C

IceCap_Loop10:
	dc.b nG4, $30, sHold, $30, sHold, nG4, nF4, nG4
	dc.b sHold, $30, nF4, sHold, $30
	sLoop		$01, $02, IceCap_Loop10
	saTranspose	$F4
	sPatFM		$02

IceCap_Loop11:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30
	sLoop		$01, $04, IceCap_Loop11
	sJump		IceCap_Jump3

IceCap_FM3:
IceCap_Loop13:
IceCap_Jump4:
	sPatFM		$04
	ssModZ80	$01, $01, $A1, $FF
	sPan		spLeft, $00
	dc.b nG6, $09, nRst, $27, nRst, $06
	sPatFM		$05
	saVolFM		$2C
	sPan		spRight, $00

IceCap_Loop12:
	dc.b nBb2, $01
	saVolFM		$FD
	sLoop		$00, $12, IceCap_Loop12
	saVolFM		$0A
	dc.b nRst, $18
	sPatFM		$01
	ssModZ80	$01, $01, $03, $03
	sPan		spCenter, $00
	dc.b nAb3, $30, nG3, nRst, nRst, nRst, nRst
	sLoop		$01, $04, IceCap_Loop13

IceCap_Loop14:
	dc.b nEb4, $30, nC4, nD4, nBb3, nEb4, nC4, nD4
	dc.b sHold, $30
	sLoop		$01, $02, IceCap_Loop14
	sPatFM		$01
	ssModZ80	$01, $01, $03, $03
	sPan		spCenter, $00
	dc.b nRst, nRst, nAb3, $30, nG3, nRst, nRst
	sPatFM		$04
	ssModZ80	$01, $01, $A1, $FF
	sPan		spLeft, $00
	dc.b nG6, $09, nRst, $27, nRst, $06
	sPatFM		$05
	saVolFM		$2C
	sPan		spRight, $00

IceCap_Loop15:
	dc.b nBb2, $01
	saVolFM		$FD
	sLoop		$00, $12, IceCap_Loop15
	saVolFM		$0A
	dc.b nRst, $18
	sPatFM		$01
	ssModZ80	$01, $01, $03, $03
	sPan		spCenter, $00
	dc.b nRst, $30, nRst, nAb3, nG3, nRst, nRst, nRst
	dc.b nRst

IceCap_Loop16:
	dc.b nEb4, $30, nC4, nD4, nBb3, nEb4, nC4, nD4
	dc.b sHold, $30
	sLoop		$01, $04, IceCap_Loop16
	sJump		IceCap_Jump4

IceCap_FM4:
IceCap_Jump5:
	saTranspose	$0C
	sPatFM		$01
	ssModZ80	$01, $01, $03, $03

IceCap_Loop17:
	dc.b nC4, $30, nBb3, nC4, nBb3, nC4, nBb3, sHold
	dc.b nBb3, sHold, $30
	sLoop		$00, $04, IceCap_Loop17
	saTranspose	$F4
	sPatFM		$03
	ssModZ80	$00, $00, $00, $00
	sPan		spRight, $00

IceCap_Loop18:
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4
	dc.b nG4
	sLoop		$00, $03, IceCap_Loop18
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5
	sPan		spCenter, $00
	sPatFM		$01
	saTranspose	$0C
	ssModZ80	$01, $01, $03, $03

IceCap_Loop19:
	dc.b nC4, $30, nBb3, nC4, nBb3, nC4, nBb3, sHold
	dc.b nBb3, sHold, $30
	sLoop		$00, $02, IceCap_Loop19
	saTranspose	$F4
	sPatFM		$03
	ssModZ80	$00, $00, $00, $00
	sPan		spRight, $00

IceCap_Loop20:
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4
	dc.b nG4
	sLoop		$01, $03, IceCap_Loop20
	dc.b nBb4, $06, nC4, nG4, nC5, nG4, nC4, nG4
	dc.b nC5, nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4
	dc.b nC5, nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5, nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4
	dc.b nD5
	sLoop		$00, $02, IceCap_Loop20
	sPan		spCenter, $00
	sJump		IceCap_Jump5

IceCap_FM5:
IceCap_Jump6:
	saTranspose	$0C
	sPatFM		$01
	ssModZ80	$01, $01, $03, $03

IceCap_Loop21:
	dc.b nEb4, $30, sHold, $30, sHold, nEb4, nD4, nEb4
	dc.b sHold, $30, nD4, sHold, $30
	sLoop		$01, $04, IceCap_Loop21
	saTranspose	$F4
	sPatFM		$03
	ssModZ80	$00, $00, $00, $00

IceCap_Loop22:
	dc.b nC4, $06, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4
	dc.b nBb4, nC4, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4
	sLoop		$01, $02, IceCap_Loop22
	sPatFM		$01
	saTranspose	$0C
	ssModZ80	$01, $01, $03, $03

IceCap_Loop23:
	dc.b nEb4, $30, sHold, $30, sHold, nEb4, nD4, nEb4
	dc.b sHold, $30, nD4, sHold, $30
	sLoop		$01, $02, IceCap_Loop23
	saTranspose	$F4
	sPatFM		$03
	ssModZ80	$00, $00, $00, $00

IceCap_Loop24:
	dc.b nC4, $06, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nG4, nBb4, nD4, nBb4, nG4
	dc.b nBb4, nC4, nG4, nC5, nG4, nC4, nG4, nC5
	dc.b nG4, nC4, nAb4, nC5, nAb4, nC4, nAb4, nC5
	dc.b nAb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4, nD4, nBb4, nD5, nBb4, nD4, nBb4, nD5
	dc.b nBb4
	sLoop		$01, $04, IceCap_Loop24
	sJump		IceCap_Jump6

IceCap_PSG1:
IceCap_Jump7:
	sVolEnvPSG	VolEnv_02
	saTranspose	$18
	sNoteTimeOut	$09

IceCap_Loop25:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $10, IceCap_Loop25
	saTranspose	$E8
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_16

IceCap_Loop26:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30
	sLoop		$01, $02, IceCap_Loop26
	sVolEnvPSG	VolEnv_02
	saTranspose	$18
	sNoteTimeOut	$09

IceCap_Loop27:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $07, IceCap_Loop27
	dc.b nRst, $30, nRst
	saTranspose	$E8
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_16

IceCap_Loop28:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30
	sLoop		$01, $04, IceCap_Loop28
	sJump		IceCap_Jump7

IceCap_PSG2:
	saDetune	$01

IceCap_Jump8:
	sVolEnvPSG	VolEnv_01
	saTranspose	$18
	sNoteTimeOut	$09
	ssModZ80	$00, $01, $01, $02

IceCap_Loop29:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $10, IceCap_Loop29
	saTranspose	$E8
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_16
	saVolPSG	$02
	dc.b nRst, $18
	ssModZ80	$00, $01, $01, $03
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, $12, nEb5, nF5, $0C, nBb4, $30
	dc.b nC5, $18, nC6, nBb5, $30, nD5, sHold, $18
	saVolPSG	$FE
	ssModZ80	$00, $00, $00, $00
	sVolEnvPSG	VolEnv_01
	saTranspose	$18
	ssModZ80	$00, $01, $01, $02
	sNoteTimeOut	$09

IceCap_Loop30:
	dc.b nG4, $0C, nG4, nG4, $06, $0C, nG4, nG4
	dc.b $2A
	sLoop		$01, $07, IceCap_Loop30
	dc.b nRst, $30, nRst
	saTranspose	$E8
	sNoteTimeOut	$00
	sVolEnvPSG	VolEnv_16
	saVolPSG	$02
	dc.b nRst, $18
	ssModZ80	$00, $01, $01, $03

IceCap_Loop31:
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $30
	sLoop		$01, $03, IceCap_Loop31
	dc.b nC5, $18, nC6, nBb5, $30, nD5, $12, nEb5
	dc.b nF5, $0C, nBb4, $30, nC5, $18, nC6, nBb5
	dc.b $30, nD5, sHold, $18
	saVolPSG	$FE
	ssModZ80	$00, $00, $00, $00
	sJump		IceCap_Jump8

IceCap_PSG3:
	sNoisePSG	$E7
	sVolEnvPSG	VolEnv_02

IceCap_Loop32:
IceCap_Jump9:
	dc.b nRst, $0C, nB6, $18, nB6, nB6, nB6, $0C
	sLoop		$01, $1F, IceCap_Loop32
	dc.b nRst, $0C, nB6, $18, nB6, nRst, $24

IceCap_Loop33:
	dc.b nRst, $0C, nB6, $18, nB6, nB6, nB6, $0C
	sLoop		$01, $10, IceCap_Loop33
	sJump		IceCap_Jump9

IceCap_DAC:
IceCap_Loop1:
IceCap_Jump1:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick
	dc.b $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick
	dc.b $0C, dBassHey, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12
	dc.b dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit
	dc.b dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit
	dc.b dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit
	sLoop		$00, $04, IceCap_Loop1

IceCap_Loop2:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b dReverseFadingWind, $0C, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $06
	dc.b dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, dHipHopHitKick3, $0C, $06, dDanceStyleKick
	dc.b $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit
	dc.b $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18
	dc.b dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C
	dc.b dQuickHit, $06, dQuickHit
	sLoop		$00, $02, IceCap_Loop2

IceCap_Loop3:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit
	dc.b dDanceStyleKick, $0C, dBassHey, dDanceStyleKick, $18, dDanceStyleKick, $06, nRst
	dc.b $12, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick, dQuickHit
	dc.b dQuickHit, dQuickHit, dDanceStyleKick, $18, dDanceStyleKick, dDanceStyleKick, $06, dQuickHit
	dc.b dQuickHit, dQuickHit, dDanceStyleKick, $0C, dQuickHit, $06, dQuickHit, dDanceStyleKick
	dc.b $18, dDanceStyleKick, dDanceStyleKick, $0C, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick
	sLoop		$00, $02, IceCap_Loop3

IceCap_Loop4:
	dc.b dDanceStyleKick, $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C
	dc.b dReverseFadingWind, $0C, dLooseSnareNoise, $18, dDanceStyleKick, dDanceStyleKick, dDanceStyleKick, $06
	dc.b dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, dHipHopHitKick3, $0C, $06, dDanceStyleKick
	dc.b $18, dDanceStyleKick, $06, nRst, $12, dDanceStyleKick, $0C, dQuickHit
	dc.b $06, dQuickHit, dDanceStyleKick, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $18
	dc.b dDanceStyleKick, dDanceStyleKick, $06, dQuickHit, dQuickHit, dQuickHit, dDanceStyleKick, $0C
	dc.b dQuickHit, $06, dQuickHit
	sLoop		$00, $04, IceCap_Loop4
	sJump		IceCap_Jump1

IceCap_Patches:
	; Patch $00
	; $20
	; $34, $38, $30, $31,	$DF, $DF, $9F, $9F
	; $07, $08, $08, $0A,	$07, $0E, $0A, $11
	; $20, $1F, $1F, $1F,	$22, $37, $14, $80
	spAlgorithm	$00
	spFeedback	$04
	spDetune	$03, $03, $03, $03
	spMultiple	$04, $00, $08, $01
	spRateScale	$03, $02, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $08, $08, $0A
	spSustainRt	$07, $0A, $0E, $11
	spSustainLv	$02, $01, $01, $01
	spReleaseRt	$00, $0F, $0F, $0F
	spTotalLv	$22, $14, $37, $00

	; Patch $01
	; $35
	; $02, $04, $02, $01,	$10, $0A, $0C, $0E
	; $07, $04, $04, $04,	$01, $0A, $0A, $0A
	; $28, $1B, $1B, $1B,	$1D, $8E, $8D, $8E
	spAlgorithm	$05
	spFeedback	$06
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $02, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $0C, $0A, $0E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $04, $04, $04
	spSustainRt	$01, $0A, $0A, $0A
	spSustainLv	$02, $01, $01, $01
	spReleaseRt	$08, $0B, $0B, $0B
	spTotalLv	$1D, $0D, $0E, $0E

	; Patch $02
	; $2D
	; $02, $02, $02, $02,	$10, $10, $10, $10
	; $07, $08, $08, $08,	$01, $05, $05, $05
	; $28, $1B, $1B, $1B,	$20, $86, $86, $89
	spAlgorithm	$05
	spFeedback	$05
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $02, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $10, $10, $10
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$07, $08, $08, $08
	spSustainRt	$01, $05, $05, $05
	spSustainLv	$02, $01, $01, $01
	spReleaseRt	$08, $0B, $0B, $0B
	spTotalLv	$20, $06, $06, $09

	; Patch $03
	; $06
	; $04, $04, $03, $34,	$1F, $1F, $1F, $1F
	; $0F, $0F, $0F, $0F,	$0D, $12, $11, $10
	; $1F, $0F, $1F, $0F,	$1D, $84, $96, $80
	spAlgorithm	$06
	spFeedback	$00
	spDetune	$00, $00, $00, $03
	spMultiple	$04, $03, $04, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0F, $0F, $0F, $0F
	spSustainRt	$0D, $11, $12, $10
	spSustainLv	$01, $01, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1D, $16, $04, $00

	; Patch $04
	; $3D
	; $00, $04, $07, $0A,	$1F, $1F, $1F, $1F
	; $1F, $1D, $1D, $1D,	$05, $06, $16, $00
	; $09, $1F, $1F, $1F,	$34, $8D, $87, $86
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $07, $04, $0A
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$1F, $1D, $1D, $1D
	spSustainRt	$05, $16, $06, $00
	spSustainLv	$00, $01, $01, $01
	spReleaseRt	$09, $0F, $0F, $0F
	spTotalLv	$34, $07, $0D, $06

	; Patch $05
	; $32
	; $38, $46, $4F, $32,	$1F, $1F, $1F, $1F
	; $0E, $1C, $16, $02,	$00, $00, $00, $00
	; $60, $60, $40, $39,	$05, $04, $18, $80
	spAlgorithm	$02
	spFeedback	$06
	spDetune	$03, $04, $04, $03
	spMultiple	$08, $0F, $06, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0E, $16, $1C, $02
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$06, $04, $06, $03
	spReleaseRt	$00, $00, $00, $09
	spTotalLv	$05, $18, $04, $00
