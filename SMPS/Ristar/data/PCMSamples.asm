	obj filesize("drivers/dual.unc")

saminc		macro id
	rept narg
DAC\id		incbin "dac/dac_\id\.bin"
DAC\id\_End
	shift
	endr
    endm

dw	macro val
	rept narg
		dc.b ((\val)&$FF), ((\val)>>8&$FF)
		shift
	endr
    endm


.sample	macro id
	rept narg
	dw DAC\id, DAC\id\_End-DAC\id, 0, 0
	shift
	endr
    endm

	.sample 81, 82, 83, 84, 85
	saminc 81, 82, 83, 84, 85
