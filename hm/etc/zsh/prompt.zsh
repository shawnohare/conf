autoload -Uz vcs_info
# autoload -U colors && colors
setopt PROMPT_SUBST
# setopt TRANSIENT_RPROMPT

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git:*' formats "%F{magenta}git%f:%%F{magenta}%b%f%u%c"
zstyle ':vcs_info:git:*' formats "%F{magenta}git%f:%b%u%c"
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}✴%f'

precmd() {
  vcs_info
}

function python_venv() {
    local out=""
    if [ ! -z "${VIRTUAL_ENV}" ]; then
        out="%F{green}pyenv%f:$(basename ${VIRTUAL_ENV} 2> /dev/null) "
    fi
    if [ ! -z "${CONDA_DEFAULT_ENV}" ]; then
        out="${out}%F{green}conda%f: ${CONDA_DEFAULT_ENV} 2> /dev/null)"
    fi
    echo "${out}"
}


# The %{...%} delimiters tells zsh the text has zero width. Since v 4.3 it's
# probably better to use the %F{color}...%f syntax.
user="%F{green}%B%n%b%f"
machine="%m"
dir="%F{blue}%B%4~%f%b"
date="%F{cyan}%D{%Y-%m-%dT%T}%f"
indicator="❯"
indicator="$"
PROMPT='
${user}@${machine} ${dir} ${date} ${vcs_info_msg_0_} $(python_venv)
%(?.%F{blue}.%F{red})${indicator}%f '
