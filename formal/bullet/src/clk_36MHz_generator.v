// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module clk_25MHz_generator(
			   input wire  i_clk_12MHz,
			   output wire o_clk_25MHz
			   );

`ifndef SYNTHESIS
   // SIMULATION
   assign o_clk_25MHz = i_clk_12MHz;
`else
   // SYNTHESIS
   SB_PLL40_CORE #(
		   .FEEDBACK_PATH("SIMPLE"),
		   .PLLOUT_SELECT("GENCLK"),
		   .DIVR(4'b0000),
		   .DIVF(7'b0101111),
		   .DIVQ(3'b100),
		   .FILTER_RANGE(3'b001),
		   ) uut (
			  .REFERENCECLK(i_clk_12MHz),
			  .PLLOUTCORE(o_clk_25MHz),
			  .RESETB(1'b1),
			  .BYPASS(1'b0)
			  );
`endif

endmodule
