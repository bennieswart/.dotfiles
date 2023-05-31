#
# Configure history behaviour.
#

# Store command history in the home directory similar to .bash_history.
# Not here, since it is not part of the config.
HISTFILE=~/.zsh_history

# Large history size to remember everything.
HISTSIZE=10000000
SAVEHIST=10000000

# How duplicate commands should be handled.
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Don't add commands starting with a space to the history.
setopt HIST_IGNORE_SPACE
