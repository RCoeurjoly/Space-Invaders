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
// Description: When shot, starting to fly just over the ship
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bullet(
	    input wire 	     clk_12MHz,
	    input wire 	     reset, //synchronous reset
	    input wire 	     enable,
	    input wire 	     hit,
	    input wire 	     shoot,
	    input wire [4:0] ship_x,
	    output reg 	     bullet_flying,
	    output reg [4:0] bullet_x,
	    output reg [3:0] bullet_y
	    );   
   
   initial
     begin
	bullet_x <= 0;
	bullet_y <= 14;
	bullet_flying <= 0;
     end
   
   always @(posedge clk_12MHz)
     begin
	// reset condition
	if (reset == 1)
	  begin
	     bullet_flying <= 0;
	     bullet_x <= 0;
	     bullet_y <= 14;
	  end
	else
	  begin
	     if (bullet_flying == 0 && shoot == 1)
	       begin
		  bullet_flying = 1;
		  bullet_x <= ship_x;
		  bullet_y <= 13;
	       end
	     else if (hit == 1)
	       begin
		  bullet_flying <= 0;
		  bullet_x <= 0;
		  bullet_y <= 14; 
	       end
	     else if (bullet_flying == 1)
	       begin
		  if (bullet_y == 0)
		    begin
		       // Reached the top of the screen
		       bullet_flying = 0;
		       bullet_x <= ship_x;
		       bullet_y = 14;
		    end
		  else
		    bullet_y = bullet_y - 1;
	       end // if (bullet_flying == 1)
	  end // if (enable == 1)
     end // always @ (posedge clk_12MHz)
endmodule
