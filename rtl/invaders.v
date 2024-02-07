// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module invaders(
		            input wire        i_clk_25MHz, //input clock: 12MHz
		            input wire        i_reset, //synchronous i_reset
 		            input wire [4:0]  i_bullet_x,
		            input wire [3:0]  i_bullet_y,
		            output reg        o_hit,
		            output reg [19:0] o_invaders_array,
		            output reg [3:0]  o_invaders_row
		            );

   wire                           tick;
   parameter SPEED = 100000;

   timer_1us #(SPEED) speed_timer1(
				                           .i_clk_25MHz(i_clk_25MHz),
				                           .i_reset(i_reset),
				                           .o_q(tick)
				                           );

   localparam RIGHT = 1'b1;
   localparam LEFT  = 1'b0;

   reg                            direction, moving;


   initial begin
      o_invaders_array = 20'b00000000000111111111;
      o_invaders_row = 4'b0000;
      moving = 0;
      direction = LEFT;
      o_hit = 0;
   end

   always @(posedge i_clk_25MHz) begin
      if (i_reset == 1) begin
	       o_invaders_array <= 20'b00000000000111111111;
	       o_invaders_row <= 4'b0000;
	       moving <= 0;
	       direction <= LEFT;
	       o_hit <= 0;
      end
      else if ((i_bullet_y == o_invaders_row + 1) && (o_invaders_array[i_bullet_x] == 1)) begin
	       o_hit <= 1;
	       o_invaders_array[i_bullet_x] <= 0;
      end
	    else if (o_invaders_row == 14) begin
         o_invaders_array <= o_invaders_array;
	       o_invaders_row <= o_invaders_row;
	       moving <= moving;
	       direction <= direction;
	       o_hit <= 0;
      end
      else if (tick == 1) begin
         if (direction == LEFT) begin
            if (o_invaders_array[19] == 1) begin
	             o_invaders_row <= o_invaders_row + 1;
	             moving <= 1;
	             direction <= RIGHT;
            end
            else begin
               o_invaders_array <= o_invaders_array<<1;
	             moving <= 1;
            end
         end // if (direction == LEFT)
         else if (direction == RIGHT) begin
            if (o_invaders_array[0] == 1) begin
	             o_invaders_row <= o_invaders_row + 1;
	             moving <= 1;
	             direction <= LEFT;
            end
            else begin
               o_invaders_array <= o_invaders_array>>1;
	             moving <= 1;
            end
         end // if (direction == RIGHT)
         else begin
	          o_invaders_array <= o_invaders_array;
	          o_invaders_row <= o_invaders_row;
	          moving <= moving;
	          direction <= direction;
	          o_hit <= 0;
	       end // else: !if(direction == RIGHT)
      end // if (tick1 == 1)
      else begin
	       o_invaders_array <= o_invaders_array;
	       o_invaders_row <= o_invaders_row;
	       moving <= moving;
	       direction <= direction;
	       o_hit <= 0;
      end // else: !if(tick1)
   end
`ifdef FORMAL
   // Immediate assemrtion to ensure that when a reset is applied, the invaders array is correctly initialized
   always @(posedge i_clk_25MHz) begin
      if (i_reset == 1) begin
         assert (o_invaders_array == 20'b00000000000111111111) else $error("Reset state of invaders array is incorrect.");
         assert (o_invaders_row == 4'b0000) else $error("Reset state of invaders row is incorrect.");
      end
   end

   // Immediate assertion to check the bullet hit logic is correct
   always @(posedge i_clk_25MHz) begin
      if ((i_bullet_y == o_invaders_row + 1) && (o_invaders_array[i_bullet_x] == 1)) begin
         assert (o_hit == 1) else $error("Bullet hit not detected correctly.");
      end
   end

   // reg [4:0] i;
   // // always @(*) begin
   //    // Invaders position goes through all y positions
   // for (i = 0; i < 16; i++) begin
   //    cover (o_invaders_row == i);
   // end
   // // end

`endif
endmodule
