// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module invaders_tb();

     //-- input registers
   reg clk_36MHz = 0;
   reg reset = 0;
   reg start = 0;
   reg [4:0] bullet_x = 0;
   reg [3:0] bullet_y = 0;
   reg [2:0] level = 0;
   
   //-- outputs
   wire hit;
   wire [19:0] invaders_array;
   wire [4:0] invaders_line;
   
   //-- Instanciar el contador
   invaders #(1) invaders1(
		      .clk_36MHz(clk_36MHz),
		      .reset(reset),
		      .start(start),
		      .bullet_x(bullet_x),
		      .bullet_y(bullet_y),
		      .level(level),
		      .hit(hit),
		      .invaders_array(invaders_array),
		      .invaders_line(invaders_line)
		      );
   
   always #1 clk_36MHz = ~clk_36MHz;
   
//-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("invaders_tb.vcd");
      $dumpvars(0, invaders_tb);
      // Next event happens n# of seconds after
      # 50 reset = 0;
      # 50 reset = 1;
            
      # 999999 $display("FIN de la simulacion");
      # 100000 $finish;
   end
   
endmodule
