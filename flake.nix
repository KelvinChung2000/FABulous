{
  description = "FABulous editable dev shell (uv2nix hello-world style)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    librelane.url = "github:librelane/librelane";
  };

  outputs = { self, librelane, nixpkgs, nixpkgs-unstable, uv2nix, pyproject-nix, pyproject-build-systems, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    pkgsBase = nixpkgs-unstable.legacyPackages.${system};

    # Base Python for uv2nix builders (plain interpreter)
    python = pkgsBase.python312;

      # Load uv workspace and create overlays (uv2nix hello-world)
      workspace = uv2nix.lib.workspace.loadWorkspace { workspaceRoot = ./.; };
      overlay = workspace.mkPyprojectOverlay { sourcePreference = "wheel"; };

      # Fix sdists that miss build deps
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
        "cocotb-test" = prev."cocotb-test".overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or []) ++ final.resolveBuildSystem {
            setuptools = [ ]; wheel = [ ];
          };
        });
      };

      pythonSet = (pkgsBase.callPackage pyproject-nix.build.packages { inherit python; })
        .overrideScope (lib.composeManyExtensions [
          pyproject-build-systems.overlays.default
          overlay
          pyprojectOverrides
        ]);

      # Enable editable installs for local package(s)
      editableOverlay = workspace.mkEditablePyprojectOverlay {
        # Use an environment variable to avoid embedding a Nix store path
        root = "$REPO_ROOT";
        members = [ "fabulous-fpga" ];
      };
      editablePythonSet = pythonSet.overrideScope (lib.composeManyExtensions [ editableOverlay ]);

      # Venv with dev deps and editable install
      editableVenv = editablePythonSet.mkVirtualEnv "fabulous-dev-env" workspace.deps.all;
      localOverlay = final: prev: {
            customPkgs = import ./nix { pkgs = final; };
          };
      pkgs = import nixpkgs { system = "x86_64-linux"; overlays = [ librelane.overlays.default localOverlay ]; };
      baseShell = librelane.devShells."x86_64-linux".dev;
    in {
      # Single editable shell; nix-shell . will start this
      devShells.${system}.default = pkgsBase.mkShell {
        name = "fabulous";
        packages = [ editableVenv pkgsBase.uv pkgsBase.python312Packages.tkinter ];
        inputsFrom = [ baseShell ];
        buildInputs = with pkgs; [ 
          which
          customPkgs.ghdl  
        ];
        env = {
          UV_PYTHON = python.interpreter;
          UV_PYTHON_DOWNLOADS = "never";
          # Expose tkinter module and its extension module to the venv's Python
          PYTHONPATH = "${pkgsBase.python312Packages.tkinter}/lib/python3.12:${pkgsBase.python312Packages.tkinter}/lib/python3.12/lib-dynload";
        };
        shellHook = ''
          REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
          export REPO_ROOT
          echo "Entering FABulous editable shell (Tk ready)."
        '';
      };

      # Make legacy `nix-shell .` pick the default editable shell
      devShell.${system} = self.devShells.${system}.default;
    };
}