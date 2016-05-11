; NOTE: This port would be more accurate if I enabled custom volume envelopes.
; However, because I restricted myself to stock ones, it sounds a bit different.
; If you want to make it better, copy volume envelope 0A from S3K to Sonic 1.
; It is the file "S3K_SMPS\VolEnv\0A.bin", and must be copied to folder "S1_SMPS\VolEnv\".
; You must then include it next to "PSG9" in Sonic 1's 68k.asm and add to the array.
; Since Sonic 1 has only 8 VolEnv's (Volume Envelopes), you must add blank entry or use entry 9.
; then you must change each VolEnv_03 to VolEnv_09 or VolEnv_0A in this file!
InvinciblityK_Header:
	smpsHeaderStartSong
	smpsHeaderVoice	InvinciblityK_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$01, $02
	smpsHeaderDAC	InvinciblityK_DAC
	smpsHeaderFM	InvinciblityK_FM1, $00, $15
	smpsHeaderFM	InvinciblityK_FM2, $00, $0A
	smpsHeaderFM	InvinciblityK_FM3, $00, $1F
	smpsHeaderFM	InvinciblityK_FM4, $00, $13
	smpsHeaderFM	InvinciblityK_FM5, $00, $13
	smpsHeaderPSG	InvinciblityK_PSG1, $00, $05, $00, VolEnv_00
	smpsHeaderPSG	InvinciblityK_PSG2, $00, $05, $00, VolEnv_00
	smpsHeaderPSG	InvinciblityK_PSG3, $E8, $01, $00, VolEnv_00

InvinciblityK_FM1:
	smpsModSet	$14, $01, $06, $06
	smpsAlterNote	$FE
	smpsPan	 panCentre, $00

InvinciblityK_Jump4:
	smpsSetvoice	$00
	dc.b nRst, $18

InvinciblityK_Jump2:
	dc.b nA4, $0C, nFs4, $06, nE4, nA4, nFs4, nD4
	dc.b nE4, smpsNoAttack, nE4, $12, nD5, $0C
	smpsNoteFill	$05
	dc.b $06, $06, $06
	smpsNoteFill	$00
	dc.b nCs5, $0C, nA4, $06, nE4, nFs4, $02, nRst
	dc.b $04, nA4, $0C, nB4, $06, smpsNoAttack, nB4, $24
	dc.b nRst, $0C
	smpsJump	InvinciblityK_Jump2
	; Unused
	smpsStop

InvinciblityK_FM2:
	dc.b nRst, $18
	smpsSetvoice	$01

InvinciblityK_Jump3:
	dc.b nA1, $03, nA1, nRst, nA1, nRst, nA1, nA1
	dc.b smpsNoAttack, nA1, nFs1, $06, nFs1, smpsNoAttack, nFs1, nE1
	dc.b nE1, $03, nE1, nRst, nE1, nRst, nE1, nD1
	dc.b smpsNoAttack, nD1, nRst, nD1, nRst, nD2, smpsNoAttack, nD2
	dc.b nD1, nD1, nD1, nA1, nA1, nRst, nA1, nRst
	dc.b nA1, nA1, smpsNoAttack, nA1, nFs1, $06, nFs1, smpsNoAttack
	dc.b nFs1, nG1, nG1, $03, nG1, nRst, nG1, nRst
	dc.b nG1, nE1, smpsNoAttack, nE1, nRst, nE1, nRst, nE2
	dc.b smpsNoAttack, nE2, nE1, nE1, nE1
	smpsJump	InvinciblityK_Jump3
	; Unused
	smpsStop

InvinciblityK_FM3:
	dc.b nRst, $0B
	smpsAlterNote	$02
	smpsModSet	$14, $01, $05, $06
	smpsPan	 panLeft, $00
	smpsJump	InvinciblityK_Jump4
	; Unused
	smpsStop

InvinciblityK_FM4:
	smpsPan	 panRight, $00
	smpsSetvoice	$02
	dc.b nRst, $18

InvinciblityK_Jump5:
	smpsNoteFill	$05
	dc.b nRst, $0C, nA5, $12, nA5, nRst, $0C, nB5
	dc.b $12
	smpsNoteFill	$00
	dc.b nA5
	smpsNoteFill	$05
	dc.b nRst, $0C, nA5, $12, nA5, nG5, $06
	smpsNoteFill	$00
	dc.b nG5, $0C, nE5, $18, nRst, $06
	smpsJump	InvinciblityK_Jump5
	; Unused
	smpsStop

InvinciblityK_FM5:
	smpsPan	 panLeft, $00
	smpsSetvoice	$02
	dc.b nRst, $18

InvinciblityK_Jump6:
	smpsNoteFill	$05
	dc.b nRst, $0C, nE5, $12, nE5, nRst, $0C, nE5
	dc.b $12
	smpsNoteFill	$00
	dc.b nD5
	smpsNoteFill	$05
	dc.b nRst, $0C, nE5, $12, nE5, nD5, $06
	smpsNoteFill	$00
	dc.b nD5, $0C, nB4, $18, nRst, $06
	smpsJump	InvinciblityK_Jump6
	; Unused
	smpsStop

InvinciblityK_PSG1:
	dc.b nRst, $18
	smpsPSGvoice	VolEnv_03

InvinciblityK_Jump7:
	dc.b nE4, $06, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nD4, nB3, nE4, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, $06, nB3, nE4, nB3, nE4, nB3
	dc.b nE4, nB3, nD4, nB3, nD4, nB3, nD5, nB4
	dc.b nD5, nB4, nE4, $06, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, nB3, nD4, nB3, nE4, nB3, nE4
	dc.b nB3, nE4, nB3, nE4, $06, nB3, nE4, nB3
	dc.b nE4, nB3, nE4, nB3, nE3, nG3, nFs3, nA3
	dc.b nAb3, nB3, nB3, nD4
	smpsJump	InvinciblityK_Jump7
	; Unused
	smpsStop

InvinciblityK_PSG2:
	dc.b nRst, $18
	smpsPSGvoice	VolEnv_03
	dc.b nRst, $03

InvinciblityK_Jump8:
	dc.b nCs4, $06, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, $06, nA3, nCs4, nA3, nCs4, nA3
	dc.b nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs5, nA4
	dc.b nCs5, nA4, nCs4, $06, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, nA3, nCs4, nA3, nCs4
	dc.b nA3, nCs4, nA3, nCs4, $06, nA3, nCs4, nA3
	dc.b nCs4, nA3, nCs4, nA3, nFs3, nA3, nG3, nB3
	dc.b nA3, nCs4, nCs4, nE4
	smpsJump	InvinciblityK_Jump8
	; Unused
	smpsStop

InvinciblityK_PSG3:
	smpsPSGvoice	VolEnv_03
	smpsModSet	$14, $01, $02, $06
	dc.b nRst, $18
	smpsJump	InvinciblityK_Jump2
	; Unused
	smpsStop

InvinciblityK_DAC:
	dc.b dSnare, $06, dSnare, dSnare, $03, dSnare, dSnare, dSnare
InvinciblityK_Jump1:
	dc.b dKick, $0C, dSnare, dKick, $06, dKick, dSnare, nRst
	dc.b dKick, $0C, dSnare, $09, $03, dKick, $06, dKick
	dc.b dSnare, nRst, dKick, $0C, dSnare, dKick, $06, dKick
	dc.b dSnare, nRst, dKick, $0C, dSnare, $09, $03, dKick
	dc.b $06, dKick, dSnare, $03, nRst, dSnare, dSnare
	smpsJump	InvinciblityK_Jump1
	; Unused
	smpsStop

InvinciblityK_Voices:
	; Voice $00
	; $3D
	; $61, $02, $12, $52,	$1F, $18, $18, $1B
	; $04, $02, $01, $02,	$00, $00, $00, $00
	; $5F, $4F, $3F, $4F,	$17, $80, $80, $80
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$05, $01, $00, $06
	smpsVcCoarseFreq	$02, $02, $02, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1B, $18, $18, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$02, $01, $02, $04
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$04, $03, $04, $05
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $17

	; Voice $01
	; $2D
	; $01, $51, $31, $21,	$1F, $1F, $1F, $1F
	; $0B, $09, $00, $0B,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$0C, $90, $90, $90
	smpsVcAlgorithm	$05
	smpsVcFeedback	$05
	smpsVcDetune	$02, $03, $05, $00
	smpsVcCoarseFreq	$01, $01, $01, $01
	smpsVcRateScale	$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0B, $00, $09, $0B
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$0F, $0F, $0F, $0F
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$10, $10, $10, $0C

	; Voice $02
	; $3D
	; $00, $01, $01, $01,	$94, $19, $19, $19
	; $0F, $0D, $0D, $0D,	$07, $04, $04, $04
	; $25, $1A, $1A, $1A,	$10, $84, $84, $84
	smpsVcAlgorithm	$05
	smpsVcFeedback	$07
	smpsVcDetune	$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $01, $01, $00
	smpsVcRateScale	$00, $00, $00, $02
	smpsVcAttackRate	$19, $19, $19, $14
	smpsVcAmpMod	$00, $00, $00, $00
	smpsVcDecayRate1	$0D, $0D, $0D, $0F
	smpsVcDecayRate2	$04, $04, $04, $07
	smpsVcDecayLevel	$01, $01, $01, $02
	smpsVcReleaseRate	$0A, $0A, $0A, $05
	smpsVcTotalLevel	$04, $04, $04, $10
