{
  description = "Node LTS developer setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          (final: prev: {
            nodejs = prev.nodejs_20;
          })
        ];
        pkgs = import nixpkgs { inherit overlays system; };
      in
      with pkgs;
      {
        packages.default = buildEnv {
          name = "devel";
          paths = [ nodejs nodePackages.prettier ];
        };

        devShells.default = mkShell {
          packages = [ self.packages.${system}.default ];
          shellHook = ''
            node
          '';
        };
      });
}
