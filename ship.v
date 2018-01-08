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
	    input wire 	     clk,
	    input wire 	     reset,
	    input wire 	     clear, //asynchronous reset
	    input wire 	     left,
	    input wire 	     right,
	    input wire 	     enable,
	    output reg [4:0] ship_x 
	    );   

   initial begin
      posH <= 5;
   end
   
   always @(posedge clk_85MHz)
     begin
	if (reset == 0)
	  begin
	     ship_x <= 5;
	  end
	else if (enable == 1)
	    begin
	       if (left == 1 && ship_x != 0)
		 ship_x <= ship_x - 1;
	       else if (right == 1 && ship_x != 19)
		 ship_x <= ship_x + 1;
	    end
	  else
	    ship_x <= ship_x;
     end // always @ (posedge clk_85MHz)
endmodule
