# FCP — File Context Protocol

**A file-based, MCP-style channel between a supervising AI assistant and a desktop coding agent that has no CLI or API.**

Some of the best coding agents run only as desktop apps. You can't call them from a server, you can't script them, and you can't check on them remotely. FCP solves this with the most boring tool there is: a shared folder of Markdown files on your computer. The desktop agent reads tasks from it and writes progress back. A supervising assistant (a cloud bot, a scheduled script, or you) reads the same files, verifies the work against real git history, and leaves guidance in a message box.

Status: **v0.1 draft**. See [SPEC.md](SPEC.md).

## Why

- **Unattended runs.** Let a desktop agent work overnight while you sleep, and wake up to verified commits.
- **No integration needed.** If the agent can read and write files, it speaks FCP.
- **Honest progress.** A task is "done" only with a real commit hash, and the supervisor checks that hash exists.
- **Survives interruptions.** One commit per step plus a task table on disk means quota cut-offs or crashes lose little.

## Quick start (5 minutes)

1. Create a handoff folder outside any repo, e.g. `~/agent-night/`.
2. Copy everything from [`templates/`](templates/) into it and create `reports/` and `content/`.
3. Write one task file per task from `TASK-TEMPLATE.md` (`G-01.md`, `G-02.md`, ...) and list them in `WORK-TREE.md`, most important first.
4. Keep the machine awake. On macOS: `nohup caffeinate -imsu -t 36000 &` (10 hours). Keep it plugged in.
5. Paste [`prompts/evening-agent.md`](prompts/evening-agent.md) into the desktop agent, and set up your supervisor with [`prompts/supervisor-routine.md`](prompts/supervisor-routine.md).

Optional: if the agent has a usage quota and a built-in scheduler, open a **separate** agent session and paste [`prompts/night-agent-schedule.md`](prompts/night-agent-schedule.md) so work resumes after the quota renews.

See [`examples/overnight-run/`](examples/overnight-run/) for a small fictional run.

## How it works

```mermaid
flowchart LR
    H[Human] -- approves push / merge / deploy --> R[(Git repo)]
    subgraph F[Shared folder ~/agent-night]
      S0[00-START-HERE.md]
      WT[WORK-TREE.md<br/>task table + messages]
      T[G-*.md task specs]
      C[content/]
      RP[reports/]
    end
    A[Desktop coding agent] -- reads tasks, marks state --> WT
    A -- commits per step --> R
    A -- writes --> RP
    S[Supervisor<br/>every 10-20 min] -- reads --> WT
    S -- verifies hashes --> R
    S -- writes only to Messages --> WT
    S -- notifies on change --> H
    CM[Chat model, Stage 0] -- prepared copy / data --> C
```

The agent's loop: re-read `WORK-TREE.md` from disk → take the first `[ ]` task whose dependencies are `[x]` → mark it `[~]` → work with a commit per step → write `reports/<ID>-REPORT.md` → mark `[x] done <hash>` or `[!] blocked: <reason>` → repeat. When nothing is left, write `NIGHT-DONE.md` and stop.

## FCP vs. MCP, in plain words

| | MCP (Model Context Protocol) | FCP (File Context Protocol) |
|---|---|---|
| Transport | A live connection (stdio / HTTP) | Files in a shared folder |
| Needs | A client that supports MCP | An agent that can read and write files |
| Speed | Instant calls | Slow: minutes between checks |
| Best for | Giving a model tools and data | Handing a whole work queue to an agent you can't drive remotely |
| Direction | Model calls a server | Two agents leave notes for each other |

FCP isn't a replacement for MCP. It's for the gap MCP doesn't cover: agents locked inside a desktop app.

## Key rules

- No push, merge, deploy, environment change or migration without explicit human approval.
- Completion is claimed only with a real commit hash, and the supervisor verifies it.
- The supervisor writes only in the `## Messages from supervisor` section.
- Never put secrets in the folder.
- If the agent has a quota and a scheduler, the wake-up job belongs to a **separate agent session**. A session told to both keep working and wake later tends to park itself waiting for the reminder.

## For creators: Agada and your other tools, side by side

Creators rarely use one tool. A single project might touch a desktop chat app (Claude, ChatGPT), a coding agent (Cursor or another desktop agent), Canva exports, and a Drive-synced folder. FCP gives them one shared project queue: any tool that can read and write files can pick up a task from `WORK-TREE.md`, put its output in the folder, and hand the next step to another tool.

In this picture, Agada is the home base: it supervises the queue, checks the work, and keeps the project record. FCP itself is open and works with any supervisor. This describes how the protocol is designed to be used, not a shipped Agada feature.

## Built by the team behind Agada

FCP came out of building [Agada](https://gabios.ai) at [GabiOS](https://gabios.ai), where we use it to hand overnight work to a desktop coding agent under the watch of a supervising assistant.

## License

MIT, see [LICENSE](LICENSE). Contributions welcome, see [CONTRIBUTING.md](CONTRIBUTING.md). עברית: [README.he.md](README.he.md).
