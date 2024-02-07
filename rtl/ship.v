// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module ship(
	          input wire       i_clk_25MHz,
	          input wire       i_reset, //synchronous i_reset
	          input wire       i_left_debounced,
	          input wire       i_right_debounced,
	          output reg [4:0] o_ship_x
	          );

   reg [4:0]                 next_x;
   reg [4:0]                 i;

   localparam left_limit = 0;
   localparam reset_position = 5;
   localparam right_limit = 19;

   initial begin
      o_ship_x = reset_position;
   end

   always @(posedge i_clk_25MHz) begin
      o_ship_x <= next_x;
   end

   always @(*) begin
      if (i_reset == 1) begin
	       next_x = reset_position;
	    end
      else begin
         for(i = left_limit; i <= right_limit; i = i + 1) begin
            if (i_left_debounced == 1) begin
               if (i == left_limit) begin
	                //Left limit
	                next_x = left_limit;
               end
               else begin
	                next_x = i - 1;
               end
            end
            else if (i_right_debounced == 1) begin
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
            end // else: !if(i_right_debounced == 1)
         end // for (i = left_limit; i <= right_limit; i = i + 1)
      end // else: !if(i_reset == 0)
   end // always @ (i_reset or i_i_left_debounced or i_right_debounced or i_enable or current_state)
`ifdef FORMAL
   reg [4:0]           i;
   always @(posedge i_clk_25MHz) begin
      // Safety properties: o_ship_x and next_x within bounds
      assert (o_ship_x >= left_limit);
      assert (o_ship_x <= right_limit);
      assert (next_x >= left_limit);
      assert (next_x <= right_limit);

      // for (i = 0; i < 20; i++) begin
      //    cover (o_ship_x == i);
      // end

   end
`endif
endmodule
