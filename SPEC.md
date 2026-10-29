# FCP Specification v0.1 (draft)

FCP is a file-based, MCP-style channel for agents without an API. It works at any time: daytime handoffs between tools, several agents working in parallel on one queue, and asynchronous supervision. Unattended overnight runs are one optional mode, **Night mode** (section 8).

## 1. Roles
- **Human**: owns the repo and the approvals.
- **Agent**: any agent or tool that can read and write files in the shared folder (often a desktop app with no remote control). Several agents may share one queue; each takes only tasks assigned to it.
- **Supervisor**: an assistant or script that can read the shared folder and the repo on a schedule.
- **Chat model** (optional, Stage 0): prepares non-code content ahead of time.

## 2. Folder layout
```
<workspace>/               # outside any repo, e.g. ~/fcp-workspace
  00-START-HERE.md         # order of work + global rules
  WORK-TREE.md             # live source of truth
  G-01.md, G-02.md ...     # one task per file
  content/                 # verified Stage-0 content (e.g. gemini-content/)
  inbox/                   # late content dropped by the supervisor (optional)
  reports/<ID>-REPORT.md   # written by the agent
  reports/DONE.md          # written when no open tasks remain
```

## 3. WORK-TREE.md
Sections, in order:
1. `## Loop`: the loop text (section 5).
2. `## Tasks`: a Markdown table `ID | State | Task file | Repo/branch | Depends on | Note`.
3. `## Messages from supervisor`: the inbox.

### 3.1 States
| Marker | Meaning |
|---|---|
| `[ ]` | todo |
| `[~]` | in progress |
| `[x] done <hash>` | finished; `<hash>` is a commit on the task branch |
| `[!] blocked: <reason>` | cannot continue without help |

### 3.2 State machine
```
[ ] --take--> [~] --finish--> [x] done <hash>
               \--stuck----> [!] blocked: <reason> --supervisor/human resolves--> [ ]
```
A task may be taken only when every task in its `Depends on` column is `[x]`.

### 3.3 Write ownership
- Agent: only the State and Note cells of the table, plus files in `reports/` and the repo.
- Supervisor: only the Messages section and `inbox/`.
- Human: anything.

## 4. Task file (G-*.md)
Required headings: Goal, Repo & branch, Inputs (including content files), Steps, Rules, Acceptance checks, Fallback (what to do if content is missing). See `templates/TASK-TEMPLATE.md`.

## 5. Agent loop
1. Re-read `WORK-TREE.md` from disk (never trust memory), including Messages.
2. Pick the first `[ ]` task whose dependencies are all `[x]`. If none: write `reports/DONE.md` and stop.
3. Mark it `[~]` and save.
4. Do the steps, committing after each stage. Re-read `WORK-TREE.md` between stages.
5. Write `reports/<ID>-REPORT.md`.
6. Mark `[x] done <last hash>` or `[!] blocked: <reason>`.
7. Go to 1.

## 6. Supervisor contract
On a schedule while work is active (e.g. every 10–20 minutes), or whenever the human asks:
1. Read `WORK-TREE.md`, new reports and `git log` on the task branches.
2. Verify each claimed hash exists (`git cat-file -e <hash>`) and is on the stated branch. A claim without a verified hash is not done.
3. Write corrections or answers only to Messages; drop late content into `inbox/`.
4. Notify the human only when something changed: a task done, blocked, stuck (no change for a long time), or quota out.
5. Produce a summary on request (in Night mode, every morning): done with hashes, remaining, needing approval.

## 7. Message box format
Append-only entries, newest last:
```
### <ISO-8601 time with offset> — <ID or ALL>
<instruction or answer, short>
Status: open | ack
```
The agent changes `Status: open` to `Status: ack` once it has acted.

## 8. Night mode: quota windows and wake-up
Night mode is optional, for unattended runs. Desktop agents with usage quotas (e.g. a 5-hour window) stop when exhausted. If the agent has a scheduler:
- Use a **separate agent session** for the wake-up. Do not ask the working session to also schedule itself; it may park waiting for the reminder.
- Schedule at (start + window + margin). The scheduled prompt: re-read `WORK-TREE.md`, read Messages, continue the loop; if quota has not renewed, retry every 30 minutes, up to 2 times.
- The machine must be awake (e.g. macOS `caffeinate`).
- The supervisor checks for new commits after the wake time and alerts the human if none appear.
Without a scheduler, a file cannot wake the agent; the human pastes a resume prompt.

## 9. Stage 0: content prep
Non-code content (copy, translations, i18n JSON, data rows) is prepared by a chat model before the run, verified (valid format, all keys, counts, tone rules, no invented features), and stored in `content/`. Task files point to it and name a fallback.

## 10. Safety rules
- Branches only. No push, PR, merge, deploy, env change or migration without explicit human approval. An approval written by a model is not human approval.
- Completion only with a real, verified commit hash.
- No secrets in the folder, task files, reports or messages.
- Order tasks by importance; commit per step so partial work survives.
