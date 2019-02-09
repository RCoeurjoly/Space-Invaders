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
  reg [0:0] PI_start;
  reg [0:0] PI_clk_25MHz;
  reg [3:0] PI_bullet_y;
  reg [0:0] PI_level;
  reg [4:0] PI_bullet_x;
  reg [0:0] PI_reset;
  invaders UUT (
    .start(PI_start),
    .clk_25MHz(PI_clk_25MHz),
    .bullet_y(PI_bullet_y),
    .level(PI_level),
    .bullet_x(PI_bullet_x),
    .reset(PI_reset)
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
    // UUT.$formal$invaders.v:106$1_CHECK = 1'b0;
    // UUT.$formal$invaders.v:106$1_EN = 1'b0;
    // UUT.$formal$invaders.v:107$2_CHECK = 1'b0;
    UUT.direction = 1'b1;
    UUT.hit = 1'b0;
    UUT.invaders_array = 20'b00000000000000000001;
    UUT.invaders_line = 4'b1101;
    UUT.speed_timer1.count = 32'b00000000001101101110111001101110;
    UUT.speed_timer1.q = 1'b0;

    // state 0
    PI_start = 1'b0;
    PI_clk_25MHz = 1'b0;
    PI_bullet_y = 4'b0000;
    PI_level = 1'b0;
    PI_bullet_x = 5'b00000;
    PI_reset = 1'b1;
  end
  always @(posedge clock) begin
    // state 1
    if (cycle == 0) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 2
    if (cycle == 1) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 3
    if (cycle == 2) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 4
    if (cycle == 3) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 5
    if (cycle == 4) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 6
    if (cycle == 5) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 7
    if (cycle == 6) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 8
    if (cycle == 7) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 9
    if (cycle == 8) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 10
    if (cycle == 9) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 11
    if (cycle == 10) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 12
    if (cycle == 11) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 13
    if (cycle == 12) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 14
    if (cycle == 13) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 15
    if (cycle == 14) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 16
    if (cycle == 15) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 17
    if (cycle == 16) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 18
    if (cycle == 17) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b1;
    end

    // state 19
    if (cycle == 18) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b0;
    end

    // state 20
    if (cycle == 19) begin
      PI_start <= 1'b0;
      PI_clk_25MHz <= 1'b0;
      PI_bullet_y <= 4'b0000;
      PI_level <= 1'b0;
      PI_bullet_x <= 5'b00000;
      PI_reset <= 1'b0;
    end

    genclock <= cycle < 20;
    cycle <= cycle + 1;
  end
endmodule
