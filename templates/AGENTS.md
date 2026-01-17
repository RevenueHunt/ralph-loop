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
