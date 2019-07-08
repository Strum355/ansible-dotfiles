set fish_greeting ""
set -x GOPATH $HOME/Go
set -x PATH /usr/local/go/bin $HOME/.bin $GOPATH/bin $PATH
set -x M2_HOME /opt/maven
set -x M2 $M2_HOME/bin
set -x PATH $M2 $PATH
set -x RUST_BACKTRACE 1
set -x GO111MODULE auto

set -g theme_title_display_process yes
set -g theme_title_use_abbreviated_path no
set -g theme_show_exit_status yes
set -g theme_color_scheme terminal
