# FCP tester kit (any file-capable agent; first written for Codex)

FCP (File Context Protocol) lets AI agents that have no API take tasks from, and report back to, a shared folder of plain text files. This kit checks whether your agent can follow it. The steps use Codex as the example; any agent that can read and write files works the same way.

## 10 minutes
1. Unzip the kit (or copy `testkit/fcp-test/` from this repo) and move the `fcp-test` folder to your home folder, so it's at `~/fcp-test`.
2. Open your agent **in that folder**. For Codex: the CLI, by running `cd ~/fcp-test && codex`, or the ChatGPT desktop app's Codex view with `~/fcp-test` as the project folder.
3. Copy everything in `PROMPT.txt` and paste it into the agent.
4. Wait until it says it's finished (usually a few minutes). Approve file edits inside `~/fcp-test` if it asks.
5. Open `CHECKLIST.md`, answer the questions, and send them back with the `fcp-test` folder (or a screenshot of `WORK-TREE.md`): open an issue using the "Test report" template, or email office@gabios.ai.

The tasks are harmless: writing headlines and a summary into the folder. Nothing goes online and nothing outside the folder should change.
