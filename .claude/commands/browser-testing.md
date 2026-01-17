# Browser Testing with agent-browser

For web/frontend tasks, use [agent-browser](https://github.com/vercel-labs/agent-browser) to verify UI changes. It's optimized for AI agents with minimal token usage.

## Commands

```bash
# Open the local dev server
agent-browser open http://localhost:3000

# Get accessibility snapshot (token-efficient way to "see" the page)
agent-browser snapshot --interactive

# Interact using element refs from snapshot
agent-browser click @e2
agent-browser fill @e3 "test@example.com"

# Get text content to verify
agent-browser get text @e1

# Take screenshot for visual verification
agent-browser screenshot verification.png

# Close when done
agent-browser close
```

## Use this workflow to verify

- UI components render correctly
- Forms submit and validate properly
- Navigation works as expected
- Error states display appropriately
