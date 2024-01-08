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
  };
}
