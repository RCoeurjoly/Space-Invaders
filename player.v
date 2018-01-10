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
	      input wire       clear_score,
	      input wire       enable,
	      input wire       hit,
	      output wire [4:0] ship_x,
	      output wire       start_debounced,
	      output wire [4:0] bullet_x,
	      output wire [3:0] bullet_y,
	      output wire       bullet_flying,
	      output reg [7:0] score
	   );
   wire [4:0] 		       o_ship_x;
   wire [4:0] 		       o_bullet_x;
   wire [3:0] 		       o_bullet_y;
   
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
					   .debounced(start_pulse)
					   );

   ship ship1(
	      .clk_12MHz(clk_12MHz),
	      .reset(reset),
	      .left_debounced(left_debounced),
	      .right_debounced(right_debounced),
	      .enable(enable),
	      .ship_x(o_ship_x)
	      );

     
   bullet bullet1(
		  .clk_12MHz(clk_12MHz),
		  .reset(reset),
		  .enable(enable),
		  .hit(hit),
		  .shoot(shoot),
		  .ship_x(ship_x),
		  .bullet_flying(o_bullet_flying),
		  .bullet_x(o_bullet_x),
		  .bullet_y(o_bullet_y)
		  );

   assign start_debounced = start_pulse;
   assign ship_x = o_ship_x;
   assign bullet_flying = o_bullet_flying;
   assign bullet_x = o_bullet_x;
   assign bullet_y = o_bullet_y;
   assign ship_x = o_ship_x;
   assign ship_x = o_ship_x;
   
   initial
     begin
	score <= 7'b0000000;     
     end
   
   always @(posedge clk_12MHz)
     begin
        if (reset == 1)
	  begin
	     score <= 0;
	  end
	else
	  begin
	     if (clear_score == 1)  
	       score <= 0;
	     else if (hit == 1)
	       score <= score + 1;
	  end
     end // always @ (posedge clk_12MHz)
endmodule
