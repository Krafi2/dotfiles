# Fix flatpak environment
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

## Alias section
alias please='eval "sudo $history[1]";history delete --exact --case-sensitive please' # Sudo last command with `please`
alias cp='cp -i'                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias gits='git status'
alias gitc='git commit'
alias gita='git add'
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
# Force groff to use weird custom escape sequences when run by man. Coloring by less doesn't seem to work otherwise.
set -gx MANROFFOPT '-c'
set -gx MANPAGER 'less -R -s -M +Gg'
set -gx PAGER 'less -R'

set -gx LESS_TERMCAP_md (printf "\e[01;34m")     # Start bold effect
set -gx LESS_TERMCAP_me (printf "\e[0m")         # Stop bold effect
set -gx LESS_TERMCAP_us (printf "\e[01;32m")     # Start underline
set -gx LESS_TERMCAP_ue (printf "\e[0m")         # Stop underline
set -gx LESS_TERMCAP_so (printf "\e[01;40;33m")  # Start reverse video
set -gx LESS_TERMCAP_se (printf "\e[0m")         # Stop  reverse video
set -gx LESS_TERMCAP_mb (printf "\e[01;31m")     # Start blink

# Set EDITOR
set EDITOR nvim
set VISUAL $EDITOR

set fish_greeting   # Disable welcome message

starship init fish | source
