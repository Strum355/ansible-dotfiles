set fish_greeting ""
set -x GOPATH $HOME/Go
set -x PATH /usr/local/go/bin $HOME/.bin $GOPATH/bin /var/lib/ /opt/protoc/bin $PATH
set -x M2_HOME /opt/maven
set -x M2 $M2_HOME/bin
set -x PATH $M2 $PATH
set -x RUST_BACKTRACE 1
set -x GO111MODULE on
set -x VAULT_ADDR http://127.0.0.1:10001
set -x JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/

set -g theme_title_display_process yes
set -g theme_title_use_abbreviated_path no
set -g theme_show_exit_status yes
set -g theme_color_scheme terminal

function dgrep
	docker logs $argv[1] 2>&1 | grep $argv[2..-1]
end
