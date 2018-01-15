// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module bullet(
	    input wire 	     clk_36MHz,
	    input wire 	     reset, //synchronous reset
	    input wire 	     enable,
	    input wire 	     hit,
	    input wire 	     shoot,
	    input wire [4:0] ship_x,
	    output reg 	     bullet_flying,
	    output reg [4:0] bullet_x,
	    output reg [3:0] bullet_y
	    );

   timer_1us # (90000) timer_1us1(
				 .clk_36MHz(clk_36MHz),
				 .reset(reset),
				 .en(1),
				 .q(tick)
				 );
   
   initial begin
      bullet_flying <= 0;
      bullet_x <= 0;
      bullet_y <= 14;
   end
   
   always @(posedge clk_36MHz) begin
      // reset condition
      if (reset == 0) begin
	 bullet_flying <= 0;
	 bullet_x <= 0;
	 bullet_y <= 14;
      end
      else begin
	 if (bullet_flying == 0) begin
	    if (shoot == 1) begin
	       bullet_flying = 1;
	       bullet_x <= ship_x;
	       bullet_y <= 12;
	    end
	    else begin
	       bullet_flying <= 0;
	       bullet_x <= 0;
	       bullet_y <= bullet_y;
	    end
	 end
	 else begin 
	    if (hit == 1 || bullet_y == 0) begin
	       bullet_flying <= 0;
	       bullet_x <= 0;
	       bullet_y <= 15; 
	    end else if (tick) begin
	       bullet_flying <= bullet_flying;
	       bullet_x <= bullet_x;
	       bullet_y = bullet_y - 1;
	    end
	    else begin
	       bullet_flying <= bullet_flying;
	       bullet_x <= bullet_x;
	       bullet_y <= bullet_y; 
	    end
	 end // else: !if(bullet_flying == 0)
      end // else: !if(reset == 0)
   end // always @ (posedge clk_36MHz)

endmodule
