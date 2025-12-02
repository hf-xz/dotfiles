#!/usr/bin/env bash

set -e

SCRIPT_DIR="$HOME/.scripts"
BIN_DIR="$SCRIPT_DIR/bin"

echo "🛠️  设置脚本目录为 $SCRIPT_DIR"

# 清理并创建 bin 目录
if [[ -d "$BIN_DIR" ]]; then
    echo "🧹 清理旧目录: $BIN_DIR"
    rm -rf "$BIN_DIR"
fi
mkdir -p "$BIN_DIR"

# 查找当前目录的脚本文件和子目录中的 main.* 文件
find -L "$SCRIPT_DIR" -maxdepth 2 -type f \( -name "*.sh" -o -name "*.py" -o -name "main.*" \) | while read -r file; do

    # 跳过 bin 目录和安装脚本
    if [[ "$file" == *"/bin/"* ]] || [[ "$(basename "$file")" == "setup.sh" ]]; then
        continue
    fi

    echo "➡️  处理脚本: $file"

    # 确保可执行
    chmod +x "$file"

    # 创建链接名
    if [[ "$file" == */main.* ]]; then
        # 使用子目录名作为链接名
        linkname="$(basename "$(dirname "$file")")"
    else
        # 默认使用文件名去掉扩展名
        filename=$(basename "$file")
        linkname="${filename%.*}"
    fi

    # 避免覆盖已有命令
    if type "$linkname" >/dev/null 2>&1; then
        echo "  ⚠️ 系统已有同名命令'$linkname'，使用前缀 'my_' 避免冲突"
        linkname="my_${linkname}"  # 添加前缀
    fi

    # 创建符号链接
    ln -sf "$file" "$BIN_DIR/$linkname"
    echo "  📝 $linkname → $(basename "$file")"
done

# 添加到 PATH（如果还没添加）
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "⚠️  $BIN_DIR 不在 PATH"
    echo "👉 请将以下行添加到你的 shell 配置文件（如 ~/.zshrc 或 ~/.bashrc）中："
    echo ""
    echo "export PATH=\"$BIN_DIR:\$PATH\""
fi

echo ""
echo ""
echo "🎉 安装完成！可用命令："
ls -1 "$BIN_DIR" | sed 's/^/- /'
