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
git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"
