function t --description 'Tmux session manager with interactive selection'
    # 依赖检查
    if not command -q tmux
        echo "错误: 需要安装 tmux"
        return 1
    end

    # 切换 / 连接 到 tmux session
    function connect_to_session -a session
        if set -q TMUX
            # 已经在 tmux 中，切换 session
            echo "切换到已存在的 session: $session"
            tmux switch-client -t "$session"
        else
            # 不在 tmux 中，附加到 session
            echo "连接到已存在的 session: $session"
            tmux attach -t "$session"
        end
    end

    # 创建新 tmux session
    function create_new_session -a session
        if set -q TMUX
            # 在 tmux 中创建新 session 但保持当前 session
            echo "创建新 session: $session"
            tmux new-session -d -s "$session"
            tmux switch-client -t "$session"
        else
            # 不在 tmux 中，创建并附加到新 session
            echo "创建并连接到新 session: $session"
            tmux new-session -s "$session"
        end
    end

    # 使用 tmux session (存在则连接，不存在则创建)
    function use_session -a session
        if tmux has-session -t "$session" 2>/dev/null
            connect_to_session "$session"
        else
            create_new_session "$session"
        end
    end

    ### 主逻辑 ###

    # 如果提供了 session 名称参数
    if test (count $argv) -gt 0
        use_session $argv[1]
        return
    end

    # 没有参数，显示交互式菜单
    # 获取所有 session 列表
    set -l sessions (tmux list-sessions -F '#S' 2>/dev/null; or echo "")
    set -l session

    # 如果没有 session 直接创建新的
    if test -z "$sessions"
        # 检查 gum 是否可用
        if command -q gum
            set session (gum input --placeholder "New session name" --prompt "  ")
        else
            read -P "  New session name: " session
        end
    else
        # 检查 gum 是否可用
        if command -q gum
            # 否则显示选择菜单
            set -l options
            for s in $sessions
                set -a options $s
            end
            set -a options "[new session]"

            set -l height (math (count $options) + 3)
            set -l selected (string join \n $options | \
                             gum filter \
                             --placeholder "Pick session..." \
                             --prompt "  " \
                             --height $height \
            )

            if test "$selected" = "[new session]"
                set session (gum input --placeholder "New session name" --prompt "  ")
            else
                set session "$selected"
            end
        else
            # 没有 gum，使用简单选择
            echo "Available sessions:"
            set -l i 1
            for s in $sessions
                echo "  $i) $s"
                set i (math $i + 1)
            end
            echo "  n) [new session]"

            read -P "  Select (number or 'n'): " choice

            if test "$choice" = n
                read -P "  New session name: " session
            else if test -n "$choice" -a "$choice" -ge 1 -a "$choice" -le (count $sessions)
                set session $sessions[$choice]
            else
                echo 无效选择
                return 1
            end
        end
    end

    # 判断取消
    if test -z "$session"
        echo canceled
        return 0
    end

    # 最终执行使用 session
    use_session "$session"
end
