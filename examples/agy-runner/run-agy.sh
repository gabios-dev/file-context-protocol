#!/usr/bin/env bash
# Launch one headless Antigravity CLI (agy) run in the background.
# Usage: run-agy.sh <prompt-file> [model]
# Env:   FCP_DIR     shared FCP folder        (default: $HOME/fcp-workspace)
#        AGY_WORKDIR repo the agent works in  (default: $PWD)
#        AGY_TIMEOUT print timeout            (default: 120m)
set -euo pipefail

PROMPT_FILE="${1:?usage: run-agy.sh <prompt-file> [model]}"
MODEL="${2:-gemini-4-argon-medium}"
FCP_DIR="${FCP_DIR:-$HOME/fcp-workspace}"
AGY_WORKDIR="${AGY_WORKDIR:-$PWD}"
AGY_TIMEOUT="${AGY_TIMEOUT:-120m}"
AGY_BIN="${AGY_BIN:-$(command -v agy || echo "$HOME/.local/bin/agy")}"
RUNS="$FCP_DIR/runs"
LOCK="$RUNS/agy.lock"

mkdir -p "$RUNS"
[ -f "$PROMPT_FILE" ] || { echo "prompt file not found: $PROMPT_FILE" >&2; exit 2; }

# Quota guard: refuse models that burn the quota in minutes.
case "$MODEL" in
  claude-opus-*) echo "refusing $MODEL: too quota-hungry for unattended runs" >&2; exit 3 ;;
esac

# One run at a time.
if [ -f "$LOCK" ] && kill -0 "$(cat "$LOCK")" 2>/dev/null; then
  echo "agy already running (pid $(cat "$LOCK"))" >&2; exit 4
fi

TS="$(date +%Y%m%d-%H%M%S)"
OUT="$RUNS/$TS.json"; ERR="$RUNS/$TS.err"
echo "$TS model=$MODEL prompt=$PROMPT_FILE" > "$RUNS/last-run.txt"

cd "$AGY_WORKDIR"
nohup bash -c '
  "$0" -p "$(cat "$1")" --model "$2" --output-format json \
       --print-timeout "$3" --add-dir "$4" > "$5" 2> "$6"
  rm -f "$7"
' "$AGY_BIN" "$PROMPT_FILE" "$MODEL" "$AGY_TIMEOUT" "$FCP_DIR" "$OUT" "$ERR" "$LOCK" >/dev/null 2>&1 &
echo $! > "$LOCK"
echo "started pid $! -> $OUT"
