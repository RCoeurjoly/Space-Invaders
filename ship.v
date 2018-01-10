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
	    input wire 	     clk_12MHz,
	    input wire 	     reset, //synchronous reset
	    input wire 	     left_debounced,
	    input wire 	     right_debounced,
	    input wire 	     enable,
	    output reg [4:0] ship_x 
	    );   
   
   initial begin
      ship_x <= 5;
   end
   
   always @(posedge clk_12MHz)
     begin
	if (reset == 1)
	  begin
	     ship_x <= 5;
	  end
	else if (enable == 1)
	  begin
	     if (left_debounced == 1 && ship_x != 0)
	       ship_x <= ship_x - 1;
	     else if (right_debounced == 1 && ship_x != 19)
	       ship_x <= ship_x + 1;
	  end
	else
	  ship_x <= ship_x;
     end // always @ (posedge clk_85MHz)
endmodule
