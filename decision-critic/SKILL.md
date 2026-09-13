---
name: decision-critic
description: |
  Get an adversarial, independent evaluation of a decision, document section, or
  trade-off before committing to it. Dispatches to the decision-critic agent in a
  fresh, isolated context so it evaluates without inheriting this conversation's
  reasoning or attachment to prior choices. Use when the user types /decision-critic,
  or asks for a hard/critical/skeptical review of something already decided or drafted.
metadata:
  version: "1.0.0"
---

# Decision critic (trigger)

This skill is a pure dispatcher. Its only job is to hand off to the `decision-critic`
agent — never evaluate the decision yourself inline, even if you already have an
opinion about it. The entire point is that the evaluation happens in a context with
no memory of how this conversation arrived at the decision, so it isn't shaped by
whatever reasoning or momentum got it here.

## What to do

1. Identify exactly what needs to be evaluated from `$ARGUMENTS` and/or the current
   conversation: a decision just made, a section of a file, a trade-off being
   considered. If it's ambiguous which thing the user means, ask before launching —
   do not guess and hand the agent the wrong target.
2. Write a **self-contained brief** for the agent. It starts with zero context, so
   include:
   - The decision or claim, stated plainly.
   - Exact file paths and line ranges if it concerns a document, or the exact text
     pasted inline if it's not yet saved anywhere — don't just describe it, give it
     the real content to evaluate.
   - Any constraints the decision must respect that you already know from this
     conversation (project rules, prior decisions, stated goals). The agent can also
     read a CLAUDE.md or project docs itself if you point it at the repo, but don't
     rely on it rediscovering constraints you already know — state them.
   - What NOT to touch or re-litigate, if the scope needs bounding.
3. Launch the Agent tool with `subagent_type: "decision-critic"` and that brief as
   the prompt. Never use `subagent_type: "fork"` for this — a fork inherits your own
   reasoning and defeats the entire purpose.
4. Relay the agent's verdict back to the user directly and completely. Do not
   soften it, summarize it away, or blend in your own counter-argument. If you
   disagree with something it found, say so explicitly and separately, clearly
   labeled as your own opinion — never folded into its verdict as if it were part
   of the independent evaluation.

## When not to use this

Line-level code bugs: use `/code-review`. Security vulnerabilities: use
`/security-review`. This skill is for decisions and reasoning, not for finding
defects in code syntax or logic.
