CASE_SENSITIVE="true"
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

export EDITOR='nvim'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Make Ctrl+S do nothing
stty -ixon
bindkey -r "^S"

source $HOME/.zsh_aliases

export PATH="$PATH:$HOME/scripts"

# source ~/repos/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# bindkey -M menuselect '\r' .accept-line
# zstyle ':autocomplete:*:*' list-lines 5
# zstyle ':autocomplete:*:*' list-lines 5
# zstyle '*:compinit' arguments -D -i -u -C -w
# zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
# zstyle ':autocomplete:*history*:*' insert-unambiguous yes
# zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
# zstyle ':autocomplete:history-search-backward:*' list-lines 10

source ~/repos/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Prompt
alias _check_git_repo="git rev-parse --git-dir > /dev/null 2>&1"
export _IN_GIT_REPO=
_set_in_git_repo_hook() {
    _check_git_repo
    export _IN_GIT_REPO=$?
};
typeset -a -g chpwd_functions
chpwd_functions=(_set_in_git_repo_hook $chpwd_functions);

export _GIT_STATUS=

if [[ -d "$HOME/gitstatus" ]]; then
    source ~/gitstatus/gitstatus.plugin.zsh
    gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

    function _set_git_status_hook() {
        if [[ -z "$_IN_GIT_REPO" ]]; then
            _set_in_git_repo_hook
        fi

        if [[ _IN_GIT_REPO -ne 0 ]]; then
            export _GIT_STATUS=
            return
        fi

        if ! gitstatus_query MY || [[ $VCS_STATUS_RESULT != ok-sync ]]; then
            return
        fi

        local out=""
        if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
            out+=" %B%F$VCS_STATUS_LOCAL_BRANCH%b%f"
        else
            out+=" %B%F${VCS_STATUS_COMMIT:0:7}%b%f"
        fi
        (( VCS_STATUS_COMMITS_BEHIND )) && out+=" %F{green}⇣${VCS_STATUS_COMMITS_BEHIND}%f"
        (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && out+=" "
        (( VCS_STATUS_COMMITS_AHEAD  )) && out+="%F{green}⇡${VCS_STATUS_COMMITS_AHEAD}%f"

        (( VCS_STATUS_NUM_STAGED    )) && out+=" %F{green}+${VCS_STATUS_NUM_STAGED}%f"
        (( VCS_STATUS_NUM_UNSTAGED  )) && out+=" %F{yellow}!${VCS_STATUS_NUM_UNSTAGED}%f"
        (( VCS_STATUS_NUM_UNTRACKED )) && out+=" %F{blue}?${VCS_STATUS_NUM_UNTRACKED}%f"
        (( VCS_STATUS_NUM_CONFLICED )) && out+=" %F{red}!${VCS_STATUS_NUM_CONFLICED}%f"

        export _GIT_STATUS="$out"
    }
else
    function _set_git_status_hook() {}
fi

typeset -a precmd_functions
precmd_functions+=(_set_git_status_hook);

setopt PROMPT_SUBST
local _exit_code_status='%(?.%F{magenta}→%f.%B%F{red}→%b%f)'
local _path_formatted='%F{blue}%B%~%b%f'
export PROMPT='$_path_formatted% $_GIT_STATUS%f $_exit_code_status '
printf '\e]12;#cba6f7\007'

# export LS_COLORS=${LS_COLORS/ow=34;42/ow=1;34}
# export LS_COLORS=${LS_COLORS/tw=30;42/tw=1;34}
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Leaves output of `less` on screen after exiting
export LESS="-Xr"

# pip may install packages to this directory
# if [ -d "$HOME/.local/bin" ] ; then
#     PATH="$PATH:$HOME/.local/bin"
# fi

# Add go install path to $PATH
if command -v go &> /dev/null; then
    # Quick:
    PATH="$PATH:$HOME/go/bin"
    # Safe: (Use this running binaries installed via go doesn't work. In that
    # case you might want to update the hard-coded value above)
    # PATH="$PATH:$(go env GOPATH)/bin"
fi

export PATH="$HOME/.cargo/bin:$HOME/.local/bin:/opt:$PATH"

# fuck
eval $(thefuck --alias)

# # pnpm
# export PNPM_HOME="/home/mathis/.local/share/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# # pnpm end

# pfetch with kitties (https://github.com/andreasgrafen/pfetch-with-kitties)
export PF_ASCII="Catppuccin"
export PF_ALIGN="20"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH=$PATH:/home/pth/.spicetify

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

[ -f "/home/pth/.ghcup/env" ] && source "/home/pth/.ghcup/env" # ghcup-env
# source ~/powerlevel10k/powerlevel10k.zsh-theme
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
