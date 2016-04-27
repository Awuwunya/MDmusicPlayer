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
				=VolEnv_00 0
				=VolEnv_01 1
				=VolEnv_02 2
				=VolEnv_03 3
				=VolEnv_04 4
				=VolEnv_05 5
				=VolEnv_06 6
				=VolEnv_07 7
				=VolEnv_08 8
				=VolEnv_09 9
				=VolEnv_0A 0x0A
				=VolEnv_0B 0x0B
				=VolEnv_0C 0x0C
				=VolEnv_0D 0x0D
				=VolEnv_0E 0x0E
				=VolEnv_0F 0x0F
				=VolEnv_10 0x10
				=VolEnv_11 0x11
				=VolEnv_12 0x12
				=VolEnv_13 0x13
				=VolEnv_14 0x14
				=VolEnv_15 0x15
				=VolEnv_16 0x16
				=VolEnv_17 0x17
				=VolEnv_18 0x18
				=VolEnv_19 0x19
				=VolEnv_1A 0x1A
				=VolEnv_1B 0x1B
				=VolEnv_1C 0x1C
				=VolEnv_1D 0x1D
				=VolEnv_1E 0x1E
				=VolEnv_1F 0x1F
				=VolEnv_20 0x20
				=VolEnv_21 0x21
				=VolEnv_22 0x22
				=VolEnv_23 0x23
				=VolEnv_24 0x24
				=VolEnv_25 0x25
				=VolEnv_26 0x26
				=VolEnv_27 0x27
			}
		}
	}
}

?Voices {
	=num 0
	=b1 0
	=b2 0
	=b3 0
	=b4 0
	%; Voice {$2!\num\}\r\n\t; {$2!/db}\r\n\t; {$2!/db}, {$2!/db}, {$2!/db}, {$2!/db},\t{$2!/db}, {$2!/db}, {$2!/db}, {$2!/db}\r\n\t; {$2!/db}, {$2!/db}, {$2!/db}, {$2!/db},\t{$2!/db}, {$2!/db}, {$2!/db}, {$2!/db}\r\n\t; {$2!/db}, {$2!/db}, {$2!/db}, {$2!/db},\t{$2!/db}, {$2!/db}, {$2!/db}, {$2!/db}
	>b 25
	! > smpsVcAlgorithm: /nb&0x7;
	! > smpsVcFeedback: (/db&0x38)>>3;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcDetune: (\b4\&0xF0)>>4, (\b3\&0xF0)>>4, (\b2\&0xF0)>>4, (\b1\&0xF0)>>4;
	! > smpsVcCoarseFreq: \b4\&0xF, \b3\&0xF, \b2\&0xF, \b1\&0xF;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcRateScale: (\b4\&0xC0)>>6, (\b3\&0xC0)>>6, (\b2\&0xC0)>>6, (\b1\&0xC0)>>6;
	! > smpsVcAttackRate: \b4\&0x1F, \b3\&0x1F, \b2\&0x1F, \b1\&0x1F;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcAmpMod: (\b4\&0x80)>>7, (\b3\&0x80)>>7, (\b2\&0x80)>>7, (\b1\&0x80)>>7;
	! > smpsVcDecayRate1: \b4\&0x1F, \b3\&0x1F, \b2\&0x1F, \b1\&0x1F;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcDecayRate2: \b4\, \b3\, \b2\, \b1\;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcDecayLevel: (\b4\&0xF0)>>4, (\b3\&0xF0)>>4, (\b2\&0xF0)>>4, (\b1\&0xF0)>>4;
	! > smpsVcReleaseRate: \b4\&0xF, \b3\&0xF, \b2\&0xF, \b1\&0xF;
	=b1 /db
	=b2 /db
	=b3 /db
	! > smpsVcTotalLevel: /db&0x7F, \b3\&0x7F, \b2\&0x7F, \b1\&0x7F;
	=num \num\+1
}

?DAC {
	=nRst 0x80
	=dSnare 0x81
	=dHighTom 0x82
	=dMidTom 0x83
	=dLowTom 0x84
	=dFloorTom 0x85
	=dKick 0x86
	=dMuffledSnare 0x87
	=dCrashCymbal 0x88
	=dRideCymbal 0x89
	=dLowMetalHit 0x8A
	=dMetalHit 0x8B
	=dHighMetalHit 0x8C
	=dHigherMetalHit 0x8D
	=dMidMetalHit 0x8E
	=dClap 0x8F
	=dElectricHighTom 0x90
	=dElectricMidTom 0x91
	=dElectricLowTom 0x92
	=dElectricFloorTom 0x93
	=dTightSnare 0x94
	=dMidpitchSnare 0x95
	=dLooseSnare 0x96
	=dLooserSnare 0x97
	=dHiTimpani 0x98
	=dLowTimpani 0x99
	=dMidTimpani 0x9A
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
	=dScratch 0xBB
	=dLooseSnareNoise 0xBC
	=dPowerKick2 0xBD
	=dCrashingNoiseWoo 0xBE
	=dQuickHit 0xBF
	=dKickHey 0xC0
	=dPowerKickHit 0xC1
	=dLowPowerKickHit 0xC2
	=dLowerPowerKickHit 0xC3
	=dLowestPowerKickHit 0xC4
	=dEchoedClapHit2 0xC5
	=dLowerEchoedClapHit2 0xC6
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
	=nC 0xA6
	=nD3 0xA7
	=nEb3 0xA8
	=nE3 0xA9
	=nF3 0xAA
	=nF 0xAB
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
			=VolEnv_00 0
			=VolEnv_01 1
			=VolEnv_02 2
			=VolEnv_03 3
			=VolEnv_04 4
			=VolEnv_05 5
			=VolEnv_06 6
			=VolEnv_07 7
			=VolEnv_08 8
			=VolEnv_09 9
			=VolEnv_0A 0x0A
			=VolEnv_0B 0x0B
			=VolEnv_0C 0x0C
			=VolEnv_0D 0x0D
			=VolEnv_0E 0x0E
			=VolEnv_0F 0x0F
			=VolEnv_10 0x10
			=VolEnv_11 0x11
			=VolEnv_12 0x12
			=VolEnv_13 0x13
			=VolEnv_14 0x14
			=VolEnv_15 0x15
			=VolEnv_16 0x16
			=VolEnv_17 0x17
			=VolEnv_18 0x18
			=VolEnv_19 0x19
			=VolEnv_1A 0x1A
			=VolEnv_1B 0x1B
			=VolEnv_1C 0x1C
			=VolEnv_1D 0x1D
			=VolEnv_1E 0x1E
			=VolEnv_1F 0x1F
			=VolEnv_20 0x20
			=VolEnv_21 0x21
			=VolEnv_22 0x22
			=VolEnv_23 0x23
			=VolEnv_24 0x24
			=VolEnv_25 0x25
			=VolEnv_26 0x26
			=VolEnv_27 0x27
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
