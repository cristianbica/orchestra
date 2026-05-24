#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

fail() {
  echo "verify: $*" >&2
  exit 1
}

check_file() {
  [ -f "$1" ] || fail "missing file: $1"
}

check_absent() {
  [ ! -e "$1" ] || fail "unexpected file exists: $1"
}

check_contains() {
  file=$1
  pattern=$2
  grep -q "$pattern" "$file" || fail "missing pattern '$pattern' in $file"
}

cd "$ROOT"

sh -n install.sh

for f in src/tools/codex/.codex/agents/*.toml .codex/agents/*.toml; do
  check_contains "$f" '^name = '
  check_contains "$f" '^description = '
  check_contains "$f" '^developer_instructions = '
done

for role in conductor planner builder validator forger; do
  check_file "src/tools/codex/.codex/agents/$role.toml"
  check_absent "src/tools/codex/.codex/agents/$role.md"
  check_contains "src/tools/codex/.codex/agents/$role.toml" ".ai/agents/$role.md"
done

check_contains "src/tools/codex/.codex/config.toml" '^\[agents\]'
check_contains "src/tools/codex/.codex/config.toml" '^max_threads = 6'
check_contains "src/tools/codex/.codex/config.toml" '^max_depth = 1'

if command -v python3 >/dev/null 2>&1; then
  python3 - "$ROOT" <<'PY'
import pathlib
import re
import sys
import tomllib

root = pathlib.Path(sys.argv[1])
for path in list((root / "src/tools/codex/.codex/agents").glob("*.toml")) + list((root / ".codex/agents").glob("*.toml")):
    data = tomllib.loads(path.read_text())
    for key in ("name", "description", "developer_instructions"):
        if key not in data or not str(data[key]).strip():
            raise SystemExit(f"verify: {path} missing {key}")

targets = [
    root / "src/tools/copilot/.github/copilot-instructions.md",
    root / "src/tools/copilot/.github/instructions/ai.instructions.md",
    root / "src/tools/claude-code/.claude/CLAUDE.md",
    root / "src/tools/opencode/.opencode/AGENTS.md",
    root / "src/tools/codex/.codex/AGENTS.md",
]
pattern = re.compile(r"`((?:\.ai|src/ai)/[^`]+?\.md)`")
for path in targets:
    for ref in pattern.findall(path.read_text()):
        if "*" in ref:
            continue
        candidate = root / ref
        if not candidate.exists():
            raise SystemExit(f"verify: {path} references missing {ref}")
PY
else
  echo "verify: python3 not found; skipped TOML parse and wrapper-link checks"
fi

for role in conductor planner builder validator forger; do
  check_file "src/ai/agents/$role.md"
done

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT INT TERM

for tool in codex claude-code copilot opencode; do
  dest="$tmp/$tool"
  mkdir -p "$dest"
  if [ "$tool" = "codex" ]; then
    mkdir -p "$dest/.codex/agents"
    for role in conductor planner builder validator forger; do
      : > "$dest/.codex/agents/$role.md"
    done
  fi
  (cd "$dest" && SRC_DIR="$ROOT" sh "$ROOT/install.sh" "$tool")
done

for role in conductor planner builder validator forger; do
  check_file "$tmp/codex/.codex/agents/$role.toml"
  check_absent "$tmp/codex/.codex/agents/$role.md"
done

check_file "$tmp/codex/.codex/AGENTS.md"
check_file "$tmp/codex/.codex/config.toml"
check_absent "$tmp/claude-code/.claude/skills"
check_file "$tmp/copilot/.github/instructions/ai.instructions.md"
check_file "$tmp/opencode/.opencode/AGENTS.md"

line_budget=$(wc -l < src/ai/AGENTS.md)
[ "$line_budget" -le 80 ] || fail "src/ai/AGENTS.md exceeds 80 lines: $line_budget"

echo "verify: ok"
