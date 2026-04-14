#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_NAME="$(basename "$REPO_ROOT")"
VAULT_DIR="$HOME/Dev/ryven-brain/projects/$PROJECT_NAME/docs"
LINK_PATH="$REPO_ROOT/docs/project-context"

if [ ! -d "$HOME/Dev/ryven-brain" ]; then
  echo "error: ~/Dev/ryven-brain not found" >&2
  exit 1
fi

mkdir -p "$VAULT_DIR"
mkdir -p "$REPO_ROOT/docs"

if [ -L "$LINK_PATH" ]; then
  current="$(readlink "$LINK_PATH")"
  if [ "$current" = "$VAULT_DIR" ]; then
    echo "ok: $LINK_PATH already linked to $VAULT_DIR"
    exit 0
  fi
  echo "error: $LINK_PATH is a symlink to $current — remove it manually" >&2
  exit 1
fi

if [ -e "$LINK_PATH" ]; then
  echo "error: $LINK_PATH exists and is not a symlink — remove it manually" >&2
  exit 1
fi

ln -s "$VAULT_DIR" "$LINK_PATH"
echo "linked: $LINK_PATH -> $VAULT_DIR"
