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
module edgeDetectorDebounce(
		    input wire clk,
		    input wire clr, //asynchronous reset
		    input wire enable,
		    input wire in,
		    output reg detected	       
		    );   
   reg [1:0] 		       currentState;
   reg [1:0] 		       nextState;
   reg 			       counterEnabled;
   
   
   parameter [1:0] notDetected = 2'b00;
   parameter [1:0] edgeDetected = 2'b01;
   parameter [1:0] Disabled = 2'b11;
   parameter [1:0] waiting = 2'b10;

   Timer Timer1(
		.clk(clk),
		.reset(0), //hardcoded
		.clr(clr),
		.en(counterEnabled),
		.q(timeout)
		);
   
   initial begin
      currentState <= 2'b00;
      nextState <= 2'b00;
   end
   
   always @(posedge clk)
     begin
	// reset condition
	if (clr == 0)	  
	  begin
	     currentState <= notDetected;	     
	  end
	else
	  begin
	     if (enable == 1)
	       begin
		  currentState <= nextState;
	       end
	  end // else: !if(clr == 1)
     end // always @ (posedge clk or posedge clr)

   always @(currentState or in or timeout)
     /*currentState or in or timeout*/
     begin
	nextState <= currentState;
	case (currentState)
	  notDetected:
	    begin
	       detected <= 0;
	       counterEnabled <= 0;
	       if (in == 0)
		 nextState <= notDetected;
	       else
		 nextState <= edgeDetected;
	    end	  
	  edgeDetected:
	    begin
	       detected <= 1;
	       counterEnabled <= 0;
	       nextState <= Disabled;
	    end
	  Disabled:
	    begin
	       detected <= 0;
	       counterEnabled <= 1;
	       if (timeout == 1)
		 begin
		    if (in == 0)
		      nextState <= notDetected;
		    else
		      nextState <= waiting;
		 end
	    end // case: Disabled
	  waiting:
	    begin
	       detected <= 0;
	       counterEnabled <= 0;
	       if (in == 0)
		 nextState <= notDetected;
	       else
		 nextState <= waiting;
	    end
	  default:
	    begin
	       detected <= 0;
	       counterEnabled <= 0;
	       if (in == 0)
		 nextState <= notDetected;
	       else
		 nextState <= waiting;
	    end // always @ (...
	endcase
     end // always @ (in)
endmodule
