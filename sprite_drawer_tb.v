// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module formatVGA_tb();

   //-- input registers
   reg [9:0] VGAx = 0;
   reg [9:0] VGAy = 0;
   reg 	     clr = 0;
   reg [19:0] invArray = 20'b00000000001110101011;
   reg [3:0]  invLine = 4'b1011;
   reg [4:0]  shipX = 5'b10011;
   reg [4:0]  bulletX = 5'b11011;
   reg [3:0]  bulletY = 4'b0100;
   reg 	      bulletFlying = 1;
   
   //-- outputs
   wire [2:0] rgb;
   
   //-- Instanciar el contador
   formatVGA formatVGA1(
			.VGAx(VGAx),
			.VGAy(VGAy),
			.clr(clr),
			.invArray(invArray),
			.invLine(invLine),
			.shipX(shipX),
			.bulletX(bulletX),
			.bulletY(bulletY),
			.bulletFlying(bulletFlying),
			.rgb(rgb)
			);

   always #1 VGAx = VGAx + 1;
   always #1024 VGAy = VGAy + 1;
   //-- Proceso al inicio
   initial begin
      
      //-- Fichero donde almacenar los resultados
      $dumpfile("formatVGA_tb.vcd");
      $dumpvars(0, formatVGA_tb);
      # 100 clr = 1;
      
      # 9999 $display("FIN de la simulacion");
      # 1000000 $finish;
   end
   
endmodule
