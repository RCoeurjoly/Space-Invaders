//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    player
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
module player(
	      input wire       clk,
	      input wire       reset,
	      input wire       clear,
	      input wire       left,
	      input wire       right,
	      input wire       start,
	      input wire       shoot,
	      input wire       ScoreClear,
	      input wire       Enable,
	      input wire       hit,
	      output reg [4:0] posShip,
	      output reg       startPulse,
	      output reg [4:0] BulletX,
	      output reg [3:0] BulletY,
	      output reg       BulletActive,
	      output reg [7:0] Score
	   );   
   reg 			       leftDetected;
   reg 			       rightDetected;
   reg [4:0] 		       posHBus;
   
   ship ship1(
	      .dclk(dclk),
	      .reset(Reset),
	      .clr(clear),
	      .left(leftDetected),
	      .right(rightDetected),
	      .enable(enable),
	      .posH(posHBus)
	      );
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
				     .enable(enable),
				     .in(left),
				     .detected(leftDetected)
				     );

   edgeDetectorDebounce rightDetector(
				      .clk(dclk),
				      .clr(clr),
				      .enable(enable),
				      .in(right),
				      .detected(rightDetected)
				      );
   edgeDetectorDebounce startDetector(
				      .clk(dclk),
				      .clr(0),
				      .enable(1),
				      .in(Start),
				      .detected(startPulse)
				      );
  
   bullet bullet1(
		  .dclk(dclk),
		  .reset(Reset),
		  .clr(clear),
		  .enable(enable),
		  .hit(hit),
		  .shoot(shoot),
		  .posH(posHBus),
		  .flying(BulletActive),
		  .bullX(BulletX),
		  .bullY(BulletY)
		  );
   
   always @(posedge clk)
     begin
	posShip <= posHBus;
	// reset condition
	if (reset == 1)
	  begin
	     intScore <= 0;
	  end
	else
	  begin
	     if (ScoreClear == 1)  
	       intScore <= 0;
	     else if (hit == 1)
	       intScore <= intScore + 1;
	  end
     end // always @ (posedge clk)
endmodule
