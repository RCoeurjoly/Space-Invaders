// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module player_tb();

   //-- Registro para generar la señal de reloj
   reg clk = 0;
   reg reset = 0;
   reg clear = 0;
   reg left = 0;
   reg right = 0;
   reg start = 0;
   reg shoot = 0;
   reg ScoreClear = 0;
   reg Enable = 0;
   reg hit = 0;

   //salidas
   wire [4:0] posShip;
   wire       startPulse;
   wire [4:0] bulletX;
   wire [3:0] bulletY;   
   wire       BulletActive;
   wire [7:0] Score;
   
   
   //-- Instanciar el contador
   player player1(
		  .clk(clk),
		  .reset(reset),
		  .clear(clear),
		  .left(left),
		  .right(right),
		  .start(start),
		  .shoot(shoot),
		  .ScoreClear(ScoreClear),
		  .Enable(Enable),
		  .hit(hit),
		  .posShip(posShip),
		  .startPulse(startPulse),
		  .bulletX(bulletY),
		  .BulletActive(BulletActive),
		  .Score(Score)
		  );

   //-- Generador de reloj. Periodo 2 unidades
   always #1 clk = ~clk;

   always @(negedge clk) begin
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
      # 20 shoot = 1;
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
