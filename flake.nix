{
  description = "FABulous development environment with librelane dependencies and additional tools";

  inputs = {
    # Use stable nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    
    # Use the latest stable nix-eda version
    nix-eda.url = "github:fossi-foundation/nix-eda/5.5.0";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nix-eda, devshell, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlays.default
            nix-eda.overlays.default
          ];
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.devshell.mkShell {
          name = "FABulous Development Environment";
          
          motd = ''
            {202}🔧 FABulous Development Environment{reset}
            
            This shell includes:
            • All EDA tools: yosys, nextpnr-generic, iverilog, ghdl
            • Java 17 + Maven for FABulator development
            • Node.js with npm 
            • Git and development tools
            • uv for Python dependency management
            
            Use 'uv' for Python package management instead of pip/conda.
            Run 'test-tools' to verify all tools are available.
          '';

          packages = with pkgs; [
            # Core EDA tools
            yosys              # Synthesis tool
            nextpnr            # Place and route
            iverilog           # Verilog simulator (specifically requested)
            ghdl               # VHDL simulator with GCC backend (specifically requested)
            verilator          # Fast Verilog simulator
            gtkwave            # Waveform viewer
            
            # Try to get nextpnr-generic if available, fallback to nextpnr
            (pkgs.nextpnr.override { 
              enableGeneric = true; 
            } or pkgs.nextpnr)
            
            # Python dependency management (uv instead of Python packages)
            uv
            
            # Java ecosystem for FABulator (specifically requested)
            openjdk17          # Java 17 JVM
            maven              # Maven build tool
            
            # Node.js ecosystem (specifically requested)
            nodejs             # Node.js runtime
            nodePackages.npm   # Node package manager
            
            # Version control and development tools
            git                # Version control (specifically requested)
            
            # Shell and development utilities
            tmux
            wget
            curl
            jq
            
            # Build tools that might be needed
            cmake
            ninja
            gnumake
            pkg-config
            
            # Text editors and development tools
            vim
            
            # Archive tools
            unzip
            tar
            gzip
            
            # Additional utilities
            ripgrep
            fd
            fzf
            which
            file
          ];

          env = [
            {
              name = "JAVA_HOME";
              value = "${pkgs.openjdk17}/lib/openjdk";
            }
            {
              name = "MAVEN_OPTS";
              value = "-Xms512m -Xmx2g";
            }
            # Configure uv
            {
              name = "UV_PYTHON_DOWNLOADS";
              value = "never";  # Don't download Python, use system Python
            }
            {
              name = "UV_SYSTEM_PYTHON";
              value = "1";      # Allow using system Python
            }
          ];

          commands = [
            {
              name = "setup-python";
              help = "Set up Python environment with uv";
              command = ''
                echo "Setting up Python environment with uv..."
                if [ -f pyproject.toml ]; then
                  uv sync
                  echo "Python environment ready! Use 'uv run <command>' to run Python commands."
                else
                  echo "No pyproject.toml found. You can create one with 'uv init' or 'uv add <package>'"
                fi
              '';
            }
            {
              name = "install-nvm";
              help = "Install and configure nvm (Node Version Manager)";
              command = ''
                if [ ! -d "$HOME/.nvm" ]; then
                  echo "Installing nvm..."
                  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
                  echo "nvm installed! Restart your shell or run 'source ~/.bashrc' (or equivalent for your shell)"
                else
                  echo "nvm is already installed at $HOME/.nvm"
                fi
              '';
            }
            {
              name = "run-fabulator";
              help = "Run FABulator GUI application from source";
              command = ''
                if [ -f pom.xml ]; then
                  echo "Running FABulator..."
                  mvn javafx:run
                else
                  echo "No pom.xml found. Please clone FABulator source:"
                  echo "  git clone https://github.com/FPGA-Research/FABulator"
                  echo "  cd FABulator"
                  echo "  mvn javafx:run"
                fi
              '';
            }
            {
              name = "build-fabulator";
              help = "Build FABulator from source in current directory";
              command = ''
                if [ -f pom.xml ]; then
                  mvn clean compile
                else
                  echo "No pom.xml found. Are you in a FABulator source directory?"
                fi
              '';
            }
            {
              name = "test-tools";
              help = "Test that all tools are available";
              command = ''
                echo "Testing EDA tools availability..."
                echo -n "yosys: "; command -v yosys >/dev/null && echo "✓" || echo "✗"
                echo -n "nextpnr: "; command -v nextpnr >/dev/null && echo "✓" || echo "✗"
                echo -n "iverilog: "; command -v iverilog >/dev/null && echo "✓" || echo "✗"
                echo -n "ghdl: "; command -v ghdl >/dev/null && echo "✓" || echo "✗"
                echo -n "uv: "; command -v uv >/dev/null && echo "✓" || echo "✗"
                echo -n "java: "; command -v java >/dev/null && echo "✓" || echo "✗"
                echo -n "mvn: "; command -v mvn >/dev/null && echo "✓" || echo "✗"
                echo -n "node: "; command -v node >/dev/null && echo "✓" || echo "✗"
                echo -n "git: "; command -v git >/dev/null && echo "✓" || echo "✗"
                echo ""
                echo "Tool versions:"
                yosys -V 2>/dev/null | head -1 || echo "yosys: version not available"
                java -version 2>&1 | head -1 || echo "java: version not available"
                mvn -version 2>/dev/null | head -1 || echo "maven: version not available"
                node -v 2>/dev/null || echo "node: version not available"
              '';
            }
            {
              name = "clone-fabulator";
              help = "Clone FABulator repository";
              command = ''
                if [ ! -d "FABulator" ]; then
                  echo "Cloning FABulator..."
                  git clone https://github.com/FPGA-Research/FABulator.git
                  echo "FABulator cloned to ./FABulator"
                  echo "You can now cd into it and run 'mvn javafx:run'"
                else
                  echo "FABulator directory already exists"
                fi
              '';
            }
          ];
        };
        
        # Minimal shell without GUI applications for CI/headless environments
        devShells.ci = pkgs.devshell.mkShell {
          name = "FABulous CI Environment";
          
          packages = with pkgs; [
            # Core EDA tools
            yosys
            nextpnr
            iverilog
            ghdl
            verilator
            
            # Python and Java
            uv
            openjdk17
            maven
            
            # Development tools
            git
            nodejs
            
            # Build tools
            cmake
            ninja
            gnumake
          ];
        };
      }
    );
}