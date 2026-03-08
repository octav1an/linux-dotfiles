#!/bin/bash
# Setup the minimum required for a fresh headless linux

package_manager () {
    apt install -y "$@"
}

package_manager vim
package_manager fzf
package_manager tree
package_manager bat
package_manager rsync
package_manager tmux

# Setup tmux tpm
TPM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi
