//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    player
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
module player(
	      input wire       clk_12MHz,
	      input wire       reset,
	      input wire       clear,
	      input wire       left,
	      input wire       right,
	      input wire       start,
	      input wire       shoot,
	      input wire       score_clear,
	      input wire       enable,
	      input wire       hit,
	      output reg [4:0] ship_x,
	      output reg       start_debounced,
	      output reg [4:0] bullet_x,
	      output reg [3:0] bullet_x,
	      output reg       bullet_flying,
	      output reg [7:0] score
	   );   
   
   edge_detector_debouncer left_debouncer(
					  .clk_12MHz(clk_12MHz),
					  .reset(reset),
					  .enable(enable),
					  .in(left),
					  .debounced(left_debounced)
					  );

   edge_detector_debouncer right_debouncer(
					   .clk_12MHz(clk_12MHz),
					   .reset(reset),
					   .enable(enable),
					   .in(right),
					   .debounced(right_debounced)
					   );
   
   edge_detector_debouncer start_debouncer(
					   .clk_12MHz(clk_12MHz),
					   .reset(reset),
					   .enable(enable),
					   .in(start),
					   .debounced(start_debounced)
					   );

   ship ship1(
	      .clk_12MHz(clk_12MHz),
	      .reset(reset),
	      .clear(clear),
	      .left_debounced(left_debounced),
	      .right_debounced(right_debounced),
	      .enable(enable),
	      .ship_x(ship_x)
	      );

     
   bullet bullet1(
		  .clk_12MHz(clk_12MHz),
		  .reset(reset),
		  .clear(clear),
		  .enable(enable),
		  .hit(hit),
		  .shoot(shoot),
		  .ship_x(ship_x),
		  .bullet_flying(bullet_flying),
		  .bullet_x(bullet_x),
		  .bullet_y(bullet_y)
		  );
   
   always @(posedge clk_12MHz)
     begin
	ship_x <= ship_x;
	if (reset == 1)
	  begin
	     score <= 0;
	  end
	else
	  begin
	     if (score_clear == 1)  
	       score <= 0;
	     else if (hit == 1)
	       score <= score + 1;
	  end
     end // always @ (posedge clk_12MHz)
endmodule
