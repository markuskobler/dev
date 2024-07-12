{
  description = "Node developer shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          (final: prev: {
            nodejs = prev.nodejs_22;
          })
        ];
        pkgs = import nixpkgs { inherit overlays system; };
      in
      with pkgs;
      {
        packages.default = buildEnv {
          name = "devel";
          paths = 
            [ nodejs ] ++ (with nodePackages; [ prettier prettier-plugin-toml ]);
        };

        devShells.default = mkShell {
          packages = [ self.packages.${system}.default ];
          shellHook = ''
            node
          '';
        };
      });
}
