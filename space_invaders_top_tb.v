//-------------------------------------------------------------------
//-- top_tb.v
//-- Banco de pruebas
//-------------------------------------------------------------------
//-- July 2017. Written by RCL
//-------------------------------------------------------------------

module space_invaders_top_tb();

   //-- Registro para generar la señal de reloj
   reg clk_12MHz = 0;
   reg reset = 1;
   reg left = 0;
   reg right = 0;
   reg shoot = 0;
   reg start = 0;
   //salidas
   wire hsync;
   wire vsync;
   wire red;
   wire green;
   wire blue;
   
   //-- Instanciar el contador
   space_invaders_top space_invaders_top1(
					  .clk_12MHz(clk_12MHz),
					  .reset(reset),
					  .left(left),
					  .right(right),
					  .shoot(shoot),
					  .start(start),
					  .hsync(hsync),
					  .vsync(vsync),
					  .red(red),
					  .green(green),
					  .blue(blue)
					  );

   //-- Generador de reloj. Periodo 2 unidades
   always #1 clk_12MHz = ~clk_12MHz;

   always @(negedge clk_12MHz) begin
   end
   //-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("top_tb.vcd");
      $dumpvars(0, top_tb);
      # 100000 reset = 0;
      # 20 left = 1;
      # 10 left = 0;
      # 20 right = 1;
      # 10 right = 0;
      # 20 left = 1;
      # 10 left = 0;
      # 20 shoot = 1;
      # 10 shoot = 0;
      # 20 right = 1;
      # 10 right = 0;
      # 20 left = 1;
      # 10 left = 0;
      
      # 10000 $display("End of simulation");
      # 1 $finish;
   end
endmodule
