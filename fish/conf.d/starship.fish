if status is-interactive
    # Starship
    starship init fish | source
    enable_transience

    # workaround https://github.com/starship/starship/issues/560
    function starship_transient_prompt_func
        tput cuu1
        starship module character
    end

    function prompt_newline --on-event fish_postexec
        echo
    end

    alias clear "command clear; commandline -f clear-screen"
    alias cl "command clear; commandline -f clear-screen"
end
