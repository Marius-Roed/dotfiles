#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config_backup"
SIMULATE=false

# --- Argument parsing ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--no|--simulate)
      SIMULATE=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [-n|--no|--simulate]"
      exit 1
      ;;
  esac
done

# --- Helpers ---
log()  { echo "$*"; }
info() { echo "  → $*"; }
warn() { echo "  ⚠ $*"; }

run() {
  if $SIMULATE; then
    echo "  [simulate] $*"
  else
    "$@"
  fi
}

is_stow_managed() {
  local dir="$1"
  [[ ! -d "$dir" ]] && return 1
  while IFS= read -r -d '' link; do
    if [[ "$(readlink "$link")" == *"$DOTFILES_DIR"* ]]; then
      return 0
    fi
  done < <(find "$dir" -maxdepth 1 -type l -print0)
  return 1
}

# --- Remove .DS_Store files ---
log "Cleaning .DS_Store files..."
if $SIMULATE; then
  find "$DOTFILES_DIR" -name ".DS_Store" | sed 's/^/  [simulate] rm /'
else
  find "$DOTFILES_DIR" -name ".DS_Store" -delete
fi

# --- Detect OS ---
if [[ "$(uname)" == "Darwin" ]]; then
  log "Detected macOS"
  PACKAGE_DIRS=("$DOTFILES_DIR/Shared" "$DOTFILES_DIR/Mac")
else
  log "Detected Linux"
  PACKAGE_DIRS=("$DOTFILES_DIR/Shared" "$DOTFILES_DIR/Linux")
fi

# --- Main ---
if $SIMULATE; then
  log "Running in SIMULATE mode — no changes will be made"
fi

for dir in "${PACKAGE_DIRS[@]}"; do
  log ""
  log "Stowing from $dir"

  for package in "$dir"/*/; do
    name=$(basename "$package")

    if [[ "$name" == "archive" ]]; then
      info "skipping $name"
      continue
    fi

    target_config="$HOME/.config/$name"

    if [[ -d "$target_config" ]] && ! is_stow_managed "$target_config"; then
      warn "$target_config already exists, backing up → $BACKUP_DIR/$name"
      run mkdir -p "$BACKUP_DIR"
      run mv "$target_config" "$BACKUP_DIR"
    fi

    run mkdir -p "$target_config"

    info "stowing $name"

    if $SIMULATE; then
      stow -nv --target="$target_config" --dir="$dir" "$name" 2>&1 | sed 's/^/     /'
    else
      stow --target="$target_config" --dir="$dir" "$name"
    fi
  done
done

log ""
log "Done!"
