?dat {
	=endian "little"
	@offset 0 "Please specify offset of this song in Z80 bank"
}

?header {
	¤ /nw == 0x17D8 {
		! > smpsHeaderVoiceUVB:;
		$ /sw;
	} {
		~£_Voices
		! > smpsHeaderVoice: /aw;
	}

	=FMnum /db
	=PSGnum /nb
	! > smpsHeaderChan: /lb, /db;
	! > smpsHeaderTempo: /db, /db;
	~£_DAC
	! > smpsHeaderDAC: /aw;
	$ /sw;
	~£_FM#
	* \FMnum\ - 1 {
		! > smpsHeaderFM: /aw, /db, /db;
	}

	~£_PSG#
	* \PSGnum\ {
		! > smpsHeaderPSG: /aw, /db, /db, /db, /db {
			#4 {
				=sTone_01 1
				=sTone_02 2
				=sTone_03 3
				=sTone_04 4
				=sTone_05 5
				=sTone_06 6
				=sTone_07 7
				=sTone_08 8
				=sTone_09 9
				=sTone_0A 0x0A
				=sTone_0B 0x0B
				=sTone_0C 0x0C
				=sTone_0D 0x0D
				=sTone_0E 0x0E
				=sTone_0F 0x0F
				=sTone_10 0x10
				=sTone_11 0x11
				=sTone_12 0x12
				=sTone_13 0x13
				=sTone_14 0x14
				=sTone_15 0x15
				=sTone_16 0x16
				=sTone_17 0x17
				=sTone_18 0x18
				=sTone_19 0x19
				=sTone_1A 0x1A
				=sTone_1B 0x1B
				=sTone_1C 0x1C
				=sTone_1D 0x1D
				=sTone_1E 0x1E
				=sTone_1F 0x1F
				=sTone_20 0x20
				=sTone_21 0x21
				=sTone_22 0x22
				=sTone_23 0x23
				=sTone_24 0x24
				=sTone_25 0x25
				=sTone_26 0x26
				=sTone_27 0x27
			}
		}
	}
}

?DAC {
	=nRst 0x80
	=dSnareS3 0x81
	=dHighTom 0x82
	=dMidTomS3 0x83
	=dLowTomS3 0x84
	=dFloorTomS3 0x85
	=dKickS3 0x86
	=dMuffledSnare 0x87
	=dCrashCymbal 0x88
	=dRideCymbal 0x89
	=dLowMetalHit 0x8A
	=dMetalHit 0x8B
	=dHighMetalHit 0x8C
	=dHigherMetalHit 0x8D
	=dMidMetalHit 0x8E
	=dClapS3 0x8F
	=dElectricHighTom 0x90
	=dElectricMidTom 0x91
	=dElectricLowTom 0x92
	=dElectricFloorTom 0x93
	=dTightSnare 0x94
	=dMidpitchSnare 0x95
	=dLooseSnare 0x96
	=dLooserSnare 0x97
	=dHiTimpaniS3 0x98
	=dLowTimpaniS3 0x99
	=dMidTimpaniS3 0x9A
	=dQuickLooseSnare 0x9B
	=dClick 0x9C
	=dPowerKick 0x9D
	=dQuickGlassCrash 0x9E
	=dGlassCrashSnare 0x9F
	=dGlassCrash 0xA0
	=dGlassCrashKick 0xA1
	=dQuietGlassCrash 0xA2
	=dOddSnareKick 0xA3
	=dKickExtraBass 0xA4
	=dComeOn 0xA5
	=dDanceSnare 0xA6
	=dLooseKick 0xA7
	=dModLooseKick 0xA8
	=dWoo 0xA9
	=dGo 0xAA
	=dSnareGo 0xAB
	=dPowerTom 0xAC
	=dHiWoodBlock 0xAD
	=dLowWoodBlock 0xAE
	=dHiHitDrum 0xAF
	=dLowHitDrum 0xB0
	=dMetalCrashHit 0xB1
	=dEchoedClapHit 0xB2
	=dLowerEchoedClapHit 0xB3
	=dHipHopHitKick 0xB4
	=dHipHopHitPowerKick 0xB5
	=dBassHey 0xB6
	=dDanceStyleKick 0xB7
	=dHipHopHitKick2 0xB8
	=dHipHopHitKick3 0xB9
	=dReverseFadingWind 0xBA
	=dScratchS3 0xBB
	=dLooseSnareNoise 0xBC
	=dPowerKick2 0xBD
	=dCrashingNoiseWoo 0xBE
	=dQuickHit 0xBF
	=dKickHey 0xC0
	=dPowerKickHit 0xC1
	=dLowPowerKickHit 0xC2
	=dLowerPowerKickHit 0xC3
	=dLowestPowerKickHit 0xC4
	=dEchoedClapHit_S3 0xC5
	=dLowerEchoedClapHit_S3 0xC6
}

?note {
	=nRst 0x80
	=nC0 0x81
	=nCs0 0x82
	=nD0 0x83
	=nEb0 0x84
	=nE0 0x85
	=nF0 0x86
	=nFs0 0x87
	=nG0 0x88
	=nAb0 0x89
	=nA0 0x8A
	=nBb0 0x8B
	=nB0 0x8C
	=nC1 0x8D
	=nCs1 0x8E
	=nD1 0x8F
	=nEb1 0x90
	=nE1 0x91
	=nF1 0x92
	=nFs1 0x93
	=nG1 0x94
	=nAb1 0x95
	=nA1 0x96
	=nBb1 0x97
	=nB1 0x98
	=nC2 0x99
	=nCs2 0x9A
	=nD2 0x9B
	=nEb2 0x9C
	=nE2 0x9D
	=nF2 0x9E
	=nFs2 0x9F
	=nG2 0xA0
	=nAb2 0xA1
	=nA2 0xA2
	=nBb2 0xA3
	=nB2 0xA4
	=nC3 0xA5
	=nCs3 0xA6
	=nD3 0xA7
	=nEb3 0xA8
	=nE3 0xA9
	=nF3 0xAA
	=nFs3 0xAB
	=nG3 0xAC
	=nAb3 0xAD
	=nA3 0xAE
	=nBb3 0xAF
	=nB3 0xB0
	=nC4 0xB1
	=nCs4 0xB2
	=nD4 0xB3
	=nEb4 0xB4
	=nE4 0xB5
	=nF4 0xB6
	=nFs4 0xB7
	=nG4 0xB8
	=nAb4 0xB9
	=nA4 0xBA
	=nBb4 0xBB
	=nB4 0xBC
	=nC5 0xBD
	=nCs5 0xBE
	=nD5 0xBF
	=nEb5 0xC0
	=nE5 0xC1
	=nF5 0xC2
	=nFs5 0xC3
	=nG5 0xC4
	=nAb5 0xC5
	=nA5 0xC6
	=nBb5 0xC7
	=nB5 0xC8
	=nC6 0xC9
	=nCs6 0xCA
	=nD6 0xCB
	=nEb6 0xCC
	=nE6 0xCD
	=nF6 0xCE
	=nFs6 0xCF
	=nG6 0xD0
	=nAb6 0xD1
	=nA6 0xD2
	=nBb6 0xD3
	=nB6 0xD4
	=nC7 0xD5
	=nCs7 0xD6
	=nD7 0xD7
	=nEb7 0xD8
	=nE7 0xD9
	=nF7 0xDA
	=nFs7 0xDB
	=nG7 0xDC
	=nAb7 0xDD
	=nA7 0xDE
	=nBb7 0xDF
}

?coordination {
	!0xE0 > smpsPan: /db & 0xC0, /lb & 0x3F {
		#0 {
			=panNone 0x00
			=panRight 0x40
			=panLeft 0x80
			=panCentre 0xC0
		}
	}
	!0xE1 > smpsAlterNote: /db;
	!0xE2 > smpsNop: /db;
	!0xE3 > smpsStopFM:;
	!0xE4 > smpsSetVol: /db;
	!0xE5 > smpsFMAlterVol: /db, /db;
	!0xE6 > %smpsFMAlterVol: /db;
	=smpsNoAttack 0xE7
	!0xE8 > smpsNoteFill: /db;
	!0xE9 > smpsSpindashRev:;
	!0xEA > smpsPlayDACSample: /db | 0x80;
	~£_Jumpc#
	!0xEB > smpsConditionalJump: /db, /aw;
	!0xEC > smpsPSGAlterVol: /db;
	!0xED > smpsSetNote: /db;
	!0xEE > smpsFMICommand: /db, /db;
	¤ /nb == 0xEF {
		$ /sb
		¤ (/nb & 0x80) == 0 {
			! > smpsSetvoice: /db & 0x7F;
		} {
			! > smpsSetvoice: /db & 0x7F, /db - 0x81;
		}
	}
	!0xF0 > smpsModSet: /db, /db, /db, /db;
	!0xF1 > smpsModChange2: /db, /db;
	!0xF2 > smpsStop:{
		;
	}
	!0xF3 > smpsPSGform: /db;
	!0xF4, 0x80 > smpsModOn:;
	!0xF4 > smpsModChange: /db;
	!0xF5 > smpsPSGvoice: /db {
		#0 {
			=sTone_01 1
			=sTone_02 2
			=sTone_03 3
			=sTone_04 4
			=sTone_05 5
			=sTone_06 6
			=sTone_07 7
			=sTone_08 8
			=sTone_09 9
			=sTone_0A 0x0A
			=sTone_0B 0x0B
			=sTone_0C 0x0C
			=sTone_0D 0x0D
			=sTone_0E 0x0E
			=sTone_0F 0x0F
			=sTone_10 0x10
			=sTone_11 0x11
			=sTone_12 0x12
			=sTone_13 0x13
			=sTone_14 0x14
			=sTone_15 0x15
			=sTone_16 0x16
			=sTone_17 0x17
			=sTone_18 0x18
			=sTone_19 0x19
			=sTone_1A 0x1A
			=sTone_1B 0x1B
			=sTone_1C 0x1C
			=sTone_1D 0x1D
			=sTone_1E 0x1E
			=sTone_1F 0x1F
			=sTone_20 0x20
			=sTone_21 0x21
			=sTone_22 0x22
			=sTone_23 0x23
			=sTone_24 0x24
			=sTone_25 0x25
			=sTone_26 0x26
			=sTone_27 0x27
		}
	}
	~£_Jump#
	!0xF6 > smpsJump: /aw{
		;
	}
	~£_Loop#
	!0xF7 > smpsLoop: /db, /db, /aw;
	~£_Call#
	!0xF8 > smpsCall: /aw;
	!0xF9 > smpsReturn:{
		;
	}
	!0xFA > smpsModOff:;
	!0xFB > smpsAlterPitch: /db;
	~£_Loopc#
	!0xFC > smpsContinuousLoop: /aw;
	!0xFD > smpsAlternateSMPS: /db;
	!0xFE > smpsFM3SpecialMode: /db, /db, /db, /db;
	!0xFF, 0 > smpsSetTempoMod: /db;
	!0xFF, 1 > smpsPlaySound: /db;
	!0xFF, 2 > smpsHaltMusic: /db;
	!0xFF, 3 > smpsCopyData: /db, /db {
		=comment "No song should ever use this coordination flag. It may good idea to remove it."
	}
	!0xFF, 4 > smpsSetTempoDiv: /db;
	!0xFF, 5 > smpsSSGEG: /db, /db, /db, /db;
	!0xFF, 6 > smpsFMVolEnv: /db, /db;
	!0xFF, 7 > smpsResetSpindashRev:;
}
