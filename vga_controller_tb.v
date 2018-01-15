// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module vga_tb();

   //-- Registro para generar la señal de reloj
   reg dclk = 0;
   reg clr = 1;
   
   //-- Datos de salida del controlador de vga
   wire hsync;
   wire vsync;
   wire 	red;
   wire 	green;
   wire 	blue;
   //reg [25:0] data;
   //wire 	D5;
   

   //-- Instanciar el contador
   vga vga1(
	    .dclk(dclk),
	    .clr(clr),
	    .hsync(hsync),
	    .vsync(vsync),
	    .red(red),
	    .green(green),
	    .blue(blue)
	    //.data(data),
	    //.D5(D5)
	    );

   //-- Generador de reloj. Periodo 2 unidades
   always #1 dclk = ~dclk;

   always @(negedge dclk) begin
   end
   //-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("vga_tb.vcd");
      $dumpvars(0, vga_tb);
      # 1000 clr = 0;
      # 9999 $display("FIN de la simulacion");
      # 1000000 $finish;
   end
   
endmodule
