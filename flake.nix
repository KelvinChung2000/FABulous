{
  description = "hello world application using uv2nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    librelane.url = "github:librelane/librelane";

    # Tag-pinned sources for custom tools (locked in flake.lock)
    ghdl-src = {
      url = "github:ghdl/ghdl/nightly";
      flake = false;
    };
    nextpnr-src = {
      url = "github:YosysHQ/nextpnr/nextpnr-0.9";
      flake = false;
    };

  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      librelane,
      ghdl-src,
      nextpnr-src,
      pyproject-nix,
      uv2nix,
      pyproject-build-systems,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;

      workspace = uv2nix.lib.workspace.loadWorkspace { workspaceRoot = ./.; };

      overlay = workspace.mkPyprojectOverlay {
        sourcePreference = "wheel";
      };

      pyprojectOverrides = final: prev: {
        fasm = prev.fasm.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or []) ++ final.resolveBuildSystem {
            setuptools = [ ]; wheel = [ ]; cython = [ ];
          };
        });
        pyperclip = prev.pyperclip.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or []) ++ final.resolveBuildSystem {
            setuptools = [ ]; wheel = [ ];
          };
        });
      };

      editableOverlay = workspace.mkEditablePyprojectOverlay {
        root = "$REPO_ROOT";
      };

      pythonSets = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          # I can only get Tkinter support by using python3Full from nixpkgs-stable
          python = nixpkgs-stable.legacyPackages.${system}.python312Full;
        in
        (pkgs.callPackage pyproject-nix.build.packages {
          inherit python;
        }).overrideScope
          (
            lib.composeManyExtensions [
              pyproject-build-systems.overlays.wheel
              overlay
              pyprojectOverrides
            ]
          )
      );

    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          pythonSet = pythonSets.${system}.overrideScope editableOverlay;
          virtualenv = pythonSet.mkVirtualEnv "FABulous-env" workspace.deps.all;
          baseShell = librelane.devShells.${system}.dev;
          
          # pass the current pkgs to the nix overlay so it returns a package set
          # also pass flake-locked sources so tags resolve to a fixed commit
          customPkgs = import ./nix {
            inherit pkgs;
            srcs = {
              ghdl = ghdl-src;
              nextpnr = nextpnr-src;
            };
          };
        in
        {
          default = pkgs.mkShell {
            inputsFrom = [ baseShell ];
            packages = [
              virtualenv
              pkgs.uv
              pkgs.which
              customPkgs.ghdl
              customPkgs.nextpnr
            ];
            env = {
              UV_NO_SYNC = "1";
              UV_PYTHON = pythonSet.python.interpreter;
              UV_PYTHON_DOWNLOADS = "never";
            };
            shellHook = ''
              unset PYTHONPATH
              export REPO_ROOT=$(git rev-parse --show-toplevel)
              ORIGINAL_PS1="$PS1"
              . ${virtualenv}/bin/activate
              # Restore original PS1 to avoid double prompt decoration
              export PS1="$ORIGINAL_PS1"

              # Put our Python first in PATH to avoid conflicts with system Python
              export PATH="${pythonSet.python}/bin:$PATH"
            '';
          };
        }
      );

      packages = forAllSystems (system: {
        default = pythonSets.${system}.mkVirtualEnv "FABulous-env" workspace.deps.default;
      });
    };
}
