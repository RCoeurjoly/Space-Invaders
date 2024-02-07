// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module ship(
	          input wire       i_clk_25MHz,
	          input wire       i_reset, //synchronous i_reset
	          input wire       i_left_debounced,
	          input wire       i_right_debounced,
	          output reg [4:0] o_ship_x
	          );

   reg [4:0]                 next_x = reset_position;

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
      else if (i_left_debounced == 1 && i_right_debounced == 1) begin
         // If both left and right are pressed, maintain current position
         next_x = o_ship_x;
      end
      else if (i_left_debounced == 1) begin
         if (o_ship_x > left_limit) begin
            next_x = o_ship_x - 1;
         end
         else begin
            // If already at left limit, stay or wrap around based on requirements
            next_x = left_limit;
         end
      end
      else if (i_right_debounced == 1) begin
         if (o_ship_x < right_limit) begin
            next_x = o_ship_x + 1;
         end
         else begin
            // If already at right limit, stay or wrap around based on requirements
            next_x = right_limit;
         end
      end
      else begin
         // If neither left nor right is debounced, maintain current position
         next_x = o_ship_x;
      end
   end

`ifdef FORMAL
   reg [4:0]           i;
   always @(posedge i_clk_25MHz) begin
      // Safety properties: o_ship_x and next_x within bounds
      assert (o_ship_x >= left_limit);
      assert (o_ship_x <= right_limit);
      assert (next_x >= left_limit);
      assert (next_x <= right_limit);
      // if i_reset is high, then o_ship_x should be equal to reset_position at the next clock edge
      assert property ( i_reset |-> ##1 o_ship_x == reset_position);
      // Ensure the ship moves left or right correctly in response to i_left_debounced or i_right_debounced signals.
      // Formal verification with tabbyCAD and concurrent SVA made me discover some design flaws, fixed in
      assert property ((!i_reset && i_left_debounced == 1 && i_right_debounced == 0 && o_ship_x != left_limit) |-> ##1 o_ship_x == $past(o_ship_x) - 1);
      assert property ((!i_reset && i_right_debounced == 1 && i_left_debounced == 0 && o_ship_x != right_limit) |-> ##1 o_ship_x == $past(o_ship_x) + 1);
      // If both buttons are pressed or no botton is pressed, the ship does not move
      assert property ((!i_reset && i_right_debounced == 1 && i_left_debounced == 1) |-> ##1 o_ship_x == $past(o_ship_x));
      assert property ((!i_reset && i_right_debounced == 0 && i_left_debounced == 0) |-> ##1 o_ship_x == $past(o_ship_x));
   end // always @ (posedge i_clk_25MHz)
`endif
endmodule
