# Research with DeepWiki

When working with external libraries, frameworks, or tools, use **DeepWiki** to understand how to properly configure and use them.

## How to use DeepWiki

```
# Ask questions about any GitHub repository
mcp__deepwiki__ask_question("owner/repo", "How do I configure X?")

# Get wiki structure for a repo
mcp__deepwiki__read_wiki_structure("owner/repo")

# Read full wiki contents
mcp__deepwiki__read_wiki_contents("owner/repo")
```

## When to use DeepWiki

- Integrating a new dependency or library
- Configuring tools (linters, bundlers, testing frameworks)
- Understanding API patterns for external services
- Learning best practices for frameworks (React, Next.js, etc.)
- Debugging issues with third-party packages

## Example queries

- `"vercel-labs/agent-browser"` → "How do I take screenshots?"
- `"prisma/prisma"` → "How do I set up migrations?"
- `"tailwindcss/tailwindcss"` → "How do I configure custom colors?"

Always consult DeepWiki before implementing unfamiliar integrations to ensure you follow current best practices.
