// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module gameplay(
	       input wire 	 clk_36MHz,
	       input wire 	 reset,
	       input wire [19:0] invaders_array, 
	       input wire [3:0]  invaders_line,
	       output reg [1:0]  gameplay
	       );
   
   parameter PLAYING = 2'b00;
   parameter YOU_WIN = 2'b01;
   parameter GAME_OVER = 2'b10;
   
   initial
     begin
	gameplay <= PLAYING;     
     end
   
   always @(posedge clk_36MHz)
     begin
        if (reset == 0)
	  begin
	     gameplay <= PLAYING;
	  end
	else
	  begin
	     if (invaders_line == 3)  
	       gameplay <= GAME_OVER;
	     else if (invaders_array == 0)
	       gameplay <= YOU_WIN;
	     //else
	       //gameplay <= PLAYING;
	  end
     end // always @ (posedge clk_36MHz)
   
endmodule
