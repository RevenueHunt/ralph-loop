# RALPH Playbook

Autonomous AI development loop based on the [Ralph Playbook](https://github.com/ClaytonFarr/ralph-playbook) methodology by Clayton Farr.

Claude autonomously implements features through a continuous bash loop with file-based state management, human escalation workflows, and multi-agent code review.

## How It Works

```
┌────────────────────────────────────────────────────────────────────────────────┐
│                                RALPH LOOP                                      │
├────────────────────────────────────────────────────────────────────────────────┤
│                                                                                │
│  ┌────────┐   ┌────────┐   ┌────────┐   ┌────────┐   ┌────────┐   ┌─────────┐  │
│  │  PLAN  │──►│ BUILD  │──►│ VERIFY │──►│ HUMAN  │──►│  GIT   │──►│ ARCHIVE │  │
│  │        │   │        │   │        │   │ TASKS  │   │ COMMIT │   │  (opt)  │  │
│  └────────┘   └────────┘   └────────┘   │(if any)│   └────────┘   └─────────┘  │
│       ▲                                 └────────┘        │                    │
│       │                                                   │                    │
│       └───────────────────────────────────────────────────┘                    │
│                                                                                │
└────────────────────────────────────────────────────────────────────────────────┘
```

## Features

- **Autonomous implementation** - Claude picks tasks, implements, verifies, and commits
- **Human escalation** - Tasks requiring human input are tracked in HUMAN_TASKS.md
- **Multi-agent code review** - Complex tasks get parallel review from specialized agents
- **Browser testing** - Web UI verification via agent-browser
- **External library research** - DeepWiki integration for learning APIs
- **Package management** - Perplexity search for latest versions and compatibility
- **Skills system** - Slash commands provide fresh context at each stage

## Quick Start

### 1. Copy to Your Project

```bash
# Copy core files
cp ralph_playbook/loop.sh your-project/
cp ralph_playbook/requirements.sh your-project/
cp ralph_playbook/PROMPT_*.md your-project/

# Copy templates
cp ralph_playbook/templates/*.md your-project/
mkdir -p your-project/specs
cp ralph_playbook/templates/specs/*.md your-project/specs/

# Copy Claude Code skills
cp -r ralph_playbook/.claude your-project/
```

### 2. Customize

1. **PRD.md** - Define your product requirements
2. **AGENTS.md** - Add your build, test, lint commands
3. **specs/*.md** - Write detailed specifications
4. **PROMPT_build.md** - Customize implementation guidelines (optional)

### 3. Run

```bash
# Requirements mode - interactive session to define PRD and specs
./requirements.sh

# Planning mode - creates IMPLEMENTATION_PLAN.md
./loop.sh plan

# Build mode - implements tasks autonomously
./loop.sh build

# Build with iteration limit
./loop.sh build 10

# Archive mode - moves specs/ and IMPLEMENTATION_PLAN.md to .archive/
./loop.sh archive
```

## Skills (Slash Commands)

The build prompt references these skills for fresh context at each stage:

| Skill | When Used | Purpose |
|-------|-----------|---------|
| `/dev-philosophy` | Before coding | Development principles: simplicity, DRY, no over-engineering |
| `/deepwiki-research` | New dependencies | Research external libraries via DeepWiki MCP |
| `/verify` | After implementation | Verification checklist: tests, types, lint |
| `/browser-testing` | Web projects | UI verification via agent-browser |
| `/code-review` | Complex tasks | Multi-agent parallel code review |
| `/human-escalation` | When blocked | Escalation workflow for human input |

Skills are stored in `.claude/commands/` and loaded on-demand to reduce token usage.

## File Reference

| File | Purpose |
|------|---------|
| `loop.sh` | Orchestrates RALPH iterations |
| `requirements.sh` | Interactive requirements gathering session |
| `PROMPT_requirements.md` | Requirements mode instructions |
| `PROMPT_plan.md` | Planning mode instructions |
| `PROMPT_build.md` | Build mode instructions (references skills) |
| `PROMPT_archive.md` | Archive mode instructions |
| `AGENTS.md` | Operational knowledge: commands, patterns, learnings |
| `IMPLEMENTATION_PLAN.md` | Task tracking with status and dependencies |
| `HUMAN_TASKS.md` | Tasks requiring human action |
| `PRD.md` | Product requirements |
| `specs/*.md` | Detailed specifications |
| `.claude/commands/*.md` | Claude Code skills |

## Modes

**Requirements Mode** (`./requirements.sh`):
- Interactive session with Claude
- Interviews you about project goals, users, features
- Generates PRD.md and initial specs

**Plan Mode** (`./loop.sh plan`):
- Analyzes specs vs current code
- Creates/updates IMPLEMENTATION_PLAN.md
- Does NOT modify source code

**Build Mode** (`./loop.sh build`):
- Picks highest priority unblocked task
- Implements with verification
- Commits and pushes on success
- Escalates to HUMAN_TASKS.md when blocked

**Archive Mode** (`./loop.sh archive`):
- Moves `specs/` and `IMPLEMENTATION_PLAN.md` to `.archive/XX_feature_name/`
- Asks for a descriptive name for the archive
- Prepares project root for the next development iteration

## Human Escalation

When Claude encounters tasks requiring human input:

1. Task is marked `blocked-human` in IMPLEMENTATION_PLAN.md
2. Details added to HUMAN_TASKS.md
3. Loop continues with other tasks or exits

To unblock:
1. Complete the action in HUMAN_TASKS.md
2. Add notes to the "Human notes" field
3. Change status from `blocked-human` to `pending`
4. Next loop iteration will pick up the task

## Prerequisites

- [Claude Code CLI](https://github.com/anthropics/claude-code)
- Git
- Your project's build tools

Optional MCP servers:
- **DeepWiki** - For researching GitHub repositories
- **Perplexity** - For package version lookups

## Tips

1. **Start with requirements** - Run `./requirements.sh` to define PRD and specs
2. **Then plan** - Run `./loop.sh plan` to create the implementation plan
3. **Detailed specs** - Better specs = better implementation
4. **Small tasks** - Break into focused chunks
5. **Monitor HUMAN_TASKS.md** - Check for blocked items
6. **Update AGENTS.md** - Add learnings as you discover them

## Credits

Based on [Ralph Playbook](https://github.com/ClaytonFarr/ralph-playbook) by Clayton Farr.
