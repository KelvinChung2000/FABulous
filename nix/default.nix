# Systematic EDA tool dependency management
# Version-controlled builds with easy hash management
{ pkgs }:

let
  # Import version configurations
  versions = import ./versions.nix;

  # Helper function to build a tool from configuration
  buildTool = toolName:
    let
      config = versions.${toolName};
    in
    pkgs.callPackage (./tools + "/${toolName}.nix") {
      inherit (config) owner repo rev hash;
      fetchSubmodules = config.fetchSubmodules or false;
    };

  # Helper function to choose between custom build and nixpkgs fallback
  buildToolWithFallback = toolName: nixpkgsPackage:
    let
      config = versions.${toolName};
      # Check if hash is placeholder (needs updating)
      needsHash = config.hash == "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    in
    if needsHash then
      # Fall back to nixpkgs version if hash not updated yet
      nixpkgsPackage
    else
      # Use custom build with proper hash
      buildTool toolName;

in
{
  # Custom builds only for these tools
  nextpnr = buildToolWithFallback "nextpnr" pkgs.nextpnr;
  ghdl = buildToolWithFallback "ghdl" pkgs.ghdl;

  # Convenience aliases for common usage patterns
  # yosys-latest = buildToolWithFallback "yosys" pkgs.yosys;
  ghdl-master = buildToolWithFallback "ghdl" pkgs.ghdl;

  # Export the versions for inspection
  edaVersions = versions;
}