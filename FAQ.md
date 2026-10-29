# FAQ

**How is this different from MCP?**
MCP is a live tool-calling connection; FCP is a slow, durable work queue in files. Use both. See the table in the [README](README.md#fcp-vs-mcp-in-plain-words).

**How is it different from browser-extension bridges (e.g. ChatGPT↔Claude via a Chrome extension)?**
Those relay chat messages between browser tabs while you watch. FCP works with desktop apps and CLIs that have no browser tab, keeps every handoff as a file you can inspect and version, survives restarts, and can be supervised by a script or bot. They can coexist.

**Do I need git?**
No. Without git, done = the output file exists (see [SPEC §3.1](SPEC.md#31-states)).

**Can a file wake an agent?**
No. You need a scheduler or a person (see [SPEC §8](SPEC.md#8-night-mode-quota-windows-and-wake-up)).

**Is it only for overnight runs?**
No. The channel is open 24/7: daytime handoffs between tools, several agents on one queue, or supervision while you do something else. Night mode is optional.

**Can several agents share one queue?**
Yes. Use the optional `Agent` column, and have each agent claim a task with `[~] <agent name>` and re-read before working (see [SPEC §5](SPEC.md#5-agent-loop)).

**Is it safe?**
See [SECURITY.md](SECURITY.md).
