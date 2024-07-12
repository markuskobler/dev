{
  description = "Go developer shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      with pkgs;
      {
        packages.default = buildEnv {
          name = "devel";
          paths = [ go gopls goperf ];
        };

        devShells.default = mkShell {
          packages = [ self.packages.${system}.default ];
          shellHook = ''
          '';
        };
      });
}
