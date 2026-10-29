# Prompt: separate night (wake-up) agent

Open a **new, separate** agent session (not the one that is working). Replace `<handoff>` and `<HH:MM>` (quota renewal time plus a small margin):

```
Your only job is to set a scheduled task. Do not start any work now.
Using your built-in scheduler, create a task that runs today at <HH:MM> local time with this prompt:

"Re-read <handoff>/WORK-TREE.md from disk and read its '## Messages from supervisor' section.
Follow <handoff>/00-START-HERE.md. Continue the Loop from the first unfinished task
([~] first, otherwise the first eligible [ ]). Commit after each stage, write reports,
mark [x] done <hash> or [!] blocked: <reason>. Never push, merge, deploy or change env vars.
If your usage quota has not renewed yet, retry every 30 minutes, up to 2 times."

After saving, reply with the exact date and time the task is scheduled for, then stop.
```

Why separate: a session asked to both keep working and wake later tends to park itself waiting for the reminder and stop working.
