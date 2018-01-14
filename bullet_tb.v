// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module bullet_tb();

   //-- input registers
   reg clk_36MHz = 0;
   reg reset = 0;
   reg enable = 0;
   reg hit = 0;
   reg shoot = 0;
   reg [4:0] ship_x = 7;
   
   //-- outputs
   wire bullet_flying;
   wire [4:0] bullet_x;
   wire [3:0] bullet_y;
   
   
   //-- Instanciar el contador
   bullet bullet1(
		  .clk_36MHz(clk_36MHz),
		  .reset(reset),
		  .enable(enable),
		  .hit(hit),
		  .shoot(shoot),
		  .ship_x(ship_x),
		  .bullet_flying(bullet_flying),
		  .bullet_x(bullet_x),
		  .bullet_y(bullet_y)
		  );

   always #1 clk_36MHz = ~clk_36MHz;
   
//-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("bullet_tb.vcd");
      $dumpvars(0, bullet_tb);
      // Next event happens n# of seconds after
      # 50 reset = 0;
      # 50 reset = 1;
      # 50 enable = 1;	
      # 50 shoot = 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x + 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 1 ship_x = ship_x - 1;
      # 10 hit = 1;      
      # 1 shoot = 0;
      //what happens if we shoot several times very fast?
      # 1 shoot = 1;
      # 1 shoot = 0;
      
      # 9999 $display("FIN de la simulacion");
      # 1000 $finish;
   end
   
endmodule
