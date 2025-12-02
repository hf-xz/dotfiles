#!/bin/bash
# t.sh
# 用法: ./t.sh [session_name]

### 依赖检查 ###

# # 检查 gum 是否安装
# if ! command -v gum &> /dev/null; then
#     echo "错误: 需要安装 gum"
#     echo "安装方法:"
#     echo "  macOS: brew install gum"
#     echo "  Ubuntu/Debian: 参考 https://github.com/charmbracelet/gum#installation"
#     exit 1
# fi

# # 检查 tmux 是否安装
# if ! command -v tmux &> /dev/null; then
#     echo "错误: 需要安装 tmux"
#     exit 1
# fi

### 函数定义 ###

# 切换 / 连接 到 tmux session
connect_to_session() {
    local session="$1"

    if [[ -n "$TMUX" ]]; then
        # 已经在 tmux 中，切换 session
        echo "切换到已存在的 session: $session"
        tmux switch-client -t "$session"
    else
        # 不在 tmux 中，附加到 session
        echo "连接到已存在的 session: $session"
        tmux attach -t "$session"
    fi
}

# 创建新 tmux session
create_new_session() {
    local session="$1"

    if [[ -n "$TMUX" ]]; then
        # 在 tmux 中创建新 session 但保持当前 session
        echo "创建新 session: $session"
        tmux new-session -d -s "$session"
        tmux switch-client -t "$session"
    else
        # 不在 tmux 中，创建并附加到新 session
        echo "创建并连接到新 session: $session"
        tmux new-session -s "$session"
    fi
}

# 使用 tmux session (存在则连接，不存在则创建)
use_session() {
    local session="$1"

    if tmux has-session -t "$session" 2>/dev/null; then
        connect_to_session "$session"
    else
        create_new_session "$session"
    fi

    exit 0
}

### 主逻辑 ###

# 如果提供了 session 名称参数
if [[ $# -gt 0 ]]; then
    use_session "$1"
fi

# 没有参数，显示交互式菜单
# 获取所有 session 列表
sessions=$(tmux list-sessions -F '#S' 2>/dev/null)

# 如果没有 session 直接创建新的
if [[ -z "$sessions" ]]; then
    session=$(gum input --placeholder "New session name" --prompt "  ")
# 否则显示选择菜单
else
    selected=$(echo -e "$sessions\n[new session]" | \
               gum filter --placeholder "Pick session..." --prompt "  ")

    if [[ "$selected" == "[new session]" ]]; then
        session=$(gum input --placeholder "New session name" --prompt "  ")
    else
        session="$selected"
    fi
fi

# 最终执行使用 session
if [[ -z "$session" ]]; then
    echo "已取消"
    exit 0
fi
use_session "$session"