#!/usr/bin/env bash
set -euo pipefail

# Bootstrap the public GitHub organization for the Semantic Mesh initiative.
# Default: creates and configures two repositories:
#   semantic-mesh/.github
#   semantic-mesh/semantic-mesh
# Optional: pass --with-spec to also create semantic-mesh/domain-contract.
#
# The script intentionally does not add a single repository-wide license to the
# main project because the recommended model is mixed licensing:
# documentation under CC BY 4.0, software/schemas under Apache-2.0.

ORG="${ORG:-semantic-mesh}"
CORE_REPO="${CORE_REPO:-semantic-mesh}"
SPEC_REPO="${SPEC_REPO:-domain-contract}"
CREATE_SPEC=false
ASSUME_YES=false

usage() {
  cat <<USAGE
Usage: $0 [--with-spec] [--yes]

Options:
  --with-spec  Also create and configure ${ORG}/${SPEC_REPO}.
  --yes        Skip the interactive confirmation.
  -h, --help   Show this help.

Environment overrides:
  ORG          GitHub organization (default: semantic-mesh)
  CORE_REPO    Canonical project/site repository (default: semantic-mesh)
  SPEC_REPO    Domain Contract specification repository (default: domain-contract)
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --with-spec)
      CREATE_SPEC=true
      shift
      ;;
    --yes)
      ASSUME_YES=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) is not installed." >&2
  echo "On macOS: brew install gh" >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub CLI is not authenticated." >&2
  echo "Run: gh auth login --web --git-protocol ssh" >&2
  exit 1
fi

if [[ "$ASSUME_YES" != true ]]; then
  echo "This will create PUBLIC repositories in the GitHub organization '${ORG}'"
  echo "and change their repository settings and main-branch protection."
  if [[ "$CREATE_SPEC" == true ]]; then
    echo "Repositories: .github, ${CORE_REPO}, ${SPEC_REPO}"
  else
    echo "Repositories: .github, ${CORE_REPO}"
  fi
  read -r -p "Type 'create' to continue: " answer
  if [[ "$answer" != "create" ]]; then
    echo "Aborted."
    exit 0
  fi
fi

repo_exists() {
  gh repo view "${ORG}/$1" >/dev/null 2>&1
}

create_repo_if_missing() {
  local repo="$1"
  local description="$2"
  local homepage="${3:-}"

  if repo_exists "$repo"; then
    echo "Repository already exists: ${ORG}/${repo}"
    return 0
  fi

  local args=(repo create "${ORG}/${repo}" --public --description "$description" --add-readme)
  if [[ -n "$homepage" ]]; then
    args+=(--homepage "$homepage")
  fi

  echo "Creating ${ORG}/${repo} ..."
  gh "${args[@]}"
}

configure_repo() {
  local repo="$1"
  local homepage="${2:-}"

  echo "Configuring ${ORG}/${repo} ..."
  local args=(
    repo edit "${ORG}/${repo}"
    --enable-issues
    --enable-wiki=false
    --enable-projects=false
    --allow-update-branch
    --delete-branch-on-merge
    --enable-squash-merge
    --enable-merge-commit=false
    --enable-rebase-merge=false
  )

  if [[ -n "$homepage" ]]; then
    args+=(--homepage "$homepage")
  fi

  gh "${args[@]}"
}

configure_core_repo() {
  local repo="$1"
  configure_repo "$repo" "https://semanticmesh.io"

  gh repo edit "${ORG}/${repo}" \
    --enable-discussions \
    --add-topic semantic-mesh \
    --add-topic domain-contracts \
    --add-topic domain-driven-design \
    --add-topic data-mesh \
    --add-topic knowledge-graphs \
    --add-topic ai-agents
}

protect_main() {
  local repo="$1"

  echo "Protecting ${ORG}/${repo}:main ..."
  gh api --method PUT \
    -H "Accept: application/vnd.github+json" \
    "repos/${ORG}/${repo}/branches/main/protection" \
    --input - <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": false,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 0
  },
  "restrictions": null,
  "required_linear_history": true,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": true
}
JSON
}

create_repo_if_missing ".github" \
  "Organization profile and shared community health files for Semantic Mesh."
create_repo_if_missing "$CORE_REPO" \
  "Open, domain-driven approach for modular, machine-readable Domain Contracts." \
  "https://semanticmesh.io"

configure_repo ".github"
configure_core_repo "$CORE_REPO"
protect_main ".github"
protect_main "$CORE_REPO"

if [[ "$CREATE_SPEC" == true ]]; then
  create_repo_if_missing "$SPEC_REPO" \
    "Draft specification, semantic profiles, schemas, examples and conformance tests for Domain Contracts."
  configure_repo "$SPEC_REPO"
  gh repo edit "${ORG}/${SPEC_REPO}" \
    --enable-discussions \
    --add-topic domain-contracts \
    --add-topic semantic-web \
    --add-topic json-ld \
    --add-topic shacl \
    --add-topic open-standard
  protect_main "$SPEC_REPO"
fi

cat <<DONE

Bootstrap complete.

Next steps:
  1. Add profile/README.md and shared community files to ${ORG}/.github.
  2. Add explicit license files to every repository; licenses are not inherited.
  3. Add the website, whitepaper, principles, RFC process and examples to ${ORG}/${CORE_REPO}.
  4. After a second maintainer joins, require at least one approving review on main.
  5. Require 2FA for organization members in the GitHub organization settings.
DONE
