{
  description = "hello world application using uv2nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
  };

  outputs =
    {
      nixpkgs,
      librelane,
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
          python = pkgs.python3;
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
          customPkgs = import ./nix { inherit pkgs; };
        in
        {
          default = pkgs.mkShell {
            inputsFrom = [ baseShell ];
            packages = [
              virtualenv
              pkgs.uv
              pkgs.which
              customPkgs.nextpnr
              customPkgs.ghdl
            ];
            env = {
              UV_NO_SYNC = "1";
              UV_PYTHON = pythonSet.python.interpreter;
              UV_PYTHON_DOWNLOADS = "never";
            };
            shellHook = ''
              unset PYTHONPATH
              export REPO_ROOT=$(git rev-parse --show-toplevel)
              . ${virtualenv}/bin/activate
            '';
          };
        }
      );

      packages = forAllSystems (system: {
        default = pythonSets.${system}.mkVirtualEnv "FABulous-env" workspace.deps.default;
      });
    };
}