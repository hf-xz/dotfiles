function nf
    # 设置初始搜索词
    set -l initial_query ""
    if test (count $argv) -gt 0
        set initial_query "$argv"
    end

    # 设置 fzf 参数
    set -l fzf_opts \
        --reverse \
        --multi \
        --preview "bat -p {}" \
        --preview-window=right:60%:wrap \
        --bind 'ctrl-a:select-all,ctrl-d:deselect-all' \
        --query "$initial_query"

    # 使用 fzf 选择文件
    set -l selected (fd --type f --hidden --follow --exclude .git | fzf $fzf_opts)

    if test -n "$selected"
        # 如果有多个文件，一次性全部打开
        nvim (string split '\n' $selected)
    else
        echo "No file selected."
    end
end
