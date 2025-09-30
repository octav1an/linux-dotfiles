#!/bin/bash
set -eu

CONFIG_DIR=$HOME/.config
DOTFILES_DIR=$HOME/linux-dotfiles


make_symlinks() {
  base_dotfiles_path=$1
  shift
  arr=("$@")

  for config in "${arr[@]}"
  do
    if [ -e "${CONFIG_DIR:?}/${config:?}" ]; then
        echo "removing existing config for '$config'"
        rm -rf "${CONFIG_DIR:?}/${config:?}"
    fi

    config_path="$base_dotfiles_path/${config}"

    # Check if the file exists
    if [ ! -e "$config_path" ]; then
      echo "error: '$config_path' dotfile doesn't exit. Exiting..."
      exit 1
    fi

    echo "updating '$config'"
    ln -s "$config_path" "$CONFIG_DIR/${config}"
  done
}

# OS specific configs 
os_specific_configs=()
make_symlinks "$DOTFILES_DIR/config" "${os_specific_configs[@]}"

# Configs from home
TARGET_RC=$HOME/.bashrc
SOURCE_RC=$DOTFILES_DIR/.bashrc
if [ -e "$TARGET_RC" ]; then
  echo "removing existing config: $TARGET_RC"
  rm -f -- "${TARGET_RC:?}"
fi
echo "linking $SOURCE_RC -> $TARGET_RC"
ln -s -- "$SOURCE_RC" "$TARGET_RC"
