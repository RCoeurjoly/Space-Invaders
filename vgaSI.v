//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vgaSI(
	     input wire       dclk, //input clock: 12MHz
	     input wire       clr, //asynchronous reset
	     input wire [2:0] RGB,
	     output wire      hsync, //horizontal sync out
	     output wire      vsync, //vertical sync out
	     output reg       red_vga, //red vga output
	     output reg       green_vga, //green vga output
	     output reg       blue_vga, //blue vga output
	     output reg [9:0] X,
	     output reg [9:0] Y    
	     );
   //wire 		      clk = dclk;
   
   
   wire 		      clk;
   
   SB_PLL40_CORE #(.FEEDBACK_PATH("SIMPLE"),
                   .PLLOUT_SELECT("GENCLK"),
		   .DIVR(4'b0000),
		   .DIVF(7'b0101111),
		   .DIVQ(3'b100),
		   .FILTER_RANGE(3'b001),
		   ) uut (
			  .REFERENCECLK(dclk),
			  .PLLOUTCORE(clk),
			  .RESETB(1'b1),
			  .BYPASS(1'b0)
			  );
   
   /**/
   // video structure constants
   parameter activeHvideo = 640;
   parameter activeVvideo = 480;
   parameter hfp = 32; 	// horizontal front porch length
   parameter hpulse = 48; 	// hsync pulse length
   parameter hbp = 112; 	// horizontal back porch length
   parameter vfp = 1; 		// vertical front porch length
   parameter vpulse = 3; 	// vsync pulse length
   parameter vbp = 25; 	// vertical back porch length
   parameter blackH = hfp + hpulse + hbp;
   parameter blackV = vfp + vpulse + vbp;
   parameter hpixels = blackH + activeHvideo;
   parameter vlines = blackV + activeVvideo;
     
   // active horizontal video is therefore: 784 - 144 = 640
   // active vertical video is therefore: 515 - 35 = 480
   
   // registers for storing the horizontal & vertical counters
   reg [9:0] 	       hc;
   reg [9:0] 	       vc;
   
   
   initial begin
      X <= 0;
      Y <= 0;
      hc <= 0;
      vc <= 0;
      red_vga <= 0;
      green_vga <= 0;
      blue_vga <= 0;
   end
   always @(posedge clk)
     begin
	// keep counting until the end of the line
	if (hc < hpixels - 1)
	  hc <= hc + 1;	
	else
	  // When we hit the end of the line, reset the horizontal
	  // counter and increment the vertical counter.
	  // If vertical counter is at the end of the frame, then
	  // reset that one too.
	  begin
	     hc <= 0;
	     if (vc < vlines - 1)
	       vc <= vc + 1;
	     else
	       vc <= 0;
	  end // else: !if(hc < hpixels - 1)
     end // always @ (posedge clk)
   

   
   // generate sync pulses (active low)
   // ----------------
   // "assign" statements are a quick way to
   // give values to variables of type: wire
   
   wire activevideo;
   
   assign hsync = (hc >= hfp && hc < hfp + hpulse) ? 0:1;
   assign vsync = (vc >= vfp && vc < vfp + vpulse) ? 0:1;
   assign activevideo = (hc >= hfp + hpulse + hbp && vc >= vfp + vpulse + vbp) ? 1:0;


   // display 100% saturation colorbars
   // ------------------------
   // Combinational "always block", which is a block that is
   // triggered when anything in the "sensitivity list" changes.
   // The asterisk implies that everything that is capable of triggering the block
   // is automatically included in the sensitivty list.  In this case, it would be
   // equivalent to the following: always @(hc, vc)
   // Assignment statements can only be used on type "reg" and should be of the "blocking" type: =   
   
   always @(posedge clk)
     begin
	// first check if we're within vertical active video range
	if (activevideo == 1)

	// we're outside active video range so display black
	  begin
	     red_vga <= RGB[2];
	     green_vga <= RGB[1];
	     blue_vga <= RGB[0];
	     X <= hc - hfp - hpulse - hbp;
	     Y <= vc - vfp - vpulse - vbp;
	  end // if (activevideo == 1)
	else
	  begin
	     red_vga <= 0;
	     green_vga <= 0;
	     blue_vga <= 0;
	     X <= 0;
	     Y <= 0;
	  end
     end // always @ (posedge clk)
 
endmodule
