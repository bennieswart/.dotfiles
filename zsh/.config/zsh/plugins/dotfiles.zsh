#
# Automatic update of dotfiles.
#

UPDATE_DOTFILES_PATH="${0:a:h}"
UPDATE_DOTFILES_IGNORE_FILE="${0:a:h}/.update_dotfiles_ignore"
UPDATE_DOTFILES_FETCHING_ICONS=(┤ ┘ ┴ └ ├ ┌ ┬ ┐)
UPDATE_DOTFILES_FETCHING_ICON_IDX=0

UPDATE_DOTFILES_STATUS=fetching
UPDATE_DOTFILES_SEGMENT=''

function prompt_update_dotfiles() {
    p10k segment -e -f 208 -t '${UPDATE_DOTFILES_SEGMENT}'
}

function update_dotfiles_refresh_segment() {
    if [[ $UPDATE_DOTFILES_STATUS == fetching ]]; then
        local icon="${UPDATE_DOTFILES_FETCHING_ICONS[$(($UPDATE_DOTFILES_FETCHING_ICON_IDX+1))]}"
        UPDATE_DOTFILES_SEGMENT="$icon"
    elif [[ $UPDATE_DOTFILES_STATUS == failed ]]; then
        UPDATE_DOTFILES_SEGMENT="dotfiles update failed"
    elif [[ $UPDATE_DOTFILES_STATUS == ok ]]; then
        UPDATE_DOTFILES_SEGMENT=''
    else
        UPDATE_DOTFILES_SEGMENT='unknown dotfile status'
    fi

    zle reset-prompt
}

function update_dotfiles() {
    if [[ ! -f $UPDATE_DOTFILES_IGNORE_FILE ]]; then
        cd $UPDATE_DOTFILES_PATH && git pull
    fi
}

function update_dotfiles_tick() {
    local num_icons=${#UPDATE_DOTFILES_FETCHING_ICONS[@]}
    UPDATE_DOTFILES_FETCHING_ICON_IDX=$((($UPDATE_DOTFILES_FETCHING_ICON_IDX+1) % $num_icons))
    update_dotfiles_refresh_segment

    # Schedule next tick.
    if ! async_job update_dotfiles_tick sleep 0.5 &>/dev/null; then
        # Restart the async job if it died for whatever reason.
        update_dotfiles_start_ticker
    fi
}

function update_dotfiles_complete() {
    async_stop_worker update_dotfiles_tick
    async_stop_worker update_dotfiles_worker

    if [[ $2 -eq 0 ]]; then
        UPDATE_DOTFILES_STATUS=ok
    else
        UPDATE_DOTFILES_STATUS=failed
    fi
    update_dotfiles_refresh_segment
}

function update_dotfiles_start_ticker() {
    async_start_worker update_dotfiles_tick -n
    async_register_callback update_dotfiles_tick update_dotfiles_tick
    async_job update_dotfiles_tick sleep 0.5
}

source $ZDOTDIR/plugins/async/init.zsh
async_init

async_start_worker update_dotfiles_worker -n
async_register_callback update_dotfiles_worker update_dotfiles_complete
async_job update_dotfiles_worker update_dotfiles

update_dotfiles_start_ticker
