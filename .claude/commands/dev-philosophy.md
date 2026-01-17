# Development Philosophy

These principles guide ALL implementation decisions:

## Core Tenets

1. **Keep it simple** - Choose the simplest solution that works. Complexity is a cost, not a feature.
2. **DRY** - Don't Repeat Yourself. Reuse existing code, patterns, and components. Before writing new code, search for existing solutions.
3. **No by default** - Features must prove essential before earning a "yes." When in doubt, leave it out.
4. **Interface-first** - Start from the customer experience and build backwards. What does the user need?
5. **Match existing patterns** - Check existing files for format patterns before creating new code. Consistency > novelty.

## What This Means in Practice

**DO:**
- Search the codebase before writing new utilities or helpers
- Reuse existing components, even if they need minor tweaks
- Delete code that's no longer needed (less code = less maintenance)
- Write self-documenting code over comments
- Solve the actual problem, not the hypothetical future problem

**DON'T:**
- Add abstractions "for flexibility" before they're needed
- Create helper functions for one-off operations
- Add configuration options that won't be used
- Write defensive code for impossible states
- Over-engineer for scale that doesn't exist yet

## The Simplicity Test

Before completing any task, ask:
- Is there existing code that does this or something similar?
- Can this be simpler? What can be removed?
- Am I solving a real problem or an imaginary one?
- Would a junior developer understand this in 5 minutes?
