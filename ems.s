;
; File generated by cc65 v 2.18 - Ubuntu 2.19-1
;
	.fopt		compiler,"cc65 v 2.18 - Ubuntu 2.19-1"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.forceimport	__STARTUP__
	.import		_pal_bg
	.import		_pal_spr
	.import		_pal_col
	.import		_pal_bright
	.import		_ppu_wait_nmi
	.import		_ppu_off
	.import		_ppu_on_all
	.import		_ppu_system
	.import		_oam_clear
	.import		_music_stop
	.import		_pad_poll
	.import		_rand8
	.import		_set_vram_update
	.import		_vram_adr
	.import		_vram_put
	.import		_vram_fill
	.import		_vram_unrle
	.import		_delay
	.import		_set_vram_buffer
	.import		_clear_vram_buffer
	.import		_get_frame_count
	.export		_xText
	.export		_yText
	.export		_ppu_region
	.export		_fade_index
	.import		_vsprintf
	.import		_strlen
	.export		_gpit
	.export		_rda
	.export		_update_index
	.export		_gp_addr
	.export		__update_nt_text
	.export		_nes_load_title
	.export		_nes_load_title_a
	.export		_nes_load_title_b
	.export		_nes_hud_update
	.export		_nes_fade_transition_fg
	.export		_nes_fade_transition_bg
	.export		_nes_show_region_error
	.export		_nes_exit_cleanup
	.export		_nes_fade_out
	.export		_nes_fade_in
	.export		_nes_palette_rand
	.export		_nes_text_hud
	.export		_nes_clear_nametable
	.export		__print_nt_text
	.export		_palette
	.export		_put_str
	.export		_main

.segment	"DATA"

_xText:
	.word	$0000
_yText:
	.word	$0000
_update_index:
	.byte	$00

.segment	"RODATA"

_palette:
	.byte	$0F
	.byte	$00
	.byte	$10
	.byte	$30
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
	.byte	$00
L00AD:
	.byte	$50,$4C,$45,$41,$53,$45,$20,$53,$57,$49,$54,$43,$48,$20,$54,$4F
	.byte	$20,$50,$41,$4C,$20,$4F,$52,$20,$44,$45,$4E,$44,$59,$00
L00A5:
	.byte	$57,$52,$4F,$4E,$47,$20,$56,$49,$44,$45,$4F,$20,$52,$45,$47,$49
	.byte	$4F,$4E,$20,$53,$45,$4C,$45,$43,$54,$45,$44,$0A,$00
L00BC	:=	L00A5+0
L00C4:
	.byte	$50,$4C,$45,$41,$53,$45,$20,$53,$57,$49,$54,$43,$48,$20,$54,$4F
	.byte	$20,$4E,$54,$53,$43,$00
L0168:
	.byte	$47,$4F,$20,$47,$41,$54,$4F,$52,$53,$21,$00
L018F:
	.byte	$79,$61,$20,$6D,$61,$6D,$61,$00
L0173	:=	L00C4+17
L017D:
	.byte	$50,$41,$4C,$00

.segment	"BSS"

_ppu_region:
	.res	1,$00
_fade_index:
	.res	1,$00
_gpit:
	.res	1,$00
_rda:
	.res	1,$00
_gp_addr:
	.res	2,$00
_update_list:
	.res	91,$00

; ---------------------------------------------------------------
; void __near__ _update_nt_text (unsigned char, unsigned char, unsigned char, __near__ unsigned char *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	__update_nt_text: near

.segment	"CODE"

;
; {
;
	jsr     pushax
;
; gp_addr = NAMETABLE_A + (y << 5) + x;
;
	ldy     #$03
	ldx     #$00
	lda     (sp),y
	jsr     aslax4
	stx     tmp1
	asl     a
	rol     tmp1
	sta     ptr1
	lda     tmp1
	clc
	adc     #$20
	sta     ptr1+1
	iny
	lda     (sp),y
	clc
	adc     ptr1
	ldx     ptr1+1
	bcc     L0191
	inx
L0191:	sta     _gp_addr
	stx     _gp_addr+1
;
; UPDATE_NT_BUF = MSB(gp_addr) | NT_UPD_HORZ; // Horizontal type text. change to NT_UPD_VERT for Vertical text
;
	lda     _update_index
	inc     _update_index
	clc
	adc     #<(_update_list)
	sta     ptr1
	lda     #$00
	adc     #>(_update_list)
	sta     ptr1+1
	lda     _gp_addr+1
	ora     #$40
	ldy     #$00
	sta     (ptr1),y
;
; UPDATE_NT_BUF = LSB(gp_addr);
;
	lda     _update_index
	inc     _update_index
	clc
	adc     #<(_update_list)
	sta     ptr1
	tya
	adc     #>(_update_list)
	sta     ptr1+1
	lda     _gp_addr
	sta     (ptr1),y
;
; UPDATE_NT_BUF = l; //l - length of text.
;
	lda     _update_index
	inc     _update_index
	clc
	adc     #<(_update_list)
	sta     ptr1
	tya
	adc     #>(_update_list)
	sta     ptr1+1
	ldy     #$02
	lda     (sp),y
	ldy     #$00
	sta     (ptr1),y
;
; gpit = l;
;
	ldy     #$02
	lda     (sp),y
	sta     _gpit
;
; while (gpit--)
;
	jmp     L0192
;
; UPDATE_NT_BUF = *s++ + NES_TEXT_TILE_INDEX - 0x20;
;
L0133:	lda     _update_index
	inc     _update_index
	clc
	adc     #<(_update_list)
	tay
	lda     #$00
	adc     #>(_update_list)
	tax
	tya
	jsr     pushax
	ldy     #$03
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	sta     regsave
	stx     regsave+1
	clc
	adc     #$01
	bcc     L013A
	inx
L013A:	jsr     staxysp
	ldy     #$00
	lda     (regsave),y
	sec
	sbc     #$20
	jsr     staspidx
;
; while (gpit--)
;
L0192:	lda     _gpit
	dec     _gpit
	tax
	bne     L0133
;
; }
;
	jmp     incsp5

.endproc

; ---------------------------------------------------------------
; void __near__ nes_load_title (__near__ unsigned char *, unsigned int)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_load_title: near

.segment	"CODE"

;
; {
;
	jsr     pushax
;
; vram_adr(nametable);
;
	ldy     #$01
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     _vram_adr
;
; vram_unrle(title);
;
	ldy     #$03
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     _vram_unrle
;
; }
;
	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ nes_load_title_a (__near__ unsigned char *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_load_title_a: near

.segment	"CODE"

;
; {
;
	jsr     pushax
;
; vram_adr(NAMETABLE_A);
;
	ldx     #$20
	lda     #$00
	jsr     _vram_adr
;
; vram_unrle(title);
;
	ldy     #$01
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     _vram_unrle
;
; }
;
	jmp     incsp2

.endproc

; ---------------------------------------------------------------
; void __near__ nes_load_title_b (__near__ unsigned char *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_load_title_b: near

.segment	"CODE"

;
; {
;
	jsr     pushax
;
; vram_adr(NAMETABLE_B);
;
	ldx     #$24
	lda     #$00
	jsr     _vram_adr
;
; vram_unrle(title);
;
	ldy     #$01
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     _vram_unrle
;
; }
;
	jmp     incsp2

.endproc

; ---------------------------------------------------------------
; void __near__ nes_hud_update (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_hud_update: near

.segment	"CODE"

;
; update_list[update_index] = NT_UPD_EOF;
;
	ldy     _update_index
	lda     #$FF
	sta     _update_list,y
;
; update_index = 0; // Reset update list
;
	lda     #$00
	sta     _update_index
;
; }
;
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ nes_fade_transition_fg (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_fade_transition_fg: near

.segment	"CODE"

;
; if (get_frame_count() % (1 << 4) == 0)
;
	jsr     _get_frame_count
	and     #$0F
	bne     L00D7
;
; pal_col(1, rand8() & 4);
;
	lda     #$01
	jsr     pusha
	jsr     _rand8
	and     #$04
	jsr     _pal_col
;
; pal_col(3, rand8() & 4);
;
	lda     #$03
	jsr     pusha
	jsr     _rand8
	and     #$04
	jsr     _pal_col
;
; delay(10);
;
	lda     #$0A
	jmp     _delay
;
; }
;
L00D7:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ nes_fade_transition_bg (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_fade_transition_bg: near

.segment	"CODE"

;
; if (get_frame_count() % (1 << 4) == 0)
;
	jsr     _get_frame_count
	and     #$0F
	bne     L00E4
;
; pal_col(0, rand8() & 4);
;
	jsr     pusha
	jsr     _rand8
	and     #$04
	jsr     _pal_col
;
; pal_col(2, rand8() & 4);
;
	lda     #$02
	jsr     pusha
	jsr     _rand8
	and     #$04
	jsr     _pal_col
;
; delay(10);
;
	lda     #$0A
	jmp     _delay
;
; }
;
L00E4:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ nes_show_region_error (unsigned char)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_show_region_error: near

.segment	"CODE"

;
; {
;
	jsr     pusha
;
; ppu_region = REGION_DENDY + 1; //Error set initial.
;
	lda     #$03
	sta     _ppu_region
;
; if (ppu_system() && region_type == REGION_NTSC)
;
	jsr     _ppu_system
	tax
	beq     L009B
	ldy     #$00
	lda     (sp),y
	bne     L009B
;
; NES_GOTOXY(3, 15);
;
	tax
	lda     #$03
	sta     _xText
	stx     _xText+1
	lda     #$0F
	sta     _yText
	stx     _yText+1
;
; nes_text_hud("WRONG VIDEO REGION SELECTED\n");
;
	lda     #<(L00A5)
	ldx     #>(L00A5)
	jsr     pushax
	ldy     #$02
	jsr     _nes_text_hud
;
; NES_GOTOXY(3, 17);
;
	ldx     #$00
	lda     #$03
	sta     _xText
	stx     _xText+1
	lda     #$11
	sta     _yText
	stx     _yText+1
;
; nes_text_hud("PLEASE SWITCH TO PAL OR DENDY");
;
	lda     #<(L00AD)
	ldx     #>(L00AD)
	jsr     pushax
	ldy     #$02
	jsr     _nes_text_hud
;
; ppu_region = REGION_NTSC;
;
	lda     #$00
;
; else if (!ppu_system() && region_type == REGION_PAL || region_type == REGION_DENDY)
;
	jmp     L0193
L009B:	jsr     _ppu_system
	tax
	bne     L00B4
	lda     (sp,x)
	cmp     #$01
	beq     L0199
L00B4:	ldy     #$00
	lda     (sp),y
	cmp     #$02
	bne     L019A
;
; NES_GOTOXY(3, 15);
;
	ldx     #$00
L0199:	lda     #$03
	sta     _xText
	stx     _xText+1
	lda     #$0F
	sta     _yText
	stx     _yText+1
;
; nes_text_hud("WRONG VIDEO REGION SELECTED\n");
;
	lda     #<(L00BC)
	ldx     #>(L00BC)
	jsr     pushax
	ldy     #$02
	jsr     _nes_text_hud
;
; NES_GOTOXY(3, 17);
;
	ldx     #$00
	lda     #$03
	sta     _xText
	stx     _xText+1
	lda     #$11
	sta     _yText
	stx     _yText+1
;
; nes_text_hud("PLEASE SWITCH TO NTSC");
;
	lda     #<(L00C4)
	ldx     #>(L00C4)
	jsr     pushax
	ldy     #$02
	jsr     _nes_text_hud
;
; ppu_region = REGION_PAL;
;
	lda     #$01
L0193:	sta     _ppu_region
;
; if (ppu_region <= REGION_DENDY)
;
L019A:	lda     _ppu_region
	cmp     #$03
	bcs     L00D1
;
; nes_clear_nametable(NAMETABLE_A);
;
	ldx     #$20
	lda     #$00
	jsr     _nes_clear_nametable
;
; nes_hud_update();
;
	jsr     _nes_hud_update
;
; set_vram_update(update_list);
;
	lda     #<(_update_list)
	ldx     #>(_update_list)
	jsr     _set_vram_update
;
; ppu_on_all();
;
	jsr     _ppu_on_all
;
; ppu_wait_nmi();
;
L00D0:	jsr     _ppu_wait_nmi
;
; nes_fade_transition_fg();
;
	jsr     _nes_fade_transition_fg
;
; while (TRUE)
;
	jmp     L00D0
;
; }
;
L00D1:	jmp     incsp1

.endproc

; ---------------------------------------------------------------
; void __near__ nes_exit_cleanup (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_exit_cleanup: near

.segment	"CODE"

;
; set_vram_buffer();
;
	jsr     _set_vram_buffer
;
; clear_vram_buffer();
;
	jsr     _clear_vram_buffer
;
; oam_clear();
;
	jsr     _oam_clear
;
; music_stop();
;
	jsr     _music_stop
;
; nes_fade_out();
;
	jsr     _nes_fade_out
;
; ppu_off();
;
	jmp     _ppu_off

.endproc

; ---------------------------------------------------------------
; void __near__ nes_fade_out (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_fade_out: near

.segment	"CODE"

;
; for (fade_index = 4; fade_index > 0; fade_index--)
;
	lda     #$04
	sta     _fade_index
L019B:	lda     _fade_index
	beq     L00F9
;
; pal_bright(fade_index);
;
	jsr     _pal_bright
;
; delay(FADE_DELAY);
;
	lda     #$04
	jsr     _delay
;
; for (fade_index = 4; fade_index > 0; fade_index--)
;
	dec     _fade_index
	jmp     L019B
;
; }
;
L00F9:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ nes_fade_in (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_fade_in: near

.segment	"CODE"

;
; for (fade_index = 0; fade_index < 5; fade_index++)
;
	lda     #$00
	sta     _fade_index
L019C:	lda     _fade_index
	cmp     #$05
	bcs     L0106
;
; pal_bright(fade_index);
;
	jsr     _pal_bright
;
; delay(FADE_DELAY);
;
	lda     #$04
	jsr     _delay
;
; for (fade_index = 0; fade_index < 5; fade_index++)
;
	inc     _fade_index
	jmp     L019C
;
; }
;
L0106:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ nes_palette_rand (unsigned char)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_palette_rand: near

.segment	"RODATA"

L001B:
	.byte	$00
	.res	15,$00
L001F:
	.byte	$00
	.res	15,$00

.segment	"CODE"

;
; {
;
	jsr     pusha
;
; uint8_t bgPalette[16] = {NULL}, sprPalette[16] = {NULL};
;
	ldy     #$10
	jsr     subysp
	ldy     #$0F
L001D:	lda     L001B,y
	sta     (sp),y
	dey
	bpl     L001D
	ldy     #$10
	jsr     subysp
	ldy     #$0F
L0021:	lda     L001F,y
	sta     (sp),y
	dey
	bpl     L0021
;
; uint8_t i = 0;
;
	lda     #$00
	jsr     pusha
;
; for (i = 0; i < 16; ++i)
;
	tay
L019F:	sta     (sp),y
	cmp     #$10
	jcs     L0024
;
; bgPalette[i] = (i + rand8() + (i * 2)) % 0x3F;
;
	lda     sp
	ldx     sp+1
	clc
	adc     #$11
	bcc     L01A5
	inx
	clc
L01A5:	adc     (sp),y
	bcc     L002E
	inx
L002E:	jsr     pushax
	ldy     #$02
	lda     (sp),y
	jsr     pusha0
	jsr     _rand8
	jsr     tosaddax
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	ldy     #$02
	lda     (sp),y
	asl     a
	bcc     L01A0
	inx
	clc
L01A0:	adc     ptr1
	pha
	txa
	adc     ptr1+1
	tax
	pla
	jsr     pushax
	lda     #$3F
	jsr     tosumoda0
	ldy     #$00
	jsr     staspidx
;
; sprPalette[i] = (i + rand8() + (i * 1)) % 0x3F;
;
	lda     sp
	ldx     sp+1
	clc
	adc     #$01
	bcc     L0034
	inx
L0034:	ldy     #$00
	clc
	adc     (sp),y
	bcc     L0035
	inx
L0035:	jsr     pushax
	ldy     #$02
	lda     (sp),y
	jsr     pusha0
	jsr     _rand8
	jsr     tosaddax
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (sp),y
	clc
	adc     ptr1
	ldx     ptr1+1
	bcc     L019E
	inx
L019E:	jsr     pushax
	lda     #$3F
	jsr     tosumoda0
	ldy     #$00
	jsr     staspidx
;
; for (i = 0; i < 16; ++i)
;
	ldy     #$00
	clc
	lda     #$01
	adc     (sp),y
	jmp     L019F
;
; if (paletteType == PALETTE_TYPE_BG)
;
L0024:	ldy     #$21
	lda     (sp),y
	bne     L01A3
;
; pal_bg(bgPalette);
;
	lda     sp
	ldx     sp+1
	clc
	adc     #$11
	bcc     L003D
	inx
L003D:	jsr     _pal_bg
;
; else if (paletteType == PALETTE_TYPE_SPR)
;
	jmp     L0044
L01A3:	lda     (sp),y
	cmp     #$01
;
; else
;
	beq     L01AA
;
; pal_bg(bgPalette);
;
	lda     sp
	ldx     sp+1
	clc
	adc     #$11
	bcc     L0047
	inx
L0047:	jsr     _pal_bg
;
; pal_spr(sprPalette);
;
L01AA:	lda     sp
	ldx     sp+1
	clc
	adc     #$01
	bcc     L004A
	inx
L004A:	jsr     _pal_spr
;
; }
;
L0044:	ldy     #$22
	jmp     addysp

.endproc

; ---------------------------------------------------------------
; void __near__ nes_text_hud (__near__ const unsigned char *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_text_hud: near

.segment	"RODATA"

L004D:
	.byte	$00
	.res	31,$00

.segment	"CODE"

;
; {
;
	jsr     enter
;
; char textBuf[32] = {NULL};
;
	ldy     #$20
	jsr     subysp
	ldy     #$1F
L004F:	lda     L004D,y
	sta     (sp),y
	dey
	bpl     L004F
;
; va_start(args, format);
;
	jsr     decsp2
	ldy     #$22
	lda     (sp),y
	jsr     leaa0sp
	clc
	adc     #$21
	bcc     L0054
	inx
L0054:	jsr     stax0sp
;
; vsprintf(textBuf, format, args);
;
	jsr     decsp4
	lda     sp
	ldx     sp+1
	clc
	adc     #$06
	bcc     L0057
	inx
L0057:	ldy     #$02
	sta     (sp),y
	iny
	txa
	sta     (sp),y
	ldy     #$26
	lda     (sp),y
	jsr     leaa0sp
	clc
	adc     #$25
	bcc     L0059
	inx
L0059:	sta     ptr1
	stx     ptr1+1
	ldy     #$01
	lda     (ptr1),y
	tax
	dey
	lda     (ptr1),y
	sta     (sp),y
	iny
	txa
	sta     (sp),y
	ldy     #$05
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     _vsprintf
;
; _update_nt_text(xText, yText, strlen(textBuf), textBuf);
;
	jsr     decsp3
	lda     _xText
	ldy     #$02
	sta     (sp),y
	lda     _yText
	dey
	sta     (sp),y
	ldx     #$FF
	ldy     #$04
L0060:	inx
	iny
	lda     (sp),y
	bne     L0060
	txa
	ldy     #$00
	sta     (sp),y
	lda     sp
	ldx     sp+1
	clc
	adc     #$05
	bcc     L0062
	inx
L0062:	jsr     __update_nt_text
;
; if (textBuf[strlen(textBuf) - 1] == '\n')
;
	ldx     #$FF
	ldy     #$01
L0067:	inx
	iny
	lda     (sp),y
	bne     L0067
	txa
	ldx     #$00
	sec
	sbc     #$01
	bcs     L0068
	dex
L0068:	clc
	adc     #$02
	bcc     L0069
	inx
	clc
L0069:	adc     sp
	sta     ptr1
	txa
	adc     sp+1
	sta     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	cmp     #$0A
	bne     L0063
;
; yText++;
;
	lda     _yText
	ldx     _yText+1
	sta     regsave
	stx     regsave+1
	clc
	adc     #$01
	bcc     L006B
	inx
L006B:	sta     _yText
	stx     _yText+1
;
; xText = 0;
;
	tya
	sta     _xText
	sta     _xText+1
;
; if (textBuf[strlen(textBuf) - 1] == '\t')
;
L0063:	ldx     #$FF
	iny
L0072:	inx
	iny
	lda     (sp),y
	bne     L0072
	txa
	ldx     #$00
	sec
	sbc     #$01
	bcs     L0073
	dex
L0073:	clc
	adc     #$02
	bcc     L0074
	inx
	clc
L0074:	adc     sp
	sta     ptr1
	txa
	adc     sp+1
	sta     ptr1+1
	ldx     #$00
	lda     (ptr1,x)
	cmp     #$09
	bne     L006E
;
; xText += strlen(textBuf) + 4;
;
	dex
	ldy     #$01
L0078:	inx
	iny
	lda     (sp),y
	bne     L0078
	txa
	ldx     #$00
	clc
	adc     #$04
	bcc     L01AB
	inx
	clc
L01AB:	adc     _xText
	sta     _xText
	txa
	adc     _xText+1
	sta     _xText+1
	tax
	lda     _xText
;
; }
;
L006E:	ldy     #$22
	jmp     leavey

.endproc

; ---------------------------------------------------------------
; void __near__ nes_clear_nametable (unsigned int)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_nes_clear_nametable: near

.segment	"CODE"

;
; {
;
	jsr     pushax
;
; ppu_off();
;
	jsr     _ppu_off
;
; vram_adr(nametable);
;
	ldy     #$01
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     _vram_adr
;
; vram_fill(0, 1024);
;
	lda     #$00
	jsr     pusha
	ldx     #$04
	jsr     _vram_fill
;
; ppu_on_all();
;
	jsr     _ppu_on_all
;
; }
;
	jmp     incsp2

.endproc

; ---------------------------------------------------------------
; void __near__ _print_nt_text (unsigned char, unsigned char, __near__ unsigned char *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	__print_nt_text: near

.segment	"CODE"

;
; {
;
	jsr     pushax
;
; vram_adr(NAMETABLE_A + (y << 5) + x);
;
	ldy     #$02
	ldx     #$00
	lda     (sp),y
	jsr     aslax4
	stx     tmp1
	asl     a
	rol     tmp1
	sta     ptr1
	lda     tmp1
	clc
	adc     #$20
	sta     ptr1+1
	iny
	lda     (sp),y
	clc
	adc     ptr1
	ldx     ptr1+1
	bcc     L01AC
	inx
L01AC:	jsr     _vram_adr
;
; while (rda = *s++)
;
	jmp     L0117
;
; vram_put(rda - +NES_TEXT_TILE_INDEX - 0x20);
;
L0115:	lda     _rda
	sec
	sbc     #$20
	jsr     _vram_put
;
; while (rda = *s++)
;
L0117:	ldy     #$01
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	sta     regsave
	stx     regsave+1
	clc
	adc     #$01
	bcc     L011A
	inx
L011A:	jsr     stax0sp
	ldy     #$00
	lda     (regsave),y
	sta     _rda
	tax
	bne     L0115
;
; }
;
	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ put_str (unsigned int, __near__ const unsigned char *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_put_str: near

.segment	"CODE"

;
; void put_str(unsigned int adr, const char* str){
;
	jsr     pushax
;
; vram_adr(adr);
;
	ldy     #$03
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     _vram_adr
;
; if(!*str)break;
;
L0150:	ldy     #$01
	lda     (sp),y
	sta     ptr1+1
	dey
	lda     (sp),y
	sta     ptr1
	lda     (ptr1),y
	beq     L0151
;
; vram_put((*str++));
;
	iny
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	sta     regsave
	stx     regsave+1
	clc
	adc     #$01
	bcc     L0159
	inx
L0159:	jsr     stax0sp
	ldy     #$00
	lda     (regsave),y
	jsr     _vram_put
;
; while(1){
;
	jmp     L0150
;
; }
;
L0151:	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

;
; ppu_off(); // screen off
;
	jsr     _ppu_off
;
; pal_bg(palette); // load the BG palette
;
	lda     #<(_palette)
	ldx     #>(_palette)
	jsr     _pal_bg
;
; pal_col(1, 0x30);
;
	lda     #$01
	jsr     pusha
	lda     #$30
	jsr     _pal_col
;
; put_str(NTADR_A(2, 2), "GO GATORS!");
;
	ldx     #$20
	lda     #$42
	jsr     pushax
	lda     #<(L0168)
	ldx     #>(L0168)
	jsr     _put_str
;
; if(ppu_system()) put_str(NTADR_A(2, 5), "NTSC");
;
	jsr     _ppu_system
	tax
	beq     L016A
	ldx     #$20
	lda     #$A2
	jsr     pushax
	lda     #<(L0173)
	ldx     #>(L0173)
;
; else put_str(NTADR_A(2, 5), "PAL");
;
	jmp     L01AD
L016A:	ldx     #$20
	lda     #$A2
	jsr     pushax
	lda     #<(L017D)
	ldx     #>(L017D)
L01AD:	jsr     _put_str
;
; ppu_on_all(); // turn on screen
;
	jsr     _ppu_on_all
;
; if (NES_PAD1(PAD_LEFT))
;
L0180:	lda     #$00
L01AE:	jsr     _pad_poll
	and     #$02
	beq     L01AE
;
; put_str(NTADR_A(2, 4), "ya mama");
;
	ldx     #$20
	lda     #$82
	jsr     pushax
	lda     #<(L018F)
	ldx     #>(L018F)
	jsr     _put_str
;
; while (1){
;
	jmp     L0180

.endproc

