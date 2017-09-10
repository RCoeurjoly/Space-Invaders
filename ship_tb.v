//-------------------------------------------------------------------
//-- ship_tb.v
//-- Banco de pruebas para el ship
//-------------------------------------------------------------------
//-- June 2017. Written by RCL
//-------------------------------------------------------------------

module ship_tb();

   //-- input registers
   reg clk = 0;
   reg reset = 0;
   reg clr = 0;
   reg left = 0;
   reg right = 0;
   reg enable = 0;
   
   //-- outputs
   wire [4:0] posH;
   
   
   
   //-- Instanciar el contador
   ship ship1(
	      .clk(clk),
	      .reset(reset),
	      .clr(clr),
	      .left(left),
	      .right(right),
	      .enable(enable),
	      .posH(posH),
	      );

   always #1 clk = ~clk;
   always #20 left = ~left;
   always #40 right = ~right;
   
   //-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("ship_tb.vcd");
      $dumpvars(0, ship_tb);
      # 100 clr = 1;
      # 150 clr = 0;
      # 200 reset = 1;
      # 250 reset = 0;
      # 300 enable = 1;	 
      # 9999 $display("FIN de la simulacion");
      # 1000 $finish;
   end
   
endmodule
