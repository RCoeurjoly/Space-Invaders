// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module space_invaders_top_tb();

   //-- Inputs
   reg i_clk_12MHz = 0;
   reg i_reset = 0;
   reg i_left = 0;
   reg i_right = 0;
   reg i_shoot = 0;
   reg i_start = 0;
   //Outputs
   wire o_hsync;
   wire o_vsync;
   wire o_red;
   wire o_green;
   wire o_blue;

   //-- Instantiation
   space_invaders_top space_invaders_top1(
					                                .i_clk_12MHz(clk_12MHz),
					                                .i_reset(reset),
					                                .i_left(left),
					                                .i_right(right),
					                                .i_shoot(shoot),
					                                .i_start(start),
					                                .o_hsync(o_hsync),
					                                .o_vsync(o_vsync),
					                                .o_red(o_red),
					                                .o_green(o_green),
					                                .o_blue(o_blue)
					                                );

   //-- Clock generator
   always #1 i_clk_12MHz = ~i_clk_12MHz;

   always @(negedge i_clk_12MHz) begin
   end

   initial begin

      //-- Fichero donde almacenar los resultados
      $dumpfile("space_invaders_top_tb.vcd");
      $dumpvars(0, space_invaders_top_tb);
      # 10 i_reset = 1;
      # 20 i_left = 1;
      # 10 i_left = 0;
      # 20 i_right = 1;
      # 10 i_right = 0;
      # 20 i_left = 1;
      # 10 i_left = 0;
      # 20 i_shoot = 1;
      # 10 i_shoot = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_right = 1;
      # 50 i_right = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;
      # 50 i_left = 1;
      # 50 i_left = 0;


      # 10000 $display("End of simulation");
      # 1 $finish;
   end
endmodule
