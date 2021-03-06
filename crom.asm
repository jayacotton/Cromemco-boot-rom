; z80dasm 1.1.5
; command line: /usr/local/bin/z80dasm -a -l -g 0xc000 -t crom.bin

	org	0c000h

lc000h:
	di			;c000	f3 	. 
	jr lc03fh		;c001	18 3c 	. < 
; looks like a cp/m jump table
	jp lc030h		;c003	c3 30 c0 	. 0 . 
	jp lc504h		;c006	c3 04 c5 	. . . 
	jp lc037h		;c009	c3 37 c0 	. 7 . 
	jp lc03bh		;c00c	c3 3b c0 	. ; . 
	jp lcb9eh		;c00f	c3 9e cb 	. . . 
	jp lcd37h		;c012	c3 37 cd 	. 7 . 
	jp lc4d4h		;c015	c3 d4 c4 	. . . 
	jp lcd52h		;c018	c3 52 cd 	. R . 
	jp lc5abh		;c01b	c3 ab c5 	. . . 
	jp lc24bh		;c01e	c3 4b c2 	. K . 
	jp lcc6ch		;c021	c3 6c cc 	. l . 
	jp lcc76h		;c024	c3 76 cc 	. v . 
	jp lcbeah		;c027	c3 ea cb 	. . . 
	jp lc7feh		;c02a	c3 fe c7 	. . . 
	jp lcc97h		;c02d	c3 97 cc 	. . . 
lc030h:
	ld (00077h),a		;c030	32 77 00 	2 w . 
	ld a,b			;c033	78 	x 
	jp lc387h		;c034	c3 87 c3 	. . . 
lc037h:
	ld (00075h),a		;c037	32 75 00 	2 u . 
	ret			;c03a	c9 	. 
lc03bh:
	ld (00076h),a		;c03b	32 76 00 	2 v . 
	ret			;c03e	c9 	. 
lc03fh:
	xor a			;c03f	af 	. 
	out (003h),a		;c040	d3 03 	. . 
	ld b,a			;c042	47 	G 
	exx			;c043	d9 	. 
	cpl			;c044	2f 	/ 
	out (004h),a		;c045	d3 04 	. . 
	ld a,0d0h		;c047	3e d0 	> . 
	out (030h),a		;c049	d3 30 	. 0 
	ld hl,0002eh		;c04b	21 2e 00 	! . . 
	ld sp,hl		;c04e	f9 	. 
lc04fh:
	dec h			;c04f	25 	% 
	jr nz,lc04fh		;c050	20 fd 	  . 
lc052h:
	ld (hl),h		;c052	74 	t 
	inc l			;c053	2c 	, 
	jr nz,lc052h		;c054	20 fc 	  . 
	inc h			;c056	24 	$ 
	ld (00062h),hl		;c057	22 62 00 	" b . 
	ld (00064h),hl		;c05a	22 64 00 	" d . 
	call lc24bh		;c05d	cd 4b c2 	. K . 
	in a,(034h)		;c060	db 34 	. 4 
	and 040h		;c062	e6 40 	. @ 
	jp nz,lc139h		;c064	c2 39 c1 	. 9 . 
lc067h:
	in a,(004h)		;c067	db 04 	. . 
	cpl			;c069	2f 	/ 
	and 003h		;c06a	e6 03 	. . 
lc06ch:
	ld (00077h),a		;c06c	32 77 00 	2 w . 
	call sub_c806h		;c06f	cd 06 c8 	. . . 
	defb	"Preparing to boot, ESC to abort",0x8d
	call sub_cfa8h		;c092	cd a8 cf 	. . . 
	ld d,a			;c095	57 	W 
	out (034h),a		;c096	d3 34 	. 4 
	ld b,064h		;c098	06 64 	. d 
lc09ah:
	call sub_c128h		;c09a	cd 28 c1 	. ( . 
	ld hl,00064h		;c09d	21 64 00 	! d . 
	call sub_cff1h		;c0a0	cd f1 cf 	. . . 
	djnz lc09ah		;c0a3	10 f5 	. . 
	ld (00075h),a		;c0a5	32 75 00 	2 u . 
	ld (0007dh),a		;c0a8	32 7d 00 	2 } . 
	ld (00078h),a		;c0ab	32 78 00 	2 x . 
	inc a			;c0ae	3c 	< 
	ld (00076h),a		;c0af	32 76 00 	2 v . 
	call sub_c1f7h		;c0b2	cd f7 c1 	. . . 
	ld (0007eh),a		;c0b5	32 7e 00 	2 ~ . 
	ld hl,00080h		;c0b8	21 80 00 	! . . 
	ld (0007bh),hl		;c0bb	22 7b 00 	" { . 
	ld (00079h),hl		;c0be	22 79 00 	" y . 
	ld a,042h		;c0c1	3e 42 	> B 
	ld (00070h),a		;c0c3	32 70 00 	2 p . 
	ld b,002h		;c0c6	06 02 	. . 
lc0c8h:
	push bc			;c0c8	c5 	. 
	call lcd37h		;c0c9	cd 37 cd 	. 7 . 
	call nc,sub_cdcbh	;c0cc	d4 cb cd 	. . . 
	call nc,lcd52h		;c0cf	d4 52 cd 	. R . 
	pop bc			;c0d2	c1 	. 
	jr nc,lc0e8h		;c0d3	30 13 	0 . 
	call sub_c128h		;c0d5	cd 28 c1 	. ( . 
	djnz lc0c8h		;c0d8	10 ee 	. . 
lc0dah:
	call sub_c806h		;c0da	cd 06 c8 	. . . 
	defb	0x0d,"Unable ",0xf4
	jr lc115h		;c0e6	18 2d 	. - 
lc0e8h:
	ld a,(00080h)		;c0e8	3a 80 00 	: . . 
	cp 040h			;c0eb	fe 40 	. @ 
	jr z,lc0f3h		;c0ed	28 04 	( . 
	cp 0e5h			;c0ef	fe e5 	. . 
lc0f1h:
	jr nz,lc0fah		;c0f1	20 07 	  . 
lc0f3h:
	call sub_c806h		;c0f3	cd 06 c8 	. . . 
	dec c			;c0f6	0d 	. 
	adc a,018h		;c0f7	ce 18 	. . 
	dec de			;c0f9	1b 	. 
lc0fah:
	call sub_c128h		;c0fa	cd 28 c1 	. ( . 
	call sub_cfa8h		;c0fd	cd a8 cf 	. . . 
	ld d,a			;c100	57 	W 
	ld a,(00077h)		;c101	3a 77 00 	: w . 
	ex af,af'		;c104	08 	. 
	call sub_c806h		;c105	cd 06 c8 	. . . 
	defb	0x0d,"Standby",0x8d
	scf			;c111	37 	7 
	jp 00080h		;c112	c3 80 00 	. . . 
lc115h:
	call sub_c806h		;c115	cd 06 c8 	. . . 
	defb	" to boot",0x8d
	ld a,(00071h)		;c11f	3a 71 00 	: q . 
	or a			;c122	b7 	. 
	call nz,sub_c359h	;c123	c4 59 c3 	. Y . 
	jr lc131h		;c126	18 09 	. . 
sub_c128h:
	call lcc76h		;c128	cd 76 cc 	. v . 
	call nz,lcc6ch		;c12b	c4 6c cc 	. l . 
	cp 01bh			;c12e	fe 1b 	. . 
	ret nz			;c130	c0 	. 
lc131h:
	ld a,0d0h		;c131	3e d0 	> . 
	out (030h),a		;c133	d3 30 	. 0 
	ld a,07ch		;c135	3e 7c 	> | 
	out (004h),a		;c137	d3 04 	. . 
lc139h:
	call sub_c806h		;c139	cd 06 c8 	. . . 
	defb	0x0d,"Cromemco RDOS 02.52",0x8d
	ld	(06ch),a
lc155h:
	ld a,(0007eh)		;c155	3a 7e 00 	: ~ . 
	ld b,a			;c158	47 	G 
	call sub_c1e2h		;c159	cd e2 c1 	. . . 
	ld sp,0002eh		;c15c	31 2e 00 	1 . . 
	call sub_c806h		;c15f	cd 06 c8 	. . . 
	cp e			;c162	bb 	. 
	call sub_c7a3h		;c163	cd a3 c7 	. . . 
	call sub_c814h		;c166	cd 14 c8 	. . . 
	and a			;c169	a7 	. 
	jr z,$-25		;c16a	28 e5 	( . 
	call 0c2c1h		;c16c	cd c1 c2 	. . . 
	jr z,lc155h		;c16f	28 e4 	( . 
	ld a,b			;c171	78 	x 
	cp 017h			;c172	fe 17 	. . 
	jr nc,lc1bdh		;c174	30 47 	0 G 
	add a,a			;c176	87 	. 
	ld hl,lc18bh		;c177	21 8b c1 	! . . 
	call sub_c186h		;c17a	cd 86 c1 	. . . 
lc17dh:
	ld a,(hl)		;c17d	7e 	~ 
	inc hl			;c17e	23 	# 
	ld h,(hl)		;c17f	66 	f 
	ld l,a			;c180	6f 	o 
	call sub_c1c7h		;c181	cd c7 c1 	. . . 
	jr lc155h		;c184	18 cf 	. . 
sub_c186h:
	add a,l			;c186	85 	. 
	ld l,a			;c187	6f 	o 
	ret nc			;c188	d0 	. 
	inc h			;c189	24 	$ 
	ret			;c18a	c9 	. 
lc18bh:
	defb 0fdh,0cch,0c8h	;illegal sequence		;c18b	fd cc c8 	. . . 
	pop bc			;c18e	c1 	. 
	cp l			;c18f	bd 	. 
	pop bc			;c190	c1 	. 
	dec hl			;c191	2b 	+ 
	rst 0			;c192	c7 	. 
	ld hl,(0bdc6h)		;c193	2a c6 bd 	* . . 
	pop bc			;c196	c1 	. 
	call nz,0bdc1h		;c197	c4 c1 bd 	. . . 
	pop bc			;c19a	c1 	. 
	ld b,l			;c19b	45 	E 
	jp nz,lc1bdh		;c19c	c2 bd c1 	. . . 
	cp l			;c19f	bd 	. 
	pop bc			;c1a0	c1 	. 
	add hl,sp		;c1a1	39 	9 
	call nz,sub_c645h	;c1a2	c4 45 c6 	. E . 
	cp l			;c1a5	bd 	. 
	pop bc			;c1a6	c1 	. 
	ld (hl),0c6h		;c1a7	36 c6 	6 . 
	cp l			;c1a9	bd 	. 
	pop bc			;c1aa	c1 	. 
	jp nz,016c6h		;c1ab	c2 c6 16 	. . . 
	push bc			;c1ae	c5 	. 
	ld a,d			;c1af	7a 	z 
	add a,041h		;c1b0	c6 41 	. A 
	ret			;c1b2	c9 	. 
	cp l			;c1b3	bd 	. 
	pop bc			;c1b4	c1 	. 
	ld d,d			;c1b5	52 	R 
	add a,01ah		;c1b6	c6 1a 	. . 
	push bc			;c1b8	c5 	. 
lc1b9h:
	xor a			;c1b9	af 	. 
	ld (0006ch),a		;c1ba	32 6c 00 	2 l . 
lc1bdh:
	call sub_c806h		;c1bd	cd 06 c8 	. . . 
	ccf			;c1c0	3f 	? 
	adc a,l			;c1c1	8d 	. 
	jr lc155h		;c1c2	18 91 	. . 
	call sub_c853h		;c1c4	cd 53 c8 	. S . 
sub_c1c7h:
	jp (hl)			;c1c7	e9 	. 
	call sub_c814h		;c1c8	cd 14 c8 	. . . 
	or a			;c1cb	b7 	. 
	jp z,lc067h		;c1cc	ca 67 c0 	. g . 
	cp 045h			;c1cf	fe 45 	. E 
	jp nc,lc42ah		;c1d1	d2 2a c4 	. * . 
	sub 041h		;c1d4	d6 41 	. A 
	jp c,lc42ah		;c1d6	da 2a c4 	. * . 
	push af			;c1d9	f5 	. 
	inc de			;c1da	13 	. 
	call sub_c827h		;c1db	cd 27 c8 	. ' . 
	pop af			;c1de	f1 	. 
	jp lc06ch		;c1df	c3 6c c0 	. l . 
sub_c1e2h:
	ld a,(0006ch)		;c1e2	3a 6c 00 	: l . 
	or a			;c1e5	b7 	. 
	ret z			;c1e6	c8 	. 
	call lc7feh		;c1e7	cd fe c7 	. . . 
	bit 3,b			;c1ea	cb 58 	. X 
	ret nz			;c1ec	c0 	. 
	bit 7,b			;c1ed	cb 78 	. x 
	ld a,03bh		;c1ef	3e 3b 	> ; 
	call nz,lc7feh		;c1f1	c4 fe c7 	. . . 
	jp lc7feh		;c1f4	c3 fe c7 	. . . 
sub_c1f7h:
	ld a,d			;c1f7	7a 	z 
	out (034h),a		;c1f8	d3 34 	. 4 
	ld a,0dfh		;c1fa	3e df 	> . 
	out (004h),a		;c1fc	d3 04 	. . 
	ld a,0d4h		;c1fe	3e d4 	> . 
	out (030h),a		;c200	d3 30 	. 0 
lc202h:
	in a,(034h)		;c202	db 34 	. 4 
	rrca			;c204	0f 	. 
	jr nc,lc202h		;c205	30 fb 	0 . 
	in a,(030h)		;c207	db 30 	. 0 
	ld bc,00200h		;c209	01 00 02 	. . . 
	call sub_c23bh		;c20c	cd 3b c2 	. ; . 
lc20fh:
	ld a,0d4h		;c20f	3e d4 	> . 
	out (030h),a		;c211	d3 30 	. 0 
lc213h:
	call sub_c234h		;c213	cd 34 c2 	. 4 . 
	jr z,sub_c1f7h		;c216	28 df 	( . 
	in a,(034h)		;c218	db 34 	. 4 
	rrca			;c21a	0f 	. 
	jr nc,lc213h		;c21b	30 f6 	0 . 
	in a,(030h)		;c21d	db 30 	. 0 
	djnz lc20fh		;c21f	10 ee 	. . 
	xor a			;c221	af 	. 
	out (003h),a		;c222	d3 03 	. . 
	ld a,c			;c224	79 	y 
	cp 05ah			;c225	fe 5a 	. Z 
	jr nc,lc22ch		;c227	30 03 	0 . 
	add a,a			;c229	87 	. 
	add a,a			;c22a	87 	. 
	add a,a			;c22b	87 	. 
lc22ch:
	cp 0b7h			;c22c	fe b7 	. . 
	ld a,080h		;c22e	3e 80 	> . 
	ret nc			;c230	d0 	. 
	ld a,004h		;c231	3e 04 	> . 
	ret			;c233	c9 	. 
sub_c234h:
	in a,(003h)		;c234	db 03 	. . 
	cp 0c7h			;c236	fe c7 	. . 
	ret nz			;c238	c0 	. 
	inc c			;c239	0c 	. 
	ret z			;c23a	c8 	. 
sub_c23bh:
	ld a,001h		;c23b	3e 01 	> . 
	out (003h),a		;c23d	d3 03 	. . 
	ld a,0fah		;c23f	3e fa 	> . 
	out (005h),a		;c241	d3 05 	. . 
	jr sub_c234h		;c243	18 ef 	. . 
	call sub_c827h		;c245	cd 27 c8 	. ' . 
	call lcc97h		;c248	cd 97 cc 	. . . 
lc24bh:
	in a,(004h)		;c24b	db 04 	. . 
	and 008h		;c24d	e6 08 	. . 
	jr z,lc2aeh		;c24f	28 5d 	( ] 
lc251h:
	ld a,00ah		;c251	3e 0a 	> . 
	out (002h),a		;c253	d3 02 	. . 
	ld hl,007d0h		;c255	21 d0 07 	! . . 
	call sub_cff1h		;c258	cd f1 cf 	. . . 
	ld a,008h		;c25b	3e 08 	> . 
	out (002h),a		;c25d	d3 02 	. . 
	ld d,064h		;c25f	16 64 	. d 
lc261h:
	dec d			;c261	15 	. 
	jr z,lc251h		;c262	28 ed 	( . 
lc264h:
	ld hl,lc2b9h		;c264	21 b9 c2 	! . . 
	ld c,000h		;c267	0e 00 	. . 
	ld a,019h		;c269	3e 19 	> . 
	ld b,009h		;c26b	06 09 	. . 
lc26dh:
	out (002h),a		;c26d	d3 02 	. . 
	outi			;c26f	ed a3 	. . 
	jr z,lc261h		;c271	28 ee 	( . 
	call sub_c298h		;c273	cd 98 c2 	. . . 
	call sub_c298h		;c276	cd 98 c2 	. . . 
	jr c,lc264h		;c279	38 e9 	8 . 
	cp 00dh			;c27b	fe 0d 	. . 
	ld a,009h		;c27d	3e 09 	> . 
	jr nz,lc26dh		;c27f	20 ec 	  . 
lc281h:
	ld a,00dh		;c281	3e 0d 	> . 
	out (001h),a		;c283	d3 01 	. . 
	ld hl,00fa0h		;c285	21 a0 0f 	! . . 
	call sub_cff1h		;c288	cd f1 cf 	. . . 
	call lcc76h		;c28b	cd 76 cc 	. v . 
	call nz,lcc6ch		;c28e	c4 6c cc 	. l . 
	cp 00dh			;c291	fe 0d 	. . 
	jr z,lc281h		;c293	28 ec 	( . 
	jp lcc97h		;c295	c3 97 cc 	. . . 
sub_c298h:
	push de			;c298	d5 	. 
	ld de,08ca0h		;c299	11 a0 8c 	. . . 
lc29ch:
	call lcc76h		;c29c	cd 76 cc 	. v . 
	jr z,lc2a6h		;c29f	28 05 	( . 
	call lcc6ch		;c2a1	cd 6c cc 	. l . 
	jr lc2ach		;c2a4	18 06 	. . 
lc2a6h:
	dec de			;c2a6	1b 	. 
	ld a,d			;c2a7	7a 	z 
	or e			;c2a8	b3 	. 
	jr nz,lc29ch		;c2a9	20 f1 	  . 
	scf			;c2ab	37 	7 
lc2ach:
	pop de			;c2ac	d1 	. 
	ret			;c2ad	c9 	. 
lc2aeh:
	ld a,009h		;c2ae	3e 09 	> . 
	out (002h),a		;c2b0	d3 02 	. . 
	ld a,084h		;c2b2	3e 84 	> . 
	out (000h),a		;c2b4	d3 00 	. . 
	jp lcc97h		;c2b6	c3 97 cc 	. . . 
lc2b9h:
	sub b			;c2b9	90 	. 
	ret nz			;c2ba	c0 	. 
	and b			;c2bb	a0 	. 
	sub b			;c2bc	90 	. 
	adc a,b			;c2bd	88 	. 
	add a,h			;c2be	84 	. 
	add a,d			;c2bf	82 	. 
	ld bc,041d6h		;c2c0	01 d6 41 	. . A 
	jp c,lc1bdh		;c2c3	da bd c1 	. . . 
	ld b,a			;c2c6	47 	G 
	inc de			;c2c7	13 	. 
	ld a,(de)		;c2c8	1a 	. 
	cp 03bh			;c2c9	fe 3b 	. ; 
	ret nz			;c2cb	c0 	. 
	ld a,b			;c2cc	78 	x 
	cp 004h			;c2cd	fe 04 	. . 
	jp nc,lc42ah		;c2cf	d2 2a c4 	. * . 
	add a,041h		;c2d2	c6 41 	. A 
	ld (0006ch),a		;c2d4	32 6c 00 	2 l . 
	call sub_c3f6h		;c2d7	cd f6 c3 	. . . 
	inc de			;c2da	13 	. 
	ld a,(de)		;c2db	1a 	. 
	cp 03bh			;c2dc	fe 3b 	. ; 
	ld b,00ch		;c2de	06 0c 	. . 
	jr nz,lc2edh		;c2e0	20 0b 	  . 
	inc de			;c2e2	13 	. 
	ld a,(de)		;c2e3	1a 	. 
	cp 03bh			;c2e4	fe 3b 	. 
	ld b,004h		;c2e6	06 04 	. . 
	jr nz,lc2edh		;c2e8	20 03 	  . 
	ld b,080h		;c2ea	06 80 	. . 
	inc de			;c2ec	13 	. 
lc2edh:
	push bc			;c2ed	c5 	. 
	call sub_c3b7h		;c2ee	cd b7 c3 	. . . 
	pop bc			;c2f1	c1 	. 
	ld (hl),b		;c2f2	70 	p 
	jr nc,lc2fbh		;c2f3	30 06 	0 . 
	ld a,(0006dh)		;c2f5	3a 6d 00 	: m . 
	or b			;c2f8	b0 	. 
	ld (hl),a		;c2f9	77 	w 
	scf			;c2fa	37 	7 
lc2fbh:
	push af			;c2fb	f5 	. 
	call sub_c384h		;c2fc	cd 84 c3 	. . . 
	ld (00078h),a		;c2ff	32 78 00 	2 x . 
	ld (0007dh),a		;c302	32 7d 00 	2 } . 
	inc a			;c305	3c 	< 
	ld (00076h),a		;c306	32 76 00 	2 v . 
	call sub_c604h		;c309	cd 04 c6 	. . . 
	ld a,048h		;c30c	3e 48 	> H 
	ld (00070h),a		;c30e	32 70 00 	2 p . 
	call lcd37h		;c311	cd 37 cd 	. 7 . 
	push af			;c314	f5 	. 
	call sub_c61eh		;c315	cd 1e c6 	. . . 
	pop af			;c318	f1 	. 
	jp c,lc40dh		;c319	da 0d c4 	. . . 
	pop af			;c31c	f1 	. 
	jp c,lc3b5h		;c31d	da b5 c3 	. . . 
lc320h:
	call sub_c604h		;c320	cd 04 c6 	. . . 
	ld hl,00100h		;c323	21 00 01 	! . . 
	ld (0007bh),hl		;c326	22 7b 00 	" { . 
	call sub_cdcbh		;c329	cd cb cd 	. . . 
	call lcd52h		;c32c	cd 52 cd 	. R . 
	push af			;c32f	f5 	. 
	call sub_c61eh		;c330	cd 1e c6 	. . . 
	pop af			;c333	f1 	. 
	jr nc,lc363h		;c334	30 2d 	0 - 
	ld a,(00071h)		;c336	3a 71 00 	: q . 
	or a			;c339	b7 	. 
	jp p,lc345h		;c33a	f2 45 c3 	. E . 
	ld hl,00064h		;c33d	21 64 00 	! d . 
	call sub_cff1h		;c340	cd f1 cf 	. . . 
	jr lc320h		;c343	18 db 	. . 
lc345h:
	call sub_c806h		;c345	cd 06 c8 	. . . 
	defb	"Can't read Label",0x8d
sub_c359h:
	ld e,001h		;c359	1e 01 	. . 
	call sub_c5f2h		;c35b	cd f2 c5 	. . . 
	call sub_c413h		;c35e	cd 13 c4 	. . . 
	xor a			;c361	af 	. 
	ret			;c362	c9 	. 
lc363h:
	ld bc,00010h		;c363	01 10 00 	. . . 
	ld de,0017ah		;c366	11 7a 01 	. z . 
	call sub_c3eeh		;c369	cd ee c3 	. . . 
	ld c,001h		;c36c	0e 01 	. . 
	call sub_c3eeh		;c36e	cd ee c3 	. . . 
	ld a,(00178h)		;c371	3a 78 01 	: x . 
	cp 043h			;c374	fe 43 	. C 
	jr nz,lc37ah		;c376	20 02 	  . 
	set 1,b			;c378	cb c8 	. . 
lc37ah:
	ld a,(0007eh)		;c37a	3a 7e 00 	: ~ . 
	and 0cch		;c37d	e6 cc 	. . 
	or b			;c37f	b0 	. 
	ld hl,(0006ah)		;c380	2a 6a 00 	* j . 
	ld (hl),a		;c383	77 	w 
sub_c384h:
	call sub_c3f6h		;c384	cd f6 c3 	. . . 
lc387h:
	ld (0007eh),a		;c387	32 7e 00 	2 ~ . 
	bit 0,a			;c38a	cb 47 	. G 
	ld de,0100ah		;c38c	11 0a 10 	. . . 
	ld hl,00200h		;c38f	21 00 02 	! . . 
	jr nz,lc3a1h		;c392	20 0d 	  . 
	bit 1,a			;c394	cb 4f 	. O 
	ld de,00805h		;c396	11 05 08 	. . . 
	jr nz,lc3a1h		;c399	20 06 	  . 
lc39bh:
	ld de,01a12h		;c39b	11 12 1a 	. . . 
	ld hl,00080h		;c39e	21 80 00 	! . . 
lc3a1h:
	ld (00079h),hl		;c3a1	22 79 00 	" y . 
	bit 7,a			;c3a4	cb 7f 	.  
	ld a,04ch		;c3a6	3e 4c 	> L 
	ld b,d			;c3a8	42 	B 
	jr z,lc3aeh		;c3a9	28 03 	( . 
	ld a,027h		;c3ab	3e 27 	> ' 
	ld b,e			;c3ad	43 	C 
lc3aeh:
	ld (0006fh),a		;c3ae	32 6f 00 	2 o . 
	ld a,b			;c3b1	78 	x 
	ld (0006eh),a		;c3b2	32 6e 00 	2 n . 
lc3b5h:
	xor a			;c3b5	af 	. 
	ret			;c3b6	c9 	. 
sub_c3b7h:
	call sub_c814h		;c3b7	cd 14 c8 	. . . 
	or a			;c3ba	b7 	. 
	ret z			;c3bb	c8 	. 
	ld bc,00010h		;c3bc	01 10 00 	. . . 
	call sub_c3deh		;c3bf	cd de c3 	. . . 
	ld c,001h		;c3c2	0e 01 	. . 
	call sub_c3deh		;c3c4	cd de c3 	. . . 
	call sub_c814h		;c3c7	cd 14 c8 	. . . 
	cp 043h			;c3ca	fe 43 	. C 
	jr nz,lc3d4h		;c3cc	20 06 	  . 
	set 1,b			;c3ce	cb c8 	. . 
	inc de			;c3d0	13 	. 
	call sub_c814h		;c3d1	cd 14 c8 	. . . 
lc3d4h:
	or a			;c3d4	b7 	. 
	jp nz,lc1b9h		;c3d5	c2 b9 c1 	. . . 
	ld a,b			;c3d8	78 	x 
	ld (0006dh),a		;c3d9	32 6d 00 	2 m . 
	scf			;c3dc	37 	7 
	ret			;c3dd	c9 	. 
sub_c3deh:
	call sub_c814h		;c3de	cd 14 c8 	. . . 
	inc de			;c3e1	13 	. 
	cp 053h			;c3e2	fe 53 	. S 
	ret z			;c3e4	c8 	. 
	cp 044h			;c3e5	fe 44 	. D 
	jp nz,lc1b9h		;c3e7	c2 b9 c1 	. . . 
lc3eah:
	ld a,b			;c3ea	78 	x 
	or c			;c3eb	b1 	. 
	ld b,a			;c3ec	47 	G 
	ret			;c3ed	c9 	. 
sub_c3eeh:
	ld a,(de)		;c3ee	1a 	. 
	inc de			;c3ef	13 	. 
	inc de			;c3f0	13 	. 
	cp 044h			;c3f1	fe 44 	. D 
	ret nz			;c3f3	c0 	. 
	jr lc3eah		;c3f4	18 f4 	. . 
sub_c3f6h:
	ld a,(0006ch)		;c3f6	3a 6c 00 	: l . 
	sub 041h		;c3f9	d6 41 	. A 
	ld (00077h),a		;c3fb	32 77 00 	2 w . 
	ld hl,00066h		;c3fe	21 66 00 	! f . 
	call sub_c186h		;c401	cd 86 c1 	. . . 
	ld (0006ah),hl		;c404	22 6a 00 	" j . 
	ld a,(hl)		;c407	7e 	~ 
lc408h:
	or a			;c408	b7 	. 
	ret			;c409	c9 	. 
lc40ah:
	call sub_c5f2h		;c40a	cd f2 c5 	. . . 
lc40dh:
	call sub_c413h		;c40d	cd 13 c4 	. . . 
	jp lc155h		;c410	c3 55 c1 	. U . 
sub_c413h:
	call sub_c806h		;c413	cd 06 c8 	. . . 
	jr nz,$+71		;c416	20 45 	  E 
	ld (hl),d		;c418	72 	r 
	ld (hl),d		;c419	72 	r 
	xor l			;c41a	ad 	. 
	ld a,(00070h)		;c41b	3a 70 00 	: p . 
	call lc7feh		;c41e	cd fe c7 	. . . 
	ld a,(00071h)		;c421	3a 71 00 	: q . 
	call sub_c7dbh		;c424	cd db c7 	. . . 
	jp lcc97h		;c427	c3 97 cc 	. . . 
lc42ah:
	call sub_c806h		;c42a	cd 06 c8 	. . . 
	ld b,c			;c42d	41 	A 
	dec l			;c42e	2d 	- 
	ld b,h			;c42f	44 	D 
	jr nz,lc4a1h		;c430	20 6f 	  o 
	ld l,(hl)		;c432	6e 	n 
	ld l,h			;c433	6c 	l 
	ld a,c			;c434	79 	y 
	adc a,l			;c435	8d 	. 
	jp lc155h		;c436	c3 55 c1 	. U . 
	call sub_c827h		;c439	cd 27 c8 	. ' . 
	ld a,(00077h)		;c43c	3a 77 00 	: w . 
	push af			;c43f	f5 	. 
	ld a,(0006ch)		;c440	3a 6c 00 	: l . 
	push af			;c443	f5 	. 
	ld a,041h		;c444	3e 41 	> A 
lc446h:
	push af			;c446	f5 	. 
	ld (0006ch),a		;c447	32 6c 00 	2 l . 
	call sub_c3f6h		;c44a	cd f6 c3 	. . . 
	ld hl,(0006ah)		;c44d	2a 6a 00 	* j . 
	ld b,(hl)		;c450	46 	F 
	call nz,sub_c463h	;c451	c4 63 c4 	. c . 
	pop af			;c454	f1 	. 
	inc a			;c455	3c 	< 
	cp 045h			;c456	fe 45 	. E 
	jr c,lc446h		;c458	38 ec 	8 . 
	pop af			;c45a	f1 	. 
	ld (0006ch),a		;c45b	32 6c 00 	2 l . 
	pop af			;c45e	f1 	. 
	ld (00077h),a		;c45f	32 77 00 	2 w . 
	ret			;c462	c9 	. 
sub_c463h:
	call sub_c806h		;c463	cd 06 c8 	. . . 
	jr nz,lc408h		;c466	20 a0 	  . 
	call sub_c1e2h		;c468	cd e2 c1 	. . . 
	call sub_c806h		;c46b	cd 06 c8 	. . . 
	dec sp			;c46e	3b 	; 
	and b			;c46f	a0 	. 
	bit 3,b			;c470	cb 58 	. X 
	call nz,sub_c7fch	;c472	c4 fc c7 	. . . 
	bit 7,b			;c475	cb 78 	. x 
	call z,sub_c7fch	;c477	cc fc c7 	. . . 
	bit 4,b			;c47a	cb 60 	. ` 
	call sub_c498h		;c47c	cd 98 c4 	. . . 
	call sub_c7fch		;c47f	cd fc c7 	. . . 
	bit 0,b			;c482	cb 40 	. @ 
	call sub_c498h		;c484	cd 98 c4 	. . . 
	bit 1,b			;c487	cb 48 	. H 
	jr z,lc495h		;c489	28 0a 	( . 
	call sub_c806h		;c48b	cd 06 c8 	. . . 
	jr nz,$+69		;c48e	20 43 	  C 
	ld (hl),d		;c490	72 	r 
	ld l,a			;c491	6f 	o 
	ld l,l			;c492	6d 	m 
	ld l,c			;c493	69 	i 
	ret m			;c494	f8 	. 
lc495h:
	jp lcc97h		;c495	c3 97 cc 	. . . 
sub_c498h:
	ld a,044h		;c498	3e 44 	> D 
	jr nz,lc49eh		;c49a	20 02 	  . 
	ld a,053h		;c49c	3e 53 	> S 
lc49eh:
	jp lc7feh		;c49e	c3 fe c7 	. . . 
lc4a1h:
	ld b,a			;c4a1	47 	G 
	ld a,(0006ch)		;c4a2	3a 6c 00 	: l . 
	or a			;c4a5	b7 	. 
	jp z,lc1bdh		;c4a6	ca bd c1 	. . . 
	ld a,b			;c4a9	78 	x 
	cp 053h			;c4aa	fe 53 	. S 
	jr z,lc4dah		;c4ac	28 2c 	( , 
	call sub_c8b0h		;c4ae	cd b0 c8 	. . . 
lc4b1h:
	jp c,lc1bdh		;c4b1	da bd c1 	. . . 
	push hl			;c4b4	e5 	. 
	call sub_c4e1h		;c4b5	cd e1 c4 	. . . 
	ld a,053h		;c4b8	3e 53 	> S 
	ld (00070h),a		;c4ba	32 70 00 	2 p . 
	pop hl			;c4bd	e1 	. 
	xor a			;c4be	af 	. 
	or h			;c4bf	b4 	. 
	jp nz,lc1bdh		;c4c0	c2 bd c1 	. . . 
	ld a,(0006fh)		;c4c3	3a 6f 00 	: o . 
	cp l			;c4c6	bd 	. 
	jr c,lc4b1h		;c4c7	38 e8 	8 . 
	ld a,l			;c4c9	7d 	} 
	ld (00075h),a		;c4ca	32 75 00 	2 u . 
	call lc4d4h		;c4cd	cd d4 c4 	. . . 
	ret nc			;c4d0	d0 	. 
	jp lc40dh		;c4d1	c3 0d c4 	. . . 
lc4d4h:
	call sub_c5f8h		;c4d4	cd f8 c5 	. . . 
	jp sub_cdcbh		;c4d7	c3 cb cd 	. . . 
lc4dah:
	inc de			;c4da	13 	. 
	call sub_c4e1h		;c4db	cd e1 c4 	. . . 
	jp sub_cdcbh		;c4de	c3 cb cd 	. . . 
sub_c4e1h:
	ld a,(00075h)		;c4e1	3a 75 00 	: u . 
	ld (0007dh),a		;c4e4	32 7d 00 	2 } . 
	call sub_c8adh		;c4e7	cd ad c8 	. . . 
	ret c			;c4ea	d8 	. 
	xor a			;c4eb	af 	. 
	or h			;c4ec	b4 	. 
lc4edh:
	jp nz,lc1bdh		;c4ed	c2 bd c1 	. . . 
	ld a,l			;c4f0	7d 	} 
	or a			;c4f1	b7 	. 
	jr nz,lc4f8h		;c4f2	20 04 	  . 
	ld (00078h),a		;c4f4	32 78 00 	2 x . 
	ret			;c4f7	c9 	. 
lc4f8h:
	dec a			;c4f8	3d 	= 
	jr nz,lc4edh		;c4f9	20 f2 	  . 
	call sub_c3f6h		;c4fb	cd f6 c3 	. . . 
	bit 4,a			;c4fe	cb 67 	. g 
	jr z,lc508h		;c500	28 06 	( . 
	ld a,001h		;c502	3e 01 	> . 
lc504h:
	ld (00078h),a		;c504	32 78 00 	2 x . 
	ret			;c507	c9 	. 
lc508h:
	call sub_c806h		;c508	cd 06 c8 	. . . 
	defb	"S.Sided",0x8d
	jp lc155h		;c513	c3 55 c1 	. U . 
	ld b,052h		;c516	06 52 	. R 
	jr lc51ch		;c518	18 02 	. . 
	ld b,057h		;c51a	06 57 	. W 
lc51ch:
	ld a,(de)		;c51c	1a 	. 
	cp 044h			;c51d	fe 44 	. D 
	jp nz,lc1bdh		;c51f	c2 bd c1 	. . . 
	ld a,b			;c522	78 	x 
	ld (00070h),a		;c523	32 70 00 	2 p . 
	call sub_c5bbh		;c526	cd bb c5 	. . . 
	push hl			;c529	e5 	. 
	pop iy			;c52a	fd e1 	. . 
	ld h,b			;c52c	60 	` 
	ld l,c			;c52d	69 	i 
lc52eh:
	push de			;c52e	d5 	. 
	push hl			;c52f	e5 	. 
	ld a,e			;c530	7b 	{ 
	ld (00076h),a		;c531	32 76 00 	2 v . 
	ld (0007bh),iy		;c534	fd 22 7b 00 	. " { . 
	call lc4d4h		;c538	cd d4 c4 	. . . 
	ld a,(00070h)		;c53b	3a 70 00 	: p . 
	cp 057h			;c53e	fe 57 	. W 
	scf			;c540	37 	7 
	ccf			;c541	3f 	? 
	call z,lc5abh		;c542	cc ab c5 	. . . 
	jr c,lc54fh		;c545	38 08 	8 . 
	ld a,(00070h)		;c547	3a 70 00 	: p . 
	cp 052h			;c54a	fe 52 	. R 
	call z,lcd52h		;c54c	cc 52 cd 	. R . 
lc54fh:
	pop hl			;c54f	e1 	. 
	pop de			;c550	d1 	. 
	jp c,lc40ah		;c551	da 0a c4 	. . . 
	ld bc,(00079h)		;c554	ed 4b 79 00 	. K y . 
	add iy,bc		;c558	fd 09 	. . 
	inc bc			;c55a	03 	. 
	sbc hl,bc		;c55b	ed 42 	. B 
	inc hl			;c55d	23 	# 
	jp c,sub_c5f2h		;c55e	da f2 c5 	. . . 
	inc e			;c561	1c 	. 
	ld a,(0006eh)		;c562	3a 6e 00 	: n . 
	cp e			;c565	bb 	. 
	jr nc,lc52eh		;c566	30 c6 	0 . 
	ld a,(00075h)		;c568	3a 75 00 	: u . 
	ld (0007dh),a		;c56b	32 7d 00 	2 } . 
	inc a			;c56e	3c 	< 
	ld b,a			;c56f	47 	G 
	ld a,(0006fh)		;c570	3a 6f 00 	: o . 
	cp b			;c573	b8 	. 
	jr c,lc57eh		;c574	38 08 	8 . 
	ld a,b			;c576	78 	x 
	ld (00075h),a		;c577	32 75 00 	2 u . 
	ld e,001h		;c57a	1e 01 	. . 
	jr lc52eh		;c57c	18 b0 	. . 
lc57eh:
	dec e			;c57e	1d 	. 
	call sub_c5f2h		;c57f	cd f2 c5 	. . . 
	call sub_c806h		;c582	cd 06 c8 	. . . 
	defb	"Next memory"
	ld a,(0fda0h)		;c590	3a a0 fd 	: . . 
	push hl			;c593	e5 	. 
	pop hl			;c594	e1 	. 
	call sub_c7e2h		;c595	cd e2 c7 	. . . 
	call sub_c806h		;c598	cd 06 c8 	. . . 
	defb	0x0d,"End of Disk",0x8d
	jp lc155h		;c5a8	c3 55 c1 	. U . 
lc5abh:
	ld hl,0007eh		;c5ab	21 7e 00 	! ~ . 
	ld b,(hl)		;c5ae	46 	F 
	push bc			;c5af	c5 	. 
	set 1,(hl)		;c5b0	cb ce 	. . 
	call sub_cd5fh		;c5b2	cd 5f cd 	. _ . 
	pop bc			;c5b5	c1 	. 
	ld a,b			;c5b6	78 	x 
	ld (0007eh),a		;c5b7	32 7e 00 	2 ~ . 
	ret			;c5ba	c9 	. 
sub_c5bbh:
	ld a,(0006ch)		;c5bb	3a 6c 00 	: l . 
	or a			;c5be	b7 	. 
	jp z,lc1bdh		;c5bf	ca bd c1 	. . . 
	inc de			;c5c2	13 	. 
	call sub_c82fh		;c5c3	cd 2f c8 	. / . 
	xor a			;c5c6	af 	. 
	or d			;c5c7	b2 	. 
lc5c8h:
	jp nz,lc1bdh		;c5c8	c2 bd c1 	. . . 
	or e			;c5cb	b3 	. 
	jp z,lc1bdh		;c5cc	ca bd c1 	. . . 
	push bc			;c5cf	c5 	. 
	push de			;c5d0	d5 	. 
	push hl			;c5d1	e5 	. 
	call sub_c5f8h		;c5d2	cd f8 c5 	. . . 
	pop hl			;c5d5	e1 	. 
	pop de			;c5d6	d1 	. 
	pop bc			;c5d7	c1 	. 
	ld a,(0006eh)		;c5d8	3a 6e 00 	: n . 
	cp e			;c5db	bb 	. 
	jr c,lc5c8h		;c5dc	38 ea 	8 . 
sub_c5deh:
	in a,(031h)		;c5de	db 31 	. 1 
	ld d,a			;c5e0	57 	W 
	ex de,hl		;c5e1	eb 	. 
	call sub_c7fch		;c5e2	cd fc c7 	. . . 
	call sub_c7e2h		;c5e5	cd e2 c7 	. . . 
lc5e8h:
	ex de,hl		;c5e8	eb 	. 
	call sub_c7fch		;c5e9	cd fc c7 	. . . 
	ld a,(00078h)		;c5ec	3a 78 00 	: x . 
	jp lc7f0h		;c5ef	c3 f0 c7 	. . . 
sub_c5f2h:
	call sub_c5deh		;c5f2	cd de c5 	. . . 
	jp lcc97h		;c5f5	c3 97 cc 	. . . 
sub_c5f8h:
	ld a,(00075h)		;c5f8	3a 75 00 	: u . 
	or a			;c5fb	b7 	. 
	jr nz,sub_c61eh		;c5fc	20 20 	    
	ld a,(00078h)		;c5fe	3a 78 00 	: x . 
	or a			;c601	b7 	. 
	jr nz,sub_c61eh		;c602	20 1a 	  . 
sub_c604h:
	ld a,(0007eh)		;c604	3a 7e 00 	: ~ . 
	bit 5,a			;c607	cb 6f 	. o 
	ret nz			;c609	c0 	. 
	bit 1,a			;c60a	cb 4f 	. O 
	jr nz,lc611h		;c60c	20 03 	  . 
	bit 0,a			;c60e	cb 47 	. G 
lc610h:
	ret z			;c610	c8 	. 
lc611h:
	ld (0007fh),a		;c611	32 7f 00 	2  . 
	set 5,a			;c614	cb ef 	. . 
	res 0,a			;c616	cb 87 	. . 
	ld (0007eh),a		;c618	32 7e 00 	2 ~ . 
	jp lc39bh		;c61b	c3 9b c3 	. . . 
sub_c61eh:
	ld a,(0007eh)		;c61e	3a 7e 00 	: ~ . 
	bit 5,a			;c621	cb 6f 	. o 
	ret z			;c623	c8 	. 
	ld a,(0007fh)		;c624	3a 7f 00 	:  . 
	jp lc387h		;c627	c3 87 c3 	. . . 
	call sub_c853h		;c62a	cd 53 c8 	. S . 
	ld c,l			;c62d	4d 	M 
	in a,(c)		;c62e	ed 78 	. x 
	call sub_c7e7h		;c630	cd e7 c7 	. . . 
	jp lcc97h		;c633	c3 97 cc 	. . . 
	call sub_c8adh		;c636	cd ad c8 	. . . 
	push hl			;c639	e5 	. 
	call sub_c81bh		;c63a	cd 1b c8 	. . . 
	call sub_c853h		;c63d	cd 53 c8 	. S . 
	pop de			;c640	d1 	. 
	ld c,l			;c641	4d 	M 
	out (c),e		;c642	ed 59 	. Y 
	ret			;c644	c9 	. 
sub_c645h:
	call sub_c82fh		;c645	cd 2f c8 	. / . 
	push bc			;c648	c5 	. 
	push de			;c649	d5 	. 
	push hl			;c64a	e5 	. 
	ldir			;c64b	ed b0 	. . 
	pop hl			;c64d	e1 	. 
	pop de			;c64e	d1 	. 
	pop bc			;c64f	c1 	. 
	jr lc655h		;c650	18 03 	. . 
	call sub_c82fh		;c652	cd 2f c8 	. / . 
lc655h:
	ld a,(de)		;c655	1a 	. 
	cp (hl)			;c656	be 	. 
	jr z,lc672h		;c657	28 19 	( . 
	call sub_c7e2h		;c659	cd e2 c7 	. . . 
	ld a,(hl)		;c65c	7e 	~ 
	call sub_c7dbh		;c65d	cd db c7 	. . . 
	call sub_c7fch		;c660	cd fc c7 	. . . 
	ld a,(de)		;c663	1a 	. 
	call sub_c7dbh		;c664	cd db c7 	. . . 
	call sub_c7fch		;c667	cd fc c7 	. . . 
	ex de,hl		;c66a	eb 	. 
	call sub_c7e2h		;c66b	cd e2 c7 	. . . 
	ex de,hl		;c66e	eb 	. 
	call lcc97h		;c66f	cd 97 cc 	. . . 
lc672h:
	inc de			;c672	13 	. 
	inc hl			;c673	23 	# 
	dec bc			;c674	0b 	. 
	ld a,b			;c675	78 	x 
	or c			;c676	b1 	. 
	jr nz,lc655h		;c677	20 dc 	  . 
	ret			;c679	c9 	. 
	call sub_c814h		;c67a	cd 14 c8 	. . . 
	cp 04dh			;c67d	fe 4d 	. M 
	jp nz,lc4a1h		;c67f	c2 a1 c4 	. . . 
	inc de			;c682	13 	. 
	ld hl,(00064h)		;c683	2a 64 00 	* d . 
	call sub_c85bh		;c686	cd 5b c8 	. [ . 
lc689h:
	call sub_c7e2h		;c689	cd e2 c7 	. . . 
	ld a,(hl)			;c68c	7e 	~ 
	call sub_c7dbh		;c68d	cd db c7 	. . . 
	call sub_c7fch		;c690	cd fc c7 	. . . 
	call sub_c7a3h		;c693	cd a3 c7 	. . . 
	call sub_c814h		;c696	cd 14 c8 	. . . 
	cp 02eh			;c699	fe 2e 	. . 
	ret z			;c69b	c8 	. 
	cp 02dh			;c69c	fe 2d 	. - 
	jr nz,lc6a3h		;c69e	20 03 	  . 
	dec hl			;c6a0	2b 	+ 
	jr lc6bdh		;c6a1	18 1a 	. . 
lc6a3h:
	call sub_c6f1h		;c6a3	cd f1 c6 	. . . 
	jr nc,lc6afh		;c6a6	30 07 	0 . 
	call sub_c806h		;c6a8	cd 06 c8 	. . . 
	ccf			;c6ab	3f 	? 
	adc a,l			;c6ac	8d 	. 
	jr lc689h		;c6ad	18 da 	. . 
lc6afh:
	xor a			;c6af	af 	. 
	add a,b			;c6b0	80 	. 
	jr nz,lc6b6h		;c6b1	20 03 	  . 
	inc hl			;c6b3	23 	# 
	jr lc6bdh		;c6b4	18 07 	. . 
lc6b6h:
	ld c,b			;c6b6	48 	H 
	ld b,000h		;c6b7	06 00 	. . 
	ex de,hl		;c6b9	eb 	. 
	ldir			;c6ba	ed b0 	. . 
	ex de,hl		;c6bc	eb 	. 
lc6bdh:
	ld (00064h),hl		;c6bd	22 64 00 	" d . 
	jr lc689h		;c6c0	18 c7 	. . 
	call sub_c865h		;c6c2	cd 65 c8 	. e . 
	push bc			;c6c5	c5 	. 
	call sub_c6f1h		;c6c6	cd f1 c6 	. . . 
	pop de			;c6c9	d1 	. 
	jp c,lc1bdh		;c6ca	da bd c1 	. . . 
	xor a			;c6cd	af 	. 
	add a,b			;c6ce	80 	. 
	jp z,lc1bdh		;c6cf	ca bd c1 	. . . 
lc6d2h:
	push bc			;c6d2	c5 	. 
	push de			;c6d3	d5 	. 
	push hl			;c6d4	e5 	. 
	ld de,0002eh		;c6d5	11 2e 00 	. . . 
lc6d8h:
	ld a,(de)		;c6d8	1a 	. 
	cp (hl)			;c6d9	be 	. 
	jr nz,lc6e0h		;c6da	20 04 	  . 
	inc de			;c6dc	13 	. 
	inc hl			;c6dd	23 	# 
	djnz lc6d8h		;c6de	10 f8 	. . 
lc6e0h:
	pop hl			;c6e0	e1 	. 
	push hl			;c6e1	e5 	. 
	ld b,010h		;c6e2	06 10 	. . 
	call z,sub_c760h	;c6e4	cc 60 c7 	. ` . 
	pop hl			;c6e7	e1 	. 
	pop de			;c6e8	d1 	. 
	pop bc			;c6e9	c1 	. 
	inc hl			;c6ea	23 	# 
	dec de			;c6eb	1b 	. 
	ld a,d			;c6ec	7a 	z 
	or e			;c6ed	b3 	. 
	jr nz,lc6d2h		;c6ee	20 e2 	  . 
	ret			;c6f0	c9 	. 
sub_c6f1h:
	push hl			;c6f1	e5 	. 
	ld b,000h		;c6f2	06 00 	. . 
	ld hl,0002eh		;c6f4	21 2e 00 	! . . 
lc6f7h:
	call sub_c814h		;c6f7	cd 14 c8 	. . . 
	or a			;c6fa	b7 	. 
	jr z,lc726h		;c6fb	28 29 	( ) 
	cp 02ch			;c6fd	fe 2c 	. , 
	inc de			;c6ff	13 	. 
	jr z,lc6f7h		;c700	28 f5 	( . 
	ld c,a			;c702	4f 	O 
	cp 027h			;c703	fe 27 	. ' 
	jr z,lc719h		;c705	28 12 	( . 
	cp 022h			;c707	fe 22 	. " 
	jr z,lc719h		;c709	28 0e 	( . 
	dec de			;c70b	1b 	. 
	push hl			;c70c	e5 	. 
	call sub_c8adh		;c70d	cd ad c8 	. . . 
	ld a,l			;c710	7d 	} 
	pop hl			;c711	e1 	. 
	jr c,lc726h		;c712	38 12 	8 . 
	ld (hl),a		;c714	77 	w 
	inc hl			;c715	23 	# 
	inc b			;c716	04 	. 
	jr lc6f7h		;c717	18 de 	. . 
lc719h:
	ld a,(de)		;c719	1a 	. 
	inc de			;c71a	13 	. 
	or a			;c71b	b7 	. 
	jr z,lc726h		;c71c	28 08 	( . 
	cp c			;c71e	b9 	. 
	jr z,lc6f7h		;c71f	28 d6 	( . 
	ld (hl),a		;c721	77 	w 
	inc hl			;c722	23 	# 
	inc b			;c723	04 	. 
	jr lc719h		;c724	18 f3 	. . 
lc726h:
	ld de,0002eh		;c726	11 2e 00 	. . . 
	pop hl			;c729	e1 	. 
	ret			;c72a	c9 	. 
	call sub_c814h		;c72b	cd 14 c8 	. . . 
	cp 04dh			;c72e	fe 4d 	. M 
	jr nz,lc733h		;c730	20 01 	  . 
	inc de			;c732	13 	. 
lc733h:
	ld bc,00080h		;c733	01 80 00 	. . . 
	ld hl,(00062h)		;c736	2a 62 00 	* b . 
	call sub_c84eh		;c739	cd 4e c8 	. N . 
lc73ch:
	ld e,010h		;c73c	1e 10 	. . 
	xor a			;c73e	af 	. 
	or b			;c73f	b0 	. 
	jr nz,lc74ch		;c740	20 0a 	  . 
	ld a,00fh		;c742	3e 0f 	> . 
	cp c			;c744	b9 	. 
	jr c,lc74ch		;c745	38 05 	8 . 
	xor a			;c747	af 	. 
	or c			;c748	b1 	. 
	jr z,lc74ch		;c749	28 01 	( . 
	ld e,c			;c74b	59 	Y 
lc74ch:
	push bc			;c74c	c5 	. 
	ld b,e			;c74d	43 	C 
	call sub_c760h		;c74e	cd 60 c7 	. ` . 
	ld (00062h),hl		;c751	22 62 00 	" b . 
	pop bc			;c754	c1 	. 
	ld a,c			;c755	79 	y 
	sub e			;c756	93 	. 
	ld c,a			;c757	4f 	O 
	jr nc,lc75bh		;c758	30 01 	0 . 
	dec b			;c75a	05 	. 
lc75bh:
	ld a,b			;c75b	78 	x 
	or c			;c75c	b1 	. 
	jr nz,lc73ch		;c75d	20 dd 	  . 
	ret			;c75f	c9 	. 
sub_c760h:
	call sub_c7e2h		;c760	cd e2 c7 	. . . 
	push bc			;c763	c5 	. 
	push hl			;c764	e5 	. 
	push de			;c765	d5 	. 
	ld c,000h		;c766	0e 00 	. . 
	ld e,004h		;c768	1e 04 	. . 
lc76ah:
	ld a,003h		;c76a	3e 03 	> . 
	and c			;c76c	a1 	. 
	call z,sub_c7a0h	;c76d	cc a0 c7 	. . . 
	call sub_c7a0h		;c770	cd a0 c7 	. . . 
	ld a,(hl)		;c773	7e 	~ 
	call sub_c7e7h		;c774	cd e7 c7 	. . . 
	inc e			;c777	1c 	. 
	inc e			;c778	1c 	. 
	inc hl			;c779	23 	# 
	inc c			;c77a	0c 	. 
	djnz lc76ah		;c77b	10 ed 	. . 
lc77dh:
	call sub_c7a0h		;c77d	cd a0 c7 	. . . 
	ld a,03ah		;c780	3e 3a 	> : 
	cp e			;c782	bb 	. 
	jr nz,lc77dh		;c783	20 f8 	  . 
	pop de			;c785	d1 	. 
	pop hl			;c786	e1 	. 
	pop bc			;c787	c1 	. 
lc788h:
	ld a,(hl)		;c788	7e 	~ 
	inc hl			;c789	23 	# 
	call sub_c792h		;c78a	cd 92 c7 	. . . 
	djnz lc788h		;c78d	10 f9 	. . 
	jp lcc97h		;c78f	c3 97 cc 	. . . 
sub_c792h:
	and 07fh		;c792	e6 7f 	.  
	cp 07fh			;c794	fe 7f 	.  
	jr z,lc79ch		;c796	28 04 	( . 
	cp 020h			;c798	fe 20 	.   
	jr nc,lc7feh		;c79a	30 62 	0 b 
lc79ch:
	ld a,02eh		;c79c	3e 2e 	> . 
	jr lc7feh		;c79e	18 5e 	. ^ 
sub_c7a0h:
	inc e			;c7a0	1c 	. 
	jr sub_c7fch		;c7a1	18 59 	. Y 
sub_c7a3h:
	ld a,031h		;c7a3	3e 31 	> 1 
	ld de,0002eh		;c7a5	11 2e 00 	. . . 
	ld (de),a		;c7a8	12 	. 
	push de			;c7a9	d5 	. 
	call lcbeah		;c7aa	cd ea cb 	. . . 
	ex (sp),hl		;c7ad	e3 	. 
	inc hl			;c7ae	23 	# 
	ld b,(hl)		;c7af	46 	F 
	inc b			;c7b0	04 	. 
	inc hl			;c7b1	23 	# 
	push hl			;c7b2	e5 	. 
lc7b3h:
	dec b			;c7b3	05 	. 
	jr z,lc7cdh		;c7b4	28 17 	( . 
	ld a,(hl)		;c7b6	7e 	~ 
	call sub_c7d2h		;c7b7	cd d2 c7 	. . . 
	ld (hl),a		;c7ba	77 	w 
	inc hl			;c7bb	23 	# 
	cp 022h			;c7bc	fe 22 	. " 
	jr z,lc7c4h		;c7be	28 04 	( . 
	cp 027h			;c7c0	fe 27 	. ' 
	jr nz,lc7b3h		;c7c2	20 ef 	  . 
lc7c4h:
	dec b			;c7c4	05 	. 
	jr z,lc7cdh		;c7c5	28 06 	( . 
	cp (hl)			;c7c7	be 	. 
	inc hl			;c7c8	23 	# 
	jr nz,lc7c4h		;c7c9	20 f9 	  . 
	jr lc7b3h		;c7cb	18 e6 	. . 
lc7cdh:
	ld (hl),000h		;c7cd	36 00 	6 . 
	pop de			;c7cf	d1 	. 
	pop hl			;c7d0	e1 	. 
	ret			;c7d1	c9 	. 
sub_c7d2h:
	cp 061h			;c7d2	fe 61 	. a 
	ret c			;c7d4	d8 	. 
	cp 07bh			;c7d5	fe 7b 	. { 
	ret nc			;c7d7	d0 	. 
	sub 020h		;c7d8	d6 20 	.   
	ret			;c7da	c9 	. 
sub_c7dbh:
	push af			;c7db	f5 	. 
	call sub_c7fch		;c7dc	cd fc c7 	. . . 
	pop af			;c7df	f1 	. 
	jr sub_c7e7h		;c7e0	18 05 	. . 
sub_c7e2h:
	ld a,h			;c7e2	7c 	| 
	call sub_c7e7h		;c7e3	cd e7 c7 	. . . 
	ld a,l			;c7e6	7d 	} 
sub_c7e7h:
	push af			;c7e7	f5 	. 
	rra			;c7e8	1f 	. 
	rra			;c7e9	1f 	. 
	rra			;c7ea	1f 	. 
	rra			;c7eb	1f 	. 
	call lc7f0h		;c7ec	cd f0 c7 	. . . 
	pop af			;c7ef	f1 	. 
lc7f0h:
	and 00fh		;c7f0	e6 0f 	. . 
	cp 00ah			;c7f2	fe 0a 	. . 
	jr c,lc7f8h		;c7f4	38 02 	8 . 
	add a,007h		;c7f6	c6 07 	. . 
lc7f8h:
	add a,030h		;c7f8	c6 30 	. 0 
	jr lc7feh		;c7fa	18 02 	. . 
sub_c7fch:
	ld a,020h		;c7fc	3e 20 	>   
lc7feh:
	push af			;c7fe	f5 	. 
	and 07fh		;c7ff	e6 7f 	.  
	call sub_cc99h		;c801	cd 99 cc 	. . . 
	pop af			;c804	f1 	. 
	ret			;c805	c9 	. 
sub_c806h:
	ex (sp),hl		;c806	e3 	. 
lc807h:
	ld a,(hl)		;c807	7e 	~ 
	inc hl			;c808	23 	# 
	or a			;c809	b7 	. 
	jr z,lc812h		;c80a	28 06 	( . 
	call lc7feh		;c80c	cd fe c7 	. . . 
	jp p,lc807h		;c80f	f2 07 c8 	. . . 
lc812h:
	ex (sp),hl		;c812	e3 	. 
	ret			;c813	c9 	. 
sub_c814h:
	ld a,(de)		;c814	1a 	. 
	cp 020h			;c815	fe 20 	.   
	ret nz			;c817	c0 	. 
	inc de			;c818	13 	. 
	jr sub_c814h		;c819	18 f9 	. . 
sub_c81bh:
	call sub_c814h		;c81b	cd 14 c8 	. . . 
	cp 02ch			;c81e	fe 2c 	. , 
	ret nz			;c820	c0 	. 
	inc de			;c821	13 	. 
	call sub_c814h		;c822	cd 14 c8 	. . . 
	xor a			;c825	af 	. 
	ret			;c826	c9 	. 
sub_c827h:
	call sub_c814h		;c827	cd 14 c8 	. . . 
	or a			;c82a	b7 	. 
	ret z			;c82b	c8 	. 
	jp lc1bdh		;c82c	c3 bd c1 	. . . 
sub_c82fh:
	ld hl,00080h		;c82f	21 80 00 	! . . 
	ld b,h			;c832	44 	D 
	ld c,l			;c833	4d 	M 
	call sub_c868h		;c834	cd 68 c8 	. h . 
	push hl			;c837	e5 	. 
	push bc			;c838	c5 	. 
	call sub_c81bh		;c839	cd 1b c8 	. . . 
	call sub_c8adh		;c83c	cd ad c8 	. . . 
	jp c,lc1bdh		;c83f	da bd c1 	. . . 
	call sub_c827h		;c842	cd 27 c8 	. ' . 
	ex de,hl		;c845	eb 	. 
	pop bc			;c846	c1 	. 
	pop hl			;c847	e1 	. 
	ret			;c848	c9 	. 
	call sub_c865h		;c849	cd 65 c8 	. e . 
	jr sub_c827h		;c84c	18 d9 	. . 
sub_c84eh:
	call sub_c868h		;c84e	cd 68 c8 	. h . 
	jr sub_c827h		;c851	18 d4 	. . 
sub_c853h:
	call sub_c8adh		;c853	cd ad c8 	. . . 
	jp c,lc1bdh		;c856	da bd c1 	. . . 
	jr sub_c827h		;c859	18 cc 	. . 
sub_c85bh:
	push hl			;c85b	e5 	. 
	call sub_c8adh		;c85c	cd ad c8 	. . . 
	jr c,lc862h		;c85f	38 01 	8 . 
	ex (sp),hl		;c861	e3 	. 
lc862h:
	pop hl			;c862	e1 	. 
	jr sub_c827h		;c863	18 c2 	. . 
sub_c865h:
	scf			;c865	37 	7 
	jr lc869h		;c866	18 01 	. . 
sub_c868h:
	or a			;c868	b7 	. 
lc869h:
	ex af,af'		;c869	08 	. 
	push bc			;c86a	c5 	. 
	push hl			;c86b	e5 	. 
	call sub_c8adh		;c86c	cd ad c8 	. . . 
	jr nc,lc879h		;c86f	30 08 	0 . 
	ex af,af'		;c871	08 	. 
	jp c,lc1bdh		;c872	da bd c1 	. . . 
	ex af,af'		;c875	08 	. 
	pop hl			;c876	e1 	. 
	jr lc87ah		;c877	18 01 	. . 
lc879h:
	pop af			;c879	f1 	. 
lc87ah:
	call sub_c887h		;c87a	cd 87 c8 	. . . 
	jr nc,lc885h		;c87d	30 06 	0 . 
	ex af,af'			;c87f	08 	. 
	pop bc			;c880	c1 	. 
	ret nc			;c881	d0 	. 
	jp lc1bdh		;c882	c3 bd c1 	. . . 
lc885h:
	pop af			;c885	f1 	. 
	ret			;c886	c9 	. 
sub_c887h:
	call sub_c81bh		;c887	cd 1b c8 	. . . 
	ld a,(de)		;c88a	1a 	. 
	cp 053h			;c88b	fe 53 	. S 
	jr nz,lc890h		;c88d	20 01 	  . 
	inc de			;c88f	13 	. 
lc890h:
	push hl			;c890	e5 	. 
	push af			;c891	f5 	. 
	call sub_c8adh		;c892	cd ad c8 	. . . 
	jr c,lc8a6h		;c895	38 0f 	8 . 
	ld b,h			;c897	44 	D 
	ld c,l			;c898	4d 	M 
	pop af			;c899	f1 	. 
	pop hl			;c89a	e1 	. 
	jr z,lc8a4h		;c89b	28 07 	( . 
	ld a,c			;c89d	79 	y 
	sub l			;c89e	95 	. 
	ld c,a			;c89f	4f 	O 
	ld a,b			;c8a0	78 	x 
	sbc a,h			;c8a1	9c 	. 
	ld b,a			;c8a2	47 	G 
	inc bc			;c8a3	03 	. 
lc8a4h:
	or a			;c8a4	b7 	. 
	ret			;c8a5	c9 	. 
lc8a6h:
	pop af			;c8a6	f1 	. 
	pop hl			;c8a7	e1 	. 
	jp z,lc1bdh		;c8a8	ca bd c1 	. . . 
	scf			;c8ab	37 	7 
	ret			;c8ac	c9 	. 
sub_c8adh:
	call sub_c814h		;c8ad	cd 14 c8 	. . . 
sub_c8b0h:
	call sub_c8e0h		;c8b0	cd e0 c8 	. . . 
	ret c			;c8b3	d8 	. 
	push de			;c8b4	d5 	. 
lc8b5h:
	inc de			;c8b5	13 	. 
	call sub_c8e0h		;c8b6	cd e0 c8 	. . . 
	jr nc,lc8b5h		;c8b9	30 fa 	0 . 
	pop de			;c8bb	d1 	. 
	cp 02eh			;c8bc	fe 2e 	. . 
	jr z,lc8c5h		;c8be	28 05 	( . 
	call sub_c8cah		;c8c0	cd ca c8 	. . . 
	and a			;c8c3	a7 	. 
	ret			;c8c4	c9 	. 
lc8c5h:
	call sub_c8f4h		;c8c5	cd f4 c8 	. . . 
	and a			;c8c8	a7 	. 
	ret			;c8c9	c9 	. 
sub_c8cah:
	ld hl,00000h		;c8ca	21 00 00 	! . . 
lc8cdh:
	call sub_c8e0h		;c8cd	cd e0 c8 	. . . 
	jr c,lc8dbh		;c8d0	38 09 	8 . 
	add hl,hl		;c8d2	29 	) 
	add hl,hl		;c8d3	29 	) 
	add hl,hl		;c8d4	29 	) 
	add hl,hl		;c8d5	29 	) 
	add a,l			;c8d6	85 	. 
	ld l,a			;c8d7	6f 	o 
	inc de			;c8d8	13 	. 
	jr lc8cdh		;c8d9	18 f2 	. . 
lc8dbh:
	cp 048h			;c8db	fe 48 	. H 
	ret nz			;c8dd	c0 	. 
	inc de			;c8de	13 	. 
	ret			;c8df	c9 	. 
sub_c8e0h:
	ld a,(de)		;c8e0	1a 	. 
	cp 030h			;c8e1	fe 30 	. 0 
	ret c			;c8e3	d8 	. 
	cp 03ah			;c8e4	fe 3a 	. : 
	jr c,lc8f1h		;c8e6	38 09 	8 . 
	cp 041h			;c8e8	fe 41 	. A 
	ret c			;c8ea	d8 	. 
	cp 047h			;c8eb	fe 47 	. G 
	ccf			;c8ed	3f 	? 
	ret c			;c8ee	d8 	. 
	sub 007h		;c8ef	d6 07 	. . 
lc8f1h:
	sub 030h		;c8f1	d6 30 	. 0 
	ret			;c8f3	c9 	. 
sub_c8f4h:
	ld hl,00000h		;c8f4	21 00 00 	! . . 
lc8f7h:
	call sub_c910h		;c8f7	cd 10 c9 	. . . 
	inc de			;c8fa	13 	. 
	jr c,lc90ah		;c8fb	38 0d 	8 . 
	push bc			;c8fd	c5 	. 
	add hl,hl		;c8fe	29 	) 
	ld b,h			;c8ff	44 	D 
	ld c,l			;c900	4d 	M 
	add hl,hl		;c901	29 	) 
	add hl,hl		;c902	29 	) 
	add hl,bc		;c903	09 	. 
	pop bc			;c904	c1 	. 
	call sub_c186h		;c905	cd 86 c1 	. . . 
	jr lc8f7h		;c908	18 ed 	. . 
lc90ah:
	cp 02eh			;c90a	fe 2e 	. . 
	ret z			;c90c	c8 	. 
	jp lc1bdh		;c90d	c3 bd c1 	. . . 
sub_c910h:
	ld a,(de)		;c910	1a 	. 
	cp 030h			;c911	fe 30 	. 0 
	ret c			;c913	d8 	. 
	cp 03ah			;c914	fe 3a 	. : 
	ccf			;c916	3f 	? 
	ret c			;c917	d8 	. 
	sub 030h		;c918	d6 30 	. 0 
	ret			;c91a	c9 	. 
sub_c91bh:
	ld bc,00018h		;c91b	01 18 00 	. . . 
	ld de,00100h		;c91e	11 00 01 	. . . 
	ld hl,lc929h		;c921	21 29 c9 	! ) . 
	ldir			;c924	ed b0 	. . 
	jp 00100h		;c926	c3 00 01 	. . . 
lc929h:
	ld bc,01000h		;c929	01 00 10 	. . . 
	ld de,01000h		;c92c	11 00 10 	. . . 
	ld hl,lc000h		;c92f	21 00 c0 	! . . 
	push bc			;c932	c5 	. 
	push de			;c933	d5 	. 
	push hl			;c934	e5 	. 
	ldir			;c935	ed b0 	. . 
	ld a,001h		;c937	3e 01 	> . 
	out (040h),a		;c939	d3 40 	. @ 
	pop de			;c93b	d1 	. 
	pop hl			;c93c	e1 	. 
	pop bc			;c93d	c1 	. 
	ldir			;c93e	ed b0 	. . 
	ret			;c940	c9 	. 
	call sub_c814h		;c941	cd 14 c8 	. . . 
	cp 05ah			;c944	fe 5a 	. Z 
	push af			;c946	f5 	.  
	jr nz,lc94ah		;c947	20 01 	  .  
	inc de			;c949	13 	.  
lc94ah:
	call sub_c827h		;c94a	cd 27 c8 	. ' . 
	pop af			;c94d	f1 	. 
	call nz,sub_c91bh	;c94e	c4 1b c9 	. . . 
	call sub_c806h		;c951	cd 06 c8 	. . . 
	defb	0x0d,"Memory",0xba
	ld bc,01000h		;c95c	01 00 10 	. . . 
lc95fh:
	call sub_c7fch		;c95f	cd fc c7 	. . . 
	ld a,c			;c962	79 	y 
	call lc7f0h		;c963	cd f0 c7 	. . . 
	inc c			;c966	0c 	. 
	djnz lc95fh		;c967	10 f6 	. . 
	call lcc97h		;c969	cd 97 cc 	. . . 
	ld b,007h		;c96c	06 07 	. . 
lc96eh:
	call sub_c7fch		;c96e	cd fc c7 	. . . 
	djnz lc96eh		;c971	10 fb 	. . 
	ld h,b			;c973	60 	` 
	ld l,b			;c974	68 	h 
lc975h:
	call sub_c7fch		;c975	cd fc c7 	. . . 
	push hl			;c978	e5 	. 
	ld de,01000h		;c979	11 00 10 	. . . 
lc97ch:
	ld a,h			;c97c	7c 	| 
	cp 0c9h			;c97d	fe c9 	. . 
	jr nz,lc98ah		;c97f	20 09 	  . 
	ld a,l			;c981	7d 	} 
	cp 08dh			;c982	fe 8d 	. . 
	jr c,lc98ah		;c984	38 04 	8 . 
	cp 09ch			;c986	fe 9c 	. . 
	jr c,lc99ch		;c988	38 12 	8 . 
lc98ah:
	ld b,(hl)		;c98a	46 	F 
	ld a,055h		;c98b	3e 55 	> U 
	ld (hl),a		;c98d	77 	w 
	cp (hl)			;c98e	be 	. 
	jr nz,lc996h		;c98f	20 05 	  . 
	cpl			;c991	2f 	/ 
	ld (hl),a		;c992	77 	w 
	cp (hl)			;c993	be 	. 
	jr z,lc99bh		;c994	28 05 	( . 
lc996h:
	ld (hl),b		;c996	70 	p 
	ld a,058h		;c997	3e 58 	> X 
	jr lc9a4h		;c999	18 09 	. . 
lc99bh:
	ld (hl),b		;c99b	70 	p 
lc99ch:
	inc hl			;c99c	23 	# 
	dec de			;c99d	1b 	. 
	ld a,d			;c99e	7a 	z 
	or e			;c99f	b3 	. 
	jr nz,lc97ch		;c9a0	20 da 	  . 
	ld a,05eh		;c9a2	3e 5e 	> ^ 
lc9a4h:
	call lc7feh		;c9a4	cd fe c7 	. . . 
	pop hl			;c9a7	e1 	. 
	ld a,010h		;c9a8	3e 10 	> . 
	add a,h			;c9aa	84 	. 
	ld h,a			;c9ab	67 	g 
	jr nz,lc975h		;c9ac	20 c7 	  . 
	call sub_c806h		;c9ae	cd 06 c8 	. . . 
	defb	0x0d,"Specify disk (eg, A; or A;; or A;;;)",0xa0
	call sub_c7a3h		;c9d7	cd a3 c7 	. . . 
	call sub_c814h		;c9da	cd 14 c8 	. . . 
	or a			;c9dd	b7 	. 
	jp z,lcc97h		;c9de	ca 97 cc 	. . . 
	call 0c2c1h		;c9e1	cd c1 c2 	. . . 
	jp nz,lc1b9h		;c9e4	c2 b9 c1 	. . . 
	call sub_c806h		;c9e7	cd 06 c8 	. . . 
	defb	"Seek tests:.",0x8d
	ld	b,15h		;06 	15 	. 
	ld hl,lca20h		;c9f8	21 20 ca 	!   . 
lc9fbh:
	in a,(031h)		;c9fb	db 31 	. 1 
	ld (0007dh),a		;c9fd	32 7d 00 	2 } . 
	ld a,(hl)		;ca00	7e 	~ 
	push bc			;ca01	c5 	. 
	push hl			;ca02	e5 	. 
	cp 0ffh			;ca03	fe ff 	. . 
	jr nz,lca35h		;ca05	20 2e 	  . 
	call sub_c806h		;ca07	cd 06 c8 	. . . 
	defb	" Restore ",0xba
lca13h:
	call sub_c604h		;ca13	cd 04 c6 	. . . 
	call lcd37h		;ca16	cd 37 cd 	. 7 . 
	ex af,af'		;ca19	08 	. 
	call sub_c61eh		;ca1a	cd 1e c6 	. . . 
	ex af,af'		;ca1d	08 	. 
	jr lca4ch		;ca1e	18 2c 	. , 
lca20h:
	ld bc,00302h		;ca20	01 02 03 	. . . 
	inc b			;ca23	04 	. 
	dec b			;ca24	05 	. 
	cp 006h			;ca25	fe 06 	. . 
	rlca			;ca27	07 	. 
	ex af,af'		;ca28	08 	. 
	add hl,bc		;ca29	09 	. 
	nop			;ca2a	00 	. 
	cp 027h			;ca2b	fe 27 	. ' 
	nop			;ca2d	00 	. 
	dec d			;ca2e	15 	. 
	nop			;ca2f	00 	. 
	ld bc,0fffeh		;ca30	01 fe ff 	. . . 
	cp 027h			;ca33	fe 27 	. ' 
lca35h:
	cp 0feh			;ca35	fe fe 	. . 
lca37h:
	jr nz,lca3fh		;ca37	20 06 	  . 
	call lcc97h		;ca39	cd 97 cc 	. . . 
	or a			;ca3c	b7 	. 
	jr lca51h		;ca3d	18 12 	. . 
lca3fh:
	ld (00075h),a		;ca3f	32 75 00 	2 u . 
	call sub_c7dbh		;ca42	cd db c7 	. . . 
	call sub_c806h		;ca45	cd 06 c8 	. . . 
	cp d			;ca48	ba 	. 
	call lc4d4h		;ca49	cd d4 c4 	. . . 
lca4ch:
	push af			;ca4c	f5 	. 
	call sub_cb7ah		;ca4d	cd 7a cb 	. z . 
	pop af			;ca50	f1 	. 
lca51h:
	pop hl			;ca51	e1 	. 
	pop bc			;ca52	c1 	. 
	jp c,lcc97h		;ca53	da 97 cc 	. . . 
	inc hl			;ca56	23 	# 
	djnz lc9fbh		;ca57	10 a2 	. . 
	call sub_c806h		;ca59	cd 06 c8 	. . . 
	defb	0x0d,"Read/Write tests",0x8d
	call sub_cb94h		;ca6e	cd 94 cb 	. . . 
	call sub_cbb0h		;ca71	cd b0 cb 	. . . 
	jp c,lcc97h		;ca74	da 97 cc 	. . . 
	call sub_c806h		;ca77	cd 06 c8 	. . . 
	defb	"Write test MAY DESTROY data",0x0d
	defb	"ESC=abort RETURN-proceed",0xa0
	call sub_c7a3h		;caaf	cd a3 c7 	. . . 
	ld hl,00900h		;cab2	21 00 09 	! . . 
	call sub_cba2h		;cab5	cd a2 cb 	. . . 
	ld bc,00200h		;cab8	01 00 02 	. . . 
lcabbh:
	ld (hl),l		;cabb	75 	u 
	inc hl			;cabc	23 	# 
	dec bc			;cabd	0b 	. 
	ld a,b			;cabe	78 	x 
	or c			;cabf	b1 	. 
	jr nz,lcabbh		;cac0	20 f9 	  . 
	call sub_cbc1h		;cac2	cd c1 cb 	. . . 
	jr nc,lcb35h		;cac5	30 6e 	0 n 
lcac7h:
	call sub_c806h		;cac7	cd 06 c8 	. . . 
	defb	"Test failed!",0x0d
	defb	"Disk data a ",0xf4
	ld	e,1
	call sub_c5deh		;cae5	cd de c5 	. . . 
	call sub_c806h		;cae8	cd 06 c8 	. . . 
	defb	"may have been:", 0x6e
	defb	"destroyed",0x0d
	defb	"Original is located at 0D00",0xf3
	ld hl,(00079h)		;cb20	2a 79 00 	* y . 
	call sub_c7e2h		;cb23	cd e2 c7 	. . . 
	call sub_c806h		;cb26	cd 06 c8 	. . . 
	defb	" in memory",0x8d
	ret			;cb34	c9 	. 
lcb35h:
	ld hl,00b00h		;cb35	21 00 0b 	! . . 
	call sub_cba2h		;cb38	cd a2 cb 	. . . 
	call sub_cbb0h		;cb3b	cd b0 cb 	. . . 
	jr c,lcac7h		;cb3e	38 87 	8 . 
	call sub_c806h		;cb40	cd 06 c8 	. . . 
	defb	"Pattern Compare",0xa0
	ld bc,(00079h)		;cb53	ed 4b 79 00 	. K y . 
	ld de,00900h		;cb57	11 00 09 	. . . 
lcb5ah:
	ld hl,00b00h		;cb5a	21 00 0b 	! . . 
lcb5dh:
	ld a,(de)		;cb5d	1a 	. 
	cp (hl)			;cb5e	be 	. 
lcb5fh:
	jr nz,lcb6ah		;cb5f	20 09 	  . 
	inc de			;cb61	13 	. 
	inc hl			;cb62	23 	# 
	dec bc			;cb63	0b 	. 
	ld a,b			;cb64	78 	x 
	or c			;cb65	b1 	. 
	jr nz,lcb5dh		;cb66	20 f5 	  . 
	jr lcb6bh		;cb68	18 01 	. . 
lcb6ah:
	scf			;cb6a	37 	7 
lcb6bh:
	call sub_cbd1h		;cb6b	cd d1 cb 	. . . 
	call sub_cb94h		;cb6e	cd 94 cb 	. . . 
	call sub_cbc1h		;cb71	cd c1 cb 	. . . 
	jp c,lcac7h		;cb74	da c7 ca 	. . . 
lcb77h:
	jp lcc97h		;cb77	c3 97 cc 	. . . 
sub_cb7ah:
	jr c,lcb82h		;cb7a	38 06 	8 . 
	call sub_c806h		;cb7c	cd 06 c8 	. . . 
	ld c,a			;cb7f	4f 	O 
	set 1,c			;cb80	cb c9 	. . 
lcb82h:
	call sub_c806h		;cb82	cd 06 c8 	. . . 
	defb	"error",0xa0
	ld a,(00071h)		;cb8b	3a 71 00 	: q . 
	call sub_c7e7h		;cb8e	cd e7 c7 	. . . 
	jp lcc97h		;cb91	c3 97 cc 	. . . 
sub_cb94h:
	call sub_c806h		;cb94	cd 06 c8 	. . . 
	defb	"Dat",0xe1
lcb9bh:
	ld hl,00d00h		;cb9b	21 00 0d 	! . . 
lcb9eh:
	ld (0007bh),hl		;cb9e	22 7b 00 	" { . 
	ret			;cba1	c9 	. 
sub_cba2h:
	ld (0007bh),hl		;cba2	22 7b 00 	" { . 
	call sub_c806h		;cba5	cd 06 c8 	. . . 
	defb	"Patter",0xee
	ret
sub_cbb0h:
	call sub_cbdah		;cbb0	cd da cb 	. . . 
	call sub_c806h		;cbb3	cd 06 c8 	. . . 
	defb	" read",0xa0
	call lcd52h		;cbbc	cd 52 cd 	. R . 
	jr sub_cbd1h		;cbbf	18 10 	. . 
sub_cbc1h:
	call sub_cbdah		;cbc1	cd da cb 	. . . 
	call sub_c806h		;cbc4	cd 06 c8 	. . . 
	defb	 " Write",0xa0
	call lc5abh		;cbce	cd ab c5 	. . . 
sub_cbd1h:
	push af			;cbd1	f5 	. 
	call sub_cb7ah		;cbd2	cd 7a cb 	. z . 
	call lcc97h		;cbd5	cd 97 cc 	. . . 
	pop af			;cbd8	f1 	. 
lcbd9h:
	ret			;cbd9	c9 	. 
sub_cbdah:
	ld a,027h		;cbda	3e 27 	> ' 
	ld (00075h),a		;cbdc	32 75 00 	2 u . 
	ld (0007dh),a		;cbdf	32 7d 00 	2 } . 
	ld a,001h		;cbe2	3e 01 	> . 
	ld (00076h),a		;cbe4	32 76 00 	2 v . 
	jp sub_cdcbh		;cbe7	c3 cb cd 	. . . 
lcbeah:
	push bc			;cbea	c5 	. 
	push hl			;cbeb	e5 	. 
lcbech:
	ld b,000h		;cbec	06 00 	. . 
	ld hl,00002h		;cbee	21 02 00 	! . . 
	add hl,de		;cbf1	19 	. 
lcbf2h:
	call sub_cc64h		;cbf2	cd 64 cc 	. d . 
	cp 010h			;cbf5	fe 10 	. . 
	call z,sub_ccbbh	;cbf7	cc bb cc 	. . . 
	jr z,lcbf2h		;cbfa	28 f6 	( . 
	cp 01bh			;cbfc	fe 1b 	. . 
	jp z,lcc8eh		;cbfe	ca 8e cc 	. . . 
	cp 008h			;cc01	fe 08 	. . 
	jr z,lcc09h		;cc03	28 04 	( . 
	cp 07fh			;cc05	fe 7f 	.  
	jr nz,lcc1ah		;cc07	20 11 	  . 
lcc09h:
	xor a			;cc09	af 	. 
	or b			;cc0a	b0 	. 
	jr z,lcbf2h		;cc0b	28 e5 	( . 
	dec hl			;cc0d	2b 	+ 
	dec b			;cc0e	05 	. 
	call sub_cc4bh		;cc0f	cd 4b cc 	. K . 
	ld a,(hl)		;cc12	7e 	~ 
	cp 020h			;cc13	fe 20 	.   
	call c,sub_cc4bh	;cc15	dc 4b cc 	. K . 
	jr lcbf2h		;cc18	18 d8 	. . 
lcc1ah:
	cp 00dh			;cc1a	fe 0d 	. . 
	call z,sub_cc45h	;cc1c	cc 45 cc 	. E . 
	jr z,lcc3ch		;cc1f	28 1b 	( . 
	cp 015h			;cc21	fe 15 	. . 
	jr nz,lcc2dh		;cc23	20 08 	  . 
	call sub_cc45h		;cc25	cd 45 cc 	. E . 
	call lcc97h		;cc28	cd 97 cc 	. . . 
	jr lcbech		;cc2b	18 bf 	. . 
lcc2dh:
	ld c,a			;cc2d	4f 	O 
	ld a,(de)		;cc2e	1a 	. 
	dec a			;cc2f	3d 	= 
	cp b			;cc30	b8 	. 
	jr z,lcbf2h		;cc31	28 bf 	( . 
	ld a,c			;cc33	79 	y 
	call sub_cc45h		;cc34	cd 45 cc 	. E . 
	ld (hl),a		;cc37	77 	w 
	inc hl			;cc38	23 	# 
	inc b			;cc39	04 	. 
	jr lcbf2h		;cc3a	18 b6 	. . 
lcc3ch:
	ld (hl),000h		;cc3c	36 00 	6 . 
	ld a,b			;cc3e	78 	x 
	inc de			;cc3f	13 	. 
lcc40h:
	ld (de),a		;cc40	12 	. 
	dec de			;cc41	1b 	. 
	pop hl			;cc42	e1 	. 
	pop bc			;cc43	c1 	. 
	ret			;cc44	c9 	. 
sub_cc45h:
	push af			;cc45	f5 	. 
	call sub_cc52h		;cc46	cd 52 cc 	. R . 
	pop af			;cc49	f1 	. 
	ret			;cc4a	c9 	. 
sub_cc4bh:
	call sub_c806h		;cc4b	cd 06 c8 	. . . 
	ex af,af'		;cc4e	08 	. 
	jr nz,lcbd9h		;cc4f	20 88 	  . 
	ret			;cc51	c9 	. 
sub_cc52h:
	cp 020h			;cc52	fe 20 	.   
	jr nc,sub_cc99h		;cc54	30 43 	0 C 
	cp 00dh			;cc56	fe 0d 	. . 
	jr z,sub_cc99h		;cc58	28 3f 	( ? 
	push af			;cc5a	f5 	. 
	call sub_c806h		;cc5b	cd 06 c8 	. . . 
	sbc a,0f1h		;cc5e	de f1 	. . 
	add a,040h		;cc60	c6 40 	. @ 
	jr sub_cc99h		;cc62	18 35 	. 5 
sub_cc64h:
	call sub_cd23h		;cc64	cd 23 cd 	. # . 
	call lcc76h		;cc67	cd 76 cc 	. v . 
	jr z,sub_cc64h		;cc6a	28 f8 	( . 
lcc6ch:
	call lcc76h		;cc6c	cd 76 cc 	. v . 
	jr z,lcc6ch		;cc6f	28 fb 	( . 
	in a,(001h)		;cc71	db 01 	. . 
	and 07fh		;cc73	e6 7f 	.  
	ret			;cc75	c9 	. 
lcc76h:
	in a,(000h)		;cc76	db 00 	. . 
	and 040h		;cc78	e6 40 	. @ 
	ret			;cc7a	c9 	. 
sub_cc7bh:
	call lcc76h		;cc7b	cd 76 cc 	. v . 
	ret z			;cc7e	c8 	. 
	call lcc6ch		;cc7f	cd 6c cc 	. l . 
	cp 013h			;cc82	fe 13 	. . 
	call z,lcc6ch		;cc84	cc 6c cc 	. l . 
	cp 00dh			;cc87	fe 0d 	. . 
	jr z,lcc8eh		;cc89	28 03 	( . 
	cp 01bh			;cc8b	fe 1b 	. . 
	ret nz			;cc8d	c0 	. 
lcc8eh:
	ld sp,0002eh		;cc8e	31 2e 00 	1 . . 
	call lcc97h		;cc91	cd 97 cc 	. . . 
	jp lc155h		;cc94	c3 55 c1 	. U . 
lcc97h:
	ld a,00dh		;cc97	3e 0d 	> . 
sub_cc99h:
	push af			;cc99	f5 	. 
	exx			;cc9a	d9 	. 
	bit 7,b			;cc9b	cb 78 	. x 
	exx			;cc9d	d9 	. 
	call nz,sub_cccbh	;cc9e	c4 cb cc 	. . . 
	call sub_cd23h		;cca1	cd 23 cd 	. # . 
lcca4h:
	in a,(000h)		;cca4	db 00 	. . 
	and 080h		;cca6	e6 80 	. . 
	jr z,lcca4h		;cca8	28 fa 	( . 
	pop af			;ccaa	f1 	. 
	out (001h),a		;ccab	d3 01 	. . 
	cp 00dh			;ccad	fe 0d 	. . 
	ret nz			;ccaf	c0 	. 
	ld a,00ah		;ccb0	3e 0a 	> . 
	call sub_cc99h		;ccb2	cd 99 cc 	. . . 
	call sub_cc7bh		;ccb5	cd 7b cc 	. { . 
	cp 010h			;ccb8	fe 10 	. . 
	ret nz			;ccba	c0 	. 
sub_ccbbh:
	push af			;ccbb	f5 	. 
	exx			;ccbc	d9 	. 
	ld a,080h		;ccbd	3e 80 	> . 
	xor b			;ccbf	a8 	. 
	ld b,a			;ccc0	47 	G 
	bit 7,b			;ccc1	cb 78 	. x 
	exx			;ccc3	d9 	. 
	call nz,sub_ccc9h	;ccc4	c4 c9 cc 	. . . 
	pop af			;ccc7	f1 	. 
	ret			;ccc8	c9 	. 
sub_ccc9h:
	ld a,011h		;ccc9	3e 11 	> . 
sub_cccbh:
	push af			;cccb	f5 	. 
	push hl			;cccc	e5 	. 
	ld hl,00008h		;cccd	21 08 00 	! . . 
	call sub_cff1h		;ccd0	cd f1 cf 	. . . 
	pop hl			;ccd3	e1 	. 
	pop af			;ccd4	f1 	. 
	push af			;ccd5	f5 	. 
	cp 011h			;ccd6	fe 11 	. . 
	jr z,lccedh		;ccd8	28 13 	( . 
lccdah:
	call sub_cc7bh		;ccda	cd 7b cc 	. { . 
	cp 010h			;ccdd	fe 10 	. . 
	jr nz,lcce6h		;ccdf	20 05 	  . 
	call sub_ccbbh		;cce1	cd bb cc 	. . . 
	pop af			;cce4	f1 	. 
	ret			;cce5	c9 	. 
lcce6h:
	in a,(054h)		;cce6	db 54 	. T 
	cpl			;cce8	2f 	/ 
	and 020h		;cce9	e6 20 	.   
	jr z,lccdah		;cceb	28 ed 	( . 
lccedh:
	pop af			;cced	f1 	. 
	set 7,a			;ccee	cb ff 	. . 
	out (054h),a		;ccf0	d3 54 	. T 
	res 7,a			;ccf2	cb bf 	. . 
	out (054h),a		;ccf4	d3 54 	. T 
	set 7,a			;ccf6	cb ff 	. . 
	out (054h),a		;ccf8	d3 54 	. T 
	res 7,a			;ccfa	cb bf 	. . 
	ret			;ccfc	c9 	. 
	call sub_c814h		;ccfd	cd 14 c8 	. . . 
	cp 04fh			;cd00	fe 4f 	. O 
	jp nz,lc1bdh		;cd02	c2 bd c1 	. . . 
	inc de			;cd05	13 	. 
	ld a,(de)		;cd06	1a 	. 
	cp 04eh			;cd07	fe 4e 	. N 
	jr z,lcd19h		;cd09	28 0e 	( . 
	cp 046h			;cd0b	fe 46 	. F 
	jp nz,lc1bdh		;cd0d	c2 bd c1 	. . . 
	exx			;cd10	d9 	. 
	res 5,b			;cd11	cb a8 	. . 
	exx			;cd13	d9 	. 
	ld a,0ffh		;cd14	3e ff 	> . 
	out (004h),a		;cd16	d3 04 	. . 
	ret			;cd18	c9 	. 
lcd19h:
	exx			;cd19	d9 	. 
	set 5,b			;cd1a	cb e8 	. . 
	exx			;cd1c	d9 	. 
	ld a,001h		;cd1d	3e 01 	> . 
	ld (00072h),a		;cd1f	32 72 00 	2 r . 
	ret			;cd22	c9 	. 
sub_cd23h:
	exx			;cd23	d9 	. 
	bit 5,b			;cd24	cb 68 	. h 
	exx			;cd26	d9 	. 
	ret z			;cd27	c8 	. 
	push bc			;cd28	c5 	. 
	call sub_cfa8h		;cd29	cd a8 cf 	. . . 
	pop bc			;cd2c	c1 	. 
	out (034h),a		;cd2d	d3 34 	. 4 
	call sub_cfd6h		;cd2f	cd d6 cf 	. . . 
	xor 0a0h		;cd32	ee a0 	. . 
	out (004h),a		;cd34	d3 04 	. . 
	ret			;cd36	c9 	. 
lcd37h:
	ld d,002h		;cd37	16 02 	. . 
lcd39h:
	push de			;cd39	d5 	. 
	call sub_cd70h		;cd3a	cd 70 cd 	. p . 
	pop de			;cd3d	d1 	. 
	ret nc			;cd3e	d0 	. 
	push de			;cd3f	d5 	. 
	ld a,00ah		;cd40	3e 0a 	> . 
	ld (00075h),a		;cd42	32 75 00 	2 u . 
	call sub_cdcbh		;cd45	cd cb cd 	. . . 
	call sub_cd70h		;cd48	cd 70 cd 	. p . 
	pop de			;cd4b	d1 	. 
	ret nc			;cd4c	d0 	. 
	dec d			;cd4d	15 	. 
	jr nz,lcd39h		;cd4e	20 e9 	  . 
	jr lcd6ah		;cd50	18 18 	. . 
lcd52h:
	ld d,00ah		;cd52	16 0a 	. . 
lcd54h:
	push de			;cd54	d5 	. 
	call sub_ce58h		;cd55	cd 58 ce 	. X . 
	pop de			;cd58	d1 	. 
	ret nc			;cd59	d0 	. 
	dec d			;cd5a	15 	. 
	jr nz,lcd54h		;cd5b	20 f7 	  . 
	jr lcd6ah		;cd5d	18 0b 	. . 
sub_cd5fh:
	ld d,004h		;cd5f	16 04 	. . 
lcd61h:
	push de			;cd61	d5 	. 
	call sub_ce9fh		;cd62	cd 9f ce 	. . . 
	pop de			;cd65	d1 	. 
	ret nc			;cd66	d0 	. 
	dec d			;cd67	15 	. 
	jr nz,lcd61h		;cd68	20 f7 	  . 
lcd6ah:
	ld a,(00071h)		;cd6a	3a 71 00 	: q . 
	ld c,a			;cd6d	4f 	O 
	scf			;cd6e	37 	7 
	ret			;cd6f	c9 	. 
sub_cd70h:
	sub a			;cd70	97 	. 
	ld (00075h),a		;cd71	32 75 00 	2 u . 
	ld (00078h),a		;cd74	32 78 00 	2 x . 
	call sub_cf55h		;cd77	cd 55 cf 	. U . 
	out (034h),a		;cd7a	d3 34 	. 4 
	call sub_ce25h		;cd7c	cd 25 ce 	. % . 
	jr c,lcd8fh		;cd7f	38 0e 	8 . 
	out (030h),a		;cd81	d3 30 	. 0 
lcd83h:
	in a,(034h)		;cd83	db 34 	. 4 
	bit 2,a			;cd85	cb 57 	. W 
	jr nz,lcdc4h		;cd87	20 3b 	  ; 
	rra			;cd89	1f 	. 
	jr nc,lcd83h		;cd8a	30 f7 	0 . 
	jp lce3eh		;cd8c	c3 3e ce 	. > . 
lcd8fh:
	ld a,0c4h		;cd8f	3e c4 	> . 
	out (030h),a		;cd91	d3 30 	. 0 
	call sub_cfd6h		;cd93	cd d6 cf 	. . . 
	and 057h		;cd96	e6 57 	. W 
	out (004h),a		;cd98	d3 04 	. . 
	call sub_cfe4h		;cd9a	cd e4 cf 	. . . 
lcd9dh:
	in a,(004h)		;cd9d	db 04 	. . 
	and 040h		;cd9f	e6 40 	. @ 
	jr nz,lcdb9h		;cda1	20 16 	  . 
	call sub_cfcfh		;cda3	cd cf cf 	. . . 
lcda6h:
	in a,(034h)		;cda6	db 34 	. 4 
	bit 2,a			;cda8	cb 57 	. W 
	jr nz,lcdc4h		;cdaa	20 18 	  . 
	rra			;cdac	1f 	. 
	jr nc,lcda6h		;cdad	30 f7 	0 . 
	ld a,0d0h		;cdaf	3e d0 	> . 
	out (030h),a		;cdb1	d3 30 	. 0 
	sub a			;cdb3	97 	. 
	out (031h),a		;cdb4	d3 31 	. 1 
	jp lce50h		;cdb6	c3 50 ce 	. P . 
lcdb9h:
	in a,(034h)		;cdb9	db 34 	. 4 
	bit 2,a			;cdbb	cb 57 	. W 
	jr nz,lcdc4h		;cdbd	20 05 	  . 
	rra			;cdbf	1f 	. 
	jr nc,lcd9dh		;cdc0	30 db 	0 . 
	jr lcd8fh		;cdc2	18 cb 	. . 
lcdc4h:
	ld a,080h		;cdc4	3e 80 	> . 
	ld (00071h),a		;cdc6	32 71 00 	2 q . 
	scf			;cdc9	37 	7 
	ret			;cdca	c9 	. 
sub_cdcbh:
	sub a			;cdcb	97 	. 
	call sub_cf55h		;cdcc	cd 55 cf 	. U . 
	out (034h),a		;cdcf	d3 34 	. 4 
	ld a,(00075h)		;cdd1	3a 75 00 	: u . 
	out (033h),a		;cdd4	d3 33 	. 3 
	ld c,a			;cdd6	4f 	O 
	ld a,(00076h)		;cdd7	3a 76 00 	: v . 
	out (032h),a		;cdda	d3 32 	. 2 
	ld a,(0007dh)		;cddc	3a 7d 00 	: } . 
	out (031h),a		;cddf	d3 31 	. 1 
	sub c			;cde1	91 	. 
	jp z,sub_cfcfh		;cde2	ca cf cf 	. . . 
	call sub_ce25h		;cde5	cd 25 ce 	. % . 
	jr c,lcdf9h		;cde8	38 0f 	8 . 
	or 010h			;cdea	f6 10 	. . 
	out (030h),a		;cdec	d3 30 	. 0 
lcdeeh:
	in a,(034h)		;cdee	db 34 	. 4 
	bit 2,a			;cdf0	cb 57 	. W 
	jr nz,lcdc4h		;cdf2	20 d0 	  . 
	rra			;cdf4	1f 	. 
	jr nc,lcdeeh		;cdf5	30 f7 	0 . 
	jr lce3eh		;cdf7	18 45 	. E 
lcdf9h:
	call sub_cfd6h		;cdf9	cd d6 cf 	. . . 
	and 04fh		;cdfc	e6 4f 	. O 
	out (004h),a		;cdfe	d3 04 	. . 
	ld a,018h		;ce00	3e 18 	> . 
	out (030h),a		;ce02	d3 30 	. 0 
lce04h:
	in a,(034h)		;ce04	db 34 	. 4 
	bit 2,a			;ce06	cb 57 	. W 
	jr nz,lcdc4h		;ce08	20 ba 	  . 
	rra			;ce0a	1f 	. 
	jr nc,lce04h		;ce0b	30 f7 	0 . 
	in a,(030h)		;ce0d	db 30 	. 0 
	ld l,032h		;ce0f	2e 32 	. 2 
lce11h:
	in a,(004h)		;ce11	db 04 	. . 
	and 040h		;ce13	e6 40 	. @ 
	jr nz,lce11h		;ce15	20 fa 	  . 
	dec l			;ce17	2d 	- 
	jr nz,lce11h		;ce18	20 f7 	  . 
lce1ah:
	in a,(004h)		;ce1a	db 04 	. . 
	and 040h		;ce1c	e6 40 	. @ 
	jr nz,lce1ah		;ce1e	20 fa 	  . 
	call sub_cfcfh		;ce20	cd cf cf 	. . . 
	jr lce50h		;ce23	18 2b 	. + 
sub_ce25h:
	ld a,(0007eh)		;ce25	3a 7e 00 	: ~ . 
	bit 2,a			;ce28	cb 57 	. W 
	jr nz,lce36h		;ce2a	20 0a 	  . 
	bit 3,a			;ce2c	cb 5f 	. _ 
	ld a,00eh		;ce2e	3e 0e 	> . 
	jr z,lce34h		;ce30	28 02 	( . 
	ld a,00ch		;ce32	3e 0c 	> . 
lce34h:
	and a			;ce34	a7 	. 
	ret			;ce35	c9 	. 
lce36h:
	bit 3,a			;ce36	cb 5f 	. _ 
	ld a,00fh		;ce38	3e 0f 	> . 
	jr z,lce34h		;ce3a	28 f8 	( . 
	scf			;ce3c	37 	7 
	ret			;ce3d	c9 	. 
lce3eh:
	call sub_cfcfh		;ce3e	cd cf cf 	. . . 
	ld hl,00064h		;ce41	21 64 00 	! d . 
	call sub_cff1h		;ce44	cd f1 cf 	. . . 
	in a,(030h)		;ce47	db 30 	. 0 
	ld (00071h),a		;ce49	32 71 00 	2 q . 
	and 098h		;ce4c	e6 98 	. . 
	scf			;ce4e	37 	7 
	ret nz			;ce4f	c0 	. 
lce50h:
	ld a,(00075h)		;ce50	3a 75 00 	: u . 
	ld (0007dh),a		;ce53	32 7d 00 	2 } . 
	and a			;ce56	a7 	. 
	ret			;ce57	c9 	. 
sub_ce58h:
	call sub_ce8fh		;ce58	cd 8f ce 	. . . 
	out (030h),a		;ce5b	d3 30 	. 0 
lce5dh:
	in a,(034h)		;ce5d	db 34 	. 4 
	rra			;ce5f	1f 	. 
	jr c,lce78h		;ce60	38 16 	8 . 
	ini			;ce62	ed a2 	. . 
	inc b			;ce64	04 	. 
	in a,(034h)		;ce65	db 34 	. 4 
	rra			;ce67	1f 	. 
	jr c,lce78h		;ce68	38 0e 	8 . 
	ini			;ce6a	ed a2 	. . 
	jp nz,lce5dh		;ce6c	c2 5d ce 	. ] . 
lce6fh:
	in a,(034h)		;ce6f	db 34 	. 4 
	bit 1,a			;ce71	cb 4f 	. O 
	jr nz,lce85h		;ce73	20 10 	  . 
	rra			;ce75	1f 	. 
	jr nc,lce6fh		;ce76	30 f7 	0 . 
lce78h:
	call sub_cfcfh		;ce78	cd cf cf 	. . . 
	in a,(030h)		;ce7b	db 30 	. 0 
	ld (00071h),a		;ce7d	32 71 00 	2 q . 
	and 09ch		;ce80	e6 9c 	. . 
	ret z			;ce82	c8 	. 
	jr lce8dh		;ce83	18 08 	. . 
lce85h:
	call sub_cfcfh		;ce85	cd cf cf 	. . . 
	ld a,080h		;ce88	3e 80 	> . 
	ld (00071h),a		;ce8a	32 71 00 	2 q . 
lce8dh:
	scf			;ce8d	37 	7 
	ret			;ce8e	c9 	. 
sub_ce8fh:
	call sub_cf40h		;ce8f	cd 40 cf 	. @ . 
	ld d,a			;ce92	57 	W 
	di			;ce93	f3 	. 
	call sub_cfc6h		;ce94	cd c6 cf 	. . . 
	add a,088h		;ce97	c6 88 	. . 
	ld e,a			;ce99	5f 	_ 
	ld a,d			;ce9a	7a 	z 
	out (034h),a		;ce9b	d3 34 	. 4 
	ld a,e			;ce9d	7b 	{ 
	ret			;ce9e	c9 	. 
sub_ce9fh:
	call sub_cfe4h		;ce9f	cd e4 cf 	. . . 
	call sub_cf40h		;cea2	cd 40 cf 	. @ . 
	ld d,a			;cea5	57 	W 
	di			;cea6	f3 	. 
	call sub_cfc6h		;cea7	cd c6 cf 	. . . 
	add a,0a8h		;ceaa	c6 a8 	. . 
	ld e,a			;ceac	5f 	_ 
	ld a,d			;cead	7a 	z 
	out (034h),a		;ceae	d3 34 	. 4 
	ld a,e			;ceb0	7b 	{ 
	out (030h),a		;ceb1	d3 30 	. 0 
lceb3h:
	in a,(034h)		;ceb3	db 34 	. 4 
	rra			;ceb5	1f 	. 
	jr c,lcecah		;ceb6	38 12 	8 . 
	outi			;ceb8	ed a3 	. . 
	inc b			;ceba	04 	. 
	in a,(034h)		;cebb	db 34 	. 4 
	rra			;cebd	1f 	. 
	jr c,lcecah		;cebe	38 0a 	8 . 
	outi			;cec0	ed a3 	. . 
	jp nz,lceb3h		;cec2	c2 b3 ce 	. . . 
lcec5h:
	in a,(034h)		;cec5	db 34 	. 4 
	rra			;cec7	1f 	. 
	jr nc,lcec5h		;cec8	30 fb 	0 . 
lcecah:
	call sub_cfcfh		;ceca	cd cf cf 	. . . 
	call sub_cfe4h		;cecd	cd e4 cf 	. . . 
	in a,(030h)		;ced0	db 30 	. 0 
	ld (00071h),a		;ced2	32 71 00 	2 q . 
	and 0fch		;ced5	e6 fc 	. . 
	scf			;ced7	37 	7 
	ret nz			;ced8	c0 	. 
	and a			;ced9	a7 	. 
	ld a,(0007eh)		;ceda	3a 7e 00 	: ~ . 
	bit 1,a			;cedd	cb 4f 	. O 
	ret z			;cedf	c8 	. 
	call sub_cf00h		;cee0	cd 00 cf 	. . . 
	jr c,lceefh		;cee3	38 0a 	8 . 
lcee5h:
	in a,(034h)		;cee5	db 34 	. 4 
	rra			;cee7	1f 	. 
	jr c,lceeeh		;cee8	38 04 	8 . 
	in a,(033h)		;ceea	db 33 	. 3 
	jr lcee5h		;ceec	18 f7 	. . 
lceeeh:
	inc e			;ceee	1c 	. 
lceefh:
	call sub_cfcfh		;ceef	cd cf cf 	. . . 
	in a,(030h)		;cef2	db 30 	. 0 
	ld (00071h),a		;cef4	32 71 00 	2 q . 
	and 09ch		;cef7	e6 9c 	. . 
	scf			;cef9	37 	7 
	ret nz			;cefa	c0 	. 
	ld a,e			;cefb	7b 	{ 
	and a			;cefc	a7 	. 
	ret z			;cefd	c8 	. 
	scf			;cefe	37 	7 
	ret			;ceff	c9 	. 
sub_cf00h:
	call sub_ce8fh		;cf00	cd 8f ce 	. . . 
	ld bc,(00079h)		;cf03	ed 4b 79 00 	. K y . 
	srl b			;cf07	cb 38 	. 8 
	rr c			;cf09	cb 19 	. . 
	srl b			;cf0b	cb 38 	. 8 
	rr c			;cf0d	cb 19 	. . 
	ld b,c			;cf0f	41 	A 
	ld e,000h		;cf10	1e 00 	. . 
	out (030h),a		;cf12	d3 30 	. 0 
lcf14h:
	in a,(034h)		;cf14	db 34 	. 4 
	rra			;cf16	1f 	. 
	ret c			;cf17	d8 	. 
	in a,(033h)		;cf18	db 33 	. 3 
	xor (hl)			;cf1a	ae 	. 
	ret nz			;cf1b	c0 	. 
	inc hl			;cf1c	23 	# 
	in a,(034h)		;cf1d	db 34 	. 4 
	rra			;cf1f	1f 	. 
	ret c			;cf20	d8 	. 
	in a,(033h)		;cf21	db 33 	. 3 
	xor (hl)		;cf23	ae 	. 
	ret nz			;cf24	c0 	. 
	inc hl			;cf25	23 	# 
	in a,(034h)		;cf26	db 34 	. 4 
	rra			;cf28	1f 	. 
	ret c			;cf29	d8 	. 
	in a,(033h)		;cf2a	db 33 	. 3 
	xor (hl)		;cf2c	ae 	. 
	ret nz			;cf2d	c0 	. 
	inc hl			;cf2e	23 	# 
	in a,(034h)		;cf2f	db 34 	. 4 
	rra			;cf31	1f 	. 
	ret c			;cf32	d8 	. 
	in a,(033h)		;cf33	db 33 	. 3 
	xor (hl)		;cf35	ae 	. 
	ret nz			;cf36	c0 	. 
	inc hl			;cf37	23 	# 
	djnz lcf14h		;cf38	10 da 	. . 
lcf3ah:
	in a,(034h)		;cf3a	db 34 	. 4 
	rra			;cf3c	1f 	. 
	jr nc,lcf3ah		;cf3d	30 fb 	0 . 
	ret			;cf3f	c9 	. 
sub_cf40h:
	in a,(033h)		;cf40	db 33 	. 3 
	ld a,080h		;cf42	3e 80 	> . 
	call sub_cf55h		;cf44	cd 55 cf 	. U . 
	ld hl,(00079h)		;cf47	2a 79 00 	* y . 
	rr h			;cf4a	cb 1c 	. . 
	rr l			;cf4c	cb 1d 	. . 
	ld b,l			;cf4e	45 	E 
	ld c,033h		;cf4f	0e 33 	. 3 
	ld hl,(0007bh)		;cf51	2a 7b 00 	* { . 
	ret			;cf54	c9 	. 
sub_cf55h:
	ld c,a			;cf55	4f 	O 
	in a,(034h)		;cf56	db 34 	. 4 
	and 004h		;cf58	e6 04 	. . 
	jr z,lcf60h		;cf5a	28 04 	( . 
	sub a			;cf5c	97 	. 
	ld (00072h),a		;cf5d	32 72 00 	2 r . 
lcf60h:
	call sub_cfa8h		;cf60	cd a8 cf 	. . . 
	out (034h),a		;cf63	d3 34 	. 4 
	push af			;cf65	f5 	. 
	push hl			;cf66	e5 	. 
	call sub_cfd6h		;cf67	cd d6 cf 	. . . 
	and 05fh		;cf6a	e6 5f 	. _ 
	out (004h),a		;cf6c	d3 04 	. . 
	ld a,(00072h)		;cf6e	3a 72 00 	: r . 
	and a			;cf71	a7 	. 
	jr z,lcf95h		;cf72	28 21 	( ! 
	ld hl,00190h		;cf74	21 90 01 	! . . 
	ld a,(00073h)		;cf77	3a 73 00 	: s . 
	cp b			;cf7a	b8 	. 
	jr nz,lcf98h		;cf7b	20 1b 	  . 
	ld a,(00074h)		;cf7d	3a 74 00 	: t . 
	ld h,a			;cf80	67 	g 
	ld a,(00078h)		;cf81	3a 78 00 	: x . 
	ld (00074h),a		;cf84	32 74 00 	2 t . 
	cp h			;cf87	bc 	. 
	jr nz,lcf90h		;cf88	20 06 	  . 
	in a,(034h)		;cf8a	db 34 	. 4 
	and 020h		;cf8c	e6 20 	.   
	jr nz,lcf9bh		;cf8e	20 0b 	  . 
lcf90h:
	call sub_cfe4h		;cf90	cd e4 cf 	. . . 
	jr lcf9bh		;cf93	18 06 	. . 
lcf95h:
	ld hl,04e20h		;cf95	21 20 4e 	!   N 
lcf98h:
	call sub_cff1h		;cf98	cd f1 cf 	. . . 
lcf9bh:
	pop hl			;cf9b	e1 	. 
	ld a,b			;cf9c	78 	x 
	ld (00073h),a		;cf9d	32 73 00 	2 s . 
	ld a,001h		;cfa0	3e 01 	> . 
	ld (00072h),a		;cfa2	32 72 00 	2 r . 
	pop af			;cfa5	f1 	. 
	or c			;cfa6	b1 	. 
	ret			;cfa7	c9 	. 
sub_cfa8h:
	ld a,(00077h)		;cfa8	3a 77 00 	: w . 
	ld b,a			;cfab	47 	G 
	inc b			;cfac	04 	. 
	sub a			;cfad	97 	. 
	scf			;cfae	37 	7 
lcfafh:
	rla			;cfaf	17 	. 
	djnz lcfafh		;cfb0	10 fd 	. . 
	ld b,a			;cfb2	47 	G 
	ld a,(0007eh)		;cfb3	3a 7e 00 	: ~ . 
	bit 2,a			;cfb6	cb 57 	. W 
	jr z,lcfbch		;cfb8	28 02 	( . 
	set 4,b			;cfba	cb e0 	. . 
lcfbch:
	bit 0,a			;cfbc	cb 47 	. G 
	jr z,lcfc2h		;cfbe	28 02 	( . 
	set 6,b			;cfc0	cb f0 	. . 
lcfc2h:
	ld a,b			;cfc2	78 	x 
	or 020h			;cfc3	f6 20 	.   
	ret			;cfc5	c9 	. 
sub_cfc6h:
	in a,(034h)		;cfc6	db 34 	. 4 
	cpl			;cfc8	2f 	/ 
	and 020h		;cfc9	e6 20 	.   
	ret z			;cfcb	c8 	. 
	ld a,004h		;cfcc	3e 04 	> . 
	ret			;cfce	c9 	. 
sub_cfcfh:
	call sub_cfd6h		;cfcf	cd d6 cf 	. . . 
	out (004h),a		;cfd2	d3 04 	. . 
	xor a			;cfd4	af 	. 
	ret			;cfd5	c9 	. 
sub_cfd6h:
	push bc			;cfd6	c5 	. 
	ld b,07fh		;cfd7	06 7f 	.  
	ld a,(00078h)		;cfd9	3a 78 00 	: x . 
	and a			;cfdc	a7 	. 
	jr z,lcfe1h		;cfdd	28 02 	( . 
	ld b,07dh		;cfdf	06 7d 	. } 
lcfe1h:
	ld a,b			;cfe1	78 	x 
	pop bc			;cfe2	c1 	. 
	ret			;cfe3	c9 	. 
sub_cfe4h:
	ld hl,00008h		;cfe4	21 08 00 	! . . 
	ld a,(0007eh)		;cfe7	3a 7e 00 	: ~ . 
	bit 2,a			;cfea	cb 57 	. W 
	jr nz,sub_cff1h		;cfec	20 03 	  . 
	ld hl,0000ch		;cfee	21 0c 00 	! . . 
sub_cff1h:
	push bc			;cff1	c5 	. 
lcff2h:
	dec hl			;cff2	2b 	+ 
	ld b,01ch		;cff3	06 1c 	. . 
lcff5h:
	djnz lcff5h		;cff5	10 fe 	. . 
	nop			;cff7	00 	. 
	nop			;cff8	00 	. 
	ld a,l			;cff9	7d 	} 
	or h			;cffa	b4
	jr nz,lcff2h		;cffb	20 f5 	  . 
	pop bc			;cffd	c1 	. 
	ret			;cffe	c9 	. 
