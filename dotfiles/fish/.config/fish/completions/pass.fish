function __fish_pass_get_prefix
    set -l prefix "$PASSWORD_STORE_DIR"
    if [ -z "$prefix" ]
        set prefix "$HOME/.password-store"
    end
    echo "$prefix"
end

function __fish_pass_needs_command
    set -l cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = pass ]
        return 0
    end
    return 1
end

function __fish_pass_uses_command
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

function __fish_pass_print_gpg_keys
    gpg2 --list-secret-keys | awk '/sec/{getline l1; getline l2; gsub(/ /, "",l1); print l1 "\011" l2}'
end

function __fish_pass_print_entry_dirs
    cd (__fish_pass_get_prefix); ls -d **/
end

function __fish_pass_print_entries
    cd (__fish_pass_get_prefix); find . -type f -name "*.gpg" | sed "s/\.\/\|.gpg//g"
end

function __fish_pass_print_entries_and_dirs
    __fish_pass_print_entry_dirs
    __fish_pass_print_entries
end

# init
complete -f -c pass -n '__fish_pass_needs_command' -a init -d 'initialize new password storage'
complete -x -c pass -n '__fish_pass_uses_command init' -s p -l path -a '(__fish_pass_print_entry_dirs)' -d 'Assign gpg-id for specified sub folder of password store'
complete -f -k -c pass -n '__fish_pass_uses_command init' -a '(__fish_pass_print_gpg_keys)'

# ls
complete -f -c pass -n '__fish_pass_needs_command' -a ls -d 'list passwords'
complete -x -c pass -n '__fish_pass_uses_command ls' -a '(__fish_pass_print_entry_dirs)'

# grep
complete -f -c pass -n '__fish_pass_needs_command' -a grep -d 'search inside of decrypted password files for matching pattern'
complete -x -c pass -n '__fish_pass_uses_command grep' 

# find or search
complete -f -c pass -n '__fish_pass_needs_command' -a "find search" -d 'find a password file or directory matching pattern'
complete -x -c pass -n '__fish_pass_uses_command search' 
complete -x -c pass -n '__fish_pass_uses_command find'

# show
complete -f -c pass -n '__fish_pass_needs_command' -a show -d 'show existing password'
complete -f -c pass -n '__fish_pass_uses_command show' -s c -l clip -d 'copy first (or otherwise specified) line to the clipboard'
complete -f -c pass -n '__fish_pass_uses_command show' -s q -l qrcode -d 'display a QR code of the (or otherwise specified) first line'
complete -f -c pass -n '__fish_pass_uses_command show' -a '(__fish_pass_print_entries)' 

# insert
complete -f -c pass -n '__fish_pass_needs_command' -a insert -d 'insert new password'
complete -f -c pass -n '__fish_pass_uses_command insert' -s e -l echo -d 'Echo the password on console'
complete -f -c pass -n '__fish_pass_uses_command insert' -s m -l multiline -d 'Provide multiline password entry'
complete -f -c pass -n '__fish_pass_uses_command insert' -s f -l force -d 'Do not prompt before overwritting'
complete -f -c pass -n '__fish_pass_uses_command insert' -a "(__fish_pass_print_entry_dirs)"

# edit
complete -f -c pass -n '__fish_pass_needs_command' -a edit -d 'edit password using text editor'
complete -f -c pass -n '__fish_pass_uses_command edit' -a "(__fish_pass_print_entries)"

# generate
complete -f -c pass -n '__fish_pass_needs_command' -a generate -d 'generate new password'
complete -f -c pass -n '__fish_pass_uses_command generate' -s n -l no-symbols -d 'Do not use special symbols'
complete -f -c pass -n '__fish_pass_uses_command generate' -s c -l clip -d 'Put the password in clipboard'
complete -f -c pass -n '__fish_pass_uses_command generate' -s f -l force -d 'Do not prompt before overwritting'
complete -f -c pass -n '__fish_pass_uses_command generate' -s i -l in-place -d 'Replace only the first line with the generated password'
complete -f -c pass -n '__fish_pass_uses_command generate' -a "(__fish_pass_print_entries_and_dirs)"

# rm
complete -f -c pass -n '__fish_pass_needs_command' -a rm -d 'remove existing password'
complete -f -c pass -n '__fish_pass_uses_command rm' -s r -l recursive -d 'Remove password groups recursively'
complete -f -c pass -n '__fish_pass_uses_command rm' -s f -l force -d 'Force removal'
complete -f -c pass -n '__fish_pass_uses_command rm' -a "(__fish_pass_print_entries_and_dirs)"

# mv
complete -f -c pass -n '__fish_pass_needs_command' -a mv -d 'rename existing password'
complete -f -c pass -n '__fish_pass_uses_command mv' -s f -l force -d 'Force rename'
complete -f -c pass -n '__fish_pass_uses_command mv' -a "(__fish_pass_print_entries_and_dirs)"

# cp
complete -f -c pass -n '__fish_pass_needs_command' -a cp -d 'copy existing password'
complete -f -c pass -n '__fish_pass_uses_command cp' -s f -l force -d 'Force copy'
complete -f -c pass -n '__fish_pass_uses_command cp' -a "(__fish_pass_print_entries_and_dirs)"

# git
complete -f -c pass -n '__fish_pass_needs_command' -a git -d 'execute a git command'
complete -f -c pass -f -n '__fish_pass_uses_command git' -a 'init' -d 'Initialize git repository'
complete -f -c pass -f -n '__fish_pass_uses_command git' -a 'status' -d 'Show status of the repo'
complete -f -c pass -f -n '__fish_pass_uses_command git' -a 'add' -d 'Add changes to the index'
complete -f -c pass -f -n '__fish_pass_uses_command git' -a 'commit' -d 'Commit changes to the repo'
complete -f -c pass -f -n '__fish_pass_uses_command git' -a 'push' -d 'Push changes to remote repo'
complete -f -c pass -f -n '__fish_pass_uses_command git' -a 'pull' -d 'Pull changes from remote repo'
complete -f -c pass -f -n '__fish_pass_uses_command git' -a 'log' -d 'View changelog'

# help
complete -f -c pass -n '__fish_pass_needs_command' -a help -d 'show usage help'

# version
complete -f -c pass -n '__fish_pass_needs_command' -a version -d 'show program version'
