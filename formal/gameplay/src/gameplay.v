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
        if (i_reset == 0)
	        begin
	           o_gameplay <= PLAYING;
	        end
	      else
	        begin
	           if (i_invaders_line == 13)
	             o_gameplay <= GAME_OVER;
	           else if (i_invaders_array == 0)
	             o_gameplay <= YOU_WIN;
	           else
	             o_gameplay <= PLAYING;
	        end
     end // always @ (posedge i_clk_25MHz)
`ifdef FORMAL
   reg GAME_OVER_reached;
   initial begin
      GAME_OVER_reached = 0;
   end
   always @(posedge i_clk_25MHz) begin
      if (o_gameplay == GAME_OVER)
        GAME_OVER_reached <= 1;
      assert (!(GAME_OVER_reached && (o_gameplay <= PLAYING || o_gameplay <= YOU_WIN)));
   end
`endif
endmodule
