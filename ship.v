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
   wire [1:0] 		     next_state;
   reg [1:0] 		     current_state;
   
   parameter [1:0] idle = 2'b01;
   parameter [1:0] moving = 2'b10;
   
   initial 
     begin
	current_state <= idle; 
     end
   
   always @ (posedge clk_36MHz)
     begin
	current_state <= next_state;
     end
   
   always @(reset or left_debounced or right_debounced or enable or current_state)
     begin
	case (current_state)
	  idle : 
	    begin
	       ship_x <= 5;
	       if (reset = 1)
		 next_state =  idle;
	       else
		 next_state = moving;
	    end
	  moving : 
	    begin
	       if (reset = 1)
		 next_state = idle;
	       else if (left_debounced = 1 && ship_x != 0)
		   ship_x = ship_x - 1;
	       else if (right_debounced = 1 && ship_x != 19)
		   ship_x = ship_x + 1;
	    end
	  default : next_state <= idle;
	endcase
     end // always @ (reset or left_debounced or right_debounced or enable or current_state)
   
endmodule
