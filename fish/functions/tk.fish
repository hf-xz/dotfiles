function tk --description 'Tmux session manager - kill sessions with interactive selection'
    # 依赖检查
    if not command -q tmux
        echo "错误: 需要安装 tmux"
        return 1
    end

    # 关闭 session 的函数
    function kill_session -a session
        if tmux has-session -t "$session" 2>/dev/null
            echo "正在关闭 session: $session"
            tmux kill-session -t "$session"
        else
            echo "Session 不存在: $session"
            return 1
        end
    end

    ### 主逻辑 ###

    # 如果提供了 session 名称参数
    if test (count $argv) -gt 0
        kill_session $argv[1]
        return
    end

    # 没有参数，显示交互式菜单
    # 获取所有 session 列表
    set -l sessions (tmux list-sessions -F '#S' 2>/dev/null; or echo "")

    # 检查是否有 session
    if test -z "$sessions"
        echo "没有活动的 tmux session"
        return 0
    end

    # 检查 gum 是否可用
    if command -q gum
        # 使用 gum 进行选择
        set -l options
        for s in $sessions
            set -a options $s
        end
        set -a options "[cancel]"

        set -l height (math (count $options) + 3)
        set -l selected (string join \n $options | \
                         gum filter \
                         --placeholder "Select session to kill..." \
                         --prompt "  " \
                         --height $height \
        )

        # 判断是否取消
        if test "$selected" = "[cancel]" -o -z "$selected"
            echo canceled
            return 0
        else
            # 确认删除
            if gum confirm "确定要关闭 session: '$selected' 吗?" \
                    --affirmative 关闭 \
                    --negative 取消
                kill_session "$selected"
                return 0
            end

            echo canceled
            return 0
        end

    else
        # 没有 gum，使用简单选择
        echo "Available sessions:"
        set -l i 1
        for s in $sessions
            echo "  $i) $s"
            set i (math $i + 1)
        end
        echo "  c) [cancel]"

        read -P "  Select session to kill (number or 'c' to cancel): " choice

        # 判断是否取消
        if test "$choice" = c -o -z "$choice"
            echo canceled
            return 0
        else if test -n "$choice" -a "$choice" -ge 1 -a "$choice" -le (count $sessions)
            set session $sessions[$choice]

            # 确认删除
            read -P "确定要关闭 session: '$session' 吗? (y/N): " confirm
            if test "$confirm" != y -a "$confirm" != Y
                echo canceled
                return 0
            end

            # 执行关闭
            kill_session "$session"
        else
            echo 无效选择
            return 1
        end
    end
end
