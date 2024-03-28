;
; File generated by cc65 v 2.19 - Git b993d8833
;
	.fopt		compiler,"cc65 v 2.19 - Git b993d8833"
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
	.import		_ppu_wait_nmi
	.import		_ppu_off
	.import		_ppu_on_all
	.import		_ppu_system
	.import		_oam_clear
	.import		_oam_spr
	.import		_pad_poll
	.import		_rand8
	.import		_vram_adr
	.import		_vram_put
	.import		_clear_vram_buffer
	.import		_get_pad_new
	.export		_p2
	.export		_p2val
	.export		_p2low
	.export		_p2high
	.export		_pad1
	.export		_pad1Next
	.export		_palSprites
	.export		_palette
	.export		_i
	.export		_j
	.export		_spr
	.export		_menuIndexH
	.export		_menuIndexV
	.export		_page
	.export		_menu
	.export		_cursorX
	.export		_cursorY
	.export		_put_str
	.export		_draw_bg_menu
	.export		_handleMenuInput
	.export		_main

.segment	"DATA"

_p2val:
	.byte	$00
_p2low:
	.byte	$00
_p2high:
	.byte	$00
_pad1:
	.byte	$00
_pad1Next:
	.byte	$00
_j:
	.byte	$00
_spr:
	.byte	$00
_menuIndexH:
	.byte	$00
_menuIndexV:
	.byte	$00
_page:
	.byte	$00
_menu:
	.byte	$53,$2E,$20,$4D,$41,$52,$49,$4F,$20,$42,$52,$4F,$53,$00
	.res	2,$00
	.byte	$53,$2E,$20,$4D,$41,$52,$49,$4F,$20,$42,$52,$4F,$53,$20,$32,$00
	.byte	$53,$2E,$20,$4D,$41,$52,$49,$4F,$20,$42,$52,$4F,$53,$20,$33,$00
	.byte	$44,$4F,$4E,$4B,$45,$59,$20,$4B,$4F,$4E,$47,$00
	.res	4,$00
	.byte	$44,$4F,$4E,$4B,$45,$59,$20,$4B,$4F,$4E,$47,$20,$32,$00
	.res	2,$00
	.byte	$4D,$45,$47,$41,$20,$4D,$41,$4E,$00
	.res	7,$00
	.byte	$4D,$45,$47,$41,$20,$4D,$41,$4E,$20,$32,$00
	.res	5,$00
	.byte	$4D,$45,$47,$41,$20,$4D,$41,$4E,$20,$33,$00
	.res	5,$00
	.byte	$4D,$45,$47,$41,$20,$4D,$41,$4E,$20,$34,$00
	.res	5,$00
	.byte	$4D,$45,$47,$41,$20,$4D,$41,$4E,$20,$35,$00
	.res	5,$00
	.byte	$4D,$45,$47,$41,$20,$4D,$41,$4E,$20,$36,$00
	.res	5,$00
	.byte	$4C,$2E,$20,$4F,$46,$20,$5A,$45,$4C,$44,$41,$00
	.res	4,$00
	.byte	$4C,$2E,$20,$4F,$46,$20,$5A,$45,$4C,$44,$41,$20,$32,$00
	.res	2,$00
	.byte	$4D,$54,$27,$53,$20,$50,$55,$4E,$43,$48,$20,$4F,$55,$54,$00
	.res	1,$00
	.byte	$43,$41,$53,$54,$4C,$45,$56,$41,$4E,$49,$41,$00
	.res	4,$00
	.byte	$43,$41,$53,$54,$4C,$45,$56,$41,$4E,$49,$41,$20,$32,$00
	.res	2,$00
	.byte	$43,$41,$53,$54,$4C,$45,$56,$41,$4E,$49,$41,$20,$33,$00
	.res	2,$00
	.byte	$4D,$45,$54,$52,$4F,$49,$44,$00
	.res	8,$00
	.byte	$46,$49,$4E,$41,$4C,$20,$46,$41,$4E,$54,$41,$53,$59,$00
	.res	2,$00
	.byte	$4B,$49,$44,$20,$49,$43,$41,$52,$55,$53,$00
	.res	5,$00
	.byte	$42,$41,$54,$54,$4C,$45,$54,$4F,$41,$44,$53,$00
	.res	4,$00
	.byte	$54,$45,$54,$52,$49,$53,$00
	.res	9,$00
	.byte	$47,$48,$4F,$53,$54,$53,$20,$26,$20,$47,$42,$4C,$4E,$53,$00
	.res	1,$00
	.byte	$49,$43,$45,$20,$43,$4C,$49,$4D,$42,$45,$52,$00
	.res	4,$00
	.byte	$4D,$41,$52,$49,$4F,$20,$42,$52,$4F,$53,$00
	.res	5,$00
	.byte	$54,$4E,$4D,$54,$00
	.res	11,$00
	.byte	$44,$55,$43,$4B,$20,$48,$55,$4E,$54,$00
	.res	6,$00
	.byte	$43,$4F,$4E,$54,$52,$41,$00
	.res	9,$00
	.byte	$43,$48,$49,$50,$20,$4E,$20,$44,$41,$4C,$45,$00
	.res	4,$00
	.byte	$44,$52,$20,$4D,$41,$52,$49,$4F,$00
	.res	7,$00
	.byte	$4B,$49,$52,$42,$59,$27,$53,$20,$41,$44,$56,$00
	.res	4,$00
	.res	16,$00
_cursorX:
	.byte	$00
_cursorY:
	.byte	$37

.segment	"RODATA"

_palSprites:
	.byte	$0F
	.byte	$15
	.byte	$26
	.byte	$11
	.byte	$0F
	.byte	$11
	.byte	$21
	.byte	$15
	.byte	$0F
	.byte	$15
	.byte	$25
	.byte	$19
	.byte	$0F
	.byte	$19
	.byte	$29
	.byte	$38
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
S0022:
	.byte	$56,$49,$44,$45,$4F,$20,$4D,$4F,$44,$45,$3A,$00
S0021:
	.byte	$47,$4F,$20,$47,$41,$54,$4F,$52,$53,$21,$00
S0023:
	.byte	$4E,$54,$53,$43,$00
S0024:
	.byte	$50,$41,$4C,$00

.segment	"BSS"

_p2:
	.res	2,$00
_ball_x:
	.res	8,$00
_ball_y:
	.res	8,$00
_ball_dx:
	.res	8,$00
_ball_dy:
	.res	8,$00
_i:
	.res	1,$00

; ---------------------------------------------------------------
; void __near__ put_str (unsigned int adr, const char *str)
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
L0002:	ldy     #$01
	lda     (sp),y
	sta     ptr1+1
	dey
	lda     (sp),y
	sta     ptr1
	lda     (ptr1),y
	beq     L0003
;
; vram_put((*str++));
;
	iny
	lda     (sp),y
	sta     ptr1+1
	dey
	lda     (sp),y
	sta     ptr1
	lda     (ptr1),y
	pha
	ldx     #$00
	lda     #$01
	jsr     addeq0sp
	pla
	jsr     _vram_put
;
; while(1){
;
	jmp     L0002
;
; }
;
L0003:	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ draw_bg_menu (const unsigned char page)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_draw_bg_menu: near

.segment	"CODE"

;
; void draw_bg_menu(const unsigned char page){
;
	jsr     pusha
;
; clear_vram_buffer();
;
	jsr     _clear_vram_buffer
;
; ppu_off();
;
	jsr     _ppu_off
;
; for(i = 0; i < 4; ++i){
;
	lda     #$00
	sta     _i
L0011:	lda     _i
	cmp     #$04
	jcs     L0003
;
; put_str(NTADR_A(1, i * 2 + 7), menu[(page * 8) + (i * 2)]);
;
	ldx     #$00
	lda     _i
	asl     a
	bcc     L000D
	inx
	clc
L000D:	adc     #$07
	bcc     L0006
	inx
L0006:	jsr     aslax4
	stx     tmp1
	asl     a
	rol     tmp1
	ora     #$01
	pha
	lda     tmp1
	ora     #$20
	tax
	pla
	jsr     pushax
	ldy     #$02
	ldx     #$00
	lda     (sp),y
	jsr     shlax3
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     _i
	asl     a
	bcc     L000E
	inx
	clc
L000E:	adc     ptr1
	pha
	txa
	adc     ptr1+1
	tax
	pla
	jsr     aslax4
	clc
	adc     #<(_menu)
	tay
	txa
	adc     #>(_menu)
	tax
	tya
	jsr     _put_str
;
; put_str(NTADR_A(17, i *2 + 7), menu[(page * 8) + (i * 2) + 1]);
;
	ldx     #$00
	lda     _i
	asl     a
	bcc     L000F
	inx
	clc
L000F:	adc     #$07
	bcc     L0007
	inx
L0007:	jsr     aslax4
	stx     tmp1
	asl     a
	rol     tmp1
	ora     #$11
	pha
	lda     tmp1
	ora     #$20
	tax
	pla
	jsr     pushax
	ldy     #$02
	ldx     #$00
	lda     (sp),y
	jsr     shlax3
	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     _i
	asl     a
	bcc     L0010
	inx
	clc
L0010:	adc     ptr1
	pha
	txa
	adc     ptr1+1
	tax
	pla
	clc
	adc     #$01
	bcc     L0008
	inx
L0008:	jsr     aslax4
	clc
	adc     #<(_menu)
	tay
	txa
	adc     #>(_menu)
	tax
	tya
	jsr     _put_str
;
; for(i = 0; i < 4; ++i){
;
	inc     _i
	jmp     L0011
;
; ppu_on_all(); 
;
L0003:	jsr     _ppu_on_all
;
; }
;
	jmp     incsp1

.endproc

; ---------------------------------------------------------------
; void __near__ handleMenuInput (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_handleMenuInput: near

.segment	"CODE"

;
; if((pad1Next & PAD_UP) && menuIndexV){ 
;
	lda     _pad1Next
	and     #$08
	beq     L001B
	lda     _menuIndexV
	beq     L001B
;
; cursorY -= 16;
;
	lda     _cursorY
	sec
	sbc     #$10
	sta     _cursorY
;
; --menuIndexV;
;
	dec     _menuIndexV
;
; *p2 = 0xAE;
;
	lda     _p2+1
	sta     ptr1+1
	lda     _p2
	sta     ptr1
	lda     #$AE
	ldy     #$00
	sta     (ptr1),y
;
; if((pad1Next & PAD_DOWN) && (menuIndexV < 3)){ 
;
L001B:	lda     _pad1Next
	and     #$04
	beq     L001F
	lda     _menuIndexV
	cmp     #$03
	bcs     L001F
;
; cursorY += 16;
;
	lda     #$10
	clc
	adc     _cursorY
	sta     _cursorY
;
; ++menuIndexV;
;
	inc     _menuIndexV
;
; *p2 = 0xB1;
;
	lda     _p2+1
	sta     ptr1+1
	lda     _p2
	sta     ptr1
	lda     #$B1
	ldy     #$00
	sta     (ptr1),y
;
; if((pad1Next & PAD_LEFT) && menuIndexH){
;
L001F:	lda     _pad1Next
	and     #$02
	beq     L0023
	lda     _menuIndexH
	beq     L0023
;
; cursorX -= 136;
;
	lda     _cursorX
	sec
	sbc     #$88
	sta     _cursorX
;
; --menuIndexH;
;
	dec     _menuIndexH
;
; *p2 = 0x25;
;
	lda     _p2+1
	sta     ptr1+1
	lda     _p2
	sta     ptr1
	lda     #$25
	ldy     #$00
	sta     (ptr1),y
;
; if((pad1Next & PAD_RIGHT) && !menuIndexH){
;
L0023:	lda     _pad1Next
	and     #$01
	beq     L0027
	lda     _menuIndexH
	bne     L0027
;
; cursorX += 136;
;
	lda     #$88
	clc
	adc     _cursorX
	sta     _cursorX
;
; ++menuIndexH;
;
	inc     _menuIndexH
;
; *p2 = 0x49;
;
	lda     _p2+1
	sta     ptr1+1
	lda     _p2
	sta     ptr1
	lda     #$49
	ldy     #$00
	sta     (ptr1),y
;
; if((pad1Next & PAD_A)){
;
L0027:	lda     _pad1Next
	and     #$80
	beq     L002A
;
; if(page == 2) page = 0;
;
	lda     _page
	cmp     #$02
	bne     L0028
	lda     #$00
	sta     _page
;
; else ++page;
;
	jmp     L0029
L0028:	inc     _page
;
; draw_bg_menu(page);
;
L0029:	lda     _page
	jsr     _draw_bg_menu
;
; if((pad1Next & PAD_B)){
;
L002A:	lda     _pad1Next
	and     #$40
	beq     L0015
;
; if(!page) page = 2;
;
	lda     _page
	bne     L002B
	lda     #$02
	sta     _page
;
; else --page;
;
	jmp     L002C
L002B:	dec     _page
;
; draw_bg_menu(page);
;
L002C:	lda     _page
	jmp     _draw_bg_menu
;
; }
;
L0015:	rts

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
; *p2 = 0xEF;
;
	lda     _p2+1
	sta     ptr1+1
	lda     _p2
	sta     ptr1
	lda     #$EF
	ldy     #$00
	sta     (ptr1),y
;
; pal_spr(palSprites);
;
	lda     #<(_palSprites)
	ldx     #>(_palSprites)
	jsr     _pal_spr
;
; for(i = 0;i < BALLS_MAX; ++i){
;
	lda     #$00
	sta     _i
L0032:	lda     _i
	cmp     #$08
	jcs     L0003
;
; ball_x[i] = rand8();
;
	lda     #<(_ball_x)
	ldx     #>(_ball_x)
	clc
	adc     _i
	bcc     L0006
	inx
L0006:	jsr     pushax
	jsr     _rand8
	ldy     #$00
	jsr     staspidx
;
; ball_y[i] = rand8();
;
	lda     #<(_ball_y)
	ldx     #>(_ball_y)
	clc
	adc     _i
	bcc     L0007
	inx
L0007:	jsr     pushax
	jsr     _rand8
	ldy     #$00
	jsr     staspidx
;
; j = rand8();
;
	jsr     _rand8
	sta     _j
;
; spr = 1 + (rand8() % 3);
;
	jsr     _rand8
	jsr     pushax
	lda     #$03
	jsr     tosumoda0
	clc
	adc     #$01
	sta     _spr
;
; ball_dx[i] = j & 1? -spr:spr;
;
	lda     #<(_ball_dx)
	ldx     #>(_ball_dx)
	clc
	adc     _i
	bcc     L0009
	inx
L0009:	sta     ptr1
	stx     ptr1+1
	lda     _j
	and     #$01
	beq     L0033
	lda     _spr
	eor     #$FF
	clc
	adc     #$01
	jmp     L0034
L0033:	lda     _spr
L0034:	ldy     #$00
	sta     (ptr1),y
;
; spr = 1 + (rand8() % 3);
;
	jsr     _rand8
	jsr     pushax
	lda     #$03
	jsr     tosumoda0
	clc
	adc     #$01
	sta     _spr
;
; ball_dy[i] = j & 1? -spr:spr;
;
	lda     #<(_ball_dy)
	ldx     #>(_ball_dy)
	clc
	adc     _i
	bcc     L000D
	inx
L000D:	sta     ptr1
	stx     ptr1+1
	lda     _j
	and     #$01
	beq     L0035
	lda     _spr
	eor     #$FF
	clc
	adc     #$01
	jmp     L0036
L0035:	lda     _spr
L0036:	ldy     #$00
	sta     (ptr1),y
;
; for(i = 0;i < BALLS_MAX; ++i){
;
	inc     _i
	jmp     L0032
;
; pal_bg(palette); // load the BG palette
;
L0003:	lda     #<(_palette)
	ldx     #>(_palette)
	jsr     _pal_bg
;
; pal_spr(palSprites);
;
	lda     #<(_palSprites)
	ldx     #>(_palSprites)
	jsr     _pal_spr
;
; put_str(NTADR_A(1, 2), "GO GATORS!");
;
	ldx     #$20
	lda     #$41
	jsr     pushax
	lda     #<(S0021)
	ldx     #>(S0021)
	jsr     _put_str
;
; put_str(NTADR_A(1, 4), "VIDEO MODE:");
;
	ldx     #$20
	lda     #$81
	jsr     pushax
	lda     #<(S0022)
	ldx     #>(S0022)
	jsr     _put_str
;
; if(ppu_system()) put_str(NTADR_A(1, 5), "NTSC");
;
	jsr     _ppu_system
	tax
	beq     L0010
	ldx     #$20
	lda     #$A1
	jsr     pushax
	lda     #<(S0023)
	ldx     #>(S0023)
;
; else put_str(NTADR_A(1, 5), "PAL");
;
	jmp     L002F
L0010:	ldx     #$20
	lda     #$A1
	jsr     pushax
	lda     #<(S0024)
	ldx     #>(S0024)
L002F:	jsr     _put_str
;
; ppu_on_all();
;
	jsr     _ppu_on_all
;
; ppu_wait_nmi();
;
L0012:	jsr     _ppu_wait_nmi
;
; oam_clear();
;
	jsr     _oam_clear
;
; spr = 0;
;
	lda     #$00
	sta     _spr
;
; for(i = 0; i < BALLS_MAX; ++i){
;
	sta     _i
L0037:	lda     _i
	cmp     #$08
	jcs     L0016
;
; if(i % 2) oam_spr(ball_x[i], ball_y[i], 0x55, i % 4);
;
	and     #$01
	beq     L0019
	jsr     decsp3
	ldy     _i
	lda     _ball_x,y
	ldy     #$02
	sta     (sp),y
	ldy     _i
	lda     _ball_y,y
	ldy     #$01
	sta     (sp),y
	lda     #$55
;
; else oam_spr(ball_x[i], ball_y[i], 0x46, i % 4);
;
	jmp     L003C
L0019:	jsr     decsp3
	ldy     _i
	lda     _ball_x,y
	ldy     #$02
	sta     (sp),y
	ldy     _i
	lda     _ball_y,y
	ldy     #$01
	sta     (sp),y
	lda     #$46
L003C:	dey
	sta     (sp),y
	lda     _i
	and     #$03
	jsr     _oam_spr
;
; ball_x[i] += ball_dx[i];
;
	lda     #<(_ball_x)
	ldx     #>(_ball_x)
	clc
	adc     _i
	bcc     L001F
	inx
L001F:	sta     sreg
	stx     sreg+1
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	sta     ptr1
	ldy     _i
	lda     _ball_dx,y
	clc
	adc     ptr1
	ldy     #$00
	sta     (sreg),y
;
; ball_y[i] += ball_dy[i];
;
	lda     #<(_ball_y)
	ldx     #>(_ball_y)
	clc
	adc     _i
	bcc     L0021
	inx
L0021:	sta     sreg
	stx     sreg+1
	sta     ptr1
	stx     ptr1+1
	lda     (ptr1),y
	sta     ptr1
	ldy     _i
	lda     _ball_dy,y
	clc
	adc     ptr1
	ldy     #$00
	sta     (sreg),y
;
; if(ball_x[i]>=(256-8)) ball_dx[i]=-ball_dx[i];
;
	ldy     _i
	lda     _ball_x,y
	cmp     #$F8
	bcc     L0023
	lda     #<(_ball_dx)
	ldx     #>(_ball_dx)
	clc
	adc     _i
	bcc     L0025
	inx
L0025:	sta     ptr1
	stx     ptr1+1
	ldy     _i
	lda     _ball_dx,y
	eor     #$FF
	clc
	adc     #$01
	ldy     #$00
	sta     (ptr1),y
;
; if(ball_y[i]>=(240-8)) ball_dy[i]=-ball_dy[i];
;
L0023:	ldy     _i
	lda     _ball_y,y
	cmp     #$E8
	bcc     L0038
	lda     #<(_ball_dy)
	ldx     #>(_ball_dy)
	clc
	adc     _i
	bcc     L0029
	inx
L0029:	sta     ptr1
	stx     ptr1+1
	ldy     _i
	lda     _ball_dy,y
	eor     #$FF
	clc
	adc     #$01
	ldy     #$00
	sta     (ptr1),y
;
; for(i = 0; i < BALLS_MAX; ++i){
;
L0038:	inc     _i
	jmp     L0037
;
; oam_spr(cursorX, cursorY, 0x7F, 0x00);
;
L0016:	jsr     decsp3
	lda     _cursorX
	ldy     #$02
	sta     (sp),y
	lda     _cursorY
	dey
	sta     (sp),y
	lda     #$7F
	dey
	sta     (sp),y
	tya
	jsr     _oam_spr
;
; pad1 = pad_poll(0);
;
	lda     #$00
	jsr     _pad_poll
	sta     _pad1
;
; pad1Next = get_pad_new(0);
;
	lda     #$00
	jsr     _get_pad_new
	sta     _pad1Next
;
; handleMenuInput();
;
	jsr     _handleMenuInput
;
; p2val = menuIndexH + menuIndexV * 2;
;
	lda     _menuIndexV
	asl     a
	bcc     L0031
	clc
L0031:	adc     _menuIndexH
	sta     _p2val
;
; p2low = p2val & 0x0F;
;
	and     #$0F
	sta     _p2low
;
; p2low += 0x30;
;
	lda     #$30
	clc
	adc     _p2low
	sta     _p2low
;
; p2high = p2val & 0xF0;
;
	lda     _p2val
	and     #$F0
	sta     _p2high
;
; p2high = p2high >> 4;
;
	lsr     a
	lsr     a
	lsr     a
	lsr     a
	sta     _p2high
;
; p2high += 0x30;
;
	lda     #$30
	clc
	adc     _p2high
	sta     _p2high
;
; oam_spr(0x88, 0x80, p2low, 0x0);
;
	jsr     decsp3
	lda     #$88
	ldy     #$02
	sta     (sp),y
	lda     #$80
	dey
	sta     (sp),y
	lda     _p2low
	dey
	sta     (sp),y
	tya
	jsr     _oam_spr
;
; oam_spr(0x80, 0x80, p2high, 0x0);
;
	jsr     decsp3
	lda     #$80
	ldy     #$02
	sta     (sp),y
	dey
	sta     (sp),y
	lda     _p2high
	dey
	sta     (sp),y
	tya
	jsr     _oam_spr
;
; while (1){
;
	jmp     L0012

.endproc

