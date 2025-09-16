{
  description = "FABulous development environment (librelane-based)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    librelane.url = "github:librelane/librelane";
    devshell.url = "github:numtide/devshell";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
    # uv2nix.url = "github:pyproject-nix/uv2nix";
  };

  inputs.devshell.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, librelane, devshell, ... }@inputs:
    let
      nixpkgs = inputs.nixpkgs;
      lib = nixpkgs.lib;
        # (no top-level helper overlay here) we'll apply librelane's overlay and a small local overlay per-system
    in {
      # Top-level overlay that imports our custom package set using the *previous*
      # package set to avoid recursive overlays.
        # Note: we intentionally don't export a conflicting overlays output here. We apply overlays when importing nixpkgs below.

      devShells = {
        x86_64-linux = let
          # Avoid recursive reference to pkgs inside the overlay; use 'final'
          localOverlay = final: prev: {
            customPkgs = import ./nix { pkgs = final; };
          };
          pkgs = import nixpkgs { system = "x86_64-linux"; overlays = [ librelane.overlays.default localOverlay ]; };
          # Reuse librelane's dev shell by composing with inputsFrom
          baseShell = librelane.devShells."x86_64-linux".dev;
        in {
          dev = pkgs.mkShell {
            name = "fabulous-dev";
            # Compose our shell with librelane's dev shell
            inputsFrom = [ baseShell ];
            buildInputs = with pkgs; [
              # add a few local tools in addition to upstream shell
              which
              customPkgs.ghdl
            ];
            shellHook = ''
              echo "Entering FABulous dev shell. Available tools: yosys, verilator, nextpnr, ghdl, gtkwave, librelane"
            '';
          };
        };

      };
  };
}