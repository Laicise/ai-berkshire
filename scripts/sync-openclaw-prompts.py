#!/usr/bin/env python3
"""Generate OpenCLAW custom prompts from AI Berkshire Claude command files."""

from __future__ import annotations

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CLAUDE_SKILLS = ROOT / "skills"
OPENCLAW_PROMPTS = ROOT / "openclaw-prompts"


def main() -> None:
    check = "--check" in sys.argv[1:]
    unknown_args = [arg for arg in sys.argv[1:] if arg != "--check"]
    if unknown_args:
        joined = ", ".join(unknown_args)
        raise SystemExit(f"Unknown argument(s): {joined}")

    if not check:
        OPENCLAW_PROMPTS.mkdir(exist_ok=True)

    count = 0
    stale: list[str] = []
    for source in sorted(CLAUDE_SKILLS.glob("*.md")):
        name = source.stem
        source_text = source.read_text(encoding="utf-8")

        # Extract title from first heading
        title = name
        for line in source_text.splitlines():
            if line.startswith("# "):
                title = line[2:].strip()
                break

        prompt = f"# {title}\n\n"
        prompt += "Use the AI Berkshire investment research workflow. "
        prompt += f"Source: `skills/{source.name}`\n\n"
        prompt += source_text

        target = OPENCLAW_PROMPTS / f"{name}.md"
        if check:
            if not target.exists() or target.read_text(encoding="utf-8") != prompt:
                stale.append(str(target.relative_to(ROOT)))
        else:
            target.write_text(prompt, encoding="utf-8")
        count += 1

    if check:
        if stale:
            print("OpenCLAW prompts are out of date:")
            for path in stale:
                print(f"  {path}")
            raise SystemExit(1)
        print(f"Checked {count} OpenCLAW prompts in {OPENCLAW_PROMPTS.relative_to(ROOT)}")
        return

    print(f"Generated {count} OpenCLAW prompts in {OPENCLAW_PROMPTS.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
