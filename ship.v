//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    ship
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
module ship(
	    input wire 	     dclk,
	    input wire 	     reset,
	    input wire 	     clr, //asynchronous reset
	    input wire 	     left,
	    input wire 	     right,
	    input wire 	     enable,
	    output reg [4:0] posH 
	    );   

   initial begin
      posH <= 5;
   end
   
   always @(posedge dclk)
     begin
	if (clr == 0)
	  begin
	     posH <= 5;
	  end
	else 
	  if (enable == 1)
	    begin
	       if (left == 1 && posH != 0)
		 posH <= posH - 1;
	       else if (right == 1 && posH != 19)
		 posH <= posH + 1;
	    end
	  else
	    posH <= posH;
     end // always @ (posedge dclk)
endmodule
