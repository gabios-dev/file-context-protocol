# Compatibility

FCP needs only one thing from a tool: it can **read and write files in a shared folder** (or watch it for changes). This page lists tools that should be able to do that.

**Status meanings**
- **Tested**: used in a real FCP run by the maintainers.
- **Should work (untested)**: public docs say the tool can read and write local files (or watch a folder), but we haven't run FCP with it.
- **Unverified**: we couldn't confirm the capability from a public source.

Capabilities were checked against public sources on 29 Oct 2026. Tools change; check their current docs.

## Desktop coding agents
| Tool | Role in FCP | Status | Notes / source |
|---|---|---|---|
| Google Antigravity (desktop app) | Working agent | **Tested** | The original FCP run used it as the working agent. Google's [Drive MCP docs](https://developers.google.com/workspace/drive/api/guides/configure-mcp-server) also list Antigravity as an MCP host. |
| Cursor | Working agent | Should work (untested) | Agent edits files in the workspace and can use MCP servers such as the filesystem server ([Cursor MCP docs](https://cursor.com/docs/mcp)). Scheduled wake-up seen working (one user report); full FCP run not yet tested. |
| Windsurf (Cascade) | Working agent | Should work (untested) | Can use MCP servers such as the filesystem server ([Windsurf MCP docs](https://docs.windsurf.com/windsurf/cascade/mcp)). |
| Claude Code | Working agent or supervisor | Should work (untested) | Edits local files and can use MCP servers ([Claude Code MCP docs](https://code.claude.com/docs/en/mcp)). |
| Codex CLI | Working agent or supervisor | Should work (untested) | Reads and edits files in a `workspace-write` sandbox ([OpenAI sandbox docs](https://learn.chatgpt.com/docs/sandboxing)). |
| Gemini CLI | Working agent | Should work (untested) | Check Google's current docs for availability. |
| Cline (VS Code extension) | Working agent | Should work (untested) | "Cline can create and edit files directly in your editor" ([VS Code Marketplace page](https://marketplace.visualstudio.com/items?itemName=saoudrizwan.claude-dev)). |
| Kiro | Working agent | Should work (untested) | Custom agents with `read`/`write` tool access; hooks trigger on file events ([Kiro 1.0 changelog](https://kiro.dev/changelog/ide/1-0/)). |

## Chat apps with file access
| Tool | Role in FCP | Status | Notes / source |
|---|---|---|---|
| Claude Desktop + filesystem MCP server | Working agent or supervisor | Should work (untested) | The official filesystem server gives read/write in the folders you allow ([MCP docs](https://modelcontextprotocol.io/docs/2025-03-26/develop/connect-local-servers), [server repo](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem)). |
| ChatGPT desktop app (Work / Codex) | Working agent or supervisor | Should work (untested) | "On desktop, Work can use local files and desktop apps with your permission" ([release notes](https://help.openai.com/en/articles/11391654-chatgpt-team-release-notes)). |

## Supervisors
| Tool | Role in FCP | Status | Notes |
|---|---|---|---|
| Cloud supervising assistant with access to the user's computer | Supervisor | **Tested** | Used as the supervisor in the original run: scheduled checks, hash verification, messages section. |

## Automation (via synced-folder file triggers)
| Tool | Role in FCP | Status | Notes / source |
|---|---|---|---|
| Make | Notifier / mover | Should work (untested) | Google Drive "Watch Files in a Folder" trigger ([Make Google Drive app docs](https://apps.make.com/google-drive)). |
| Zapier | Notifier / mover | Should work (untested) | Google Drive "New File in Folder" and "Updated File" triggers ([Zapier page](https://zapier.com/apps/google-drive/integrations/anthropic-claude)). Polls every 15 min on the Free plan. Dropbox trigger: **unverified** (no primary source checked). |
| n8n | Notifier / mover | Should work (untested) | Local File Trigger watches a file or folder for add/change/delete ([source](https://github.com/n8n-io/n8n/blob/master/packages/nodes-base/nodes/LocalFileTrigger/LocalFileTrigger.node.ts)). Drive/Dropbox triggers: unverified. |

Automation tools don't do the tasks themselves; they can notify you or move files when WORK-TREE or reports change.

## Synced folders (transport)
| Tool | Status | Notes |
|---|---|---|
| Google Drive (desktop sync) | Should work (untested) | Lets tools on different machines share one folder. Watch for sync delays and conflict copies. |
| Dropbox | Should work (untested) | Same as above. |
| iCloud Drive | Should work (untested) | Same as above. Files may be offloaded until opened. |

Sync is not instant. Keep one writer per section (see SPEC §3.3), and re-read files before writing.

## Scripts and cron
| Tool | Role | Status | Notes |
|---|---|---|---|
| Shell / Python scripts, cron, launchd | Supervisor or notifier | Should work (untested) | Anything that can read files and run `git` can verify hashes and append to Messages. |

## Add your tool via PR
Used FCP with a tool not listed, or tested one marked untested? Open a PR that edits this file with: the tool and version, the role it played, what worked and what didn't, and a link to the docs for its file access. Please don't change a status to **Tested** without a real run.

## Antigravity Remote Control

To check in on Antigravity agents from your phone, enable Settings → Application → Remote Control → "Enable Remote Control" and scan the QR code (turn on "Prevent Sleep" to keep the computer awake). It is a remote screen for the same tool and quota; FCP still handles moving work between agents, and approvals still follow FCP's rules. See the README section "Monitor from your phone".
