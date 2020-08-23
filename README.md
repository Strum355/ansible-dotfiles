```  
███████╗████████╗██████╗ ██╗   ██╗███╗   ███╗██████╗ ███████╗███████╗ █ ███████╗
██╔════╝╚══██╔══╝██╔══██╗██║   ██║████╗ ████║╚════██╗██╔════╝██╔════╝   ██╔════╝
███████╗   ██║   ██████╔╝██║   ██║██╔████╔██║ █████╔╝███████╗███████╗   ███████╗
╚════██║   ██║   ██╔══██╗██║   ██║██║╚██╔╝██║ ╚═══██╗╚════██║╚════██║   ╚════██║
███████║   ██║   ██║  ██║╚██████╔╝██║ ╚═╝ ██║██████╔╝███████║███████║   ███████║
╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═════╝ ╚══════╝╚══════╝   ╚══════╝

██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
```

## deploying dotfiles

Prerequisites:
- `254571E6B4A4FE3E367FB9C93B22282472C8AE48` GPG secret key
- Pull access for https://github.com/Strum355/pass

Clone the repo `git clone git@github.com:Strum355/dot-files.git`

Checkout the `pass` git submodule with `git submodule update --init`

Run `ansible-playbook deploy-dotfiles.yaml --ask-become-pass` and input your password

## how it works

In this repo, dotfiles are mananged through a combination of [Ansible](https://www.ansible.com/) and [GNU Stow](http://www.gnu.org/software/stow/) to deploy all dotfiles and config at once.

When running the Ansible playbook, Stow is invoked on all directories in `./dotfiles`. with the default target directory being `../..`, which should be the home directory. If a target needs to be overridden, a directory can contain a `.override` file containing the new target directory. All source directories are merged with the target directores, so existing files aren't deleted.

This results in e.g.:

`dotfiles/i3/.config/i3/` -> `$HOME/.config/i3/`  
`dotfiles/slick-greeter/` -> `/etc/lightdm/`

To install configs for a particular service, one can invoke stow manually in the `dotfiles` directory e.g. `cd dotfiles && stow -t /target/directory fish`. The commands invoked by Ansible are a bit more involved, to take into account the possible `.override` file and for output purposes.
