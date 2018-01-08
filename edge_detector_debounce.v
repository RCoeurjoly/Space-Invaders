//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    formatVGA
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module edge_detector_debounce(
		    input wire clk,
		    input wire reset, //asynchronous reset
		    input wire enable,
		    input wire in,
		    output reg detected	       
		    );   
   reg [1:0] 		       current_state;
   reg [1:0] 		       next_state;
   reg 			       counter_enabled;
   
   
   parameter [1:0] not_detected = 2'b00;
   parameter [1:0] edge_detected = 2'b01;
   parameter [1:0] disabled = 2'b11;
   parameter [1:0] waiting = 2'b10;

   Timer Timer1(
		.clk(clk),
		.reset(0), //hardcoded
		.clr(clr),
		.en(counter_enabled),
		.q(timeout)
		);
   
   initial begin
      current_state <= 2'b00;
      next_state <= 2'b00;
   end
   
   always @(posedge clk)
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
     end // always @ (posedge clk or posedge reset)

   always @(current_state or in or timeout)
     begin
	next_state <= current_state;
	case (current_state)
	  not_detected:
	    begin
	       detected <= 0;
	       counter_enabled <= 0;
	       if (in == 0)
		 next_state <= not_detected;
	       else
		 next_state <= edge_detected;
	    end	  
	  edge_detected:
	    begin
	       detected <= 1;
	       counter_enabled <= 0;
	       next_state <= disabled;
	    end
	  disabled:
	    begin
	       detected <= 0;
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
	       detected <= 0;
	       counter_enabled <= 0;
	       if (in == 0)
		 next_state <= not_detected;
	       else
		 next_state <= waiting;
	    end
	  default:
	    begin
	       detected <= 0;
	       counter_enabled <= 0;
	       if (in == 0)
		 next_state <= not_detected;
	       else
		 next_state <= waiting;
	    end // always @ (...
	endcase
     end // always @ (in)
endmodule
