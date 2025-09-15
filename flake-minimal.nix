{
  description = "FABulous development environment - minimal version";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "FABulous Development Environment";
          
          buildInputs = with pkgs; [
            # Core EDA tools
            yosys              # Synthesis tool
            nextpnr            # Place and route
            iverilog           # Verilog simulator (specifically requested)
            ghdl               # VHDL simulator with GCC backend (specifically requested)
            verilator          # Fast Verilog simulator
            gtkwave            # Waveform viewer
            
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

          shellHook = ''
            echo "🔧 FABulous Development Environment"
            echo ""
            echo "Available tools:"
            echo "• EDA: yosys, nextpnr, iverilog, ghdl, verilator, gtkwave"
            echo "• Java: openjdk17, maven"  
            echo "• Node.js: node, npm"
            echo "• Python: uv (for package management)"
            echo "• Other: git, build tools, editors"
            echo ""
            echo "Use 'which <tool>' to verify tool availability"
            echo "Java home: ${pkgs.openjdk17}/lib/openjdk"
          '';

          JAVA_HOME = "${pkgs.openjdk17}/lib/openjdk";
          MAVEN_OPTS = "-Xms512m -Xmx2g";
          UV_PYTHON_DOWNLOADS = "never";
          UV_SYSTEM_PYTHON = "1";
        };
      }
    );
}