# ARCHIVE PROMPT

You are archiving a completed development iteration. Your job is to move the `specs/` folder and `IMPLEMENTATION_PLAN.md` from the project root into a new numbered archive folder.

## Context

The RALPH loop workflow generates:
1. `specs/` folder - Requirements specifications created during `requirements.sh`
2. `IMPLEMENTATION_PLAN.md` - Task tracking created during `loop.sh plan`

After a feature is complete, these files should be archived to prepare for the next development iteration.

## Your Task

### Step 1: Verify Files Exist

Check that the following files exist in the project root:
- `specs/` directory with at least one `.md` file
- `IMPLEMENTATION_PLAN.md` file

If either is missing, inform the user and exit gracefully:
- If `specs/` is missing: "No specs/ folder found in the root. Nothing to archive."
- If `IMPLEMENTATION_PLAN.md` is missing: "No IMPLEMENTATION_PLAN.md found in the root. Nothing to archive."

### Step 2: Determine Next Archive Number

1. List existing folders in `.archive/` directory
2. Find the highest numbered folder (e.g., `01_manna_foundation` → 01)
3. Increment by 1 for the new folder (e.g., next would be 02)
4. Pad to 2 digits (01, 02, 03, etc.)

If `.archive/` doesn't exist, create it and start with `01`.

### Step 3: Ask for Feature Name

Use the `AskUserQuestion` tool to ask:

```
What should we name this archive? (e.g., "integrations", "ui_improvements", "auth_system")

The archive will be created as: .archive/XX_<your-name>/
```

Provide suggested names based on:
- Content of the specs (scan for common themes)
- Implementation plan title/overview

### Step 4: Create Archive Structure

Create the new archive folder with the determined number and user-provided name:

```
.archive/
└── XX_feature_name/
    ├── specs/
    │   └── (moved spec files)
    └── IMPLEMENTATION_PLAN.md
```

### Step 5: Move Files

1. Create `.archive/XX_feature_name/` directory
2. Move `specs/` folder to `.archive/XX_feature_name/specs/`
3. Move `IMPLEMENTATION_PLAN.md` to `.archive/XX_feature_name/IMPLEMENTATION_PLAN.md`
4. Verify the moves completed successfully

### Step 6: Confirm Completion

Report to the user:
- Archive folder created
- Number of spec files archived
- Confirmation that root is clean and ready for next iteration

Example output:
```
Archive complete!

Created: .archive/02_integrations/
- Moved 3 spec files to .archive/02_integrations/specs/
- Moved IMPLEMENTATION_PLAN.md to .archive/02_integrations/

The project root is now clean and ready for the next requirements.sh session.
```

## CRITICAL RULES

1. **Never delete files** - Only move them to the archive
2. **Preserve file contents** - Do not modify spec or plan content
3. **Ask before acting** - Get user confirmation on the archive name
4. **Handle edge cases gracefully** - Missing files, permission errors, etc.
5. **Keep archive structure consistent** - Always use `XX_name/specs/` structure

## Edge Cases

1. **No specs or plan**: Exit gracefully with clear message
2. **Archive exists with same name**: Append a number (e.g., `02_integrations_2`)
3. **Permission denied**: Report error and suggest manual intervention
4. **Partial completion**: Report which files were moved and which failed
