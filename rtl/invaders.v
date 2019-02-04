// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module invaders(
		            input wire        i_clk_36MHz, //input clock: 12MHz
		            input wire        i_reset, //synchronous i_reset
 		            input wire [4:0]  i_bullet_x,
		            input wire [3:0]  i_bullet_y,
		            output reg        o_hit,
		            output reg [19:0] o_invaders_array,
		            output reg [3:0]  o_invaders_line
		            );

   wire                           tick1;
   wire                           tick2;
   parameter SPEED = 100000;

   timer_1us #(SPEED) speed_timer1(
				                           .i_clk_36MHz(i_clk_36MHz),
				                           .i_reset(i_reset),
				                           .o_q(tick1)
				                           );

   timer_1us #(2000) speed_timer2(
				                          .i_clk_36MHz(i_clk_36MHz),
				                          .i_reset(i_reset),
				                          .o_q(tick2)
				                          );

   localparam RIGHT = 1'b1;
   localparam LEFT  = 1'b0;

   reg                            direction, moving;
   reg [2:0]                      current_state, next_state, state;


   initial begin
      o_invaders_array = 20'b00000000000111111111;
      o_invaders_line = 4'b0001;
      moving = 0;
      direction = LEFT;
      o_hit = 0;
      state = 0;
   end
   always @(posedge i_clk_36MHz) begin
      current_state <= next_state;
   end

   always @(*) begin
      if (i_reset == 0) begin
	       o_invaders_array = 20'b00000000000111111111;
	       o_invaders_line = 4'b0001;
	       moving = 0;
	       direction <= LEFT;
	       o_hit <= 0;
	       state <= 1;
      end
      else if ((i_bullet_y == o_invaders_line + 1) && (o_invaders_array[i_bullet_x] == 1)) begin
	       o_hit <= 1;
	       o_invaders_array[i_bullet_x] <= 0;
      end
      else if (tick1 == 1) begin
	       if (o_invaders_array[19] == 1 && direction == LEFT) begin
	          o_invaders_line <= o_invaders_line + 1;
	          moving <= 1;
	          direction <= RIGHT;
	          state <= 2;
	       end
	       else if (o_invaders_array[0] == 1 && direction == RIGHT) begin
	          o_invaders_line <= o_invaders_line + 1;
	          moving <= 1;
	          direction <= LEFT;
	          state <= 3;
	       end
	       else if (direction == RIGHT) begin
	          o_invaders_array <= o_invaders_array>>1;
	          moving <= 1;
	          state <= 4;
	       end
	       else if (direction == LEFT) begin
	          o_invaders_array <= o_invaders_array<<1;
	          moving <= 1;
	          state <= 5;
	       end
	       else begin
	          o_invaders_array <= o_invaders_array;
	          o_invaders_line <= o_invaders_line;
	          moving <= moving;
	          direction <= direction;
	          state <= 6;
	          o_hit <= 0;
	       end
      end // if (tick1)
      else begin
	       o_invaders_array <= o_invaders_array;
	       o_invaders_line <= o_invaders_line;
	       moving <= moving;
	       direction <= direction;
	       state <= 7;
	       o_hit <= 0;
      end // else: !if(tick1)
   end // always @ (posedge i_clk_36MHz)
`ifdef FORMAL
   always @(posedge i_clk_36MHz) begin
      assert (o_invaders_line < 14);
      assert (o_invaders_line >= 0);
   end
`endif
endmodule
