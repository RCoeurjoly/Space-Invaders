// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module edge_detector_debouncer(
			                         input wire i_clk_25MHz,
			                         input wire i_reset, //asynchronous i_reset
			                         input wire i_in,
			                         output reg o_debounced
			                         );
   reg [1:0]                              current_state;
   reg [1:0]                              next_state;
   wire                                   timeout;


   parameter [1:0] not_detected = 2'b00;
   parameter [1:0] edge_detected = 2'b01;
   parameter [1:0] disabled = 2'b11;
   parameter [1:0] waiting = 2'b10;

   timer_1us  # (1000) timer_1us1(
				                          .i_clk_25MHz(i_clk_25MHz),
				                          .i_reset(i_reset),
				                          .o_q(timeout)
				                          );

   initial begin
      current_state = 2'b00;
      next_state = 2'b00;
      o_debounced = 1'b0;
   end

   always @(posedge i_clk_25MHz)
     begin
	      // i_reset condition
	      if (i_reset == 0)
	        begin
	           current_state <= not_detected;
	        end
	      else current_state <= next_state;
     end // always @ (posedge i_clk_25MHz)

   always @(*) begin
	    case (current_state)
	      not_detected:
	        begin
	           o_debounced = 0;
	           if (i_in == 0)
		           next_state = not_detected;
	           else
		           next_state = edge_detected;
	        end
	      edge_detected:
	        begin
	           o_debounced = 1;
	           next_state = disabled;
	        end
	      disabled:
	        begin
	           o_debounced = 0;
	           if (timeout == 1)
		           begin
		              if (i_in == 0)
		                next_state = not_detected;
		              else
		                next_state = waiting;
		           end
	        end // case: disabled
	      waiting:
	        begin
	           o_debounced = 0;
	           if (i_in == 0)
		           next_state = not_detected;
	           else
		           next_state = waiting;
	        end
	      default:
	        begin
	           o_debounced = 0;
	           if (i_in == 0)
		           next_state = not_detected;
	           else
		           next_state = waiting;
	          end
	    endcase
   end // always @ (*)
endmodule
