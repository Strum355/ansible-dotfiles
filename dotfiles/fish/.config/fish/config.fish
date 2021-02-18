set fish_greeting ""
set -x GOPATH $HOME/Go
set -x PATH /usr/local/go/bin $HOME/.bin $HOME/.local/bin $GOPATH/bin /home/noah/.gem/ruby/2.7.0/bin /opt/protoc/bin $HOME/.cargo/bin /opt/visualvm/bin /opt/asdf-vm/bin $PATH 
set -x M2_HOME /opt/maven
set -x M2 $M2_HOME/bin
set -x PATH $M2 $PATH
set -x RUST_BACKTRACE 1
set -x GO111MODULE on
set -x VAULT_ADDR http://127.0.0.1:10001
set -x KUBECONFIG ~/kubeconfig 
set -x EDITOR nano
set -x JAVA_OPTS -XX:+IgnoreUnrecognizedVMOptions -XX:+ShowCodeDetailsInExceptionMessages
set -x JAVA_HOME /usr/lib/jvm/java-15-jdk
set -x REDIS_DATA_DIR /home/noah/Sourcegraph/redis_data
set -x PGDATA_DIR /home/noah/Sourcegraph/postgres_data 
set -x PGPORT 5432
set -x PGHOST localhost
set -x PGUSER sourcegraph
set -x PGPASSWORD sourcegraph
set -x PGDATABASE sourcegraph
set -x PGSSLMODE disable
set -x SG_LSIFCLANG /home/noah/Sourcegraph/lsif-clang

set -g theme_title_display_process yes
set -g theme_title_use_abbreviated_path no
set -g theme_show_exit_status yes
set -g theme_color_scheme terminal
set -g theme_display_k8s_context yes
set -g theme_display_date no

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

function __direnv_export_eval --on-event fish_postexec;
        "/usr/bin/direnv" export fish | source;
end

set -U FZF_DEFAULT_OPTS "--height 40% --layout reverse-list --inline-info"
set -U FZF_DEFAULT_COMMAND "fd --no-ignore-vcs --follow --hidden . --base-directory \$dir"
set -U FZF_FIND_FILE_COMMAND "$FZF_DEFAULT_COMMAND"
