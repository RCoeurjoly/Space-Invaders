// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module clk_36MHz_generator(
	     input wire       clk_12MHz,
	     output wire      clk_36MHz    
	     );
   assign clk_36MHz = clk_12MHz;
   
endmodule
