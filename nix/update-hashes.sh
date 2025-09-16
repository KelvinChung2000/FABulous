#!/usr/bin/env bash
# Update content hashes for all EDA tools
# Run this after modifying nix/versions.nix

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$FLAKE_DIR"

echo "🔄 Updating content hashes for EDA tools..."

# Function to update hash for a tool
update_tool_hash() {
    local tool="$1"
    echo "  📦 Updating $tool..."
    
    # Use nix-prefetch-github to get the correct hash
    local hash=$(nix-build -A "customPackages.$tool" --no-out-link 2>&1 | grep "hash mismatch" | sed -n 's/.*got: *\(sha256-[A-Za-z0-9+/=]*\).*/\1/p' | head -1)
    
    if [ -n "$hash" ]; then
        echo "    ✓ Hash: $hash"
        # Update the hash in versions.nix
        sed -i "s|hash = \"sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=\"; # $tool|hash = \"$hash\"; # $tool|g" nix/versions.nix
    else
        echo "    ⚠️  Could not determine hash for $tool - trying alternative method"
        # Alternative: use nix to read string attributes from nix/versions.nix
        local owner repo rev
        # Use nix eval --raw to avoid JSON/thunk conversion issues and to get plain strings.
    # Use --expr so nix treats the argument as an expression, and --impure to allow reading
    # the local file system (importing a relative file). --raw returns the value as plain text.
    owner=$(nix eval --impure --raw --expr "(import ./nix/versions.nix).${tool}.owner")
    repo=$(nix eval --impure --raw --expr "(import ./nix/versions.nix).${tool}.repo")
    rev=$(nix eval --impure --raw --expr "(import ./nix/versions.nix).${tool}.rev")

        # If any of the values are empty or 'null', abort this alternative method for this tool
        if [ -z "${owner}" ] || [ "${owner}" = "null" ] || [ -z "${repo}" ] || [ "${repo}" = "null" ] || [ -z "${rev}" ] || [ "${rev}" = "null" ]; then
            echo "    ❌ Failed to read attributes for $tool from nix/versions.nix"
            return
        fi

        # Try available prefetch tools in order. Different tools return hashes in
        # different encodings (hex, base32, base64 or JSON). We normalize to the
        # `sha256-<base64>` form when possible, or `sha256-<raw>` otherwise.
        raw_hash=""
        if command -v nix-prefetch-github >/dev/null 2>&1; then
            # nix-prefetch-github may output JSON with a .sha256 field
            out=$(nix-prefetch-github "$owner" "$repo" --rev "$rev" 2>/dev/null || true)
            raw_hash=$(echo "$out" | jq -r '.sha256' 2>/dev/null || echo "$out" | tr -d '\n')
        elif command -v nix-prefetch-url >/dev/null 2>&1; then
            # Fetch the GitHub archive tarball and let nix-prefetch-url return a hash
            out=$(nix-prefetch-url --unpack "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz" 2>/dev/null || true)
            raw_hash=$(echo "$out" | tr -d '\n')
        elif command -v nix-prefetch-git >/dev/null 2>&1; then
            out=$(nix-prefetch-git --url "https://github.com/${owner}/${repo}.git" --rev "$rev" 2>/dev/null || true)
            raw_hash=$(echo "$out" | tr -d '\n')
        else
            echo "    ❌ No prefetch tool available (nix-prefetch-github | nix-prefetch-url | nix-prefetch-git)"
            return
        fi

        # Normalize raw_hash:
        # - If it already starts with sha256-, keep it.
        # - If it's 64 hex chars, convert hex -> raw bytes -> base64 and prefix sha256-.
        # - Otherwise prefix sha256- and hope nix accepts the encoding (base32/base64).
        if [ -z "$raw_hash" ] || [ "$raw_hash" = "null" ]; then
            echo "    ❌ Failed to get hash for $tool from prefetch tool"
            return
        fi

        if [[ "$raw_hash" == sha256-* ]]; then
            hash="$raw_hash"
        elif [[ "$raw_hash" =~ ^[0-9a-fA-F]{64}$ ]]; then
            # convert hex -> binary -> base64
            if command -v xxd >/dev/null 2>&1 && command -v base64 >/dev/null 2>&1; then
                bin=$(printf '%s' "$raw_hash" | xxd -r -p | base64 -w0)
                hash="sha256-$bin"
            else
                # can't convert, just prefix (may fail later)
                hash="sha256-$raw_hash"
            fi
        else
            hash="sha256-$raw_hash"
        fi

        if [ -n "$hash" ] && [ "$hash" != "null" ]; then
            echo "    ✓ Hash: $hash"
            sed -i "s|hash = \"sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=\"; # $tool|hash = \"$hash\"; # $tool|g" nix/versions.nix
        else
            echo "    ❌ Failed to get hash for $tool"
        fi
    fi
}

# List of tools to update
tools=("nextpnr" "ghdl")

for tool in "${tools[@]}"; do
    update_tool_hash "$tool"
done

echo "✅ Hash update complete!"
echo "🔄 Testing build..."

# Test that tools can be built
nix build .#customPackages.ghdl --no-link --print-build-logs

echo "✅ All done! Your EDA tools are ready."