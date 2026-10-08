#!/bin/sh
set -eu

TOOL_NAME=${1-}
DEST_DIR=$PWD
AI_DIR="$DEST_DIR/.ai"
REF=${REF-master}

if [ "$TOOL_NAME" = "vscode-copilot" ]; then
  TOOL_NAME="copilot"
fi

remove_if_exists() {
  target=$1
  if [ -e "$target" ]; then
    rm -f "$target"
  fi
}

remove_file_blocking_template_dirs() {
  src=$1
  dest_root=$2

  for item in "$src"/.[!.]* "$src"/..?* "$src"/*; do
    [ -e "$item" ] || continue
    [ -d "$item" ] || continue
    name=$(basename "$item")
    dest="$dest_root/$name"
    if [ -e "$dest" ] && [ ! -d "$dest" ]; then
      rm -f "$dest"
    fi
  done
}

copy_if_missing() {
  file_src=$1
  file_dest=$2

  if [ -e "$file_dest" ]; then
    return
  fi
  mkdir -p "$(dirname "$file_dest")"
  cp -f "$file_src" "$file_dest"
}

install_template_dir() {
  dir_src=$1
  dir_dest=$2

  (cd "$dir_src" && find . -type d -print) | while IFS= read -r rel; do
    [ "$rel" = "." ] && continue
    target="$dir_dest/${rel#./}"
    if [ -e "$target" ] && [ ! -d "$target" ]; then
      rm -f "$target"
    fi
    mkdir -p "$target"
  done

  (cd "$dir_src" && find . ! -type d -print) | while IFS= read -r rel; do
    copy_if_missing "$dir_src/${rel#./}" "$dir_dest/${rel#./}"
  done
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
  remove_if_exists "$AI_DIR/workflows/define-playbook.md"
  remove_if_exists "$AI_DIR/workflows/run-playbook.md"

  remove_if_exists "$AI_DIR/plans/01-bootstrap.md"
  remove_if_exists "$AI_DIR/plans/02-refresh-context.md"
  remove_if_exists "$AI_DIR/plans/03-create-overlays.md"

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

cleanup_codex_markdown_agents() {
  remove_if_exists "$DEST_DIR/.codex/agents/builder.md"
  remove_if_exists "$DEST_DIR/.codex/agents/conductor.md"
  remove_if_exists "$DEST_DIR/.codex/agents/forger.md"
  remove_if_exists "$DEST_DIR/.codex/agents/planner.md"
  remove_if_exists "$DEST_DIR/.codex/agents/validator.md"
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
  curl -fsSL "https://github.com/cristianbica/orchestra/archive/refs/heads/$REF.zip" \
    -o "$TMP_DIR/archive.zip"
  unzip -q "$TMP_DIR/archive.zip" -d "$TMP_DIR"
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
        continue
      fi
      cp -R "$item" "$AI_DIR/"
      ;;
    playbooks)
      if [ -e "$dest" ]; then
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
    RULES.md)
      if [ -e "$dest" ]; then
        continue
      fi
      cp -f "$item" "$AI_DIR/"
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
  if [ "$TOOL_NAME" = "codex" ]; then
    cleanup_codex_markdown_agents
  fi
  remove_file_blocking_template_dirs "$TOOL_SRC" "$DEST_DIR"
  if [ "${FORCE+x}" = "x" ]; then
    cp -R "$TOOL_SRC"/. "$DEST_DIR/"
  else
    install_template_dir "$TOOL_SRC" "$DEST_DIR"
  fi
fi
