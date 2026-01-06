# 基础编辑器别名 - 使用 abbr
abbr -a fishconf '$EDITOR ~/.config/fish/config.fish'
abbr -a aliasconf '$EDITOR ~/.config/fish/conf.d/alias.fish'
abbr -a starconf '$EDITOR ~/.config/starship.toml'
abbr -a tmuxconf '$EDITOR ~/.config/tmux/tmux.conf'
abbr -a sshconf '$EDITOR ~/.ssh/config'
abbr -a gitconf '$EDITOR ~/.gitconfig'

# 应用程序
abbr -a lg lazygit
abbr -a py python3
abbr -a nv 'neovide .'

# Docker
abbr -a compose docker-compose

# dirh
abbr -a d cdh
abbr -a 1 prevd
abbr -a 0 nextd

# 临时别名
abbr -a add-key 'ssh-add --apple-use-keychain ~/.ssh/hdzb ~/.ssh/id_ed25519'
abbr -a dev 'fnm use; and yarn dev'

abbr -a build-rsp 'ssh 50 "cd /data/appBins/esim-dev/rsp-ui && sh ./package.sh"'
abbr -a build-rsp-prod 'ssh 54 "cd /data/appBins/esim/rsp-ui && sh ./package.sh"'
abbr -a build-traffic 'ssh 40 "cd /data/appBins/traffic/traffic-ui && sh ./package.sh"'
abbr -a build-kms 'ssh 50 "cd /data/appBins/kms/kms-ui && sh ./package.sh"'
