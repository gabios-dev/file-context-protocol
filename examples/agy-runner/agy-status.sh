#!/usr/bin/env bash
# Print RUNNING/IDLE and a summary of the last headless agy run.
# Env: FCP_DIR (default: $HOME/fcp-workspace)
set -uo pipefail
FCP_DIR="${FCP_DIR:-$HOME/fcp-workspace}"
RUNS="$FCP_DIR/runs"; LOCK="$RUNS/agy.lock"

if [ -f "$LOCK" ] && kill -0 "$(cat "$LOCK")" 2>/dev/null; then
  echo "RUNNING pid=$(cat "$LOCK")"
else
  rm -f "$LOCK"; echo "IDLE"
fi

[ -f "$RUNS/last-run.txt" ] && echo "last: $(cat "$RUNS/last-run.txt")"
LAST="$(ls -t "$RUNS"/*.json 2>/dev/null | head -1)"
if [ -n "$LAST" ]; then
  echo "output: $LAST ($(wc -c < "$LAST") bytes)"
  if command -v node >/dev/null; then
    node -e 'try{const j=JSON.parse(require("fs").readFileSync(process.argv[1],"utf8"));
      const d=j.denied_actions||[];console.log("denied_actions:",d.length);
      const r=String(j.result||j.response||"").slice(-600);if(r)console.log("tail:",r)}catch(e){console.log("output not complete JSON yet")}' "$LAST"
  fi
  ERRF="${LAST%.json}.err"; [ -s "$ERRF" ] && { echo "stderr tail:"; tail -5 "$ERRF"; }
fi
