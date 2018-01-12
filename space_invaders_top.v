//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    top
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module space_invaders_top(
	   input wire  clk_12MHz, //input clock: 12MHz
	   input wire  reset, //synchronous reset
	   input wire  left,
	   input wire  right,
	   input wire  shoot,
	   input wire  start,		  
	   output wire hsync, //horizontal sync out
	   output wire vsync, //vertical sync out
	   output wire red, //red vga output
	   output wire green, //green vga output
	   output wire blue //blue vga output 	       
	   );   
   
   wire 	       clk_36MHz;
   wire [2:0] 	       rgb;
   wire [9:0]	       x;
   wire [9:0]	       y;
   wire [4:0] ship_x;
   wire [4:0] bullet_x;
   wire [3:0] bullet_y;
   wire bullet_flying;
   wire clear;
   wire start_debounced;
   wire [7:0] score;
   
   clk_36MHz_generator clk_36MHz_generator1(
			.clk_12MHz(clk_12MHz),
			.clk_36MHz(clk_36MHz)
			);
   
   vga_controller vga_controller1(
	    .clk_36MHz(clk_36MHz),
	    .rgb(rgb),
	    .hsync(hsync),
	    .vsync(vsync),
	    .red(red),
	    .green(green),
	    .blue(blue),
	    .x(x),
	    .y(y)
	    );
   
   sprite_drawer sprite_drawer1(
			  .x(x),
			  .y(y),
			  .reset(reset),
			  .invaders_array(20'b00101010101010101010),
			  .invaders_line(5'b00100),
			  .ship_x(ship_x),
			  .bullet_x(bullet_x),
			  .bullet_y(bullet_y),
			  .bullet_flying(bullet_flying),
			  .rgb(rgb)
			  );
      
   player player1(
		  .clk_36MHz(clk_36MHz),
		  .reset(reset),
		  .clear(clear),
		  .left(left),
		  .right(right),
		  .start(start),
		  .shoot(shoot),
		  .clear_score(clear_score),
		  .enable(enable),
		  .hit(left),
		  .ship_x(ship_x),
		  .start_debounced(start_debounced),
		  .bullet_x(bullet_x),
		  .bullet_y(bullet_y),
		  .bullet_flying(bullet_flying),
		  .score(score)
		  );

   assign enable = 1;
   
endmodule
