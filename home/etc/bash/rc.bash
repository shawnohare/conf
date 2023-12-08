# NOTE: iterm shell integration messes with the prompt and causes
# emacs tramp mode to hang indefinitely.
# if [[ "$TERM" != "dumb" ]] && [ -e "${HOME}/.iterm2_shell_integration.bash" ]; then
#   source "${HOME}/.iterm2_shell_integration.bash"
# fi

# interactive, login shell will source ~/.bash_profile, then ~/.bash_login, then ~/.profile
# interactive, non-login will source ~/.bashrc

# ----------------------------------------------------------------------------
source "${HOME}/.profile" > /dev/null 2>&1
source "${XDG_CONFIG_HOME}/sh/rc.sh" > /dev/null 2>&1

export ISHELL="bash"
export PYENV_SHELL=bash
export SHDATA="${XDG_STATE_HOME}/bash"


# env vars
HISTFILESIZE=1000000
HISTSIZE=1000
HISTFILE="${SHDATA}/history"

# ignore files with these suffixes when performing completion.
FIGNORE='.o:.pyc'

# Ignore files that match these patterns when performing filename expansion.
GLOBIGNORE='.DS_Store:*.o:*.pyc'

# ----------------------------------------------------------------------------
# settings (many on by default)
# Do not exit an interactive shell upon reading EOF.
set -o ignoreeof

# Report the status of terminated background jobs immediately,
# rather than before printing the next primary prompt.
set -o notify

# ----------------------------------------------------------------------------
# shell options (most off by default)

# Executed a directory name as if it were an argument to cd.
shopt -s autocd

# Correct spelling errors in directory names given to cd.
shopt -s cdspell

# Check the hash table for a command name before searching $PATH.
shopt -s checkhash

# Update the window size variables after each command.
shopt -s checkwinsize

# Save all lines of a multi-line command in the same history entry.
shopt -s cmdhist

# Correct spelling errors on directory names during word completion.
shopt -s dirspell

# Enable extended pattern matching features.
shopt -s extglob

# Enable `**` pattern in filename expansion to match all files,
# directories and subdirectories.
shopt -s globstar

# Append the history list to $HISTFILE instead of replacing it.
shopt -s histappend

# Save multi-line commands to the history with embedded newlines
# instead of semicolons -- requries cmdhist to be on.
shopt -s lithist

# Do not attempt completions on an empty line.
shopt -s no_empty_cmd_completion

# Case-insensitive filename matching in filename expansion.
shopt -s nocaseglob

# Make echo builtin expand backslash-escape-sequence.
shopt -s xpg_echo

# source <(starship init ${ISHELL} --print-full-init 2&> /dev/null)
source <(starship init ${ISHELL} --print-full-init) 2&> /dev/null
