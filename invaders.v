// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module invaders(
	   input wire 	    clk_36MHz, //input clock: 12MHz
	   input wire 	    reset, //synchronous reset
	   input wire 	    start,
 	   input wire 	    bullet_x,
	   input wire 	    bull_y,
	   input wire 	    [2:0] level,
	   output wire 	    hit,
	   inout reg [19:0] invaders_array,
	   inout reg [4:0]  invaders_line,
	   );   
   
   timer_1us speed_timer1(
		     .clk_36MHz(clk_36MHz),
		     .reset(reset),
		     .en(1),
		     .q(tick1)
		     );
   
   timer_1us speed_timer2(
		     .clk_36MHz(clk_36MHz),
		     .reset(reset),
		     .en(1),
		     .q(tick2)
		     );

   defparam speed_timer1.PERIOD = 200;
   defparam speed_timer2.PERIOD = 400;
   reg 			    direction, tick, tick1, tick2, moving, hit1;
   
   always @(posedge clk_36MHz) begin
      if (reset = 1) begin
	 direction <= 0;
	 moving <= 0;
	 hit <= 0;	     
      end
      else if 
      
   end

endmodule
