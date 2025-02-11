{
  description = "Elixir + Gleam Development Environment";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          devShells.default = pkgs.mkShell {
              buildInputs = [
                pkgs.beam27Packages.hex
                pkgs.beam27Packages.rebar3
                pkgs.beam27Packages.elixir
                pkgs.beam27Packages.elixir-ls
                pkgs.gleam
              ];
              shellHook = "
              mix archive.install hex mix_gleam --force &>/dev/null &
              mix deps.get &>/dev/null &
              iex -S mix
              ";
          };
        }
      );
}
