#!/bin/bash
set -eu

CONFIG_DIR=~/.config
DOTFILES_DIR=~/linux-dotfiles


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
CONFIG_DIR=$DOTFILE_DIR/config
os_specific_configs=()
make_symlinks "$CONFIG_DIR" "${os_specific_configs[@]}"

# Configs from home
BASHRC=".bashrc"
if [ -f "~/$BASHRC" ]; then
  echo "removing existing config for '$BASHRC'"
  rm -r ~/$BASHRC
fi
echo "updating '.bashrc'"
ln -s $DOTFILE_DIR/.bashrc ~/$BASHRC
