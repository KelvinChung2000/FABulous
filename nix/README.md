# EDA Tools Version Management

This directory contains a systematic approach to managing EDA tool dependencies with precise version control using GitHub commit hashes.

## 🎯 Quick Start

### Using the Environment
```bash
# Enter development environment
nix develop .#dev

# Test all tools
test-tools

# Run Python tests with uv
uv run pytest
```

### Updating Tool Versions
```bash
# 1. Edit the rev field in nix/versions.nix
vim nix/versions.nix

# 2. Update hashes automatically
nix/update-hashes.sh

# 3. Test the environment
nix develop .#dev --command test-tools
```

## 📁 Structure

```
nix/
├── versions.nix          # Central version configuration (EDIT THIS)
├── update-hashes.sh      # Hash update automation script
├── default.nix          # Main tool integration
├── tools/               # Individual tool derivations
│   ├── yosys.nix
│   ├── verilator.nix
│   ├── iverilog.nix
│   ├── nextpnr.nix
│   ├── ghdl.nix
│   └── gtkwave.nix
└── README.md            # This file
```

## 🔧 Available Tools

| Tool | Description | Current Version |
|------|-------------|----------------|
| **yosys** | Synthesis tool | Configurable via versions.nix |
| **verilator** | Fast Verilog simulator | Configurable via versions.nix |
| **iverilog** | Icarus Verilog simulator | Configurable via versions.nix |
| **nextpnr** | Place and route tool | Configurable via versions.nix |
| **ghdl** | VHDL simulator and analyzer | Configurable via versions.nix |
| **gtkwave** | Waveform viewer | Configurable via versions.nix |

## 📝 Version Configuration

### Format of versions.nix

```nix
{
  toolname = {
    owner = "github-owner";
    repo = "repository-name";
    rev = "commit-hash-or-tag";  # ← CHANGE THIS
    hash = "sha256-...";         # ← Auto-updated by script
    fetchSubmodules = true/false;
  };
}
```

### Examples

**Use latest stable release:**
```nix
yosys = {
  owner = "YosysHQ";
  repo = "yosys";
  rev = "v0.57";  # Use tag
  # ...
};
```

**Use specific commit:**
```nix
yosys = {
  owner = "YosysHQ";
  repo = "yosys";
  rev = "abc123def456";  # Use commit hash
  # ...
};
```

**Use development branch:**
```nix
yosys = {
  owner = "YosysHQ";
  repo = "yosys";
  rev = "main";  # Use branch name
  # ...
};
```

## 🤖 Automation Script

### `update-hashes.sh`

This script automatically:
1. Reads tool configurations from `versions.nix`
2. Fetches the correct SHA256 hash for each revision
3. Updates the hash field in `versions.nix`
4. Handles submodules correctly

### Requirements

The script requires these tools to be available:
- `nix-prefetch-git`
- `jq`
- `nix-instantiate`
- `sed`

### Usage

```bash
# Update all hashes
./nix/update-hashes.sh

# The script will show progress:
# 🔄 Updating hashes in nix/versions.nix
# 🛠️ Processing tool: yosys
# 📦 Fetching hash for YosysHQ/yosys@v0.57 (submodules: true)
# ✅ Updating yosys hash to sha256-...
# ✨ Hash update complete!
```

## 🔄 Workflow

### Adding a New Tool

1. **Add to versions.nix:**
```nix
newtool = {
  owner = "owner";
  repo = "repo";
  rev = "v1.0.0";
  hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  fetchSubmodules = false;
};
```

2. **Create tool derivation:**
```bash
# Create nix/tools/newtool.nix
cp nix/tools/yosys.nix nix/tools/newtool.nix
# Edit the derivation for your tool
```

3. **Add to main integration:**
```nix
# In nix/default.nix
{
  # ...existing tools...
  newtool = buildToolWithFallback "newtool" pkgs.newtool;
}
```

4. **Update flake.nix:**
```nix
packages = with pkgs; [
  # ...existing packages...
  customPackages.newtool
];
```

5. **Update hashes and test:**
```bash
nix/update-hashes.sh
nix develop .#dev --command test-tools
```

### Updating Existing Tools

1. **Change revision in versions.nix:**
```nix
yosys = {
  # ...
  rev = "v0.58";  # Changed from v0.57
  # hash will be updated automatically
};
```

2. **Run update script:**
```bash
nix/update-hashes.sh
```

3. **Test the environment:**
```bash
nix develop .#dev --command test-tools
```

## 🛡️ Fallback Strategy

The system includes automatic fallback to nixpkgs versions:

- If a tool's hash is the placeholder value, nixpkgs version is used
- This ensures the environment always works
- Custom builds are used only when hashes are properly updated

## 🧪 Testing

### Tool Availability Test
```bash
nix develop .#dev --command test-tools
```

### Expected Output
```
🔧 EDA Tools:
  yosys: ✓ - Yosys 0.57 (git sha1 ...)
  verilator: ✓ - Verilator 5.030 devel rev ...
  iverilog: ✓ - Icarus Verilog version 12.0 ...
  nextpnr: ✓ - NextPNR available
  ghdl: ✓ - GHDL 5.0.0 ...
  gtkwave: ✓ - GTKWave available

📝 Version Management:
  Edit nix/versions.nix to change tool versions
  Run nix/update-hashes.sh to update hashes
```

## 🎯 Benefits

1. **Single Source of Truth:** All version info in `versions.nix`
2. **Reproducible Builds:** Exact commit hashes ensure identical builds
3. **Easy Updates:** Change commit hash → run script → rebuild
4. **Automatic Fallback:** Always have working environment via nixpkgs
5. **No Manual Hash Management:** Script handles SHA256 calculation
6. **Clear Documentation:** Easy to see what version you're using

## 🔍 Troubleshooting

### Hash Mismatch Errors
```bash
# Clear and regenerate all hashes
sed -i 's/hash = "sha256-[^"]*"/hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="/g' nix/versions.nix
nix/update-hashes.sh
```

### Build Failures
```bash
# Fall back to nixpkgs versions temporarily
# Set problematic tool hash to placeholder value
# Run update-hashes.sh to fix
```

### Script Errors
```bash
# Ensure required tools are available
nix develop .#dev --command which nix-prefetch-git
nix develop .#dev --command which jq
```

## 📚 Reference

- [Nix fetchFromGitHub Documentation](https://nixos.org/manual/nixpkgs/stable/#fetchfromgithub)
- [Nix Flakes Reference](https://nixos.wiki/wiki/Flakes)
- [EDA Tools Documentation](../README.md)