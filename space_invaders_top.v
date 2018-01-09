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
module top(
	   input wire  clk_12MHz, //input clock: 12MHz
	   input wire  reset, //asynchronous reset
	   input wire  left,
	   input wire  right,
	   input wire  shoot,
	   output wire hsync, //horizontal sync out
	   output wire vsync, //vertical sync out
	   output wire red, //red vga output
	   output wire green, //green vga output
	   output wire blue //blue vga output 	       
	   );   
   
   clk_36MHz clk_36MHz1(
			.clk_12MHz(clk_12MHz),
			.clk_36MHz(clk_36MHz)
			);
   
   vga vga1(
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
   
   format_vga format_vga1(
			  .x(x),
			  .y(y),
			  .reset(reset),
			  .invaders_array(20'b00101010101010101010),
			  .invaders_line(5'b00100),
			  .ship_x(ship_x),
			  .bullet_x(bullet_x),
			  .bullet_y(bullet_x),
			  .bullet_flying(bullet_flying),
			  .rgb(rgb)
			  );
      
   player player1(
		  .clk_12MHz(clk_12MHz),
		  .reset(0),
		  .clear(clr),
		  .left(left),
		  .right(right),
		  .start(1),
		  .shoot(shoot),
		  .clear_score(0),
		  .enable(1),
		  .hit(left),
		  .ship_x(ship_x),
		  .start_pulse(start_pulse),
		  .bullet_x(bullet_x),
		  .bullet_y(bullet_y),
		  .bullet_flying(bullet_flying),
		  .score(score)
		  );

endmodule
