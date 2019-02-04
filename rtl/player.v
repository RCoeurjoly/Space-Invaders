// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module player(
              input wire        i_clk_36MHz,
              input wire        i_reset,
              input wire        i_left,
              input wire        i_right,
              input wire        i_shoot,
              input wire        i_hit,
              output wire [4:0] o_ship_x,
              output wire [4:0] o_bullet_x,
              output wire [3:0] o_bullet_y
              );

   //Interconnect
   wire                         left_debounced;
   wire                         right_debounced;
   wire                         shoot_debounced;

   edge_detector_debouncer left_debouncer(
                                          .i_clk_36MHz            (i_clk_36MHz),
                                          .i_reset                (i_reset),
                                          .i_in                   (i_left),
                                          .o_debounced            (left_debounced));

   edge_detector_debouncer right_debouncer(
                                           .i_clk_36MHz            (i_clk_36MHz),
                                           .i_reset                (i_reset),
                                           .i_in                   (i_right),
                                           .o_debounced            (right_debounced));

   edge_detector_debouncer shoot_debouncer(
                                           .i_clk_36MHz            (i_clk_36MHz),
                                           .i_reset                (i_reset),
                                           .i_in                   (i_shoot),
                                           .o_debounced            (shoot_debounced));

   ship ship1(
              .i_clk_36MHz                (i_clk_36MHz),
              .i_reset                    (i_reset),
              .i_left_debounced           (left_debounced),
              .i_right_debounced          (right_debounced),
              .o_ship_x                   (o_ship_x));

   bullet bullet1(
                  .i_clk_36MHz            (i_clk_36MHz),
                  .i_reset                (i_reset),
                  .i_shoot                (shoot_debounced),
                  .i_hit                  (i_hit),
                  .i_ship_x               (o_ship_x),
                  .o_bullet_x             (o_bullet_x),
                  .o_bullet_y             (o_bullet_y));
endmodule
