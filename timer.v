//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    Timer
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
module Timer(
				input wire clk,
				input wire reset, //asynchronous reset
				input wire clr,
				input wire en,
				output reg q	       
				);

   parameter PERIOD = 1;
   localparam clk_freq = 12; //12 MHz clock
   localparam MAX = (PERIOD * clk_freq) - 1;
   reg [20:0] 				   count;

   initial begin
      q <= 0;
      count <= 0;
   end
   
   always @(posedge clk)
     begin
	if (clr == 0)
	  count <= 0;
	else
	  count <= count + 1;   
	if (count == MAX)
	  q <= 1;
	else
	  q <= 0;
     end // always @ (posedge clk)
endmodule
