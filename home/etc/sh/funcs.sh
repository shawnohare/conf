#!/usr/bin/env sh
# ----------------------------------------------------------------------------
# Various personal utility function shell hooks for POSIX shells.
# For development, one must unset the sentinel function before resourcing
# or restart a new shell.
# ```bash
# unset -f SH_FUNCS_SOURCED
# ```
# ----------------------------------------------------------------------------
if [ -z "${FORCE+x}" ] && command -v SH_FUNCS_SOURCED 1> /dev/null; then
    return 0
fi

echo "Sourcing functions."
__local_funcs_nvim_cmd="$(command -v nvim)"
__local_funcs_git_cmd="$(command -v git)"


SH_FUNCS_SOURCED() {
    # Sentinel indication these functions exist in the current environment.
    return 0
}

_is_not_git_repo() {
    if [ "$(${__local_funcs_git_cmd} rev-parse --is-inside-work-tree)" = "false" ]; then
        # echo "Not inside a git repo"
        return 0
    else
        # echo "Inside a repo."
        return 1
    fi
}


edit() {
    if _is_not_git_repo; then
        GIT_DIR="${HOME}/.git"
        GIT_WORK_TREE="${HOME}"
    fi
    "${__local_funcs_nvim_cmd}" "$@"

}

rev() {
    if _is_not_git_repo; then
        "${__local_funcs_git_cmd}" --git-dir="${HOME}/.git/" --work-tree="${HOME}" "$@"
    else
        "${__local_funcs_git_cmd}" "$@"
    fi
}

hello() {
    if [ "$(git rev-parse --is-inside-work-tree)" = "false" ]; then
        GIT_DIR="${HOME}/.git" GIT_WORK_TREE="${HOME}"
    fi
    echo "${GIT_DIR}"
    echo "${GIT_WORK_TREE}"
}
