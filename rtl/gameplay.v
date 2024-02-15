// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module gameplay(
		            input wire        i_clk_25MHz,
		            input wire        i_reset,
		            input wire [19:0] i_invaders_array,
		            input wire [3:0]  i_invaders_line,
		            output reg [1:0]  o_gameplay
		            );

   parameter PLAYING = 2'b00;
   parameter YOU_WIN = 2'b01;
   parameter GAME_OVER = 2'b10;

   initial
     begin
	      o_gameplay = PLAYING;
     end

   always @(posedge i_clk_25MHz)
     begin
        if (i_reset == 1)
	        begin
	           o_gameplay <= PLAYING;
	        end
	      else
	        begin
	           if (i_invaders_line == 14)
	             o_gameplay <= GAME_OVER;
	           else if (i_invaders_array == 0)
	             o_gameplay <= YOU_WIN;
	           else
	             o_gameplay <= PLAYING;
	        end
     end // always @ (posedge i_clk_25MHz)


`ifdef FORMAL
   default disable iff (i_reset);
   // Note we use past function, documented in https://yosyshq.readthedocs.io/projects/ap109/en/latest/index.html#the-past-function
   assert property (@(posedge i_clk_25MHz) i_reset |-> ##1 $past(o_gameplay) == PLAYING);
   assert property (@(posedge i_clk_25MHz) i_invaders_line == 14 |-> ##1 o_gameplay == GAME_OVER);
   assert property (@(posedge i_clk_25MHz) i_invaders_array == 0 && i_invaders_line != 14 |-> ##1 o_gameplay == YOU_WIN);
   assert property (@(posedge i_clk_25MHz) disable iff (i_reset) o_gameplay == PLAYING ##1 (i_invaders_line != 14 && i_invaders_array != 0) |-> ##1 o_gameplay == PLAYING);
   // Forbiden state machine transitions:
   // Cannot go from YOU_WIN to GAME_OVER
   // Cannot go from GAME_OVER to YOU_WIN
   // These properties do not hold because the invaders is an input and can jump from 14 line to 0.
   // In real playtime is shouldn't. We should assume that i_invaders_line cannot jump more than 1 line in a clock cycle
   // assert property (@(posedge i_clk_25MHz) disable iff (i_reset) o_gameplay == GAME_OVER |-> ##1 o_gameplay != YOU_WIN);
   // assert property (@(posedge i_clk_25MHz) disable iff (i_reset) o_gameplay == YOU_WIN |-> ##1 o_gameplay != GAME_OVER);
`endif
endmodule
