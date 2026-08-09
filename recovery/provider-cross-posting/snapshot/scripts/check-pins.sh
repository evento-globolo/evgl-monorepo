#!/usr/bin/env bash
set -euo pipefail

allow_uninitialized=false
if [[ "${1:-}" == "--allow-uninitialized" ]]; then
  allow_uninitialized=true
elif [[ $# -gt 0 ]]; then
  echo "usage: $0 [--allow-uninitialized]" >&2
  exit 64
fi

status="$(git submodule status --recursive || true)"

if grep -qE '^\+|^U' <<<"$status"; then
  printf '%s\n' "$status" >&2
  echo "One or more submodules differ from the recorded system composition." >&2
  exit 1
fi

if grep -q '^-' <<<"$status"; then
  if [[ "$allow_uninitialized" != true ]]; then
    printf '%s\n' "$status" >&2
    echo "Submodules are not initialized. Run: git submodule update --init --recursive" >&2
    exit 1
  fi

  # The gitlinks themselves are still authoritative in an offline/bootstrap
  # checkout. Ensure every declared submodule path exists as a gitlink in HEAD.
  while IFS= read -r path; do
    mode="$(git ls-tree HEAD -- "$path" | awk '{print $1}')"
    if [[ "$mode" != "160000" ]]; then
      echo "Declared submodule is not recorded as a gitlink: $path" >&2
      exit 1
    fi
  done < <(git config --file .gitmodules --get-regexp '^submodule\..*\.path$' | awk '{print $2}')

  echo "All declared submodules are pinned as gitlinks; initialization was intentionally skipped."
  exit 0
fi

echo "All initialized submodules match the recorded composition."
