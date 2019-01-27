// Copo_yright (c) 2017-2018 Roland Coeurjolo_y
// This program is GPL Licensed. See LICENSE for the full license.

module vga_controller(
		                  input wire       i_clk_36MHz,
		                  input wire [2:0] i_rgb,
		                  output wire      o_hsync, //horizontal sync out
		                  output wire      o_vsync, //vertical sync out
		                  output reg       o_red, //o_red vga output
		                  output reg       o_green, //o_green vga output
		                  output reg       o_blue, //o_blue vga output
		                  output reg [9:0] o_x,
		                  output reg [9:0] o_y
		                  );

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
   reg [9:0]                           h_counter;
   reg [9:0]                           v_counter;


   initial begin
      o_x = 0;
      o_y = 0;
      o_red = 0;
      o_green = 0;
      o_blue = 0;
      h_counter = 0;
      v_counter = 0;
   end
   always @(posedge i_clk_36MHz)
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
     end // always @ (posedge i_clk_36MHz)

   // generate sync pulses (active low)
   // ----------------
   // "assign" statements are a quick way to
   // give values to variables of type: wire

   wire active_video;

   assign o_hsync = (h_counter >= HFP && h_counter < HFP + H_PULSE) ? 0:1;
   assign o_vsync = (v_counter >= VFP && v_counter < VFP + V_PULSE) ? 0:1;
   assign active_video = (h_counter >= HFP + H_PULSE + HBP && v_counter >= VFP + V_PULSE + VBP) ? 1:0;


   // displao_y 100% saturation colorbars
   // ------------------------
   // Combinational "always block", which is a block that is
   // triggered when anything in the "sensitivity list" changes.
   // The asterisk implies that everything that is capable of triggering the block
   // is automatically included in the sensitivty list.  In this case, it would be
   // equivalent to the following: always @(hc, vc)
   // Assignment statements can only be used on type "reg" and should be of the "blocking" type: =

   always @(posedge i_clk_36MHz)
     begin
	      // first check if we're within vertical active video range
	      if (active_video == 1)
	        // we're outside active video range so display black
	        begin
	           o_red <= i_rgb[2];
	           o_green <= i_rgb[1];
	           o_blue <= i_rgb[0];
	           o_x <= h_counter - HFP - H_PULSE - HBP;
	           o_y <= v_counter - VFP - V_PULSE - VBP;
	        end // if (active_video == 1)
	      else
	        begin
	           o_red <= 0;
	           o_green <= 0;
	           o_blue <= 0;
	           o_x <= 0;
	           o_y <= 0;
	        end // else: !if(active_video == 1)
     end // always @ (posedge i_clk_36MHz)
endmodule
