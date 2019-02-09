// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module timer_1us(
		 input wire clk_25MHz,
		 input wire reset, //synchronous reset
		 input wire en,
		 output reg q	       
		 );

   parameter PERIOD = 1;
   localparam CLK_FREQ = 36; //36 MHz clock
   localparam MAX = (PERIOD * CLK_FREQ) - 1;

   reg [31:0] 		    count;

   initial begin
      q <= 0;
      count <= 0;
   end
   
   always @(posedge clk_25MHz)
     begin
	if (reset == 0)
	  count <= 0;
	else if (en == 1) begin
	   if (count == MAX)
	     count <= 0;
	   else
	     count <= count + 1;
	end
	else
	  count <= 0;
	if (count == MAX)
	  q <= 1;
	else
	  q <= 0;
     end // always @ (posedge clk_25MHz)
endmodule
