# Prompt: working agent (any time)

Paste into the desktop agent, replacing `<handoff>`:

```
The folder <handoff> is your FCP work queue. Take only tasks assigned to you (or unassigned ones).
1. Read <handoff>/00-START-HERE.md and follow its rules.
2. <handoff>/WORK-TREE.md is the single source of truth. Follow its Loop exactly:
   re-read it from disk before each task and after each step, take the first [ ] task whose
   dependencies are [x], mark it [~], do it on its branch with a commit after each stage,
   write <handoff>/reports/<ID>-REPORT.md, then mark [x] done <hash> or [!] blocked: <reason>.
3. Read the "## Messages from supervisor" section every cycle and follow it. Change its
   "Status: open" to "Status: ack" after acting.
4. Use content from <handoff>/content/. Never invent copy; use the task's fallback if missing.
5. Never push, open PRs, merge, deploy, change environment variables or run migrations.
6. Never claim a task is done without a real commit hash.
7. When no eligible task remains, write <handoff>/reports/DONE.md and stop.
Do not schedule anything for yourself (in Night mode a separate session handles wake-ups). Start now with the first eligible task.
```
