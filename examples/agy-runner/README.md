# agy-runner

Generic scripts for running the Antigravity CLI (`agy`) headless on an FCP folder.
See [docs/headless-agent-runner.md](../../docs/headless-agent-runner.md).

- `run-agy.sh <prompt-file> [model]` — background launcher with lock, quota guard and logs.
- `agy-status.sh` — prints `RUNNING` / `IDLE` and the last run summary.
- `settings.example.json` — permission allow/deny example for `~/.gemini/antigravity-cli/settings.json`.
