//-------------------------------------------------------------------
//-- top_tb.v
//-- Banco de pruebas
//-------------------------------------------------------------------
//-- July 2017. Written by RCL
//-------------------------------------------------------------------

module top_tb();

   //-- Registro para generar la señal de reloj
   reg dclk = 0;
   reg clr = 0;
   reg left = 0;
   reg right = 0;
   

   //salidas
   wire hsync;
   wire vsync;
   wire red;
   wire green;
   wire blue;
   
   //-- Instanciar el contador
   top top1(
	    .dclk(dclk),
	    .clr(clr),
	    .left(left),
	    .right(right),
	    .hsync(hsync),
	    .vsync(vsync),
	    .red(red),
	    .green(green),
	    .blue(blue)
	    );

   //-- Generador de reloj. Periodo 2 unidades
   always #1 dclk = ~dclk;

   always @(negedge dclk) begin
   end
   //-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("top_tb.vcd");
      $dumpvars(0, top_tb);
      # 10 clr = 1;
      # 20 left = 1;
      # 10 left = 0;
      # 20 right = 1;
      # 10 right = 0;
      # 20 left = 1;
      # 10 left = 0;
      # 20 right = 1;
      # 10 right = 0;
      # 20 left = 1;
      # 10 left = 0;
      
      # 100 $display("End of simulation");
      # 1 $finish;
   end
endmodule
