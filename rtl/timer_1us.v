// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module timer_1us(
		             input wire i_clk_36MHz,
		             input wire i_reset, //synchronous reset
		             input wire i_en,
		             output reg o_q
		             );

   parameter PERIOD = 1;
   localparam CLK_FREQ = 36; //36 MHz clock
   localparam MAX = (PERIOD * CLK_FREQ) - 1;

   reg [31:0]               count;

   initial begin
      o_q = 0;
      count = 0;
   end

   always @(posedge i_clk_36MHz)
     begin
	      if (i_reset == 0)
	        count <= 0;
	      else if (i_en == 1) begin
	         if (count == MAX)
	           count <= 0;
	         else
	           count <= count + 1;
	      end
	      else
	        count <= 0;
	      if (count == MAX)
	        o_q <= 1;
	      else
	        o_q <= 0;
     end // always @ (posedge i_clk_36MHz)
endmodule
