# Multi-Agent Code Review

For complex implementations (multi-file changes, new features, architectural decisions), get fresh eyes on your code before committing. Launch **two independent sub-agents in parallel** to review the uncommitted changes.

## Why this works

- Fresh context windows catch issues you've become blind to
- Independent reviewers find different problems
- Consensus issues (found by both) are high-confidence bugs
- You (orchestrator) can evaluate which feedback is valid since you just built the code

## Step 1: Launch Two Reviewers in Parallel

Use the Task tool to spawn two `general-purpose` subagents simultaneously (single message, multiple tool calls):

**Reviewer A - Security & Bugs Focus:**
```
Review the uncommitted changes with fresh eyes. Run `git diff` to see all changes.

Focus on:
- Bugs: logic errors, race conditions, null/undefined handling, off-by-one errors
- Security: injection risks, auth gaps, data exposure, XSS/CSRF
- Edge cases: missing validations, unhappy paths, error handling gaps

For each issue found:
- Location: `file:line`
- Severity: Critical/High/Medium/Low
- Problem: What's wrong
- Fix: How to address it

Be thorough but don't manufacture problems. If the code looks good, say so.
```

**Reviewer B - Quality & Simplicity Focus:**
```
Review the uncommitted changes with fresh eyes. Run `git diff` to see all changes.

Focus on:
- DRY violations: Is there duplication? Could existing code be reused?
- Complexity: Is this over-engineered? Could it be simpler?
- Patterns: Does it follow existing codebase conventions?
- Performance: N+1 queries, unnecessary computation, memory issues

For each issue found:
- Location: `file:line`
- Severity: Critical/High/Medium/Low
- Problem: What's wrong
- Fix: How to address it

Also note: Would you have implemented this differently? Why?
```

## Step 2: Cross-Reference and Validate

After both reviewers complete:

1. **Consensus issues** (found by both): These are almost certainly real problems. Fix them.
2. **Single-reviewer issues**: Read the code yourself. Decide if valid or false positive.
3. **Dismiss false positives**: You just built this code - you know the context. Trust your judgment on manufactured issues.

## Step 3: Fix and Re-verify

- Fix all Critical/High issues before committing
- Medium/Low issues: fix if quick, or note for future
- Re-run tests after fixes

## When to use multi-agent review

- ✅ New features with multiple files
- ✅ Architectural changes
- ✅ Security-sensitive code
- ✅ Complex business logic
- ❌ Simple bug fixes
- ❌ Config changes
- ❌ Documentation updates
