// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module hit_detector(
		    input wire 	      clk_36MHz,
		    input wire 	      reset, //synchronous reset
		    input wire [3:0]  bullet_y,
		    input wire [4:0]  bullet_x,		    
		    input wire [3:0]  invaders_line,
		    inout wire [19:0] invaders_array,
		    output reg       hit
		    );

   initial begin
      hit <= 0;
   end
   
   always @(posedge clk_36MHz) begin
      // reset condition
      if (reset == 0) begin
	 hit <= 0;
      end
      else begin
	 if ((bullet_y == invaders_line) && (invaders_array[bullet_x] == 1)) begin
	    hit <= 1;
	    invaders_array[bullet_x] == 0;
	 end
      end // always @ (posedge clk_36MHz)

endmodule
