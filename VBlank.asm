VBlank:
	dma68kToVDP	MainPalette, 0, $80, CRAM	; DMA palette to CRAM
	dma68kToVDP	VScrollRAM, 0, 80, VSRAM	; DMA Vertical scrolling to VSRAM
		rte
