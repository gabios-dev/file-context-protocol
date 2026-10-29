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

## Tasks
| ID | State | Task file | Repo / branch | Agent | Depends on | Note |
|---|---|---|---|---|---|---|
| G-01 | [ ] | G-01.md | repo / feat/g-01 | | – | |
| G-02 | [ ] | G-02.md | repo / feat/g-02 | | G-01 | |

## Messages from supervisor
<!-- Agent column: empty = any agent. Supervisor writes only here. Format:
### <ISO time with offset> — <ID or ALL>
<message>
Status: open
-->
