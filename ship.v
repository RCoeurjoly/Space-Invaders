// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module ship(
	    input wire       clk_36MHz,
	    input wire       reset, //synchronous reset
	    input wire       left_debounced,
	    input wire       right_debounced,
	    input wire       enable,
	    output reg [4:0] ship_x
	          );

   reg [4:0]           next_x;
   reg [4:0]           i;

   localparam left_limit = 0;
   localparam reset_position = 5;
   localparam right_limit = 19;

   initial begin
      ship_x <= reset_position;
   end

   always @(posedge clk_36MHz) begin
      ship_x <= next_x;
   end

   always @(reset or left_debounced or right_debounced or enable or current_state) begin
      if (reset == 0) begin
	       next_x = reset_position;
	    end
      else begin
         for(i = left_limit; i <= right_limit; i = i + 1) begin
            if (left_debounced == 1) begin
               if (i == left_limit) begin
	                //Left limit
	                next_x = left_limit;
               end
               else begin
	                next_x = i - 1;
               end
            end
            else if (right_debounced == 1) begin
               if (i == right_limit) begin
                  //Right limit
	                next_x = right_limit;
               end
               else begin
	                next_x = i + 1;
               end
            end
            else begin
	             next_x = i;
            end // else: !if(right_debounced == 1)
         end // for (i = left_limit; i <= right_limit; i = i + 1)
      end // else: !if(reset == 0)
   end // always @ (reset or left_debounced or right_debounced or enable or current_state)

`ifdef FORMAL
always @(posedge clk_36MHz) begin
   assert (ship_x >= left_limit);
   assert (ship_x <= right_limit);
   assert (next_x >= left_limit);
   assert (next_x <= right_limit);
end
`endif
endmodule
