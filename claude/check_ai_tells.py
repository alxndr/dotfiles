"""
Check a draft against the Named AI tells in ai-tells.md, using TypeSafe/Jev.

Companion to the /style-check skill (~/.claude/commands/style-check.md):
that skill's own judgment (voice mismatches, what's working, the revision)
stays with Clod, since none of that is a fixed closed-set question. But
"does this draft contain [named pattern]?" for ~20 well-defined patterns is
exactly the shape of decision Jev is good at and Clod doesn't need to spend
its own reasoning on - one Noul per row in the ai-tells.md table, all fired
in a single request over the draft, so the skill only needs to go hunting
for a quotable phrase on the tells that actually scored high.

Unlike the blog tag-suggestion POC this is modeled on, criteria quality
isn't a concern here: ai-tells.md already gives each pattern a name, a
description, and a concrete bad example, which is the "authored criteria"
approach that POC's own docstring flagged as the fix for weak precision -
here it comes for free from a table that already existed.

SETUP
    1. Requires Python >= 3.10 (see .tool-versions in this directory - use
       `mise exec -C ~/workspace/dotfiles/claude -- python3 ...` if not
       `cd`'d into this directory in a shell with `mise activate` wired up).
    2. `pip install typesafe-sdk` (ask before installing, as always)
    3. TYPESAFE_API_KEY is expected to already be set (see ~/.zshrc)

USAGE
    python3 check_ai_tells.py <path-to-draft.txt>
    # or, piped:
    python3 check_ai_tells.py < draft.txt

    Prints JSON to stdout: every named tell, sorted by probability
    descending, each with its pattern/example carried through from
    ai-tells.md (so the caller doesn't need to re-read that file) plus
    token usage. A Noul near 1.0 means "yes, this pattern is present";
    there's no phrase-level localization - that's still on whoever reads
    this output (the style-check skill, or you) to go find in the draft.
"""

import json
import re
import sys
from pathlib import Path

from typesafe_sdk import TypeSafeClient, Noul

AI_TELLS_PATH = Path(__file__).resolve().parent / "ai-tells.md"


def parse_tells(path):
    """Parse the `| Name | Pattern to avoid | Example of the wrong thing |`
    table in ai-tells.md into a list of {name, pattern, example} dicts."""
    tells = []
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line.startswith("|") or re.fullmatch(r"[|\-\s]+", line):
            continue
        cells = [cell.strip() for cell in line.strip("|").split("|")]
        if len(cells) != 3 or cells[0] == "Name":
            continue
        name, pattern, example = cells
        tells.append({"name": name.strip("*"), "pattern": pattern, "example": example})
    return tells


def slugify(name):
    return name.lower().replace(" ", "_").replace("/", "_")


def build_questions(tells):
    questions = {}
    for tell in tells:
        questions[slugify(tell["name"])] = Noul(
            instructions=f'Does this draft contain the "{tell["name"]}" AI-tell pattern: {tell["pattern"]}?',
            criteria={
                "true": f'{tell["pattern"]} - example of the pattern: {tell["example"]}',
                "false": f'No instance of the "{tell["name"]}" pattern appears anywhere in the draft',
            },
        )
    return questions


def main():
    if len(sys.argv) > 1:
        draft = Path(sys.argv[1]).read_text(encoding="utf-8")
    else:
        draft = sys.stdin.read()

    tells = parse_tells(AI_TELLS_PATH)
    questions = build_questions(tells)

    with TypeSafeClient() as client:
        response = client.system_one(state=draft, model="jev-latest", questions=questions)

    results = [
        {
            "name": tell["name"],
            "pattern": tell["pattern"],
            "example": tell["example"],
            "probability": response.nouls[slugify(tell["name"])].noul,
        }
        for tell in tells
    ]
    results.sort(key=lambda r: r["probability"], reverse=True)

    print(json.dumps({
        "tells": results,
        "usage": {
            "input_tokens": response.usage.input_tokens,
            "output_tokens": response.usage.output_tokens,
        },
    }, indent=2))


if __name__ == "__main__":
    main()
