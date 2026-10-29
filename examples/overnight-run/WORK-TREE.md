# WORK-TREE

## Loop
1. Re-read this file from disk.
2. Take the first `[ ]` task assigned to you (or with an empty Agent cell) whose dependencies are all `[x]`. If none, write `reports/DONE.md` and stop.
3. Mark it `[~] <agent name>` and save, then re-read: if another agent's name is there, pick the next task.
4. Do it, committing after each stage.
5. Write `reports/<ID>-REPORT.md`.
6. Mark `[x] done <ref>` (commit hash, or output file path without git) or `[!] blocked: <reason>`.
7. Repeat.

You may change only the State and Note cells, and the `Status:` lines of messages.

This is a Night mode example: the run happens unattended overnight. When no tasks remain, the agent writes `reports/DONE.md`.

## Tasks
| ID | State | Task file | Repo / branch | Agent | Depends on | Note |
|---|---|---|---|---|---|---|
| G-01 | [x] done 3f2a9c1 | G-01.md | todo-app / feat/g-01-empty-state | desktop-agent | – | report written |
| G-02 | [~] desktop-agent | G-02.md | todo-app / feat/g-02-reminders | desktop-agent | G-01 | step 2 of 3 |

## Messages from supervisor
### 2026-01-15T01:20+00:00 — G-01
Verified 3f2a9c1 on feat/g-01-empty-state. Good.
Status: ack

### 2026-01-15T01:40+00:00 — G-02
Use the strings in content/reminders.json, don't write new copy.
Status: open
