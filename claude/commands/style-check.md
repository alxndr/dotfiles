Review a draft of writing against Alexander Quine's writing voice profile.

## Step 1 — Get the draft

If `$ARGUMENTS` is non-empty, treat it as the draft text to review.

If `$ARGUMENTS` is empty, ask Alexander to paste the draft.

## Step 2 — Load the voice profile

Read `~/.claude/voice.md`.

## Step 3 — Check for named AI tells

Write the draft to a temp file in your scratchpad directory, then run:

```
mise exec -C ~/workspace/dotfiles/claude -- python3 ~/workspace/dotfiles/claude/check_ai_tells.py <path-to-draft>
```

This asks Jev (TypeSafe) one yes/no question per row in `ai-tells.md` and returns each tell's probability, sorted highest first, along with its pattern description and example (see the script's own docstring for why this step is delegated rather than scanned for by hand). It's a probability, not a verdict — treat anything above ~0.5 as worth chasing down, and use your own judgment on borderline scores rather than treating the cutoff as a hard gate.

For every tell that scored high enough, find the actual matching phrase in the draft and quote it.

## Step 4 — Review and report

Check the draft against the voice profile. Flag:

**AI tells present** — for each tell Step 3 found actually present in the draft, name it and quote the offending phrase.

**Voice mismatches** — things that don't sound like Alexander's register: too formal, too hedged, too enthusiastic, preamble-heavy, summary-heavy, generic openers/closers.

**What's working** — phrases or constructions that do match his voice (brief, so he knows what to keep).

## Step 5 — Suggest a revision

Offer a revised version of the draft that preserves Alexander's intended meaning but matches his voice. Keep it tight — no padding, no preamble, no summarizing close.

If the draft is already clean, say so and explain why.
