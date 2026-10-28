{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      treefmt-nix,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
      ];
      perSystem = { pkgs, ... }: {
        treefmt = {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
          };
        };
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              just
            ];
          };
        };
      };
    };
}
