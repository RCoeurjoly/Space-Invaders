// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module bullet(
	            input wire       i_clk_25MHz,
	            input wire       i_reset, //synchronous i_reset
	            input wire       i_shoot,
	            input wire       i_hit,
	            input wire [4:0] i_ship_x,
	            output reg [4:0] o_bullet_x,
	            output reg [3:0] o_bullet_y
	            );
   wire                        tick;
   reg [1:0]                   current_state, next_state;

   localparam reset_state = 0;
   localparam initial_state = 1;
   localparam moving_state = 2;

   timer_1us # (90000) timer_1us1(
				                          .i_clk_25MHz(i_clk_25MHz),
				                          .i_reset(i_reset),
				                          .o_q(tick)
				                          );
   initial begin
      o_bullet_x = 0;
      o_bullet_y = 15;
      current_state = reset_state;
      next_state = reset_state;
   end

   always @(posedge i_clk_25MHz) begin
      current_state <= next_state;
   end

   always @(posedge i_clk_25MHz) begin
      case (current_state)
        reset_state: begin
           if (i_shoot) begin
              o_bullet_x <= i_ship_x;
              o_bullet_y <= 12;
              next_state <= initial_state;
           end
           else begin
              o_bullet_x <= 0;
              o_bullet_y <= 15;
           end
        end
        initial_state: begin
           if (i_hit) begin
              o_bullet_x <= 0;
              o_bullet_y <= 14;
              next_state <= reset_state;
           end
           else next_state <= moving_state;
        end
        moving_state: begin
           if (i_hit) begin
              o_bullet_x <= 0;
              o_bullet_y <= 14;
              next_state <= reset_state;
           end
           else if (tick) begin
              o_bullet_y <= o_bullet_y - 1;
              next_state <= moving_state;
           end
           else if (o_bullet_y == 0) begin
              o_bullet_x <= 0;
              o_bullet_y <= 14;
              next_state <= reset_state;
           end
           else begin
              o_bullet_y <= o_bullet_y;
              next_state <= moving_state;
           end
        end // case: moving_state
        default: begin
           o_bullet_x <= 0;
           o_bullet_y <= 14;
           next_state <= reset_state;
        end
      endcase
   end // always @ (posedge i_clk_25MHz)
`ifdef FORMAL
   reg [4:0] i;
   always @(posedge i_clk_25MHz) begin
      // Bullet position always between 0 and 15
      assert (o_bullet_y <= 15);
      assert (o_bullet_y >= 0);
      // Bullet position goes through all y positions
      for (i = 0; i < 16; i++) begin
         cover (o_bullet_y == i);
      end
   end
`endif
endmodule
