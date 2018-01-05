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
   
   
   //-- Instanciar el vga
   vgaSI vgaSI1(
		.dclk(dclk),
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
			.invLine(4'b0010),
			.shipX(posH_ship),
			.bulletX(4'b0100),
			.bulletY(3'b011),
			.bulletFlying(1),
			.rgb(rgb_game)
	    );

   edgeDetectorDebounce leftDetector(
				     .clk(dclk),
				     .clr(clr),
				     .enable(1),
				     .in(left),
				     .detected(left_ship)
				     );

   edgeDetectorDebounce rightDetector(
				      .clk(dclk),
				      .clr(clr),
				      .enable(1),
				      .in(right),
				      .detected(right_ship)
				      );
   ship ship1(
	      .dclk(dclk),
	      .reset(0),
	      .clr(clr),
	      .left(left_ship),
	      .right(right_ship),
	      .enable(1),
	      .posH(posH_ship)
	      );
   
endmodule
