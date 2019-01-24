// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module space_invaders_top(
			                    input wire  clk_12MHz, //input clock: 12MHz
			                    input wire  reset, //synchronous reset
			                    input wire  left,
			                    input wire  right,
			                    input wire  shoot,
			                    input wire  start,
			                    output wire hsync, //horizontal sync out
			                    output wire vsync, //vertical sync out
			                    output wire red, //red vga output
			                    output wire green, //green vga output
			                    output wire blue //blue vga output
			                    );

   wire                               clk_36MHz;
   wire [2:0]                         rgb;
   wire [9:0]                         x;
   wire [9:0]                         y;
   wire [4:0]                         ship_x;
   wire [4:0]                         bullet_x;
   wire [3:0]                         bullet_y;
   wire                               hit;
   wire [19:0]                        invaders_array;
   wire [3:0]                         invaders_line;
   wire                               bullet_flying;
   wire                               clear;
   wire                               start_debounced;
   wire [7:0]                         score;
   wire                               hit;
   wire                               level;
   wire                               clear_score;
   wire [2:0]                         gameplay;

   clk_36MHz_generator clk_36MHz_generator1(
					                                  .clk_12MHz(clk_12MHz),
					                                  .clk_36MHz(clk_36MHz)
					                                  );

   vga_controller vga_controller1(
				                          .clk_36MHz(clk_36MHz),
				                          .rgb(rgb),
				                          .hsync(hsync),
				                          .vsync(vsync),
				                          .red(red),
				                          .green(green),
				                          .blue(blue),
				                          .x(x),
				                          .y(y)
				                          );

   sprite_drawer sprite_drawer1(
				                        .x(x),
				                        .y(y),
				                        .reset(reset),
				                        .invaders_array(invaders_array),
				                        .invaders_line(invaders_line),
				                        .ship_x(ship_x),
				                        .bullet_x(bullet_x),
				                        .bullet_y(bullet_y),
				                        .bullet_flying(bullet_flying),
				                        .gameplay(gameplay),
				                        .rgb(rgb)
				                        );

   gameplay gameplay1(
		                  .clk_36MHz(clk_36MHz),
		                  .reset(reset),
		                  .invaders_array(invaders_array),
		                  .invaders_line(invaders_line),
		                  .gameplay(gameplay)
		                  );

   player player1(
		              .clk_36MHz(clk_36MHz),
		              .reset(reset),
		              .clear(clear),
		              .left(left),
		              .right(right),
		              .start(start),
		              .shoot(shoot),
		              .clear_score(clear_score),
		              .enable(1),
		              .hit(hit),
		              .ship_x(ship_x),
		              .start_debounced(start_debounced),
		              .bullet_x(bullet_x),
		              .bullet_y(bullet_y),
		              .bullet_flying(bullet_flying),
		              .score(score)
		              );

   invaders invaders1(
		                  .clk_36MHz(clk_36MHz),
		                  .reset(reset),
		                  .start(start),
		                  .bullet_x(bullet_x),
		                  .bullet_y(bullet_y),
		                  .level(level),
		                  .hit(hit),
		                  .invaders_array(invaders_array),
		                  .invaders_line(invaders_line)
		                  );

endmodule
