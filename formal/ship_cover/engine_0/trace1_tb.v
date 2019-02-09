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
  reg [0:0] PI_i_reset;
  reg [0:0] PI_i_left_debounced;
  reg [0:0] PI_i_right_debounced;
  reg [0:0] PI_i_clk_25MHz;
  ship UUT (
    .i_reset(PI_i_reset),
    .i_left_debounced(PI_i_left_debounced),
    .i_right_debounced(PI_i_right_debounced),
    .i_clk_25MHz(PI_i_clk_25MHz)
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
    // UUT.$formal$ship.v:60$21_CHECK = 1'b1;
    // UUT.$formal$ship.v:60$21_EN = 1'b0;
    // UUT.$formal$ship.v:61$22_CHECK = 1'b1;
    // UUT.$formal$ship.v:62$23_CHECK = 1'b1;
    // UUT.$formal$ship.v:63$24_CHECK = 1'b1;
    // UUT.$formal$ship.v:67$25_CHECK = 1'b0;
    // UUT.$formal$ship.v:68$26_CHECK = 1'b0;
    // UUT.$formal$ship.v:69$27_CHECK = 1'b0;
    // UUT.$formal$ship.v:70$28_CHECK = 1'b0;
    // UUT.$formal$ship.v:71$29_CHECK = 1'b0;
    // UUT.$formal$ship.v:72$30_CHECK = 1'b1;
    // UUT.$formal$ship.v:73$31_CHECK = 1'b0;
    // UUT.$formal$ship.v:74$32_CHECK = 1'b0;
    // UUT.$formal$ship.v:75$33_CHECK = 1'b0;
    // UUT.$formal$ship.v:76$34_CHECK = 1'b0;
    // UUT.$formal$ship.v:77$35_CHECK = 1'b0;
    // UUT.$formal$ship.v:78$36_CHECK = 1'b0;
    // UUT.$formal$ship.v:79$37_CHECK = 1'b0;
    // UUT.$formal$ship.v:80$38_CHECK = 1'b0;
    // UUT.$formal$ship.v:81$39_CHECK = 1'b0;
    // UUT.$formal$ship.v:82$40_CHECK = 1'b0;
    // UUT.$formal$ship.v:83$41_CHECK = 1'b0;
    // UUT.$formal$ship.v:84$42_CHECK = 1'b0;
    // UUT.$formal$ship.v:85$43_CHECK = 1'b0;
    // UUT.$formal$ship.v:86$44_CHECK = 1'b0;
    UUT.o_ship_x = 5'b00101;

    // state 0
    PI_i_reset = 1'b1;
    PI_i_left_debounced = 1'b0;
    PI_i_right_debounced = 1'b0;
    PI_i_clk_25MHz = 1'b0;
  end
  always @(posedge clock) begin
    // state 1
    if (cycle == 0) begin
      PI_i_reset <= 1'b1;
      PI_i_left_debounced <= 1'b0;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 2
    if (cycle == 1) begin
      PI_i_reset <= 1'b0;
      PI_i_left_debounced <= 1'b0;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 3
    if (cycle == 2) begin
      PI_i_reset <= 1'b0;
      PI_i_left_debounced <= 1'b0;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 4
    if (cycle == 3) begin
      PI_i_reset <= 1'b1;
      PI_i_left_debounced <= 1'b1;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 5
    if (cycle == 4) begin
      PI_i_reset <= 1'b0;
      PI_i_left_debounced <= 1'b0;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 6
    if (cycle == 5) begin
      PI_i_reset <= 1'b0;
      PI_i_left_debounced <= 1'b0;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 7
    if (cycle == 6) begin
      PI_i_reset <= 1'b1;
      PI_i_left_debounced <= 1'b1;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 8
    if (cycle == 7) begin
      PI_i_reset <= 1'b0;
      PI_i_left_debounced <= 1'b1;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 9
    if (cycle == 8) begin
      PI_i_reset <= 1'b0;
      PI_i_left_debounced <= 1'b1;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 10
    if (cycle == 9) begin
      PI_i_reset <= 1'b1;
      PI_i_left_debounced <= 1'b1;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 11
    if (cycle == 10) begin
      PI_i_reset <= 1'b1;
      PI_i_left_debounced <= 1'b1;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    // state 12
    if (cycle == 11) begin
      PI_i_reset <= 1'b0;
      PI_i_left_debounced <= 1'b0;
      PI_i_right_debounced <= 1'b0;
      PI_i_clk_25MHz <= 1'b0;
    end

    genclock <= cycle < 12;
    cycle <= cycle + 1;
  end
endmodule
