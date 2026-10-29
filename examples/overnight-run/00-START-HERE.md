FCP: 0.1

# START HERE

This folder is a shared FCP work queue. `WORK-TREE.md` is the source of truth. Follow its loop.

## Order
Work tasks in the order listed in `WORK-TREE.md` (most important first).

## Global rules
- Work on branches only. Never push, open PRs, merge, deploy, change env vars or run production migrations.
- Take only tasks assigned to you (or unassigned). Claim a task by writing `[~] <agent name>`, then re-read to make sure no one else claimed it.
- Commit after each stage. Commit author: `<name> <email>`.
- A task is done only with a real commit hash (or, without git, an existing output file).
- Re-read `WORK-TREE.md` from disk before each task and after each step.
- Read `## Messages from supervisor` every cycle and follow it.
- Use content from `content/`. Don't invent copy. If content is missing, use the task's fallback and say so in the report.
- Never write secrets into any file here.
- If stuck, mark `[!] blocked: <reason>` and move to the next eligible task.
