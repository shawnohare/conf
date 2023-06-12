# zshrc is sourced by interactive shells.
# /etc/zprofile and ~/.zprofile are sourced before.

# source "${HOME}/.profile"
# source "${XDG_CONFIG_HOME}/sh/aliases.sh"
# source "${XDG_CONFIG_HOME}/sh/path.sh"
source "${XDG_CONFIG_HOME}/sh/rc.sh"

HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=2048                    # lines to maintain in memory
SAVEHIST=100000                  # lines to maintain in history file

# setopt hist_ignore_all_dups      # no duplicate
# setopt inc_append_history_time   # add commands as they are typed,
setopt autocd
setopt always_to_end
setopt bang_hist                 # !keyword
setopt complete_in_word
setopt completealiases
setopt correct
setopt extended_history          # include timestamps
setopt extendedglob
setopt hash_list_all
setopt hist_reduce_blanks        # trim blanks
setopt hist_verify               # show before executing history commands
setopt list_ambiguous
setopt nomatch
setopt notify
setopt share_history             # share hist between sessions
setopt INTERACTIVE_COMMENTS
unsetopt hist_ignore_space       # ignore space prefixed commands

# NOTE: iterm shell integration messes with the prompt and causes
# emacs tramp mode to hang indefinitely.
# if [[ $TERM == "dumb" ]]; then
#   unsetopt zle
#   unsetopt prompt_cr
#   unsetopt prompt_subst
#   unfunction precmd
#   unfunction preexec
#   PS1='$ '
#   return
# fi

# ----------------------------------------------------------------------------
# Completions
# ----------------------------------------------------------------------------
# source "${PYENV_ROOT}/completions/pyenv.zsh"
fpath=(${ZSH_PKG_HOME}/zsh/completions  ${ZSH_PKG_HOME}/zsh-completions $fpath)
fpath+=${ZSH_PKG_HOME}/conda-zsh-completions
autoload -U compinit && compinit

# ----------------------------------------------------------------------------
bindkey -v
autoload -U chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
autoload -U zmv

zmodload -i zsh/complist
compdef _gnu_generic gcc
compdef _gnu_generic gdb

# ----------------------------------------------------------------------------
# help
# ----------------------------------------------------------------------------
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-nix
autoload -Uz run-help-svn
autoload -Uz run-help-svk
unalias run-help &> /dev/null
# alias help=run-help


# ----------------------------------------------------------------------------
# shell hooks
# ----------------------------------------------------------------------------
eval "$(micromamba shell hook --shell=zsh)" 2&> /dev/null
eval "$(starship init zsh)" 2&> /dev/null
eval "$(zoxide init zsh)" 2&> /dev/null
eval "$(rbenv init -)" 2&> /dev/null


source "${ZDOTDIR}/plugins.zsh"
export ZSHRC_SOURCED=1
