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
   reg                         current_state, next_state;

   localparam reset_state = 0;
   localparam moving_state = 1;

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
              next_state <= moving_state;
           end
           else begin
              o_bullet_x <= 0;
              o_bullet_y <= 14;
              next_state <= reset_state;
           end
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
   always @(posedge i_clk_25MHz) begin
      // Bullet position goes through all y positions
      for (reg [4:0] i = 0; i < 16; i++) begin
         cover (o_bullet_y == i);
      end
   end
   // Assertion to ensure bullet X-coordinate stays within a valid range
   // I use the property syntax introduced in Figure 5.4 in YosysHQ documentation https://yosyshq.readthedocs.io/projects/ap109/en/latest/index.html
   property p_valid_bullet_x_range;
      @(posedge i_clk_25MHz) disable iff (i_reset)
        (o_bullet_x >= 0) && (o_bullet_x < 32);
   endproperty
   assert property (p_valid_bullet_x_range) else $error("Bullet X-coordinate out of range");

   // Assertion to ensure bullet Y-coordinate stays within a valid range
   property p_valid_bullet_y_range;
      @(posedge i_clk_25MHz) disable iff (i_reset)
        (o_bullet_y >= 0) && (o_bullet_y < 16);
   endproperty
   assert property (p_valid_bullet_y_range) else $error("Bullet Y-coordinate out of range");

   // Assertion to ensure proper state transition from reset to initial
   // Thinking about this property made me simplify the design, going from 3 states (reset, initial, moving) to two (reset and moving)
   property p_reset_to_initial;
      @(posedge i_clk_25MHz) disable iff (i_reset)
        (current_state == reset_state && i_shoot) |-> ##1 (next_state == moving_state);
   endproperty
   assert property (p_reset_to_initial) else $error("Invalid state transition from reset to initial");
`endif
endmodule
