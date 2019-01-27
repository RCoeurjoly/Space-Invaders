// Copyi_right (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module space_invaders_top(
			                    input wire  i_clk_12MHz, //input clock: 12MHz
			                    input wire  i_reset, //synchronous i_reset
			                    input wire  i_left,
			                    input wire  i_right,
			                    input wire  i_shoot,
			                    input wire  i_start,
			                    output wire o_hsync, //horizontal sync out
			                    output wire o_vsync, //vertical sync out
			                    output wire o_red, //o_red vga output
			                    output wire o_green, //o_green vga output
			                    output wire o_blue //o_blue vga output
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
   wire                               level;
   wire                               clear_score;
   wire [1:0]                         gameplay;

   clk_36MHz_generator clk_36MHz_generator1(
					                                  .i_clk_12MHz(i_clk_12MHz),
					                                  .o_clk_36MHz(clk_36MHz)
					                                  );

   vga_controller vga_controller1(
				                          .i_clk_36MHz(clk_36MHz),
				                          .i_rgb(rgb),
				                          .o_hsync(o_hsync),
				                          .o_vsync(o_vsync),
				                          .o_red(o_red),
				                          .o_green(o_green),
				                          .o_blue(o_blue),
				                          .o_x(x),
				                          .o_y(y)
				                          );

   sprite_drawer sprite_drawer1(
				                        .i_x(x),
				                        .i_y(y),
				                        .i_reset(i_reset),
				                        .i_invaders_array(invaders_array),
				                        .i_invaders_line(invaders_line),
				                        .i_ship_x(ship_x),
				                        .i_bullet_x(bullet_x),
				                        .i_bullet_y(bullet_y),
				                        .i_bullet_flying(bullet_flying),
				                        .i_gameplay(gameplay),
				                        .o_rgb(rgb)
				                        );

   gameplay gameplay1(
		                  .i_clk_36MHz(clk_36MHz),
		                  .i_reset(i_reset),
		                  .i_invaders_array(invaders_array),
		                  .i_invaders_line(invaders_line),
		                  .o_gameplay(gameplay)
		                  );

   player player1(
		              .i_clk_36MHz(clk_36MHz),
		              .i_reset(i_reset),
		              .i_clear(clear),
		              .i_left(i_left),
		              .i_right(i_right),
		              .i_start(i_start),
		              .i_shoot(i_shoot),
		              .i_clear_score(clear_score),
		              .i_enable(1),
		              .i_hit(hit),
		              .o_ship_x(ship_x),
		              .o_start_debounced(start_debounced),
		              .o_bullet_x(bullet_x),
		              .o_bullet_y(bullet_y),
		              .o_bullet_flying(bullet_flying),
		              .o_score(score)
		              );

   invaders invaders1(
		                  .i_clk_36MHz(clk_36MHz),
		                  .i_reset(i_reset),
		                  .i_start(i_start),
		                  .i_bullet_x(bullet_x),
		                  .i_bullet_y(bullet_y),
		                  .i_level(level),
		                  .o_hit(hit),
		                  .o_invaders_array(invaders_array),
		                  .o_invaders_line(invaders_line)
		                  );

endmodule
