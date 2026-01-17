# Escalating to Human

When you're stuck on something that requires human action (not just a different approach), escalate properly.

## When to escalate

- Missing environment variables or secrets
- Need external service credentials (API keys, database URLs)
- Need deployment URLs or infrastructure setup
- Permissions or access issues
- Ambiguous requirements that need clarification
- External dependencies the human must set up

## When NOT to escalate

- You haven't tried alternative approaches yet
- The task is just difficult (try harder first)
- You want confirmation (make a decision and proceed)
- Nice-to-know information (work with what you have)

## How to escalate

1. **Update IMPLEMENTATION_PLAN.md**:
   - Change task status to `blocked-human`
   - Add clear note about what's needed

2. **Append to HUMAN_TASKS.md**:
   ```markdown
   ### [Brief title of what's needed]
   **Blocking**: TASK-XXX (task name)
   **Needed by**: [Why AI cannot proceed without this]

   **What's needed**:
   - [Specific action item 1]
   - [Specific action item 2]

   **How to verify**: [How human knows it's done correctly]
   ```

3. **Continue with other tasks**: Select next unblocked task and keep working

4. **If ALL tasks are blocked-human**:
   - Commit current state
   - Push changes
   - Exit cleanly with message: "All remaining tasks require human input. See HUMAN_TASKS.md"

## Human's workflow (for your awareness)

1. Human checks HUMAN_TASKS.md
2. Completes the required action
3. Removes entry from HUMAN_TASKS.md
4. Updates IMPLEMENTATION_PLAN.md: status → `pending`, adds note in "Human notes"
5. Restarts the loop
