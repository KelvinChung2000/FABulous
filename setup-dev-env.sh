#!/usr/bin/env bash
# setup-dev-env.sh - Setup script for the development environment

set -e

echo "🔧 Setting up FABulous development environment..."

# Check if we're in a Nix shell
if [ -z "$IN_NIX_SHELL" ]; then
    echo "⚠️  Not in a Nix shell. Please run:"
    echo "   nix develop"
    echo "   # or"
    echo "   nix-shell"
    exit 1
fi

echo "✓ In Nix shell"

# Setup Python environment with uv if pyproject.toml exists
if [ -f "pyproject.toml" ]; then
    echo "📦 Setting up Python environment with uv..."
    uv sync
    echo "✓ Python environment ready"
else
    echo "ℹ️  No pyproject.toml found. Python environment can be set up later with:"
    echo "   uv init  # or uv add <package>"
fi

# Test that key tools are available
echo "🧪 Testing tools availability..."

tools=("yosys" "nextpnr-generic" "iverilog" "ghdl" "uv" "java" "mvn" "node" "git")
all_good=true

for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✓ $tool"
    else
        echo "✗ $tool (missing)"
        all_good=false
    fi
done

if [ "$all_good" = true ]; then
    echo ""
    echo "🎉 All tools are available!"
    echo ""
    echo "Quick start:"
    echo "  • Python: Use 'uv run <command>' or 'uv add <package>'"
    echo "  • Java: Use 'mvn' for Maven projects"
    echo "  • EDA: yosys, nextpnr-generic, iverilog, ghdl are ready"
    echo "  • FABulator: Run 'run-fabulator' (or 'mvn javafx:run' in FABulator source)"
    echo ""
else
    echo ""
    echo "❌ Some tools are missing. Please check the Nix configuration."
    exit 1
fi