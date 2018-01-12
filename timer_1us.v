// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module timer_1us(
		 input wire clk_36MHz,
		 input wire reset, //synchronous reset
		 input wire en,
		 output reg q	       
		 );

   parameter PERIOD = 1;
   localparam CLK_FREQ = 12; //12 MHz clock
   localparam MAX = (PERIOD * CLK_FREQ) - 1;
   reg [20:0] 				   count;

   initial begin
      q <= 0;
      count <= 0;
   end
   
   always @(posedge clk_36MHz)
     begin
	if (reset == 1)
	  count <= 0;
	else
	  count <= count + 1;   
	if (count == MAX)
	  q <= 1;
	else
	  q <= 0;
     end // always @ (posedge clk_36MHz)
endmodule
