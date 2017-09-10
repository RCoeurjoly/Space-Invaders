//-------------------------------------------------------------------
//-- formatVGA_tb.v
//-- Banco de pruebas para el ship
//-------------------------------------------------------------------
//-- June 2017. Written by RCL
//-------------------------------------------------------------------

module Timer();

   //-- input registers
   reg clk = 0;
   reg reset = 0;
   reg clr = 0;
   reg enable = 0;
   reg hit = 0;
   reg shoot = 0;
   reg [4:0] posH = 0;
   
   //-- outputs
   wire flying;
   wire [4:0] bulletX;
   wire [3:0] bulletY;
   
   
   //-- Instanciar el contador
   Timer Timer1(
		  .clk(clk),
		  .reset(reset),
		  .clr(clr),
		  .enable(enable),
		  .hit(hit),
		  .shoot(shoot),
		  .posH(posH),
		  .flying(flying),
		  .bulletX(bulletX),
		  .bulletY(bulletY)
		  );

   always #1 clk = ~clk;
   
//-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("bullet_tb.vcd");
      $dumpvars(0, bullet_tb);
      // Next event happens n# of seconds after
      # 100 clr = 1;
      # 50 clr = 0;
      # 50 reset = 1;
      # 50 reset = 0;
      # 50 enable = 1;	
      # 50 shoot = 1;
      # 10 hit = 1;      
      # 1 shoot = 0;
      //what happens if we shoot several times very fast?
      # 1 shoot = 1;
      # 1 shoot = 0;
      
      # 9999 $display("FIN de la simulacion");
      # 1000 $finish;
   end
   
endmodule
