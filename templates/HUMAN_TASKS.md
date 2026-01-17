# Human Tasks

Tasks that require human intervention. The AI cannot proceed with blocked tasks until these are resolved.

## How This Works

1. **AI gets stuck** → Adds task here with details
2. **Human completes task** → Removes entry from this file
3. **Human updates IMPLEMENTATION_PLAN.md** → Adds note to the blocked task, changes status back to `pending`
4. **AI retries** → On next iteration, picks up the unblocked task

---

## Pending Tasks

<!-- AI: Append new tasks here when blocked. Include enough detail for human to act. -->
<!-- Human: Remove completed tasks from this section. -->

<!--
Example entry:

### Set up database connection
**Blocking**: TASK-005 (User authentication)
**Needed by**: AI cannot run migrations or test auth flow

**What's needed**:
- Create PostgreSQL database (local or cloud)
- Add `DATABASE_URL` to `.env` file
- Format: `postgresql://user:password@host:5432/dbname`

**How to verify**: Run `npm run db:migrate` - should complete without errors
-->

---

## Notes for Human

<!-- AI: Add any context that might help the human. -->
<!-- Human: Add notes here when completing tasks if useful for AI. -->

