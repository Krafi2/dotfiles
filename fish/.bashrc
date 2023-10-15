# Execute fish if the shell is interactive
[[ -n "$PS1" ]] && exec -l fish "$@"
