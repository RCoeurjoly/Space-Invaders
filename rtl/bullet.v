// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module bullet(
	            input wire       i_clk_36MHz,
	            input wire       i_reset, //synchronous i_reset
	            input wire       i_enable,
	            input wire       i_shoot,
	            input wire       i_hit,
	            input wire [4:0] i_ship_x,
	            output reg       o_bullet_flying,
	            output reg [4:0] o_bullet_x,
	            output reg [3:0] o_bullet_y
	            );
   wire                        tick;

   timer_1us # (90000) timer_1us1(
				                          .i_clk_36MHz(i_clk_36MHz),
				                          .i_reset(i_reset),
				                          .i_en(1),
				                          .o_q(tick)
				                          );
   initial begin
      o_bullet_flying = 0;
      o_bullet_x = 0;
      o_bullet_y = 14;
   end

   always @(posedge i_clk_36MHz) begin
      // i_reset condition
      if (i_reset == 0) begin
	       o_bullet_flying <= 0;
	       o_bullet_x <= 0;
	       o_bullet_y <= 14;
      end
      else begin
	       if (o_bullet_flying == 0) begin
	          if (i_shoot == 1) begin
	             o_bullet_flying <= 1;
	             o_bullet_x <= i_ship_x;
	             o_bullet_y <= 12;
	          end
	          else begin
	             o_bullet_flying <= 0;
	             o_bullet_x <= 0;
	             o_bullet_y <= o_bullet_y;
	          end
	       end
	       else begin
	          if (i_hit == 1 || o_bullet_y == 0) begin
	             o_bullet_flying <= 0;
	             o_bullet_x <= 0;
	             o_bullet_y <= 15;
	          end else if (tick) begin
	             o_bullet_flying <= o_bullet_flying;
	             o_bullet_x <= o_bullet_x;
	             o_bullet_y <= o_bullet_y - 1;
	          end
	          else begin
	             o_bullet_flying <= o_bullet_flying;
	             o_bullet_x <= o_bullet_x;
	             o_bullet_y <= o_bullet_y;
               o_b
	          end
	       end // else: !if(o_bullet_flying == 0)
      end // else: !if(i_reset == 0)
   end // always @ (posedge i_clk_36MHz)
`ifdef FORMAL
   always @(posedge i_clk_36MHz) begin
      assert (o_bullet_y < 16);
      assert (o_bullet_y >= 0);
   end
`endif
endmodule
