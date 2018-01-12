// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module ship_tb();

   //-- input registers
   reg clk_36MHz = 0;
   reg reset = 0;
   reg left_debounced = 0;
   reg right_debounced = 0;
   reg enable = 0;
   //-- outputs
   //wire [4:0] ship_x;
      
   //-- Instanciar el contador
   ship ship1(
	      .clk_36MHz(clk_36MHz),
	      .reset(reset),
	      .left_debounced(left_debounced),
	      .right_debounced(right_debounced),
	      .enable(enable),
	      .ship_x(ship_x)
	      );

   always #1 clk_36MHz = ~clk_36MHz;
   
   //-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("ship_tb.vcd");
      $dumpvars(0, ship_tb);
      # 200 reset = 1;
      # 250 reset = 0;
      # 300 enable = 1;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 left_debounced = 1;			     
      # 1 left_debounced = 0;
      # 100 right_debounced = 1;			     
      # 1 right_debounced = 0;
      # 9999 $display("FIN de la simulacion");
      # 1000 $finish;
   end
   
endmodule
