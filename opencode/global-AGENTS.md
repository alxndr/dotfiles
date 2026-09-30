# OpenCode rules

## Git commit messages

Every commit OpenCode makes must follow this format exactly:

```
🤖 <type>: <terse description>

<freeform body>
```

**First line:**
- Starts with the 🤖 emoji, then a space
- `<type>` is one of the Conventional Commits types (`feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `style`, `perf`) _or_ a project-specific term which is already present in the git history
- Colon, space, then a terse description (imperative mood, lowercase, no period)

**Body (separated by a blank line):**
- Freeform Markdown — use it for reasoning, links, context
- Write for a general audience: no assumed expertise in trading, markets, statistics, or math
- Explain *why*, not just *what*

**Trailers:**
- Don't add a `Co-Authored-By:` trailer for any other email address/identity unless explicitly asked.

**Author metadata:** always pass `--author="OpenCode <alxndr+opencode@gmail.com>"` so the git author field is set to OpenCode (not the local git config identity).


## Git push

Never run `git push` (including `--tags`) on your own initiative, even if a prior instruction in the same conversation authorized the broader action it's part of (e.g. "publish this release"). Always stop and ask first, every time, with no standing exception. Committing locally is fine without asking.
