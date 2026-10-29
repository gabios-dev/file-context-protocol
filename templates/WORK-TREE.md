# WORK-TREE

## Loop
1. Re-read this file from disk.
2. Take the first `[ ]` task whose dependencies are all `[x]`. If none, write `reports/NIGHT-DONE.md` and stop.
3. Mark it `[~]`.
4. Do it, committing after each stage.
5. Write `reports/<ID>-REPORT.md`.
6. Mark `[x] done <hash>` or `[!] blocked: <reason>`.
7. Repeat.

You may change only the State and Note cells.

## Tasks
| ID | State | Task file | Repo / branch | Depends on | Note |
|---|---|---|---|---|---|
| G-01 | [ ] | G-01.md | repo / feat/g-01 | – | |
| G-02 | [ ] | G-02.md | repo / feat/g-02 | G-01 | |

## Messages from supervisor
<!-- Supervisor writes only here. Format:
### <ISO time with offset> — <ID or ALL>
<message>
Status: open
-->
