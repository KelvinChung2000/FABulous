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
    librelane.url = "github:librelane/librelane/dev";

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
        librelane = prev.librelane.overrideAttrs (old: {
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
          
          # Get librelane Python package from the flake
          librelanePythonPkg = if librelane.packages ? ${system} && librelane.packages.${system} ? librelane
                               then librelane.packages.${system}.librelane
                               else null;
          
          # Create virtualenv with all deps except librelane (which we'll add separately)
          virtualenv = pythonSet.mkVirtualEnv "FABulous-env" workspace.deps.all;
          
          baseShell = if librelane.devShells ? ${system} && librelane.devShells.${system} ? dev
                      then librelane.devShells.${system}.dev
                      else null;
          
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
            inputsFrom = lib.optionals (baseShell != null) [ baseShell ];
            packages = [
              virtualenv
              pkgs.uv
              pkgs.which
              customPkgs.nextpnr
            ] ++ lib.optionals pkgs.stdenv.isDarwin [
              # Additional macOS-specific packages if needed
              pkgs.darwin.cctools
            ] ++ lib.optionals (pkgs.stdenv.isLinux || (pkgs.stdenv.isDarwin && pkgs.stdenv.isx86_64)) [
              # GHDL is only available on Linux and x86_64-darwin due to GNAT limitations
              customPkgs.ghdl
            ];
            env = {
              UV_NO_SYNC = "1";
              UV_PYTHON = pythonSet.python.interpreter;
              UV_PYTHON_DOWNLOADS = "never";
              # Prevent Python from automatically adding ~/.local to sys.path
              PYTHONNOUSERSITE = "1";
            };
            shellHook = ''
              export REPO_ROOT=$(git rev-parse --show-toplevel)
              ORIGINAL_PS1="$PS1"
              . ${virtualenv}/bin/activate
              # Restore original PS1 to avoid double prompt decoration
              export PS1="$ORIGINAL_PS1"

              # Put our Python first in PATH to avoid conflicts with system Python
              export PATH="${pythonSet.python}/bin:$PATH"

              # Ensure the repository root and the virtualenv site-packages are importable
              # for external embedded interpreters (e.g. OpenROAD) that may invoke Python
              # without inheriting the activated environment. We prepend the venv site-packages
              # and repo root to ensure they take precedence.
              VENV_SITE=$(python -c 'import site; print(site.getsitepackages()[0])' 2>/dev/null || true)
              
              # Add librelane from the flake since uv2nix cannot build it from PyPI
              LIBRELANE_SITE=""
              ${lib.optionalString (librelanePythonPkg != null) ''
                # Add librelane's site-packages to both NIX_PYTHONPATH and PYTHONPATH
                LIBRELANE_SITE="${librelanePythonPkg}/${pythonSet.python.sitePackages}"
                if [ -d "$LIBRELANE_SITE" ]; then
                  # Add to NIX_PYTHONPATH for sitecustomize.py
                  export NIX_PYTHONPATH="$LIBRELANE_SITE''${NIX_PYTHONPATH:+:$NIX_PYTHONPATH}"
                fi
              ''}
              
              # Build PYTHONPATH with librelane, virtualenv site-packages, and repo root
              # OpenROAD's embedded Python needs librelane in PYTHONPATH, not just NIX_PYTHONPATH
              if [ -n "$VENV_SITE" ]; then
                if [ -n "$LIBRELANE_SITE" ]; then
                  export PYTHONPATH="$LIBRELANE_SITE:$VENV_SITE:$REPO_ROOT"
                else
                  export PYTHONPATH="$VENV_SITE:$REPO_ROOT"
                fi
              else
                if [ -n "$LIBRELANE_SITE" ]; then
                  export PYTHONPATH="$LIBRELANE_SITE:$REPO_ROOT"
                else
                  export PYTHONPATH="$REPO_ROOT"
                fi
              fi
              
              echo "[flake shell] PYTHONPATH set to: $PYTHONPATH" >&2
              echo "[flake shell] Python executable: $(which python)" >&2
              echo "[flake shell] Python version: $(python --version)" >&2

              # macOS-specific environment setup
              ${lib.optionalString pkgs.stdenv.isDarwin ''
                # Set up macOS-specific environment if needed
                export MACOSX_DEPLOYMENT_TARGET="11.0"
                ${lib.optionalString pkgs.stdenv.isAarch64 ''
                  # Note: GHDL is not available on Apple Silicon due to GNAT limitations
                  # Consider using alternative VHDL simulators or running via Docker
                  echo "Warning: GHDL is not available on Apple Silicon Macs"
                ''}
              ''}
            '';
          };
        }
      );

      packages = forAllSystems (system: {
        default = pythonSets.${system}.mkVirtualEnv "FABulous-env" workspace.deps.default;
      });
    };
}
