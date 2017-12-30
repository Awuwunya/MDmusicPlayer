; ===========================================================================
; ---------------------------------------------------------------------------
; This macro is only used for building the files
; ---------------------------------------------------------------------------

    if ~def(incdrv)
incdrv	macro	type, folder, comp
\folder	=	drvnum		; equate driver name with it's ID
drvnum	=	drvnum+4	; next driver ID
    endm
	endif
; ===========================================================================
; ---------------------------------------------------------------------------
; here is the list of included drivers.
drvnum =	0
; format:     directory   name  compression
; explanation
; directory: The directory driver files are in. Must not contain spaces.
; name: ID to be referred by when including SMPS files.
; compression: the compression of the sound driver. See macro.asm for further details.
; ---------------------------------------------------------------------------
	incdrv	SMPS, MegaPCM,	cmp_kos
	incdrv	SMPS, Sonic3K,	cmp_kos
	incdrv	SMPS, Ristar,	cmp_kos
	incdrv	SMPS, DyHe,	cmp_kos
	incdrv	GEMS, Aladdin,	cmp_none
	incdrv	GEMS, Vectorman,cmp_none
	incdrv	GEMS, Spinball,	cmp_none
; ===========================================================================
