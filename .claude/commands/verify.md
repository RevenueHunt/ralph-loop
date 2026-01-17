# Verification Checklist

After implementing, verify your work:

## Run checks (see AGENTS.md for commands)

1. **Run tests**: See AGENTS.md for test command
2. **Type check**: See AGENTS.md for typecheck command
3. **Lint**: See AGENTS.md for lint command
4. **Manual check**: Review code against acceptance criteria
5. **Browser verification** (for web projects): Run `/browser-testing`

## Verification Checklist

- [ ] All acceptance criteria from the task are met
- [ ] Tests pass (or new tests written and passing)
- [ ] Type check passes (if applicable)
- [ ] Lint passes
- [ ] Code follows existing patterns
- [ ] No security vulnerabilities introduced
- [ ] **Simplicity check**: Is this the simplest solution? Can anything be removed?
- [ ] **DRY check**: Did I reuse existing code? No duplicate logic?
- [ ] **No over-engineering**: Am I solving only the actual problem?

## If verification fails

- Fix the issues
- Re-run verification
- Do not proceed until all checks pass

## For complex tasks

Run `/code-review` to get fresh eyes from multi-agent review before committing.
