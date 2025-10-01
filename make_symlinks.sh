#!/bin/bash
set -eu

# Makes a symlink from the source to the target if it doesn't exit
# Usage:
#   make_symlink <source> <target>
# Arguments:
#   source    Source file or dir
#   target    Target file or dir
make_symlink() {
  local source_item=$1
  local target_item=$2

  if [ "$(readlink "$target_item" 2>/dev/null)" = "$source_item" ]; then
    echo "$target_item already linked correctly"
    return 0
  fi

  # Remove any exiting file before linking, -L will catch broken links that -e doesn't
  if [ -e "$target_item" ] || [ -L "$target_item" ]; then
    echo "removing existing config: $target_item"
    rm -rf -- "${target_item:?}"
  fi

  echo "linking $source_item -> $target_item"
  ln -s -- "$source_item" "$target_item"
}

DOTFILES_DIR=$HOME/.dotfiles

# Config mapping  "source relative path-->target absolute path"
configs=( 
  ".bashrc-->$HOME/.bashrc"
)

for pair in "${configs[@]}"
do
  source_path=$DOTFILES_DIR/${pair%%-->*}
  target_path=${pair##*-->}
  make_symlink "$source_path" "$target_path"
done

echo "✅ Symlinks updated successfully."
