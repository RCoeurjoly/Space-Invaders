//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:
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
module invaders(
	   input wire 	    dclk, //input clock: 12MHz
	   input wire 	    clr, //asynchronous reset
	   input wire 	    start,
 	   input wire 	    bullX,
	   input wire 	    bullY,
	   input wire 	    [2:0] level,
	   output wire 	    hit,
	   inout reg [19:0] invArray,
	   inout reg [4:0]  invLine,
	   );   
   
   Timer speedTimer1(
		     .clk(dclk),
		     .reset(reset),
		     .clr(clr),
		     .en(),
		     .q()
		     );
   
   Timer speedTimer1(
		     .clk(dclk),
		     .reset(reset),
		     .clr(clr),
		     .en(),
		     .q()
		     );

   defparam speedTimer1.PERIOD = 200;
   defparam speedTimer2.PERIOD = 400;
   reg 			    direction, tick, tick1, tick2, moving, hit1;
   
   
   always @(posedge clk)
     begin
	if (reset = 1)
	  begin
	     direction <= 0;
	     moving <= 0;
	     hit1 <= 0;	     
	  end
	
	     
     end

endmodule
