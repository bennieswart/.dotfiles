#
# Configure vim-like behaviour.
#

# Start the command line editor in viins (vim insert) mode by default.
bindkey -v

# Add text objects for quotes and brackets for vim-like da" or cs(.
autoload -U select-quoted select-bracketed
zle -N select-quoted
zle -N select-bracketed
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $m $c select-bracketed
    done
done

# Add vim-surround behaviour.
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround
