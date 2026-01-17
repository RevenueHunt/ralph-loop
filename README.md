# RALPH Playbook

Autonomous AI development loop based on the [Ralph Playbook](https://github.com/ClaytonFarr/ralph-playbook) methodology by Clayton Farr.

Claude autonomously implements features through a continuous bash loop with file-based state management, human escalation workflows, and multi-agent code review.

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│                       RALPH LOOP                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐             │
│  │   PLAN   │───►│  BUILD   │───►│  VERIFY  │──┐          │
│  │          │    │          │    │          │  │          │
│  └──────────┘    └──────────┘    └──────────┘  │          │
│       ▲                               │        │          │
│       │         ┌──────────┐          │        │          │
│       │         │  HUMAN   │◄─────────┘        │          │
│       │         │  TASKS   │ (if blocked)      │          │
│       │         └──────────┘                   │          │
│       │              ┌──────────┐              │          │
│       └──────────────│   GIT    │◄─────────────┘          │
│                      │  COMMIT  │                         │
│                      └──────────┘                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
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
# Planning mode - creates IMPLEMENTATION_PLAN.md
./loop.sh plan

# Build mode - implements tasks autonomously
./loop.sh build

# Build with iteration limit
./loop.sh build 10
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
| `PROMPT_plan.md` | Planning mode instructions |
| `PROMPT_build.md` | Build mode instructions (references skills) |
| `AGENTS.md` | Operational knowledge: commands, patterns, learnings |
| `IMPLEMENTATION_PLAN.md` | Task tracking with status and dependencies |
| `HUMAN_TASKS.md` | Tasks requiring human action |
| `PRD.md` | Product requirements |
| `specs/*.md` | Detailed specifications |
| `.claude/commands/*.md` | Claude Code skills |

## Modes

**Plan Mode** (`./loop.sh plan`):
- Analyzes specs vs current code
- Creates/updates IMPLEMENTATION_PLAN.md
- Does NOT modify source code

**Build Mode** (`./loop.sh build`):
- Picks highest priority unblocked task
- Implements with verification
- Commits and pushes on success
- Escalates to HUMAN_TASKS.md when blocked

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

1. **Start with planning** - Run `./loop.sh plan` first
2. **Detailed specs** - Better specs = better implementation
3. **Small tasks** - Break into focused chunks
4. **Monitor HUMAN_TASKS.md** - Check for blocked items
5. **Update AGENTS.md** - Add learnings as you discover them

## Credits

Based on [Ralph Playbook](https://github.com/ClaytonFarr/ralph-playbook) by Clayton Farr.
