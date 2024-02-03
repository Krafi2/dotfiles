# Config
set -x EDITOR helix
set -x VISUAL $EDITOR
set fish_greeting # Disable the welcome message

# Enable colorful less output
set -x PAGER 'less -R --use-color -Dd+b -Dug -DSkm -DPky'
set -x MANPAGER $PAGER
alias less=$MANPAGER
set -x MANROFFOPT '-c'

# Set up bat
set -x BAT_THEME 'ansi'

# Alias section
alias please='eval "sudo $history[1]";history delete --exact --case-sensitive please' # Sudo last command with `please`
alias cp='cp -i'                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias gits='git status'
alias gitc='git commit'
alias gita='git add'
alias ls='eza -a'                                               # Colourful ls
alias ll='eza -alF'                                             # Colourful ll
alias zyp='zypper'
alias cat='bat'
alias diff='delta'

# Use terminal colours
set -g fish_color_autosuggestion      brblack # Autosuggestion
set -g fish_color_cancel              -r
set -g fish_color_command             brgreen
set -g fish_color_comment             brmagenta
set -g fish_color_cwd                 green
set -g fish_color_cwd_root            red
set -g fish_color_end                 brmagenta
set -g fish_color_error               brred
set -g fish_color_escape              brcyan
set -g fish_color_history_current     brred --bold # I have no idea what this does
set -g fish_color_host                normal
set -g fish_color_match               --background=brblue
set -g fish_color_normal              normal
set -g fish_color_operator            cyan
set -g fish_color_param               brblue
set -g fish_color_quote               yellow
set -g fish_color_redirection         bryellow
set -g fish_color_search_match        brred --background=brblack # No idea what this is either
set -g fish_color_selection           brred --bold --background=brblack # Whats this?
set -g fish_color_status              red
set -g fish_color_user                brgreen
set -g fish_color_valid_path          normal       # Valid path
set -g fish_pager_color_completion    normal       # Completion text
set -g fish_pager_color_description   yellow       # Command description
set -g fish_pager_color_prefix        brblue       # Completion common prefix
set -g fish_pager_color_progress      brwhite --background=cyan # Completion progress

# Configure prompt
set -g __fish_git_prompt_show_informative_status

