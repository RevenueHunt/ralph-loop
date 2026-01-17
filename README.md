# RALPH Playbook

Autonomous AI Development Loop based on the [Ralph Playbook](https://github.com/ClaytonFarr/ralph-playbook) methodology.

RALPH (Recursive Autonomous Loop for Programming Hyperproductivity) uses Claude to autonomously implement features through a continuous bash loop with file-based state management.

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│                       RALPH LOOP                             │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │   PLAN   │───►│  BUILD   │───►│  VERIFY  │──┐           │
│  │   MODE   │    │   MODE   │    │          │  │           │
│  └──────────┘    └──────────┘    └──────────┘  │           │
│       ▲                                         │           │
│       │              ┌──────────┐              │           │
│       └──────────────│   GIT    │◄─────────────┘           │
│                      │  COMMIT  │                          │
│                      └──────────┘                          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Quick Start

### 1. Copy Files to Your Project

```bash
# Copy the core files
cp ralph_playbook/loop.sh your-project/
cp ralph_playbook/PROMPT_build.md your-project/
cp ralph_playbook/PROMPT_plan.md your-project/

# Copy templates and customize
cp ralph_playbook/templates/PRD.md your-project/
cp ralph_playbook/templates/AGENTS.md your-project/
cp ralph_playbook/templates/IMPLEMENTATION_PLAN.md your-project/

# Create specs directory
mkdir -p your-project/specs
cp ralph_playbook/templates/specs/01-example-spec.md your-project/specs/
```

### 2. Customize for Your Project

1. **Edit `PRD.md`**: Define your product requirements and task list
2. **Edit `AGENTS.md`**: Add your project's build, test, and lint commands
3. **Create `specs/*.md`**: Write detailed specifications for each feature/component
4. **Edit `PROMPT_build.md`**: Customize the implementation guidelines section
5. **Initialize git**: Ensure your project is a git repository

### 3. Run the Loop

```bash
# Planning mode - creates/updates IMPLEMENTATION_PLAN.md
./loop.sh plan

# Build mode - implements tasks from the plan
./loop.sh build

# Build mode with custom iteration limit
./loop.sh build 10
```

## File Reference

### Core Files

| File | Purpose |
|------|---------|
| `loop.sh` | Bash script that orchestrates the RALPH iterations |
| `PROMPT_plan.md` | Instructions for Claude in planning mode |
| `PROMPT_build.md` | Instructions for Claude in build mode |
| `AGENTS.md` | Operational knowledge (commands, patterns) |
| `IMPLEMENTATION_PLAN.md` | Task tracking with status and dependencies |
| `PRD.md` | Product requirements document |
| `specs/*.md` | Detailed specifications (source of truth) |

### Modes

**Plan Mode** (`./loop.sh plan`):
- Analyzes specs vs current code
- Creates/updates IMPLEMENTATION_PLAN.md
- Does NOT modify source code
- Does NOT run builds or tests

**Build Mode** (`./loop.sh build`):
- Picks highest priority unblocked task
- Implements the task
- Runs verification (tests, lint, typecheck)
- Updates IMPLEMENTATION_PLAN.md
- Commits and pushes changes

## Customization Guide

### AGENTS.md

Add your project-specific commands:

```markdown
## Build & Run

```bash
# Your install command
npm install

# Your dev command
npm run dev
```

## Validation

```bash
# Your test command
npm run test

# Your lint command
npm run lint
```
```

### PROMPT_build.md

Customize the "Implementation Guidelines" section:

```markdown
### Implementation Guidelines

- **File structure**: [Your project structure]
- **Validation**: [Your validation library]
- **Auth**: [Your auth patterns]
- **Types**: [Your type system]
```

### specs/*.md

Create one spec file per feature/component:

```
specs/
├── 01-auth.md
├── 02-api.md
├── 03-ui.md
└── 04-database.md
```

## Prerequisites

- [Claude Code CLI](https://github.com/anthropics/claude-code) installed and configured
- Git installed
- Your project's build tools (npm, bun, etc.)

## Tips

1. **Start with planning**: Always run `./loop.sh plan` first to generate the implementation plan
2. **Keep AGENTS.md updated**: Add operational learnings as you discover them
3. **Small tasks**: Break down tasks into 1-2 hour chunks for better iteration
4. **Detailed specs**: The more detailed your specs, the better Claude can implement
5. **Monitor progress**: Check IMPLEMENTATION_PLAN.md between iterations

## Troubleshooting

### Claude CLI not found
Install Claude Code: https://github.com/anthropics/claude-code

### Prompt file not found
Ensure PROMPT_build.md or PROMPT_plan.md exists in your project root

### Git errors
Initialize git: `git init && git add . && git commit -m "Initial commit"`

## Credits

Based on the [Ralph Playbook](https://github.com/ClaytonFarr/ralph-playbook) by Clayton Farr.
