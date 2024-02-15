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
   default disable iff (i_reset);
   // --------------- Inmediate assertions ---------------------------
   // Immediate assertion to ensure that when a reset is applied, the invaders array is correctly initialized
   always @(posedge i_clk_25MHz) begin
      if (i_reset == 1) begin
         assert (o_invaders_array == 20'b00000000000111111111) else $error("Reset state of invaders array is incorrect.");
         assert (o_invaders_row == 4'b0000) else $error("Reset state of invaders row is incorrect.");
      end
   end

   // Example of range check for invaders_row (assuming valid rows are from 0 to some upper limit)
   property p_valid_invaders_row;
      @(posedge i_clk_25MHz) (o_invaders_row >= 0 && o_invaders_row < 16); // Adjust according to actual row count
   endproperty
   assert property (p_valid_invaders_row) else $error("Invalid invaders_row value");

   // --------------- Concurrent assertions ---------------------------
   // Clock and Reset Assertions
   property p_reset_initial;
      @(posedge i_clk_25MHz) i_reset |-> ##1 !i_reset[*];
   endproperty
   assert property (p_reset_initial) else $error("Reset was not maintained after the first release");

   // Safety Checks
   // Ensure invaders_array remains constant when reset is asserted
   // Note the use of $changed, documented in https://yosyshq.readthedocs.io/projects/ap109/en/latest/index.html#the-changed-function
   property p_invaders_array_on_reset;
      @(posedge i_clk_25MHz) i_reset |=> !$changed(o_invaders_array);
   endproperty
   assert property (p_invaders_array_on_reset) else $error("Invaders array changed during reset");

   // Ensure 'hit' is not asserted when 'reset' is active
   property p_hit_on_reset;
      @(posedge i_clk_25MHz) i_reset |-> !o_hit;
   endproperty
   assert property (p_hit_on_reset) else $error("Hit signal asserted during reset");

`endif
endmodule
