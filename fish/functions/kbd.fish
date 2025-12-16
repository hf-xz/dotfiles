function kbd -d "控制 kanata 开关: kbd on | off"
    if test (count $argv) -eq 0
        # 显示状态
        echo (sudo launchctl print system/com.example.kanata | rg state | string split " = ")[2]
        return 0
    end

    switch $argv[1]
        case on
            sudo launchctl start com.example.kanata

        case off
            sudo launchctl stop com.example.kanata

        case '*'
            echo "用法: kbd [on | off]"
            return 1
    end
end
