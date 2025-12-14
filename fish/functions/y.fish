function y --description 'Launch yazi and change directory on exit'
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    set -l cwd

    yazi $argv --cwd-file="$tmp"

    if set cwd (command cat "$tmp" 2>/dev/null)
        if test -n "$cwd" -a "$cwd" != "$PWD"
            cd "$cwd"
        end
    end

    rm -f "$tmp"
end
