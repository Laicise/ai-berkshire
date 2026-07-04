#!/bin/bash
# Install OpenCLAW skills locally for AI Berkshire

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo "Generating OpenCLAW skills..."
python3 "$REPO_DIR/scripts/sync-openclaw-skills.py"

echo ""
echo "OpenCLAW skills installed to: $REPO_DIR/openclaw-skills/"
echo ""
echo "To use with OpenCLAW:"
echo "  1. Copy the skills to your OpenCLAW skills directory"
echo "  2. Or reference them directly from: $REPO_DIR/openclaw-skills/"
