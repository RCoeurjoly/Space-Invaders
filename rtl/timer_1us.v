// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module timer_1us(
		             input wire i_clk_25MHz,
		             input wire i_reset, //synchronous reset
                 output reg o_q
		             );

   parameter PERIOD = 1;
   localparam CLK_FREQ = 36; //36 MHz clock
`ifdef FORMAL
   localparam MAX = 2;
`else
   localparam MAX = (PERIOD * CLK_FREQ) - 1;
`endif

   reg [31:0]               count;

   initial begin
      o_q = 0;
      count = 0;
   end

   always @(posedge i_clk_25MHz) begin
	    if (i_reset == 1) begin
	       count <= 0;
         o_q <= 0;
      end
	    else if (count == MAX) begin
	       count <= 0;
         o_q <= 1;
      end
	    else begin
	       count <= count + 1;
         o_q <= 0;
	    end
   end // always @ (posedge i_clk_25MHz)
`ifdef FORMAL
   always @(posedge i_clk_25MHz) begin
      assert (count >= 0 && count <= MAX);
      cover (0 <= count <= MAX );
      // Liveness properties: the output reaches 0 and 1
      cover (o_q == 0);
      cover (o_q == 1);

      // This assertion checks that whenever i_reset is high, in the next clock cycle, the count should be reset to 0.
      assert property (i_reset |-> ##1 count == 0);
      // This assertion verifies that o_q gets set to high (1) only when the count reaches its maximum value (MAX).
      // We also use a disable clause. See also Figure 3.2 in https://yosyshq.readthedocs.io/projects/ap109/en/latest/index.html
      // Note that in our design, i_reset is active high, in contrast to rstn in YoysysHQ documentation where is Active low
      assert property (disable iff (i_reset) count == MAX |-> ##1 o_q);
      // This assertion ensures that o_q remains low (0) when count has not yet reached MAX.
      assert property (disable iff (i_reset) count != MAX |-> ##1 !o_q);
      // o_q is deasserted in the next cycle after being high: This assertion confirms that once o_q goes high, it should return to low (0) in the next clock cycle
      assert property (o_q |-> ##1 !o_q);
      // This assertion checks that if the timer is not reset and count is not at MAX, then count should increase by 1 in the next cycle.
      assert property ((!i_reset && count < MAX) |-> ##1 count == $past(count) + 1);
   end
`endif
endmodule
