#!/bin/bash

# RALPH Loop - Autonomous AI Development Loop
# Based on the Ralph Playbook methodology
# https://github.com/ClaytonFarr/ralph-playbook

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
MODE="build"
MAX_ITERATIONS=20
PROMPT_FILE="PROMPT_build.md"
ITERATION=0

# Get the project name from current directory
PROJECT_NAME=$(basename "$(pwd)")

# Helper function to uppercase (compatible with Bash 3)
to_upper() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

# Print usage
usage() {
    echo -e "${BLUE}RALPH Loop - Autonomous AI Development${NC}"
    echo ""
    echo "Usage: $0 [mode] [max_iterations]"
    echo ""
    echo "Modes:"
    echo "  build           Run in BUILD mode (default) - implements tasks"
    echo "  plan            Run in PLAN mode - creates implementation plan from specs"
    echo "  archive         Run in ARCHIVE mode - moves specs and plan to .archive/"
    echo ""
    echo "Examples:"
    echo "  $0              # Build mode, 20 iterations"
    echo "  $0 10           # Build mode, 10 iterations"
    echo "  $0 plan         # Plan mode, 2 iterations (typical)"
    echo "  $0 plan 5       # Plan mode, max 5 iterations"
    echo "  $0 archive      # Archive mode - moves completed work to .archive/"
    echo ""
    echo "Workflow (Ralph Playbook):"
    echo "  1. ./requirements.sh    # Phase 1: Interactive - define specs"
    echo "  2. ./loop.sh plan       # Phase 2: Headless - create implementation plan"
    echo "  3. ./loop.sh            # Phase 3: Headless - build iteratively"
    echo "  4. ./loop.sh archive    # Phase 4: Interactive - archive completed work"
    echo ""
    echo "Files used:"
    echo "  PROMPT_plan.md       - Instructions for planning (gap analysis)"
    echo "  PROMPT_build.md      - Instructions for building"
    echo "  PROMPT_archive.md    - Instructions for archiving"
    echo "  IMPLEMENTATION_PLAN.md - Task tracking"
    echo "  AGENTS.md            - Operational knowledge"
    echo "  specs/*              - Requirements (created by requirements.sh)"
    exit 1
}

# Parse arguments
parse_args() {
    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        usage
    fi

    if [[ "$1" == "plan" ]]; then
        MODE="plan"
        PROMPT_FILE="PROMPT_plan.md"
        MAX_ITERATIONS=2  # Plan mode typically completes in 1-2 iterations
        if [[ -n "$2" ]] && [[ "$2" =~ ^[0-9]+$ ]]; then
            MAX_ITERATIONS=$2
        fi
    elif [[ "$1" == "archive" ]]; then
        MODE="archive"
        PROMPT_FILE="PROMPT_archive.md"
        MAX_ITERATIONS=1  # Archive mode is a single interactive session
    elif [[ "$1" =~ ^[0-9]+$ ]]; then
        MAX_ITERATIONS=$1
    elif [[ -n "$1" ]]; then
        echo -e "${RED}Error: Unknown argument '$1'${NC}"
        usage
    fi
}

# Check prerequisites
check_prerequisites() {
    echo -e "${BLUE}Checking prerequisites...${NC}"

    # Check for claude CLI
    if ! command -v claude &> /dev/null; then
        echo -e "${RED}Error: 'claude' CLI not found. Please install Claude Code CLI.${NC}"
        exit 1
    fi

    # Check for git
    if ! command -v git &> /dev/null; then
        echo -e "${RED}Error: 'git' not found. Please install git.${NC}"
        exit 1
    fi

    # Check for prompt file
    if [[ ! -f "$PROMPT_FILE" ]]; then
        echo -e "${RED}Error: Prompt file '$PROMPT_FILE' not found.${NC}"
        exit 1
    fi

    # Check for implementation plan
    if [[ ! -f "IMPLEMENTATION_PLAN.md" ]]; then
        echo -e "${YELLOW}Warning: IMPLEMENTATION_PLAN.md not found. Will be created.${NC}"
    fi

    # Initialize git if needed
    if [[ ! -d ".git" ]]; then
        echo -e "${YELLOW}Initializing git repository...${NC}"
        git init
        git add .
        git commit -m "Initial commit: RALPH loop setup"
    fi

    echo -e "${GREEN}Prerequisites OK${NC}"
}

# Run a single iteration
run_iteration() {
    local iter=$1
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  ITERATION $iter / $MAX_ITERATIONS ($(to_upper "$MODE") MODE)${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""

    # Create iteration marker
    local start_time=$(date +%s)
    local start_timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "${YELLOW}Started at: $start_timestamp${NC}"

    echo -e "${BLUE}Running Claude with $PROMPT_FILE...${NC}"
    echo ""

    # -p: headless/print mode (reads stdin, exits when done) - used for plan and build
    # --dangerously-skip-permissions: autonomous operation
    # --model opus: best reasoning for complex tasks
    # --verbose: detailed logging
    # Archive mode runs interactively (no -p) for user input
    if [[ "$MODE" == "archive" ]]; then
        if cat "$PROMPT_FILE" | claude --dangerously-skip-permissions --model opus --verbose; then
            echo ""
            echo -e "${GREEN}Claude archive completed successfully${NC}"
        else
            echo ""
            echo -e "${RED}Claude archive failed${NC}"
            return 1
        fi
    elif cat "$PROMPT_FILE" | claude -p --dangerously-skip-permissions --model opus --verbose; then
        echo ""
        echo -e "${GREEN}Claude iteration completed successfully${NC}"
    else
        echo ""
        echo -e "${RED}Claude iteration failed${NC}"
        return 1
    fi

    # Calculate duration
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    local minutes=$((duration / 60))
    local seconds=$((duration % 60))
    echo -e "${YELLOW}Duration: ${minutes}m ${seconds}s${NC}"

    # Push changes if there are any
    if [[ -n $(git status --porcelain) ]]; then
        echo ""
        echo -e "${BLUE}Pushing changes to git...${NC}"
        git add .

        # Check if there are changes to commit
        if git diff --cached --quiet; then
            echo -e "${YELLOW}No changes to commit${NC}"
        else
            local commit_msg="RALPH ${MODE} iteration $iter"
            git commit -m "$commit_msg" || true

            # Push if remote exists
            if git remote | grep -q origin; then
                git push origin HEAD || echo -e "${YELLOW}Push failed (might be OK if no remote)${NC}"
            fi
        fi
    else
        echo -e "${YELLOW}No changes detected${NC}"
    fi

    # Check if plan is complete (for build mode)
    if [[ "$MODE" == "build" ]]; then
        if grep -q "## Completed Tasks" IMPLEMENTATION_PLAN.md 2>/dev/null; then
            local pending_count=$(grep -c "Status.*pending" IMPLEMENTATION_PLAN.md 2>/dev/null || echo "0")
            local completed_count=$(grep -c "Status.*completed" IMPLEMENTATION_PLAN.md 2>/dev/null || echo "0")
            echo ""
            echo -e "${BLUE}Progress: $completed_count completed, $pending_count pending${NC}"

            if [[ "$pending_count" == "0" ]]; then
                echo ""
                echo -e "${GREEN}All tasks completed! Stopping loop.${NC}"
                return 2  # Special return code for completion
            fi
        fi
    fi

    return 0
}

# Main loop
main() {
    parse_args "$@"

    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║       RALPH LOOP - $PROJECT_NAME${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -e "Mode:           ${YELLOW}$(to_upper "$MODE")${NC}"
    echo -e "Max iterations: ${YELLOW}$MAX_ITERATIONS${NC}"
    echo -e "Prompt file:    ${YELLOW}$PROMPT_FILE${NC}"
    echo ""

    check_prerequisites

    # Confirm before starting
    echo ""
    echo -e "${YELLOW}Starting RALPH loop in 3 seconds... (Ctrl+C to cancel)${NC}"
    sleep 3

    # Main loop
    while [[ $ITERATION -lt $MAX_ITERATIONS ]]; do
        ITERATION=$((ITERATION + 1))

        run_iteration $ITERATION
        local result=$?

        if [[ $result -eq 2 ]]; then
            # All tasks completed
            break
        elif [[ $result -ne 0 ]]; then
            echo ""
            echo -e "${RED}Iteration failed. Stopping loop.${NC}"
            exit 1
        fi

        # Brief pause between iterations
        if [[ $ITERATION -lt $MAX_ITERATIONS ]]; then
            echo ""
            echo -e "${YELLOW}Pausing 5 seconds before next iteration...${NC}"
            sleep 5
        fi
    done

    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║         RALPH LOOP COMPLETE           ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo -e "Total iterations: ${YELLOW}$ITERATION${NC}"
    echo -e "Mode:             ${YELLOW}$(to_upper "$MODE")${NC}"
    echo ""

    # Summary
    if [[ -f "IMPLEMENTATION_PLAN.md" ]]; then
        echo -e "${BLUE}Final Status:${NC}"
        local pending=$(grep -c "Status.*pending" IMPLEMENTATION_PLAN.md 2>/dev/null || echo "0")
        local in_progress=$(grep -c "Status.*in_progress" IMPLEMENTATION_PLAN.md 2>/dev/null || echo "0")
        local completed=$(grep -c "Status.*completed" IMPLEMENTATION_PLAN.md 2>/dev/null || echo "0")
        local blocked=$(grep -c "Status.*blocked" IMPLEMENTATION_PLAN.md 2>/dev/null || echo "0")
        echo -e "  Pending:     $pending"
        echo -e "  In Progress: $in_progress"
        echo -e "  Completed:   $completed"
        echo -e "  Blocked:     $blocked"
    fi

    echo ""
    echo -e "${GREEN}Done!${NC}"
}

# Run main
main "$@"
