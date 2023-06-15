if [ -n "${SH_PATH_SOURCED+x}" ]; then
    return 0
fi

# echo "Updating current path: ${PATH}"
echo "Setting path."

# nix components get set prior, so append most prefixes
# usr="/usr/local/bin:/usr/local/sbin:/usr/local/opt/bin:/opt/bin"
brew="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin"
langs="${CARGO_HOME}/bin:${GOPATH}/bin"
local="${HOME}/.local/bin"

# Detect if nix has set path and split path into nix and sys parts.
sys="${PATH#*nix/profiles/default/bin:}"
if [ -n "${NIX_PROFILES+x}" ]; then
    # echo "nix detected"
    # head="${local}:${PATH%:"${sys}"}"
    head="${PATH%:"${sys}"}:${local}"
else
    head="${local}"
fi

PATH="${head}:${langs}:${brew}:${sys}"
export PATH
export SH_PATH_SOURCED=1
