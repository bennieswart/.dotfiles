# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Include plugins.
source $ZDOTDIR/plugins/dotfiles.zsh
source $ZDOTDIR/plugins/history.zsh
source $ZDOTDIR/plugins/vimlike.zsh
source $ZDOTDIR/plugins/autosuggestions/init.zsh
source $ZDOTDIR/plugins/syntax-highlighting/init.zsh




# Display help about zsh builtins using bash-like help command.
unalias run-help 2>/dev/null
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

# Edit the command line in an editor by pressing v in normal mode.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Custom aliases.
alias vim="nvim"












# The following lines were added by compinstall
zstyle :compinstall filename '/home/staple/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
_comp_options+=(globdots)

source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f $ZDOTDIR/.p10k.zsh ]] || source $ZDOTDIR/.p10k.zsh




