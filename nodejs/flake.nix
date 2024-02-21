{
  description = "Node LTS developer setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          (final: prev: {
            nodejs = prev.nodejs-slim_20;
          })
        ];
        pkgs = import nixpkgs { inherit overlays system; };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          packages = [ nodejs ];
          shellHook = ''
            node
          '';
        };
      });
}
