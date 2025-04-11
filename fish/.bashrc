# Execute fish if the shell is interactive
. "$HOME/.cargo/env"
[[ -n "$PS1" ]] && exec -l fish "$@"
