// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module edge_detector_debouncer(
			       input wire clk_36MHz,
			       input wire reset, //asynchronous reset
			       input wire enable,
			       input wire in,
			       output reg debounced	       
			       );   
   reg [1:0] 				  current_state;
   reg [1:0] 				  next_state;
   reg 					  counter_enabled;
   wire 				  timeout;
   
   
   parameter [1:0] not_detected = 2'b00;
   parameter [1:0] edge_detected = 2'b01;
   parameter [1:0] disabled = 2'b11;
   parameter [1:0] waiting = 2'b10;

   timer_1us  # (1000) timer_1us1(
				  .clk_36MHz(clk_36MHz),
				  .reset(reset),
				  .en(counter_enabled),
				  .q(timeout)
				  );
   
   initial begin
      current_state <= 2'b00;
      next_state <= 2'b00;
   end
   
   always @(posedge clk_36MHz)
     begin
	// reset condition
	if (reset == 0)	  
	  begin
	     current_state <= not_detected;	     
	  end
	else
	  begin
	     if (enable == 1)
	       begin
		  current_state <= next_state;
	       end
	  end // else: !if(reset == 1)
     end // always @ (posedge clk_36MHz)
   
   always @(current_state or in or timeout)
     begin
	next_state <= current_state;
	case (current_state)
	  not_detected:
	    begin
	       debounced <= 0;
	       counter_enabled <= 0;
	       if (in == 0)
		 next_state <= not_detected;
	       else
		 next_state <= edge_detected;
	    end	  
	  edge_detected:
	    begin
	       debounced <= 1;
	       counter_enabled <= 0;
	       next_state <= disabled;
	    end
	  disabled:
	    begin
	       debounced <= 0;
	       counter_enabled <= 1;
	       if (timeout == 1)
		 begin
		    if (in == 0)
		      next_state <= not_detected;
		    else
		      next_state <= waiting;
		 end
	       else
		 current_state <= current_state;
	    end // case: disabled
	  waiting:
	    begin
	       debounced <= 0;
	       counter_enabled <= 0;
	       if (in == 0)
		 next_state <= not_detected;
	       else
		 next_state <= waiting;
	    end
	  default:
	    begin
	       debounced <= 0;
	       counter_enabled <= 0;
	       if (in == 0)
		 next_state <= not_detected;
	       else
		 next_state <= waiting;
	    end
	endcase
     end
endmodule
