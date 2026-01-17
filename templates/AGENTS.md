# AGENTS.md - Operational Knowledge

This file contains operational learnings for building and running the project.
Keep this file concise (~60 lines max). Status updates go in IMPLEMENTATION_PLAN.md.

## Build & Run

<!-- CUSTOMIZE: Add your project's build commands -->
```bash
# Install dependencies
npm install        # or: pnpm install, bun install, yarn

# Run development server
npm run dev

# Build for production
npm run build

# Start production server
npm run start
```

## Validation

<!-- CUSTOMIZE: Add your project's validation commands -->
```bash
# Run all tests
npm run test

# Run tests in watch mode
npm run test:watch

# Type check (if using TypeScript)
npm run typecheck

# Lint
npm run lint

# Format check
npm run format:check
```

## Browser Testing (Web Projects)

For web/frontend verification, use [agent-browser](https://github.com/vercel-labs/agent-browser) - a token-efficient headless browser for AI agents.

### Installation
```bash
npm install -g agent-browser
agent-browser install
```

### Usage
```bash
# Open page and get snapshot (returns accessibility tree with refs)
agent-browser open http://localhost:3000
agent-browser snapshot --interactive

# Interact with elements using refs from snapshot
agent-browser click @e2
agent-browser fill @e3 "user@example.com"
agent-browser get text @e1

# Visual verification
agent-browser screenshot page.png

# Cleanup
agent-browser close
```

### Key Commands
| Command | Description |
|---------|-------------|
| `open <url>` | Navigate to URL |
| `snapshot` | Get accessibility tree with element refs |
| `click @ref` | Click element |
| `fill @ref "text"` | Fill input field |
| `get text @ref` | Get element text content |
| `screenshot <file>` | Save screenshot |
| `close` | Close browser |

Use `--session <name>` for isolated sessions, `--headed` for debugging.

## Database (if applicable)

<!-- CUSTOMIZE: Add database commands if your project uses one -->
```bash
# Run migrations
npm run db:migrate

# Seed database
npm run db:seed
```

## Project Structure

<!-- CUSTOMIZE: List your project's main directories -->
- `src/` - Source code
- `specs/` - Requirement specifications (source of truth)

## Patterns

<!-- CUSTOMIZE: Document your project's key patterns -->
- [Pattern 1]: [Description]
- [Pattern 2]: [Description]

## Environment Variables

Required in `.env`:

<!-- CUSTOMIZE: List required environment variables -->
- `DATABASE_URL` - Database connection string
- `API_KEY` - External API key

## Notes

<!-- CUSTOMIZE: Add any project-specific notes -->
- [Runtime/Framework info]
- [Package manager info]
- [Styling approach]
