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
module vga(
	     input wire       clk_36MHz,
	     input wire [2:0] rgb,
	     output wire      hsync, //horizontal sync out
	     output wire      vsync, //vertical sync out
	     output reg       red, //red vga output
	     output reg       green, //green vga output
	     output reg       blue, //blue vga output
	     output reg [9:0] x,
	     output reg [9:0] y    
	     );
   //wire 		      clk = dclk;
   
   
   wire 		      clk;
   
   
   /**/
   // video structure constants
   parameter ACTIVE_H_VIDEO = 640;
   parameter ACTIVE_V_VIDEO = 480;
   parameter HFP = 32; 	// horizontal front porch length
   parameter H_PULSE = 48; 	// hsync pulse length
   parameter HBP = 112; 	// horizontal back porch length
   parameter VFP = 1; 		// vertical front porch length
   parameter V_PULSE = 3; 	// vsync pulse length
   parameter VBP = 25; 	// vertical back porch length
   parameter BLACK_H = HFP + H_PULSE + HBP;
   parameter BLACK_V = VFP + V_PULSE + VBP;
   parameter H_PIXELS = BLACK_H + ACTIVE_H_VIDEO;
   parameter V_LINES = BLACK_V + ACTIVE_V_VIDEO;
     
   // active horizontal video is therefore: 784 - 144 = 640
   // active vertical video is therefore: 515 - 35 = 480
   
   // registers for storing the horizontal & vertical counters
   reg [9:0] 	       h_counter;
   reg [9:0] 	       v_counter;
   
   
   initial begin
      x <= 0;
      y <= 0;
      h_counter <= 0;
      v_counter <= 0;
      red <= 0;
      green <= 0;
      blue <= 0;
   end
   always @(posedge clk_36MHz)
     begin
	// keep counting until the end of the line
	if (h_counter < H_PIXELS - 1)
	  h_counter <= h_counter + 1;	
	else
	  // When we hit the end of the line, reset the horizontal
	  // counter and increment the vertical counter.
	  // If vertical counter is at the end of the frame, then
	  // reset that one too.
	  begin
	     h_counter <= 0;
	     if (v_counter < V_LINES - 1)
	       v_counter <= v_counter + 1;
	     else
	       v_counter <= 0;
	  end // else: !if(h_counters < H_PIXELS - 1)
     end // always @ (posedge clk_85MHz)
   

   
   // generate sync pulses (active low)
   // ----------------
   // "assign" statements are a quick way to
   // give values to variables of type: wire
   
   wire active_video;
   
   assign hsync = (h_counter >= HFP && h_counter < HFP + H_PULSE) ? 0:1;
   assign vsync = (v_counter >= VFP && v_counter < VFP + V_PULSE) ? 0:1;
   assign active_video = (h_counter >= HFP + H_PULSE + HBP && v_counter >= VFP + V_PULSE + VBP) ? 1:0;


   // display 100% saturation colorbars
   // ------------------------
   // Combinational "always block", which is a block that is
   // triggered when anything in the "sensitivity list" changes.
   // The asterisk implies that everything that is capable of triggering the block
   // is automatically included in the sensitivty list.  In this case, it would be
   // equivalent to the following: always @(hc, vc)
   // Assignment statements can only be used on type "reg" and should be of the "blocking" type: =   
   
   always @(posedge clk_36MHz)
     begin
	// first check if we're within vertical active video range
	if (active_video == 1)

	// we're outside active video range so display black
	  begin
	     red <= rgb[2];
	     green <= rgb[1];
	     blue <= rgb[0];
	     x <= h_counter - HFP - H_PULSE - HBP;
	     y <= v_counter - VFP - V_PULSE - VBP;
	  end // if (active_video == 1)
	else
	  begin
	     red <= 0;
	     green <= 0;
	     blue <= 0;
	     x <= 0;
	     y <= 0;
	  end
     end // always @ (posedge clk_85MHz)
 
endmodule
