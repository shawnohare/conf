# ---------------------------------------------------------------------------
# Load plugins.
# We have some basic custom logic for managing plugins. Basic profiling
# suggests its only about 100-200ms faster loading than zplug.
# ---------------------------------------------------------------------------
if [[ -n "${ZSH_PLUGINS_SOURCED+x}" ]]; then
    return 0
fi

echo "Loading zsh plugins."
function pack() {
    local repo=$1
    # Get everything after last slash.
    local pkg="${ZSH_PKG_HOME}/${1##*/}"
    if [[ ! -e "${pkg}" ]]; then
        git clone --recursive --depth 1 "https://github.com/${repo}" "${pkg}"
    fi
    source "${pkg}/$2"
}

# pack "junegunn/fzf"                           "shell/completion.zsh"
# pack "junegunn/fzf"                           "shell/key-bindings.zsh"
pack "zsh-users/zsh-autosuggestions"          "zsh-autosuggestions.zsh"
pack "hlissner/zsh-autopair"                  "autopair.zsh"
pack "zsh-users/zsh-syntax-highlighting"      "zsh-syntax-highlighting.zsh"
pack "zsh-users/zsh-history-substring-search" "zsh-history-substring-search.zsh"
# pack "esc/conda-zsh-completion"               "conda-zsh-completion.plugin.zsh"
pack "spwhitt/nix-zsh-completions"            "nix-zsh-completions.plugin.zsh"
pack "zsh-users/zsh-completions"              "zsh-completions.plugin.zsh"

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
ZSH_HIGHLIGHT_STYLES[arg0]='none'
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='green'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=red'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='none'
ZSH_HIGHLIGHT_STYLES[command-substitution]='none'
ZSH_HIGHLIGHT_STYLES[command]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[comment]='fg=gray'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=red'
ZSH_HIGHLIGHT_STYLES[cursor]='bg=black'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='none'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=red'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[hashed-command]='none'
ZSH_HIGHLIGHT_STYLES[history-expansion]='none'
ZSH_HIGHLIGHT_STYLES[named-fd]='none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='none'
ZSH_HIGHLIGHT_STYLES[process-substitution]='none'
ZSH_HIGHLIGHT_STYLES[rc-quote]='none'
ZSH_HIGHLIGHT_STYLES[redirection]='none'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=red'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='yellow'
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=red,bold'
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=yellow,fg=black'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'
# HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
# HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=''
# HISTORY_SUBSTRING_SEARCH_FUZZY=''

# ----------------------------------------------------------------------------
# zsh-autosuggestions
# NOTE: Accepting an autosuggestion leads to weird highlighting.
# ----------------------------------------------------------------------------
bindkey '^L' autosuggest-accept
bindkey '^K' history-substring-search-up
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
# export ZSH_PLUGINS_SOURCED=1
