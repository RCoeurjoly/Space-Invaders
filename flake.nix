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
        nativeBuildInputs = with pkgs; [ yosys nextpnr icestorm ];
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

  };

}
