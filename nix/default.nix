# Systematic EDA tool dependency management
# Version-controlled builds with easy hash management
{ pkgs }:

let
  # Import version configurations
  versions = import ./versions.nix;

  # Helper function to build a tool from configuration.
  # - versions.nix MUST provide a `rev` (either a commit or a tag).
  # - If `rev` is a 40-char commit sha it's used directly.
  # - If `rev` looks like a tag, we attempt to resolve it via the
  #   GitHub API to a commit sha and use that. If resolution fails we
  #   raise a clear error.
  buildTool = toolName:
    let
      config = versions.${toolName};
      hasRev = config ? rev;
      revVal = if hasRev then config.rev else "";
  isCommit = hasRev && builtins.match "^[0-9a-f]{40}$" revVal != null;

      resolveTagToCommit =
        let
          owner = config.owner;
          repo = config.repo;
          tag = revVal;
          refsUrl = "https://api.github.com/repos/${owner}/${repo}/git/refs/tags/${tag}";
          refsJson = builtins.fromJSON (builtins.readFile (builtins.fetchurl { url = refsUrl; }));
          obj = refsJson.object;
          sha = obj.sha;
          typ = obj.type;
          # Annotated tags point to a tag object; dereference if needed
          commitSha = if typ == "commit" then sha else
            let
              tagUrl = "https://api.github.com/repos/${owner}/${repo}/git/tags/${sha}";
              tagJson = builtins.fromJSON (builtins.readFile (builtins.fetchurl { url = tagUrl; }));
            in tagJson.object.sha;
        in commitSha;
    in
    if !hasRev then
      builtins.error ("versions.nix must provide a 'rev' (commit or tag) for tool: " + toString toolName)
    else
      let
        tv = builtins.tryEval resolveTagToCommit;
        commit = if isCommit then revVal else (if tv.success then tv.value else null);
      in
  if commit == null || builtins.match "^[0-9a-f]{40}$" commit == null then
        builtins.error ("Could not resolve rev '" + toString revVal + "' for " + toString toolName + ".\nTried resolving tag via GitHub API and failed. Please provide a commit hash in versions.nix.")
      else
        pkgs.callPackage (./tools + "/${toolName}.nix") {
          inherit (config) owner repo;
          rev = commit;
          fetchSubmodules = config.fetchSubmodules or false;
        };

in
{
  # Custom builds only for these tools
  nextpnr = buildTool "nextpnr";
  ghdl = buildTool "ghdl";

  # Convenience aliases for common usage patterns
  # yosys-latest = buildTool "yosys";
  ghdl-master = buildTool "ghdl";

  # Export the versions for inspection
  edaVersions = versions;
}