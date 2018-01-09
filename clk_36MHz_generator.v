//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    clk_36MHz
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
module clk_36MHz(
	     input wire       clk_12MHz,
	     output wire      clk_36MHz    
	     );
   
   SB_PLL40_CORE #(.FEEDBACK_PATH("SIMPLE"),
                   .PLLOUT_SELECT("GENCLK"),
		   .DIVR(4'b0000),
		   .DIVF(7'b0101111),
		   .DIVQ(3'b100),
		   .FILTER_RANGE(3'b001),
		   ) uut (
			  .REFERENCECLK(clk_12MHz),
			  .PLLOUTCORE(clk_36MHz),
			  .RESETB(1'b1),
			  .BYPASS(1'b0)
			  );
   endmodule
