#!/bin/sh
set -eu

TOOL_NAME=${1-}
DEST_DIR=$PWD
AI_DIR="$DEST_DIR/.ai"

if [ "$TOOL_NAME" = "vscode-copilot" ]; then
  TOOL_NAME="copilot"
fi

remove_if_exists() {
  target=$1
  if [ -e "$target" ]; then
    rm -f "$target"
  fi
}

cleanup_legacy_files() {
  remove_if_exists "$AI_DIR/agents/architect.md"
  remove_if_exists "$AI_DIR/agents/archivist.md"
  remove_if_exists "$AI_DIR/agents/inspector.md"
  remove_if_exists "$AI_DIR/agents/researcher.md"
  remove_if_exists "$AI_DIR/agents/reviewer.md"

  remove_if_exists "$AI_DIR/workflows/implement-feature.md"
  remove_if_exists "$AI_DIR/workflows/fix-bug.md"
  remove_if_exists "$AI_DIR/workflows/refactor.md"

  remove_if_exists "$DEST_DIR/.claude/agents/architect.md"
  remove_if_exists "$DEST_DIR/.claude/agents/archivist.md"
  remove_if_exists "$DEST_DIR/.claude/agents/inspector.md"
  remove_if_exists "$DEST_DIR/.claude/agents/researcher.md"
  remove_if_exists "$DEST_DIR/.claude/agents/reviewer.md"

  remove_if_exists "$DEST_DIR/.codex/agents/architect.md"
  remove_if_exists "$DEST_DIR/.codex/agents/archivist.md"
  remove_if_exists "$DEST_DIR/.codex/agents/inspector.md"
  remove_if_exists "$DEST_DIR/.codex/agents/researcher.md"
  remove_if_exists "$DEST_DIR/.codex/agents/reviewer.md"

  remove_if_exists "$DEST_DIR/.opencode/agents/architect.md"
  remove_if_exists "$DEST_DIR/.opencode/agents/archivist.md"
  remove_if_exists "$DEST_DIR/.opencode/agents/inspector.md"
  remove_if_exists "$DEST_DIR/.opencode/agents/researcher.md"
  remove_if_exists "$DEST_DIR/.opencode/agents/reviewer.md"

  remove_if_exists "$DEST_DIR/.github/agents/architect.agent.md"
  remove_if_exists "$DEST_DIR/.github/agents/archivist.agent.md"
  remove_if_exists "$DEST_DIR/.github/agents/inspector.agent.md"
  remove_if_exists "$DEST_DIR/.github/agents/researcher.agent.md"
  remove_if_exists "$DEST_DIR/.github/agents/reviewer.agent.md"
}

TMP_DIR=""
cleanup() {
  if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
  fi
}
trap cleanup EXIT INT TERM

if [ -n "${SRC_DIR-}" ]; then
  SRC_ROOT="$SRC_DIR"
else
  TMP_DIR=$(mktemp -d)
  curl -fsSL "https://github.com/cristianbica/orchestra/archive/refs/heads/next.tar.gz" \
    | tar -xz -C "$TMP_DIR"
  SRC_ROOT=$(find "$TMP_DIR" -maxdepth 1 -mindepth 1 -type d | head -n 1)
fi

BLUEPRINT_SRC="$SRC_ROOT/src/ai"
TEMPLATES_SRC="$SRC_ROOT/src/tools"

if [ ! -d "$BLUEPRINT_SRC" ]; then
  echo "Blueprint not found at $BLUEPRINT_SRC" >&2
  exit 1
fi

mkdir -p "$AI_DIR"

cleanup_legacy_files

for item in "$BLUEPRINT_SRC"/*; do
  [ -e "$item" ] || continue
  name=$(basename "$item")
  dest="$AI_DIR/$name"

  case "$name" in
    AGENTS.md)
      cp -f "$item" "$DEST_DIR/"
      ;;
    docs)
      if [ -e "$dest" ]; then
        continue
      fi
      cp -R "$item" "$AI_DIR/"
      ;;
    plans)
      if [ -e "$dest" ]; then
        if [ -f "$item/01-bootstrap.md" ]; then
          cp -f "$item/01-bootstrap.md" "$dest/"
        fi
        if [ -f "$item/02-refresh-context.md" ]; then
          cp -f "$item/02-refresh-context.md" "$dest/"
        fi
        continue
      fi
      cp -R "$item" "$AI_DIR/"
      ;;
    MEMORY.md)
      if [ -e "$dest" ]; then
        continue
      fi
      cp -R "$item" "$AI_DIR/"
      ;;
    *)
      if [ -d "$item" ]; then
        mkdir -p "$dest"
        cp -R "$item"/. "$dest"/
      else
        cp -f "$item" "$AI_DIR/"
      fi
      ;;
  esac
done

if [ -n "$TOOL_NAME" ]; then
  TOOL_SRC="$TEMPLATES_SRC/$TOOL_NAME"
  if [ ! -d "$TOOL_SRC" ]; then
    echo "Template not found for tool: $TOOL_NAME" >&2
    exit 1
  fi
  cp -R "$TOOL_SRC"/. "$DEST_DIR/"
fi
