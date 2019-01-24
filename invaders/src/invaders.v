// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module invaders(
		            input wire        clk_36MHz, //input clock: 12MHz
		            input wire        reset, //synchronous reset
		            input wire        start,
 		            input wire [4:0]  bullet_x,
		            input wire [3:0]  bullet_y,
		            input wire [2:0]  level,
		            output reg        hit,
		            output reg [19:0] invaders_array,
		            output reg [3:0]  invaders_line
		            );

   wire                           tick1;
   wire                           tick2;
   parameter SPEED = 100000;

   timer_1us #(SPEED) speed_timer1(
				                           .clk_36MHz(clk_36MHz),
				                           .reset(reset),
				                           .en(1),
				                           .q(tick1)
				                           );

   timer_1us #(2000) speed_timer2(
				                          .clk_36MHz(clk_36MHz),
				                          .reset(reset),
				                          .en(1),
				                          .q(tick2)
				                          );

   localparam RIGHT = 1'b1;
   localparam LEFT  = 1'b0;

   reg                            direction, moving;
   reg [2:0]                      state;


   initial begin
      invaders_array <= 20'b00000000000111111111;
      invaders_line <= 4'b0001;
      moving <= 0;
      direction <= LEFT;
      hit <= 0;
      state <= 0;
   end

   always @(posedge clk_36MHz) begin
      if (reset == 0) begin
	       invaders_array <= 20'b00000000000111111111;
	       invaders_line <= 4'b0001;
	       moving <= 0;
	       direction <= LEFT;
	       hit <= 0;
	       state <= 1;
      end
      else if ((bullet_y == invaders_line + 1) && (invaders_array[bullet_x] == 1)) begin
	       hit <= 1;
	       invaders_array[bullet_x] <= 0;
      end
      else if (tick1 == 1) begin
	       if (invaders_array[19] == 1 && direction == LEFT) begin
	          invaders_line <= invaders_line + 1;
	          moving <= 1;
	          direction <= RIGHT;
	          state <= 2;
	       end
	       else if (invaders_array[0] == 1 && direction == RIGHT) begin
	          invaders_line <= invaders_line + 1;
	          moving <= 1;
	          direction <= LEFT;
	          state <= 3;
	       end
	       else if (direction == RIGHT) begin
	          invaders_array <= invaders_array>>1;
	          moving <= 1;
	          state <= 4;
	       end
	       else if (direction == LEFT) begin
	          invaders_array <= invaders_array<<1;
	          moving <= 1;
	          state <= 5;
	       end
	       else begin
	          invaders_array <= invaders_array;
	          invaders_line <= invaders_line;
	          moving <= moving;
	          direction <= direction;
	          state <= 6;
	          hit <= 0;
	       end
      end // if (tick1)
      else begin
	       invaders_array <= invaders_array;
	       invaders_line <= invaders_line;
	       moving <= moving;
	       direction <= direction;
	       state <= 7;
	       hit <= 0;
      end // else: !if(tick1)
   end // always @ (posedge clk_36MHz)
`ifdef FORMAL
   always @(posedge clk_36MHz) begin
      assert (invaders_line < 14);
      assert (invaders_line >= 0);
   end
`endif
endmodule
