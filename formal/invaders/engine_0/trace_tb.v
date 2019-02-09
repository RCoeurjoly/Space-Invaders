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
  reg [4:0] PI_i_bullet_x;
  reg [3:0] PI_i_bullet_y;
  reg [0:0] PI_i_clk_25MHz;
  reg [0:0] PI_i_reset;
  invaders UUT (
    .i_bullet_x(PI_i_bullet_x),
    .i_bullet_y(PI_i_bullet_y),
    .i_clk_25MHz(PI_i_clk_25MHz),
    .i_reset(PI_i_reset)
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
    UUT.direction = 1'b0;
    UUT.o_hit = 1'b0;
    UUT.o_invaders_array = 20'b00000000000111111111;
    UUT.o_invaders_row = 4'b0001;
    UUT.speed_timer1.count = 32'b00000000000000000000000000000000;
    UUT.speed_timer1.o_q = 1'b0;

    // state 0
    PI_i_bullet_x = 5'b00000;
    PI_i_bullet_y = 4'b0000;
    PI_i_clk_25MHz = 1'b0;
    PI_i_reset = 1'b0;
  end
  always @(posedge clock) begin
    genclock <= cycle < 0;
    cycle <= cycle + 1;
  end
endmodule
