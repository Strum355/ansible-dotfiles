# Gradle is an build automation tool
# See: https://gradle.org

# https://github.com/hanny24/gradle-fish/blob/master/gradle.load
function __cache_or_get_gradlew_completion
  # Set up cache directory
  if test -z $XDG_CACHE_HOME
    set XDG_CACHE_HOME $HOME/.cache/
  end
  mkdir -m 700 -p $XDG_CACHE_HOME/gradlew-completions

  set -l hashed_pwd (fish_md5 -s $PWD)
  set -l gradlew_cache_file $XDG_CACHE_HOME/gradlew-completions/$hashed_pwd
  if not test -f $gradlew_cache_file; or command test build.gradle -nt $gradlew_cache_file
    command ./gradlew -q tasks --all 2>/dev/null | string match -r '^[[:lower:]][[:alnum:]:-]+(?: - .*)?' | string replace ' - ' \t > $gradlew_cache_file
  end
  cat $gradlew_cache_file
end

function __contains_gradlew_build
  test -f build.gradle
end

complete -c gradlew -l help -s h -d 'Show help'
complete -c gradlew -l no-rebuild -s a -d 'Don\'t rebuild dependencies'
complete -c gradlew -l build-file -s b -r -d 'Specify build file'
complete -c gradlew -l build-cache -d 'Enable build cache'
complete -c gradlew -l settings-file -s c -r -d 'Specify settings file'
complete -c gradlew -l configure-on-demand -d 'Configure necessary projects only'
complete -c gradlew -l console -x -d 'Specify console output type' -a 'plain auto rich verbose'
complete -c gradlew -l continue -d 'Continue task execution after failure'
complete -c gradlew -l system-prop -s D -r -d 'Set system property of the JVM'
complete -c gradlew -l debug -s d -d 'Log in debug mode'
complete -c gradlew -l daemon -d 'Uses Gradle Daemon to run build'
complete -c gradlew -l foreground -d 'Starts Gradle Daemon in foreground'
complete -c gradlew -l gradle-user-home -s g -r -d 'Specify gradle user home directory'
complete -c gradlew -l init-script -s I -r -d 'Specify an initialization script'
complete -c gradlew -l info -s i -d 'Set log level to info'
complete -c gradlew -l include-build -r -d 'Include specified build in composite'
complete -c gradlew -l dry-run -s m -d 'Runs build with all task actions disabled'
complete -c gradlew -l max-workers -x -d 'Configure number of concurrent workers' -a '1\t 2\t 3\t 4\t 5\t 6\t 7\t 8\t 9\t 10\t'
complete -c gradlew -l no-build-cache -d 'Disable build cache'
complete -c gradlew -l no-configure-on-demand -d 'Disable use of configuration on demand'
complete -c gradlew -l no-daemon -d 'Don\'t use deamon'
complete -c gradlew -l no-parallel -d 'Disable parallel execution'
complete -c gradlew -l no-scan -d 'Disable build scan'
complete -c gradlew -l offline -d 'Don\'t use network resources'
complete -c gradlew -l project-prop -s P -x -d 'Set project property for build script'
complete -c gradlew -l project-dir -s p -r -d 'Specify start directory'
complete -c gradlew -l parallel -d 'Build project in parallel'
complete -c gradlew -l priority -x -d 'Specify Gradle Daemon priority' -a 'normal low'
complete -c gradlew -l profile -d 'Profile build execution time'
complete -c gradlew -l project-cache-dir -r -d 'Specify project cache directory'
complete -c gradlew -l quiet -s q -d 'Only log erros'
complete -c gradlew -l refresh-dependencies -d 'Refresh state of dependencies'
complete -c gradlew -l rerun-tasks -d 'Ignore previously cached task results'
complete -c gradlew -l full-stacktrace -s S -d 'Print out the full stacktrace for all exceptions'
complete -c gradlew -l stacktrace -s s -d 'Print out the stacktrace for all exceptions'
complete -c gradlew -l scan -d 'Creates build scan'
complete -c gradlew -l status -d 'Shows status of running and recently stopped daemons'
complete -c gradlew -l stop -d 'Stops daemon if running'
complete -c gradlew -l continuous -s t -d 'Enable continuous build'
complete -c gradlew -l update-locks -d 'Perform partial update of dependency lock'
complete -c gradlew -l version -s v -d 'Print version'
complete -c gradlew -l warn -s w -d 'Set log level to warn'
complete -c gradlew -l warning-mode -x -d 'Specifies mode of warnings to generate' -a 'all summary none'
complete -c gradlew -l write-locks -d 'Persists dependency resolution for locked configs'
complete -c gradlew -l exclude-task -s x -x -d 'Specify task to be excluded from execution' -n '__contains_gradlew_build' -a "(__cache_or_get_gradlew_completion)"
complete -c gradlew -x -n '__contains_gradlew_build' -a "(__cache_or_get_gradlew_completion)"