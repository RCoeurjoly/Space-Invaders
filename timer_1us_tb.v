// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module timer_1us();

   //-- input registers
   reg clk_36MHz = 0;
   reg reset = 0;
   reg en = 0;
   //-- outputs
   wire      q;
   
   
   
   //-- Instanciar el contador
   timer_1us timer_1us1(
			.clk_36MHz(clk_36MHz),
			.reset(reset),
			.en(en),
			.q(q)
		  );

   always #1 clk = ~clk;
   
//-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("timer_tb.vcd");
      $dumpvars(0, timer_tb);
      // Next event happens n# of seconds after
      # 50 reset = 1;
      # 50 reset = 0;
      # 50 en = 1;
      # 9999 $display("FIN de la simulacion");
      # 1000 $finish;
   end
   
endmodule
