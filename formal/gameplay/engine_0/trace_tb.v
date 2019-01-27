`ifndef VERILATOR
module testbench;
  reg [4095:0] vcdfile;
  reg clock;
`else
module testbench(input clock, output reg genclock);
  initial genclock = 1;
`endif
  reg genclock = 1;
  reg [31:0] cycle = 0;
  reg [19:0] PI_i_invaders_array;
  reg [0:0] PI_i_clk_36MHz;
  reg [0:0] PI_i_reset;
  reg [3:0] PI_i_invaders_line;
  gameplay UUT (
    .i_invaders_array(PI_i_invaders_array),
    .i_clk_36MHz(PI_i_clk_36MHz),
    .i_reset(PI_i_reset),
    .i_invaders_line(PI_i_invaders_line)
  );
`ifndef VERILATOR
  initial begin
    if ($value$plusargs("vcd=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, testbench);
    end
    #5 clock = 0;
    while (genclock) begin
      #5 clock = 0;
      #5 clock = 1;
    end
  end
`endif
  initial begin
`ifndef VERILATOR
    #1;
`endif
    // UUT.$formal$gameplay.v:45$1_CHECK = 1'b0;
    // UUT.$formal$gameplay.v:45$1_EN = 1'b0;
    UUT.GAME_OVER_reached = 1'b0;
    UUT.o_gameplay = 2'b00;

    // state 0
    PI_i_invaders_array = 20'b00000000000000000000;
    PI_i_clk_36MHz = 1'b0;
    PI_i_reset = 1'b1;
    PI_i_invaders_line = 4'b1101;
  end
  always @(posedge clock) begin
    // state 1
    if (cycle == 0) begin
      PI_i_invaders_array <= 20'b00000000000000000000;
      PI_i_clk_36MHz <= 1'b0;
      PI_i_reset <= 1'b0;
      PI_i_invaders_line <= 4'b0000;
    end

    // state 2
    if (cycle == 1) begin
      PI_i_invaders_array <= 20'b00000000000000000000;
      PI_i_clk_36MHz <= 1'b0;
      PI_i_reset <= 1'b0;
      PI_i_invaders_line <= 4'b0000;
    end

    // state 3
    if (cycle == 2) begin
      PI_i_invaders_array <= 20'b00000000000000000000;
      PI_i_clk_36MHz <= 1'b0;
      PI_i_reset <= 1'b0;
      PI_i_invaders_line <= 4'b0000;
    end

    genclock <= cycle < 3;
    cycle <= cycle + 1;
  end
endmodule
