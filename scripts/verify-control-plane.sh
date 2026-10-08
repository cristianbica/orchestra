#!/bin/sh
set -eu

ROOT=${ORCHESTRA_VERIFY_ROOT:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}

fail() { echo "control-plane: $*" >&2; exit 1; }
need() { [ -f "$1" ] || fail "missing required file: $1"; }
has() { grep -F -q -- "$2" "$1" || fail "$1: missing contract text: $2"; }
eq() { [ "$1" = "$2" ] || fail "$3: expected '$2', got '$1'"; }

toml_field() {
  value=$(awk -v key="$2" '
    $0 ~ "^[[:space:]]*" key "[[:space:]]*=" {
      n++; value=$0; sub("^[[:space:]]*" key "[[:space:]]*=[[:space:]]*", "", value)
    }
    END {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", value)
      if (n != 1 || value == "") exit 1
      if (value ~ /^"[^"]*"$/) { sub(/^"/, "", value); sub(/"$/, "", value) }
      print value
    }' "$1") || fail "$1: TOML field '$2' must occur once with a scalar value"
  printf '%s\n' "$value"
}

front_field() {
  value=$(awk -v key="$2" '
    NR == 1 { if ($0 != "---") exit 1; front=1; next }
    front && $0 == "---" { closed=1; front=0; block=0; next }
    front && $0 ~ "^" key ":[[:space:]]*" {
      n++; value=$0; sub("^" key ":[[:space:]]*", "", value)
    }
    END { if (!closed || n != 1 || value == "") exit 1; print value }' "$1") ||
    fail "$1: frontmatter field '$2' must occur once with a scalar value"
  printf '%s\n' "$value"
}

permission_field() {
  value=$(awk -v key="$2" '
    NR == 1 { if ($0 != "---") exit 1; front=1; next }
    front && $0 == "---" { closed=1; front=0; next }
    front && /^permission:[[:space:]]*$/ { p++; block=1; next }
    block && $0 ~ "^  " key ":[[:space:]]*" {
      n++; value=$0; sub("^  " key ":[[:space:]]*", "", value)
    }
    block && /^[^ ]/ { block=0 }
    END {
      if (!closed || p != 1 || n != 1) exit 1
      if (value == "") value="<map>"
      print value
    }' "$1") || fail "$1: permission '$2' must occur once under permission"
  printf '%s\n' "$value"
}

token() {
  compact=$(printf '%s' "$1" | tr -d ' ')
  case ",$compact," in *,"$2",*) : ;; *) fail "$3: missing capability '$2'" ;; esac
}
no_token() {
  compact=$(printf '%s' "$1" | tr -d ' ')
  case ",$compact," in *,"$2",*) fail "$3: forbidden capability '$2'" ;; *) : ;; esac
}

cd "$ROOT"
route=src/ai/agents/guides/routing.md
need "$route"

awk -F '|' '
  function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
  function bad(message) { print "control-plane: routing.md: " message > "/dev/stderr"; exit 1 }
  BEGIN {
    split("direct answer,change,document,investigate,trivial-change,guided,bootstrap,refresh-context,create-overlays,define-playbook,run-playbook", expected, ",")
    terminal["direct answer"]="answered, blocked"; terminal["change"]="complete, blocked, failed"
    terminal["document"]="complete, blocked, promoted"; terminal["investigate"]="reported, blocked, promoted"
    terminal["trivial-change"]="complete, blocked, promoted"; terminal["bootstrap"]="complete, blocked, rolled back"
    terminal["refresh-context"]="complete, blocked, rolled back, promoted"
    terminal["create-overlays"]="complete, blocked, failed"; terminal["define-playbook"]="complete, blocked, failed"
    terminal["run-playbook"]="complete, blocked, failed, rolled back"
  }
  /^\| `/ {
    if (NF != 13) bad("route row at line " NR " must have 11 fields")
    name=trim($2); gsub(/`/, "", name); count++
    if (name != expected[count]) bad("expected route " expected[count] " at row " count ", got " name)
    if (seen[name]++) bad("duplicate route " name)
    for (i=3; i<=12; i++) if (trim($i) == "") bad(name " has an empty field")
    writes=trim($6); plan=trim($7); approval=trim($8); owner=trim($9); validation=trim($10); state=trim($11); gsub(/`/, "", state)
    if (name == "direct answer" && writes != "None.") bad(name " must not allow writes")
    if (name == "change" && (index(writes, ".ai/plans/**") == 0 || index(writes, ".ai/docs/**") == 0 || index(writes, ".ai/MEMORY.md") == 0)) bad(name " is missing owned artifact paths")
    if (name == "document" && (index(writes, ".ai/docs/**") == 0 || index(writes, ".ai/MEMORY.md") == 0)) bad(name " has invalid documentation writes")
    if (name == "investigate" && index(writes, ".ai/plans/**") == 0) bad(name " is missing its report path")
    if (name == "trivial-change" && writes !~ /^Only requested file locations/) bad(name " writes are not request-scoped")
    if (name == "guided" && writes !~ /^Inherited exactly/) bad(name " must inherit writes")
    if (name ~ /^(bootstrap|refresh-context)$/ && writes !~ /^Only paths declared in the approved preview/) bad(name " writes are not preview-scoped")
    if (name == "create-overlays" && index(writes, ".ai/overlays/<slug>.md") == 0) bad(name " has invalid overlay writes")
    if (name == "define-playbook" && index(writes, ".ai/playbooks/**") == 0) bad(name " has invalid playbook writes")
    if (name == "run-playbook" && writes !~ /^Only paths declared by the playbook and enclosing approved scope/) bad(name " writes exceed declared scope")
    if (name ~ /^(direct answer|document|investigate|trivial-change)$/ && plan !~ /^None/) bad(name " must be planless")
    if (name ~ /^(direct answer|document|investigate|trivial-change)$/ && approval !~ /^(None|No route approval)/) bad(name " has an unexpected route approval")
    if (name == "guided" && (plan !~ /^Inherited/ || approval !~ /^Inherited/)) bad("guided must inherit plan and approval")
    if (owner !~ /(Conductor|Builder|Planner|Validator|Inherited|role allowed)/) bad(name " has an unknown execution owner")
    if (validation !~ /(Conductor|Planner|Validator|Inherited)/) bad(name " has an unknown validation owner")
    if (name != "guided" && state != terminal[name]) bad(name " terminal states are invalid: " state)
  }
  END { if (count != 11) bad("expected 11 route rows, found " count) }
' "$route"

has "$route" "selects exactly one executable target row"
has "$route" "guided\` is a wrapper modifier, not a second selected route"
has "$route" "Planner may write \`.ai/plans/**\`; Validator may write \`.ai/docs/**\` and \`.ai/MEMORY.md\`"
has "$route" "invocation approval never substitutes for \`change\` plan approval"

for item in change document investigate trivial-change guided; do
  has "src/ai/workflows/$item.md" ".ai/agents/guides/routing.md"
done
for item in bootstrap refresh-context create-overlays define-playbook run-playbook; do
  has "src/ai/operations/$item.md" ".ai/agents/guides/routing.md"
done

has src/ai/agents/validator.md "For a planless route, accept requested scope plus diff"
has src/ai/agents/validator.md "NEVER implement product/app code"
has src/ai/agents/builder.md "Run every category that applies"
has src/ai/agents/builder.md "one successful category never replaces another applicable category"
has src/ai/agents/forger.md "Forger is additive and opt-in only"
has src/ai/agents/forger.md "NEVER delegate to subagents"
has src/ai/agents/forger.md "create the route-owned plan and STOP until the user explicitly approves"
has src/ai/agents/forger.md "Planner for discovery and plan/report artifact writes"
has src/ai/operations/create-overlays.md "Planner performs read-only discovery"
has src/ai/operations/create-overlays.md "user explicitly approves the plan before implementation"
has src/ai/operations/define-playbook.md "Planner writes a scoped \`change\`-style plan artifact"
has src/ai/operations/define-playbook.md "user explicitly approves the plan before playbook writes"

for item in bootstrap refresh-context; do
  file="src/ai/operations/$item.md"
  has "$file" "Do not inspect historical plans"
  has "$file" "snapshot every existing approved"
  has "$file" "Write a manifest containing the run ID"
  has "$file" "Delete only files and directories recorded as created by this run"
  has "$file" "Stop only processes whose PIDs were recorded as started by this run"
done

play=src/ai/operations/run-playbook.md
for phrase in "transitively declared \`May call\` children" "dependency cycles" "Allowed roles" "all required inputs" "invocation mode and step approvals" "declared side effects" "Cleanup and failure" "Terminal contract"; do
  has "$play" "$phrase"
done
has "$play" "Invocation approval, risk approval, and \`change\` plan approval are distinct"
has src/ai/playbooks/README.md "recursively preflights the complete declared graph"
has src/ai/templates/playbook.template.md "Allowed terminal states"
has src/ai/templates/playbook.template.md "Status: \`<draft | provisional | verified | deprecated>\`"

stale=0
for phrase in "Phrase matching should be case-insensitive substring match." "Bootstrap and refresh context skip intake." "Run in priority order (stop when one succeeds)" "Change is documented in the commit/PR description" "Hard gate: do not implement unless the plan is explicitly approved." "Hard gate: do not implement non-trivial changes without an explicitly approved plan." "Only implements an explicitly approved plan." "non-trivial implementation requires an approved plan."; do
  if grep -R -F -q -- "$phrase" src/ai/agents src/ai/workflows src/ai/operations src/tools; then
    echo "control-plane: forbidden stale contract text found: $phrase" >&2
    grep -R -F -n -- "$phrase" src/ai/agents src/ai/workflows src/ai/operations src/tools >&2
    stale=1
  fi
done
[ "$stale" -eq 0 ] || fail "remove the stale generic plan-gate text above"

for spec in "conductor:read-only:gpt-5.6-luna:xhigh" "planner:workspace-write:gpt-5.6-sol:high" "builder:workspace-write:gpt-5.6-terra:xhigh" "validator:workspace-write:gpt-5.6-sol:high" "forger:workspace-write:gpt-5.6-sol:high"; do
  oldifs=$IFS; IFS=:; set -- $spec; IFS=$oldifs
  file="src/tools/codex/.codex/agents/$1.toml"
  eq "$(toml_field "$file" name)" "$1" "$file name"
  eq "$(toml_field "$file" sandbox_mode)" "$2" "$file sandbox_mode"
  eq "$(toml_field "$file" model)" "$3" "$file model"
  eq "$(toml_field "$file" model_reasoning_effort)" "$4" "$file model reasoning"
done
for role in conductor planner builder validator forger; do
  source="src/tools/codex/.codex/agents/$role.toml"
  mirror=".codex/agents/$role.toml"
  need "$mirror"
  cmp -s "$source" "$mirror" || fail "Codex agent mirror differs from source: $role"
done
eq "$(toml_field src/tools/codex/.codex/config.toml max_threads)" 1 "Codex max_threads"
eq "$(toml_field src/tools/codex/.codex/config.toml max_depth)" 1 "Codex max_depth"
has src/tools/codex/.codex/AGENTS.md "only user-facing roles"
has src/tools/codex/.codex/AGENTS.md "at most one subagent at a time"
has src/tools/codex/.codex/AGENTS.md "explicit approval"

for spec in "conductor:claude-sonnet-5:medium" "planner:claude-fable-5:high" "builder:claude-sonnet-5:high" "validator:claude-opus-4-8:high" "forger:claude-fable-5:xhigh"; do
  oldifs=$IFS; IFS=:; set -- $spec; IFS=$oldifs
  file="src/tools/claude-code/.claude/agents/$1.md"
  eq "$(front_field "$file" name)" "$1" "$file name"
  eq "$(front_field "$file" model)" "$2" "$file model"
  eq "$(front_field "$file" effort)" "$3" "$file effort"
  tools=$(front_field "$file" tools)
  case "$1" in conductor) token "$tools" Agent "$file tools" ;; builder|validator) token "$tools" Edit "$file tools"; token "$tools" Write "$file tools" ;; forger) no_token "$tools" Agent "$file tools" ;; esac
done

for role in conductor planner builder validator forger; do
  file="src/tools/copilot/.github/agents/$role.agent.md"
  case "$role" in conductor|forger) invocable=true ;; *) invocable=false ;; esac
  eq "$(front_field "$file" user-invocable)" "$invocable" "$file user-invocable"
  disabled=false; [ "$role" = forger ] && disabled=true
  eq "$(front_field "$file" disable-model-invocation)" "$disabled" "$file disable-model-invocation"
  tools=$(front_field "$file" tools)
  case "$role" in conductor) token "$tools" "'agent'" "$file tools" ;; *) no_token "$tools" "'agent'" "$file tools" ;; esac
done
has src/tools/copilot/.github/copilot-instructions.md "only user-facing roles"
has src/tools/copilot/.github/copilot-instructions.md "at most one subagent at a time"
has src/tools/copilot/.github/copilot-instructions.md "explicit approval"

for spec in "conductor:all:deny:ask" "planner:subagent:deny:ask" "builder:subagent:ask:ask" "validator:subagent:<map>:ask" "forger:primary:ask:ask"; do
  oldifs=$IFS; IFS=:; set -- $spec; IFS=$oldifs
  file="src/tools/opencode/.opencode/agents/$1.md"
  eq "$(front_field "$file" mode)" "$2" "$file mode"
  eq "$(permission_field "$file" edit)" "$3" "$file edit permission"
  eq "$(permission_field "$file" bash)" "$4" "$file bash permission"
done
for role in planner builder validator forger; do
  eq "$(permission_field "src/tools/opencode/.opencode/agents/$role.md" task)" deny "OpenCode $role task permission"
done
has src/tools/opencode/.opencode/agents/validator.md '    ".ai/docs/**": ask'
has src/tools/opencode/.opencode/agents/validator.md '    ".ai/MEMORY.md": ask'
has src/tools/opencode/.opencode/AGENTS.md "only user-facing roles"
has src/tools/opencode/.opencode/AGENTS.md "at most one subagent at a time"
has src/tools/opencode/.opencode/AGENTS.md "explicit approval"

for file in src/tools/claude-code/.claude/CLAUDE.md src/tools/copilot/.github/copilot-instructions.md src/tools/opencode/.opencode/AGENTS.md; do
  has "$file" "plan-required change"
  has "$file" "inline or \`.ai/plans/**\` plan artifact"
done

echo "control-plane: ok"
