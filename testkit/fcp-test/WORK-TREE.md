# WORK-TREE (FCP test)

## Loop
1. Re-read this file from disk.
2. Take the first `[ ]` task whose dependencies are all `[x]`. If none, write `reports/DONE.md` and stop.
3. Mark it `[~]` and save this file.
4. Do the task.
5. Write `reports/<ID>-REPORT.md` (what you did, files written, any message you followed).
6. Mark `[x] done <output file>` or `[!] blocked: <reason>` and save this file.
7. Repeat.

## Tasks
| ID | State | Task | Output | Depends on | Note |
|---|---|---|---|---|---|
| T-01 | [ ] | Write 3 headline options for a short post about slow mornings. | drafts/T-01.md | – | |
| T-02 | [ ] | Summarize `content/sample.md`. | drafts/T-02.md | T-01 | |

## Messages from supervisor
### 2026-10-29T21:00+02:00 — T-02
In T-02 use exactly 5 bullets.
Status: open
