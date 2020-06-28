set fish_greeting ""
set -x GOPATH $HOME/Go
set -x PATH /usr/local/go/bin $HOME/.bin $HOME/.local/bin $GOPATH/bin /home/noah/.gem/ruby/2.7.0/bin /opt/protoc/bin $PATH 
set -x M2_HOME /opt/maven
set -x M2 $M2_HOME/bin
set -x PATH $M2 $PATH
set -x RUST_BACKTRACE 1
set -x GO111MODULE auto
set -x VAULT_ADDR http://127.0.0.1:10001
set -x KUBECONFIG ~/kubeconfig 
set -g EDITOR nano

set -g theme_title_display_process yes
set -g theme_title_use_abbreviated_path no
set -g theme_show_exit_status yes
set -g theme_color_scheme terminal
set -g theme_display_k8s_context yes

alias k "kubectl"
alias mk "minikube"

function wdiff 
    bash -c "wdiff  -n -w \$'\033[30;31m' -x \$'\033[0m' -y \$'\033[30;32m' -z \$'\033[0m' $argv[1..-1]"
end

function dgrep
	docker logs $argv[1] 2>&1 | grep $argv[2..-1]
end

if test -n "$DESKTOP_SESSION"
    set -x (gnome-keyring-daemon --start | string split "=")
end