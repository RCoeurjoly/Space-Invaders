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
	   input wire  dclk, //input clock: 12MHz
	   input wire  clr, //asynchronous reset
	   input wire  left,
	   input wire  right,
	   input wire  shoot,
	   output wire hsync, //horizontal sync out
	   output wire vsync, //vertical sync out
	   output wire red, //red vga output
	   output wire green, //green vga output
	   output wire blue //blue vga output 	       
	   );   
   wire 	       clk;
   wire [2:0] 	       rgb_game;
   wire [2:0] 	       rgb_VGA;
   assign rgb_VGA = rgb_game;
   wire [9:0] 	       X_format, X_vga;
   wire [9:0] 	       Y_format, Y_vga;
   assign X_format = X_vga;
   assign Y_format = Y_vga;
   wire [4:0] 	       posH_ship;
   
<<<<<<< HEAD
   /*
   assign red = red_vga;
   assign green = green_vga;
   assign blue = blue_vga;
   */
   clk_36MHz_generator clk_36MHz_generator1(
					    .clk_12MHz(dclk),
					    .clk_36MHz(clk)
					    );
=======
>>>>>>> ad81eb64e23fd2fc7e54f1ed6598670d1516c94e
   
   //-- Instanciar el vga
   vgaSI vgaSI1(
		.clk_36MHz(clk),
		.clr(clr),
		.RGB(rgb_VGA),
		.hsync(hsync),
		.vsync(vsync),
		.red_vga(red),
		.green_vga(green),
		.blue_vga(blue),
		.X(X_vga),
		.Y(Y_vga)
		);

   
   
   formatVGA formatVGA1(
			.VGAx(X_format),
			.VGAy(Y_format),
			.clr(clr),
			.invArray(20'b00101010101010101010),
			.invLine(5'b00100),
			.shipX(posH_ship),
			.bulletX(o_bulletX),
			.bulletY(o_bulletY),
			.bulletFlying(BulletActive),
			.rgb(rgb_game)
	    );

   edgeDetectorDebounce leftDetector(
				     .clk(clk),
				     .clr(clr),
				     .enable(1),
				     .in(left),
				     .detected(left)
				     );

   edgeDetectorDebounce rightDetector(
				      .clk(clk),
				      .clr(clr),
				      .enable(1),
				      .in(right),
				      .detected(right)
				      );
   ship ship1(
	      .dclk(clk),
	      .reset(0),
	      .clr(clr),
	      .left(left_ship),
	      .right(right_ship),
	      .enable(1),
	      .posH(posH_ship)
	      );

   player player1(
		  .clk(dclk),
		  .reset(0),
		  .clear(clr),
		  .left(left),
		  .right(right),
		  .start(1),
		  .shoot(shoot),
		  .ScoreClear(0),
		  .Enable(1),
		  .hit(left),
		  .posShip(posShip),
		  .startPulse(startPulse),
		  .bulletX(o_bulletX),
		  .bulletY(o_bulletY),
		  .BulletActive(BulletActive),
		  .Score(Score)
		  );

endmodule
