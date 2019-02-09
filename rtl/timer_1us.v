// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module timer_1us(
		             input wire i_clk_25MHz,
		             input wire i_reset, //synchronous reset
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

   always @(posedge i_clk_25MHz) begin
	    if (i_reset == 1) begin
	       count <= 0;
         o_q <= 0;
      end
	    else if (count == MAX) begin
	       count <= 0;
         o_q <= 1;
      end
	    else begin
	       count <= count + 1;
         o_q <= 0;
	    end
   end // always @ (posedge i_clk_25MHz)
`ifdef FORMAL
   always @(*) begin
      cover (count <= MAX );
      cover (o_q);
   end
`endif
endmodule
