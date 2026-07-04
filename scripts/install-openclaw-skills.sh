#!/bin/bash
# Install OpenCLAW skills and prompts to agent workspace

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# Agent workspace path
AGENT_DIR="${HOME}/.openclaw/workspace-graham"

# Generate skills and prompts first
echo "Generating OpenCLAW skills..."
python3 "$REPO_DIR/scripts/sync-openclaw-skills.py"

echo "Generating OpenCLAW prompts..."
python3 "$REPO_DIR/scripts/sync-openclaw-prompts.py"

# Copy skills to agent workspace
SKILLS_DIR="$AGENT_DIR/skills"
PROMPTS_DIR="$AGENT_DIR/prompts"

echo ""
echo "Installing to $AGENT_DIR..."

mkdir -p "$SKILLS_DIR"
mkdir -p "$PROMPTS_DIR"

# Copy skill packages (each in its own subdirectory with SKILL.md)
for skill_dir in "$REPO_DIR/openclaw-skills"/*/; do
    skill_name=$(basename "$skill_dir")
    cp -r "$skill_dir" "$SKILLS_DIR/"
    echo "  Copied skill: $skill_name"
done

# Copy prompts
for prompt_file in "$REPO_DIR/openclaw-prompts"/*.md; do
    prompt_name=$(basename "$prompt_file")
    cp "$prompt_file" "$PROMPTS_DIR/"
    echo "  Copied prompt: $prompt_name"
done

echo ""
echo "Done! Skills and prompts installed to:"
echo "  Skills:  $SKILLS_DIR/"
echo "  Prompts: $PROMPTS_DIR/"
