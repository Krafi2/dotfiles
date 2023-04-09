if not status is-interactive
    exit 0
end

builtin functions -e fish_mode_prompt

# Transient prompt
function __prompt_cancel_repaint --on-event fish_cancel
    commandline -f repaint
end

function __prompt_maybe_execute
    commandline --is-valid
    if test $status != 2
        set -g TRANSIENT 1
        commandline -f repaint
    end
    commandline -f execute
end

function __prompt_cancel_commandline
    if string length -q -- (commandline)
        set -g TRANSIENT 1
        commandline -f repaint
    end
    commandline -f cancel-commandline
end

function __prompt_edit_command_buffer
    printf '\e[2F' # 2 lines up
    edit_command_buffer
end

bind \r  __prompt_maybe_execute       # ENTER
bind \cc __prompt_cancel_commandline  # CTRL+C
bind \ee __prompt_edit_command_buffer # ALT+E
bind \ev __prompt_edit_command_buffer # ALT+V

# Prompt
function fish_prompt
    printf '\e[0J' # Clear from cursor to end of screen
    if test $TRANSIENT -eq 1 &> /dev/null
        set -g TRANSIENT 0
    else
        echo -s \n (set_color $fish_color_cwd) (prompt_pwd --dir-length=40) (set_color normal) (fish_vcs_prompt)
    end
    echo -ns (set_color brgreen) '❯' (set_color normal) ' '
end

# https://github.com/acomagu/fish-async-prompt
# https://github.com/fish-shell/fish-shell/issues/8223