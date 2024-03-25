// Simple program to display message and check video type
 
/* Original example provided by Doug

	Functionality provided by Beto Perez
	Last Update 3/20/24 - comments, cleaning, from source code that was executed on the MiSTer on Tuesday, 3/19/24

*/
#include "LIB/neslib.h"
#include "LIB/nesdoug.h" 

// P2 register data
unsigned char* p2 = (unsigned char*)0x400D;
unsigned char p2val = 0x00;
unsigned char p2reg = 0x00;


#define BLACK 0x0f
#define DK_GY 0x00
#define LT_GY 0x10
#define WHITE 0x30


unsigned char pad1 = 0;
unsigned char pad1Next = 0;


// there's some oddities in the palette code, black must be 0x0f, white must be 0x30

const unsigned char palSprites[16] = {

	0x0f,0x15,0x26,0x11,
	0x0f,0x11,0x21,0x15,
	0x0f,0x15,0x25,0x19,
	0x0f,0x19,0x29,0x38

};


const unsigned char palette[]={
BLACK, DK_GY, LT_GY, WHITE,
0,0,0,0,
0,0,0,0,
0,0,0,0
}; 


#define BALLS_MAX	8

//balls parameters, the x, y positions and speed

static unsigned char ball_x[BALLS_MAX];
static unsigned char ball_y[BALLS_MAX];
static unsigned char ball_dx[BALLS_MAX];
static unsigned char ball_dy[BALLS_MAX];

unsigned char i, j = 0;
unsigned char spr = 0;

unsigned char menuIndexH = 0;
unsigned char menuIndexV = 0;

// Cursor data
unsigned char cursorX = 0;
unsigned char cursorY = 55;


 
 
#pragma bss-name(push, "ZEROPAGE")

// GLOBAL VARIABLES
// all variables should be global for speed
// zeropage global is even faster


// My own function, a 'printf'. Puts the character's sprite on VRAM which will display on NAMETABLE which will go to screen
void put_str(unsigned int adr, const char* str){
	// Where we put the character
	vram_adr(adr);
	// \0 Terminated string
	while(1){

		if(!*str)break;
		
		vram_put((*str++));
		
	}
}

// Another function, handles input and logic

void handleMenuInput(void){

	// Up the menu, only move up if we are not at the top of the menu
	if((pad1Next & PAD_UP) && menuIndexV){ 
		cursorY -= 16;
		--menuIndexV;
		*p2 = 0x0E;
		
	}


	// Down the menu, only move down if we are not at the bottom of the menu
	if((pad1Next & PAD_DOWN) && (menuIndexV < 3)){ 
		cursorY += 16;
		++menuIndexV;
		*p2 = 0x01;
		
	}

	// Left, same conditions horizontally

	if((pad1Next & PAD_LEFT) && menuIndexH){
		cursorX -= 136;
		--menuIndexH;
		*p2 = 0x05;
		
	}

	// Right
	if((pad1Next & PAD_RIGHT) && !menuIndexH){
		cursorX += 136;
		++menuIndexH;
		*p2 = 0x09;
		
	}

}



void main (void) {
	
	ppu_off(); // screen off

	pal_spr(palSprites);
	

	for(i = 0;i < BALLS_MAX; ++i){

		ball_x[i] = rand8();
		ball_y[i] = rand8();
		j = rand8();

		// x speed
		spr = 1 + (rand8() % 3);
		ball_dx[i] = j & 1? -spr:spr;

		// y speed

		spr = 1 + (rand8() % 3);
		ball_dy[i] = j & 1? -spr:spr;
	}

	pal_bg(palette); //	load the BG palette
	// Load pallete colors
	pal_spr(palSprites);

	// Write fake menu entries
		put_str(NTADR_A(1, 2), "GO GATORS!");
		put_str(NTADR_A(1, 4), "VIDEO MODE:");

		if(ppu_system()) put_str(NTADR_A(1, 5), "NTSC");
		else put_str(NTADR_A(1, 5), "PAL");

		put_str(NTADR_A(1, 7), "SUPER MARIO BROS");
		put_str(NTADR_A(1, 9), "MEGA MAN 2");
		put_str(NTADR_A(1, 11), "FINAL FANTASY");
		put_str(NTADR_A(1, 13), "NINJA GAIDEN");

		put_str(NTADR_A(18, 7), "SUPER MARIO 3");
		put_str(NTADR_A(18, 9), "TETRIS");
		put_str(NTADR_A(1, 16), "3 MSB OF 4017:");

		ppu_on_all();

	
	//ppu_on_all(); //	turn on screen
	// Infinite loop for now
	while (1){


		ppu_wait_nmi();
		oam_clear();

		spr = 0;

		for(i = 0; i < BALLS_MAX; ++i){

			if(i % 2) oam_spr(ball_x[i], ball_y[i], 0x55, i % 4);
			else oam_spr(ball_x[i], ball_y[i], 0x46, i % 4);

			ball_x[i] += ball_dx[i];
			ball_y[i] += ball_dy[i];
			if(ball_x[i]>=(256-8)) ball_dx[i]=-ball_dx[i];
			if(ball_y[i]>=(240-8)) ball_dy[i]=-ball_dy[i];

		}

		// Draw the cursor on the screen
		oam_spr(cursorX, cursorY, 0x7F, 0x00);
		// Read player1, go through logic depending on the inputs
		pad1 = pad_poll(0);
		pad1Next = get_pad_new(0);
		handleMenuInput();

		//Player 2 register logic
		p2val = *p2;
		p2val &= 0x0F;
		p2val += 0x30;
		oam_spr(0x80, 0x80, p2val, 0x0);

	}
}
