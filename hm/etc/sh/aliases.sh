# ----------------------------------------------------------------------------
# Aliases
# Common between POSIX shells such as bash and zsh.
# ----------------------------------------------------------------------------

# Only set aliases if FORCE flag is not set and sentinel alias exists.
if [ -z "${FORCE+x}" ] && command -v SH_ALIASES_SOURCED 1> /dev/null; then
    return 0
fi

echo "Setting aliases."

if command -v exa 1> /dev/null; then
  alias ls="exa --icons --color-scale"
  alias la="exa --long --all --icons --color-scale --group --header"
  alias lg="exa --long --all --icons --color-scale --grid --group --header"
fi

alias SH_ALIASES_SOURCED="echo 0"
alias ..="cd .."
alias ...="cd ../.."
alias .2="cd ../.."
alias ....="cd ../../.."
alias .3="cd ../../.."
alias .....="cd ../../../.."
alias .4="cd ../../../.."
alias emc="emacsclient"
alias conda="micromamba"
alias mamba="micromamba"
alias hit='git --git-dir="${HOME}/.git/" --work-tree="${HOME}"'
export SH_ALIASES_SOURCED=1