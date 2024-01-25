{
  description = "Space invaders in Verilog";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    fpga_toolchain = {
      url = "github:openXC7/toolchain-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, fpga_toolchain }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.space_invaders;
    packages.x86_64-linux.space_invaders =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        buildInputs = with pkgs; [ ];
        nativeBuildInputs = with pkgs; [ yosys nextpnr icestorm gtkwave ];
        name = "space invaders";
        src = self;
        dontStrip = true;
        installPhase = "mkdir -p $out/bin; install -t $out/bin space_invaders_top.bin";
      };
    packages.x86_64-linux.leds =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        buildInputs = with pkgs; [ ];
        nativeBuildInputs = with pkgs; [ yosys nextpnr icestorm ];
        name = "leds";
        src = self;
        dontStrip = true;
        buildPhase = ''
        yosys -p "synth_ice40 -blif leds.blif -json leds.json" -l leds.log -q rtl/leds.v
      	nextpnr-ice40 --hx8k --package ct256 --pcf-allow-unconstrained --pcf syn/leds_iCE40-HX8K.pcf --json leds.json --asc leds.asc
       	icepack leds.asc leds.bin
        '';
        installPhase = "mkdir -p $out/bin; install -t $out/bin leds.bin";
      };

    packages.x86_64-linux.space_invaders_zybo =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        buildInputs = with pkgs; [ ];
        nativeBuildInputs = with pkgs; [ yosys nextpnr icestorm ];
        name = "space_invaders";
        src = self;
        dontStrip = true;
        buildPhase = ''
        yosys -p "synth_xilinx -flatten -abc9  -arch xc7 -top space_invaders_top; write_json space_invaders_zybo.json" rtl/space_invaders_top.v rtl/vga_controller.v rtl/sprite_drawer.v rtl/gameplay.v rtl/ship.v rtl/edge_detector_debouncer.v rtl/timer_u1s.v rtl/player.v rtl/invaders.v rtl/bullet.v
        nextpnr-xilinx --chipdb ../chipdb//xc7z010clg400.bin --xdc blinky.xdc --json blinky.json --fasm blinky.fasm
        fasm2frames --part xc7z010clg400-1 --db-root /nix/store/db29yxznxanfzsl32y632maqylhk98jw-nextpnr-xilinx-unstable-2023-12-05/share/nextpnr/external/prjxray-db/zynq7 blinky.fasm > blinky.frames
        xc7frames2bit --part_file /nix/store/db29yxznxanfzsl32y632maqylhk98jw-nextpnr-xilinx-unstable-2023-12-05/share/nextpnr/external/prjxray-db/zynq7/xc7z010clg400-1/part.yaml --part_name xc7z010clg400-1 --frm_file blinky.frames --output_file blinky.bit
        '';
        installPhase = "mkdir -p $out/bin; install -t $out/bin leds.bin";
      };

  };

}
