# ~/.config/fish/conf.d/proxy.fish

# 代理配置
set -gx PROXY_URL "http://127.0.0.1:7890"
set -gx SOCKS_URL "socks5://127.0.0.1:7890"

# 默认开启代理
set -gx https_proxy $PROXY_URL
set -gx http_proxy $PROXY_URL
set -gx all_proxy $SOCKS_URL

# 代理控制函数
function proxy -d "控制代理设置: proxy on | off"
    if test (count $argv) -eq 0
        # 显示状态
        if set -q http_proxy
            echo "代理已启用: $http_proxy"
        else
            echo 代理未启用
        end
        return 0
    end

    switch $argv[1]
        case on
            # 设置代理
            set -gx http_proxy $PROXY_URL
            set -gx https_proxy $PROXY_URL
            set -gx all_proxy $SOCKS_URL
            echo "✅ 代理已启用"

        case off
            # 取消代理
            set -e http_proxy
            set -e https_proxy
            set -e all_proxy
            echo "❌ 代理已关闭"

        case '*'
            echo "用法: proxy [on | off]"
            return 1
    end
end
