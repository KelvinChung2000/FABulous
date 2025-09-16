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
      inherit (config) owner repo rev;
      fetchSubmodules = config.fetchSubmodules or false;
    };

  # Helper function to choose between custom build and nixpkgs fallback
  buildToolWithFallback = toolName: nixpkgsPackage:
    let
      config = versions.${toolName};
      # Use custom build if rev is set, otherwise fallback
      hasRev = config ? rev;
    in
    if hasRev then
      buildTool toolName
    else
      nixpkgsPackage;

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