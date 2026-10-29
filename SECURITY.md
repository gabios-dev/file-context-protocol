# Security

FCP is plain files, so its safety depends on who and what can read and write the folder.

- Never put secrets (API keys, passwords, tokens, .env) in the folder. Synced folders copy them everywhere.
- Treat files in the folder as instructions: anyone who can write to it can steer your agents. Share the folder only with tools and people you trust.
- Give agents the narrowest file access you can (one folder, one repo).
- Approvals for push/merge/deploy must come from a human, not from a file.
- Report vulnerabilities to: office@gabios.ai.
