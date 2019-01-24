// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module ship(
	    input wire 	     clk_36MHz,
	    input wire 	     reset, //synchronous reset
	    input wire 	     left_debounced,
	    input wire 	     right_debounced,
	    input wire 	     enable,
	    output reg [4:0] ship_x
	    );

   reg [20:0] 		     next_state;
   reg [20:0] 		     current_state;

   parameter [20:0] init = 21'b000000000000000000001;
   parameter [20:0] S0   = 21'b000000000000000000010;
   parameter [20:0] S1   = 21'b000000000000000000100;
   parameter [20:0] S2   = 21'b000000000000000001000;
   parameter [20:0] S3   = 21'b000000000000000010000;
   parameter [20:0] S4   = 21'b000000000000000100000;
   parameter [20:0] S5   = 21'b000000000000001000000;
   parameter [20:0] S6   = 21'b000000000000010000000;
   parameter [20:0] S7   = 21'b000000000000100000000;
   parameter [20:0] S8   = 21'b000000000001000000000;
   parameter [20:0] S9   = 21'b000000000010000000000;
   parameter [20:0] S10  = 21'b000000000100000000000;
   parameter [20:0] S11  = 21'b000000001000000000000;
   parameter [20:0] S12  = 21'b000000010000000000000;
   parameter [20:0] S13  = 21'b000000100000000000000;
   parameter [20:0] S14  = 21'b000001000000000000000;
   parameter [20:0] S15  = 21'b000010000000000000000;
   parameter [20:0] S16  = 21'b000100000000000000000;
   parameter [20:0] S17  = 21'b001000000000000000000;
   parameter [20:0] S18  = 21'b010000000000000000000;
   parameter [20:0] S19  = 21'b100000000000000000000;

   initial begin
      current_state <= init;
   end

   always @(posedge clk_36MHz) begin
      current_state <= next_state;
   end
   always @(reset or left_debounced or right_debounced or enable or current_state) begin
      case (current_state)
	init : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state =  init;
	   end
	   else begin
	      ship_x = 5;
	      next_state = S5;
	   end
	end
	S0 : begin //left limit
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 1;
	      next_state = S1;
	   end
	   else begin
	      ship_x = 0;
	      next_state = S0;
	   end
	end
	S1 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 0;
	      next_state = S0;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 2;
	      next_state = S2;
	   end
	   else begin
	      ship_x = 1;
	      next_state = S1;
	   end
	end
	S2 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 1;
	      next_state = S1;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 3;
	      next_state = S3;
	   end
	   else begin
	      ship_x = 2;
	      next_state = S2;
	   end
	end
	S3 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 2;
	      next_state = S2;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 4;
	      next_state = S4;
	   end
	   else begin
	      ship_x = 3;
	      next_state = S3;
	   end
	end
	S4 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 3;
	      next_state = S3;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 5;
	      next_state = S5;
	   end
	   else begin
	      ship_x = 4;
	      next_state = S4;
	   end
	end
	S5 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 4;
	      next_state = S4;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 6;
	      next_state = S6;
	   end
	   else begin
	      ship_x = 5;
	      next_state = S5;
	   end
	end
	S6 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 6;
	      next_state = S5;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 7;
	      next_state = S7;
	   end
	   else begin
	      ship_x = 6;
	      next_state = S6;
	   end
	end
	S7 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 6;
	      next_state = S6;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 8;
	      next_state = S8;
	   end
	   else begin
	      ship_x = 7;
	      next_state = S7;
	   end
	end
	S8 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 7;
	      next_state = S7;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 9;
	      next_state = S9;
	   end
	   else begin
	      ship_x = 8;
	      next_state = S8;
	   end
	end
	S9 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 8;
	      next_state = S8;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 10;
	      next_state = S10;
	   end
	   else begin
	      ship_x = 9;
	      next_state = S9;
	   end
	end
	S10 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 9;
	      next_state = S9;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 11;
	      next_state = S11;
	   end
	   else begin
	      ship_x = 10;
	      next_state = S10;
	   end
	end
	S11 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 10;
	      next_state = S10;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 12;
	      next_state = S12;
	   end
	   else begin
	      ship_x = 11;
	      next_state = S11;
	   end
	end
	S12 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 11;
	      next_state = S11;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 13;
	      next_state = S13;
	   end
	   else begin
	      ship_x = 12;
	      next_state = S12;
	   end
	end
	S13 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 12;
	      next_state = S12;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 14;
	      next_state = S14;
	   end
	   else begin
	      ship_x = 13;
	      next_state = S13;
	   end
	end
	S14 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 13;
	      next_state = S13;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 15;
	      next_state = S15;
	   end
	   else begin
	      ship_x = 14;
	      next_state = S14;
	   end
	end
	S15 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 14;
	      next_state = S14;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 16;
	      next_state = S16;
	   end
	   else begin
	      ship_x = 15;
	      next_state = S15;
	   end
	end
	S16 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 15;
	      next_state = S15;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 17;
	      next_state = S17;
	   end
	   else begin
	      ship_x = 16;
	      next_state = S16;
	   end
	end
	S17 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 16;
	      next_state = S16;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 18;
	      next_state = S18;
	   end
	   else begin
	      ship_x = 17;
	      next_state = S17;
	   end
	end
	S18 : begin
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1) begin
	      ship_x = 17;
	      next_state = S17;
	   end
	   else if (right_debounced == 1) begin
	      ship_x = 19;
	      next_state = S19;
	   end
	   else begin
	      ship_x = 18;
	      next_state = S18;
	   end
	end
	S19 : begin //right limit
	   if (reset == 0) begin
	      ship_x = 5;
	      next_state = init;
	   end
	   else if (left_debounced == 1)
	     begin
	        ship_x = 18;
	        next_state = S18;
	     end
	   else begin
	      ship_x = 19;
	      next_state = S19;
	   end
	end
	default : begin
	   ship_x = 5;
	   next_state = init;
	end
      endcase
   end // always @ (reset or left_debounced or right_debounced or enable or current_state)
`ifdef FORMAL
   always @(posedge clk) begin
      assert (ship_x > 20 && ship_x < 0);
   end
`endif
endmodule
