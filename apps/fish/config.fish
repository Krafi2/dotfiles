# Use `please` to repeat the previous command with sudo

## Alias section
alias please='commandline -i "sudo $history[1]";history delete --exact --case-sensitive please' # Sudo last command with `please`
alias cp='cp -i'                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias ls='exa'                                                  # Colourful ls
alias ll='exa -alF'                                             # Colourful ll

# Use terminal colours
set -gx fish_color_autosuggestion      brblack # Autosuggestion
set -gx fish_color_cancel              -r
set -gx fish_color_command             brgreen
set -gx fish_color_comment             brmagenta
set -gx fish_color_cwd                 green
set -gx fish_color_cwd_root            red
set -gx fish_color_end                 brmagenta
set -gx fish_color_error               brred
set -gx fish_color_escape              brcyan
set -gx fish_color_history_current     brred --bold # I have no idea what this does
set -gx fish_color_host                normal
set -gx fish_color_match               --background=brblue
set -gx fish_color_normal              normal
set -gx fish_color_operator            cyan
set -gx fish_color_param               brblue
set -gx fish_color_quote               yellow
set -gx fish_color_redirection         bryellow
set -gx fish_color_search_match        brred --background=brblack # No idea what this is either
set -gx fish_color_selection           brred --bold --background=brblack # Whats this?
set -gx fish_color_status              red
set -gx fish_color_user                brgreen
set -gx fish_color_valid_path                       # Valid path
set -gx fish_pager_color_completion    normal       # Completion text
set -gx fish_pager_color_description   yellow       # Command description
set -gx fish_pager_color_prefix        brblue       # Completion common prefix
set -gx fish_pager_color_progress      brwhite --background=cyan # Completion progress

# Color man pages
set -x LESS_TERMCAP_md (printf "\e[01;34m")     # Start bold effect
set -x LESS_TERMCAP_me (printf "\e[0m")         # Stop bold effect
set -x LESS_TERMCAP_us (printf "\e[01;32m")     # Start underline
set -x LESS_TERMCAP_ue (printf "\e[0m")         # Stop underline
set -x LESS_TERMCAP_so (printf "\e[01;40;33m")  # Start reverse video
set -x LESS_TERMCAP_se (printf "\e[0m")         # Stop  reverse video
set -x LESS_TERMCAP_mb (printf "\e[01;31m")     # Start blink

# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"       # Use `bat` as a pager for man

set fish_greeting   # Disable welcome message

starship init fish | source
