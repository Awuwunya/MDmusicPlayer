; This macro is only used for building the files
    if ~def(incdrv)
incdrv	macro	folder, comp
\folder	=	drvnum		; equate driver name with it's ID
drvnum	=	drvnum+4	; next driver ID
    endm
	endif

; here is the list of included drivers.
drvnum		= 0
; format:     directory   name  compression
; explanation
; directory: The directory driver files are in. Must not contain spaces.
; name: ID to be referred by when including SMPS files.
; compression: the compression of the sound driver. See macro.asm for further details.
	incdrv	S1_SMPS, cmp_kos
	incdrv	MegaPCM, cmp_kos
	incdrv	S3K_SMPS, cmp_kos
	incdrv	DyHe_SMPS, cmp_kos
