#!/bin/bash

# RALPH Requirements - Interactive Requirements Definition Session
# Phase 1 of the Ralph Playbook methodology
# https://github.com/ClaytonFarr/ralph-playbook

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PROMPT_FILE="PROMPT_requirements.md"

# Print usage
usage() {
    echo -e "${BLUE}RALPH Requirements - Interactive Requirements Definition${NC}"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -m, --model    Model to use (default: opus)"
    echo ""
    echo "Description:"
    echo "  This script starts an interactive session with Claude to define"
    echo "  project requirements. Claude will interview you about:"
    echo ""
    echo "  - Jobs to Be Done (JTBDs)"
    echo "  - Topics of concern"
    echo "  - Edge cases and constraints"
    echo "  - Acceptance criteria"
    echo ""
    echo "  Output: specs/*.md files"
    echo ""
    echo "This is Phase 1 of the Ralph Playbook methodology."
    echo "After requirements are defined, run './loop.sh plan' for Phase 2."
    exit 0
}

# Parse arguments
MODEL="opus"
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -m|--model)
            MODEL="$2"
            shift 2
            ;;
        *)
            echo -e "${RED}Error: Unknown argument '$1'${NC}"
            usage
            ;;
    esac
done

# Check prerequisites
check_prerequisites() {
    echo -e "${BLUE}Checking prerequisites...${NC}"

    # Check for claude CLI
    if ! command -v claude &> /dev/null; then
        echo -e "${RED}Error: 'claude' CLI not found. Please install Claude Code CLI.${NC}"
        exit 1
    fi

    # Check for prompt file
    if [[ ! -f "$PROMPT_FILE" ]]; then
        echo -e "${RED}Error: Prompt file '$PROMPT_FILE' not found.${NC}"
        exit 1
    fi

    # Create specs directory if needed
    if [[ ! -d "specs" ]]; then
        echo -e "${YELLOW}Creating specs/ directory...${NC}"
        mkdir -p specs
    fi

    echo -e "${GREEN}Prerequisites OK${NC}"
}

# Main
main() {
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  RALPH REQUIREMENTS - Interactive Definition      ║${NC}"
    echo -e "${GREEN}║  Phase 1: Define Jobs to Be Done & Specifications ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════╝${NC}"
    echo ""

    check_prerequisites

    echo ""
    echo -e "${BLUE}Starting interactive requirements session...${NC}"
    echo -e "${YELLOW}Claude will interview you about what you want to build.${NC}"
    echo -e "${YELLOW}Type your responses naturally. Use /exit or Ctrl+C when done.${NC}"
    echo ""
    echo -e "${BLUE}────────────────────────────────────────────────────${NC}"
    echo ""

    # Read prompt content
    local prompt_content
    prompt_content=$(cat "$PROMPT_FILE")

    # Start interactive Claude session with the requirements prompt
    # First argument: provides initial instructions (starts interactive session)
    # --model: use specified model (default opus for complex reasoning)
    # --dangerously-skip-permissions: allow file creation for specs
    claude --dangerously-skip-permissions --model "$MODEL" "$prompt_content"

    echo ""
    echo -e "${BLUE}────────────────────────────────────────────────────${NC}"
    echo ""
    echo -e "${GREEN}Requirements session ended.${NC}"
    echo ""

    # Check if specs were created
    if ls specs/*.md 1> /dev/null 2>&1; then
        echo -e "${GREEN}Specs created:${NC}"
        ls -la specs/*.md
        echo ""
        echo -e "${BLUE}Next steps:${NC}"
        echo -e "  1. Review the specs in specs/*.md"
        echo -e "  2. Run ${YELLOW}./loop.sh plan${NC} to create implementation plan"
        echo -e "  3. Run ${YELLOW}./loop.sh${NC} to start building"
    else
        echo -e "${YELLOW}No spec files were created yet.${NC}"
        echo -e "Run this script again to continue defining requirements."
    fi
    echo ""
}

# Run main
main "$@"
