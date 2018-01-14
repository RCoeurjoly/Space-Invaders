//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    bullet
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
module bullet(
	    input wire 	     clk,
	    input wire 	     reset,
	    input wire 	     clr, //asynchronous reset
	    input wire 	     enable,
	    input wire 	     hit,
	    input wire 	     shoot,
	    input wire [4:0] posH,
	    output reg 	     flying,
	    output reg [4:0] bulletX,
	    output reg [3:0] bulletY
	    );   
   
   initial
     begin
	bulletX <= 0;
	bulletY <= 14;
	flying <= 0;
     end
   
   always @(posedge clk)
     begin
	// reset condition
	if (reset == 1)
	  begin
	     bulletX <= 0;
	     bulletY <= 14;
	     flying <= 0;
	  end
	else if (enable == 1)
	  begin
	     if (flying == 0 && shoot == 1)
	       begin
		  flying = 1;
		  //starting just over the ship
		  bulletX <= posH;
		  bulletY <= 13;
	       end
	     if (hit == 1)
	       begin
		  flying <= 0;
		  bulletY <= 14; 
	       end
	     if (flying == 1)
	       begin
		  if (bulletY == 0)
		    begin
		       // Reached the top of the screen
		       flying = 0;
		       bulletY = 14;
		    end
		  else
		    bulletY = bulletY - 1;
	       end // if (flying == 1)
	  end // if (enable == 1)
     end // always @ (posedge clk)
endmodule
