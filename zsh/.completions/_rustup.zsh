#compdef rustup

autoload -U is-at-least

_rustup() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" \
'-v[Enable verbose output]' \
'--verbose[Enable verbose output]' \
'(-v --verbose)-q[Disable progress output]' \
'(-v --verbose)--quiet[Disable progress output]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
'::+toolchain -- release channel (e.g. +stable) or custom toolchain to set override:_files' \
":: :_rustup_commands" \
"*::: :->rustup" \
&& ret=0
    case $state in
    (rustup)
        words=($line[2] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:rustup-command-$line[2]:"
        case $line[2] in
            (dump-testament)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(show)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
":: :_rustup__show_commands" \
"*::: :->show" \
&& ret=0
case $state in
    (show)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:rustup-show-command-$line[1]:"
        case $line[1] in
            (active-toolchain)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(home)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(profile)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(keys)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(install)
_arguments "${_arguments_options[@]}" \
'--profile=[]: :(minimal default complete)' \
'--no-self-update[Don'\''t perform self-update when running the `rustup install` command]' \
'--force[Force an update, even if some components are missing]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(update)
_arguments "${_arguments_options[@]}" \
'--no-self-update[Don'\''t perform self update when running the `rustup update` command]' \
'--force[Force an update, even if some components are missing]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
'::toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(check)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(default)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
'::toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(toolchain)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
":: :_rustup__toolchain_commands" \
"*::: :->toolchain" \
&& ret=0
case $state in
    (toolchain)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:rustup-toolchain-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
'-v[Enable verbose output with toolchain information]' \
'--verbose[Enable verbose output with toolchain information]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(update)
_arguments "${_arguments_options[@]}" \
'--profile=[]: :(minimal default complete)' \
'*-c+[Add specific components on installation]' \
'*--component=[Add specific components on installation]' \
'*-t+[Add specific targets on installation]' \
'*--target=[Add specific targets on installation]' \
'--no-self-update[Don'\''t perform self update when running the`rustup toolchain install` command]' \
'--force[Force an update, even if some components are missing]' \
'--allow-downgrade[Allow rustup to downgrade the toolchain to satisfy your component choice]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" \
'--profile=[]: :(minimal default complete)' \
'*-c+[Add specific components on installation]' \
'*--component=[Add specific components on installation]' \
'*-t+[Add specific targets on installation]' \
'*--target=[Add specific targets on installation]' \
'--no-self-update[Don'\''t perform self update when running the`rustup toolchain install` command]' \
'--force[Force an update, even if some components are missing]' \
'--allow-downgrade[Allow rustup to downgrade the toolchain to satisfy your component choice]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" \
'--profile=[]: :(minimal default complete)' \
'*-c+[Add specific components on installation]' \
'*--component=[Add specific components on installation]' \
'*-t+[Add specific targets on installation]' \
'*--target=[Add specific targets on installation]' \
'--no-self-update[Don'\''t perform self update when running the`rustup toolchain install` command]' \
'--force[Force an update, even if some components are missing]' \
'--allow-downgrade[Allow rustup to downgrade the toolchain to satisfy your component choice]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(link)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
':path:_files' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(target)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
":: :_rustup__target_commands" \
"*::: :->target" \
&& ret=0
case $state in
    (target)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:rustup-target-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'--installed[List only installed targets]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(install)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':target -- List of targets to install; "all" installs all available targets:_files' \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':target -- List of targets to install; "all" installs all available targets:_files' \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':target:_files' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':target:_files' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(component)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
":: :_rustup__component_commands" \
"*::: :->component" \
&& ret=0
case $state in
    (component)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:rustup-component-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'--installed[List only installed components]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'--target=[]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':component:_files' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'--target=[]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':component:_files' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(override)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
":: :_rustup__override_commands" \
"*::: :->override" \
&& ret=0
case $state in
    (override)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:rustup-override-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" \
'--path=[Path to the directory]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(set)
_arguments "${_arguments_options[@]}" \
'--path=[Path to the directory]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" \
'--path=[Path to the directory]' \
'--nonexistent[Remove override toolchain for all nonexistent directories]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(unset)
_arguments "${_arguments_options[@]}" \
'--path=[Path to the directory]' \
'--nonexistent[Remove override toolchain for all nonexistent directories]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(run)
_arguments "${_arguments_options[@]}" \
'--install[Install the requested toolchain if needed]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':toolchain -- Toolchain name, such as 'stable', 'nightly', or '1.8.0'. For more information see `rustup help toolchain`:_files' \
':command:_files' \
&& ret=0
;;
(which)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':command:_files' \
&& ret=0
;;
(docs)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'--path[Only print the path to the documentation]' \
'--alloc[The Rust core allocation and collections library]' \
'--book[The Rust Programming Language book]' \
'--cargo[The Cargo Book]' \
'--core[The Rust Core Library]' \
'--edition-guide[The Rust Edition Guide]' \
'--nomicon[The Dark Arts of Advanced and Unsafe Rust Programming]' \
'--proc_macro[A support library for macro authors when defining new macros]' \
'--reference[The Rust Reference]' \
'--rust-by-example[A collection of runnable examples that illustrate various Rust concepts and standard libraries]' \
'--rustc[The compiler for the Rust programming language]' \
'--rustdoc[Generate documentation for Rust projects]' \
'--std[Standard library API documentation]' \
'--test[Support code for rustc'\''s built in unit-test and micro-benchmarking framework]' \
'--unstable-book[The Unstable Book]' \
'--embedded-book[The Embedded Rust Book]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
'::topic -- Topic such as 'core', 'fn', 'usize', 'eprintln!', 'core::arch', 'alloc::format!', 'std::fs', 'std::fs::read_dir', 'std::io::Bytes', 'std::iter::Sum', 'std::io::error::Result' etc...:_files' \
&& ret=0
;;
(doc)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'--path[Only print the path to the documentation]' \
'--alloc[The Rust core allocation and collections library]' \
'--book[The Rust Programming Language book]' \
'--cargo[The Cargo Book]' \
'--core[The Rust Core Library]' \
'--edition-guide[The Rust Edition Guide]' \
'--nomicon[The Dark Arts of Advanced and Unsafe Rust Programming]' \
'--proc_macro[A support library for macro authors when defining new macros]' \
'--reference[The Rust Reference]' \
'--rust-by-example[A collection of runnable examples that illustrate various Rust concepts and standard libraries]' \
'--rustc[The compiler for the Rust programming language]' \
'--rustdoc[Generate documentation for Rust projects]' \
'--std[Standard library API documentation]' \
'--test[Support code for rustc'\''s built in unit-test and micro-benchmarking framework]' \
'--unstable-book[The Unstable Book]' \
'--embedded-book[The Embedded Rust Book]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
'::topic -- Topic such as 'core', 'fn', 'usize', 'eprintln!', 'core::arch', 'alloc::format!', 'std::fs', 'std::fs::read_dir', 'std::io::Bytes', 'std::iter::Sum', 'std::io::error::Result' etc...:_files' \
&& ret=0
;;
(man)
_arguments "${_arguments_options[@]}" \
'--toolchain=[Toolchain name, such as '\''stable'\'', '\''nightly'\'', or '\''1.8.0'\''. For more information see `rustup help toolchain`]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':command:_files' \
&& ret=0
;;
(self)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
":: :_rustup__self_commands" \
"*::: :->self" \
&& ret=0
case $state in
    (self)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:rustup-self-command-$line[1]:"
        case $line[1] in
            (update)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(uninstall)
_arguments "${_arguments_options[@]}" \
'-y[]' \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(upgrade-data)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(set)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
":: :_rustup__set_commands" \
"*::: :->set" \
&& ret=0
case $state in
    (set)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:rustup-set-command-$line[1]:"
        case $line[1] in
            (default-host)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':host_triple:_files' \
&& ret=0
;;
(profile)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
':profile-name:(minimal default complete)' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
        esac
    ;;
esac
;;
(completions)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
'::shell:(zsh bash fish powershell elvish)' \
'::command:(rustup cargo)' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" \
'-h[Prints help information]' \
'--help[Prints help information]' \
'-V[Prints version information]' \
'--version[Prints version information]' \
&& ret=0
;;
        esac
    ;;
esac
}

(( $+functions[_rustup_commands] )) ||
_rustup_commands() {
    local commands; commands=(
        "dump-testament:Dump information about the build" \
"show:Show the active and installed toolchains or profiles" \
"install:Update Rust toolchains" \
"uninstall:Uninstall Rust toolchains" \
"update:Update Rust toolchains and rustup" \
"check:Check for updates to Rust toolchains" \
"default:Set the default toolchain" \
"toolchain:Modify or query the installed toolchains" \
"target:Modify a toolchain's supported targets" \
"component:Modify a toolchain's installed components" \
"override:Modify directory toolchain overrides" \
"run:Run a command with an environment configured for a given toolchain" \
"which:Display which binary will be run for a given command" \
"doc:Open the documentation for the current toolchain" \
"man:View the man page for a given command" \
"self:Modify the rustup installation" \
"set:Alter rustup settings" \
"completions:Generate tab-completion scripts for your shell" \
"help:Prints this message or the help of the given subcommand(s)" \
    )
    _describe -t commands 'rustup commands' commands "$@"
}
(( $+functions[_rustup__show__active-toolchain_commands] )) ||
_rustup__show__active-toolchain_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup show active-toolchain commands' commands "$@"
}
(( $+functions[_rustup__add_commands] )) ||
_rustup__add_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup add commands' commands "$@"
}
(( $+functions[_rustup__component__add_commands] )) ||
_rustup__component__add_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup component add commands' commands "$@"
}
(( $+functions[_rustup__override__add_commands] )) ||
_rustup__override__add_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup override add commands' commands "$@"
}
(( $+functions[_rustup__target__add_commands] )) ||
_rustup__target__add_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup target add commands' commands "$@"
}
(( $+functions[_rustup__toolchain__add_commands] )) ||
_rustup__toolchain__add_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup toolchain add commands' commands "$@"
}
(( $+functions[_rustup__check_commands] )) ||
_rustup__check_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup check commands' commands "$@"
}
(( $+functions[_rustup__completions_commands] )) ||
_rustup__completions_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup completions commands' commands "$@"
}
(( $+functions[_rustup__component_commands] )) ||
_rustup__component_commands() {
    local commands; commands=(
        "list:List installed and available components" \
"add:Add a component to a Rust toolchain" \
"remove:Remove a component from a Rust toolchain" \
"help:Prints this message or the help of the given subcommand(s)" \
    )
    _describe -t commands 'rustup component commands' commands "$@"
}
(( $+functions[_rustup__default_commands] )) ||
_rustup__default_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup default commands' commands "$@"
}
(( $+functions[_rustup__set__default-host_commands] )) ||
_rustup__set__default-host_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup set default-host commands' commands "$@"
}
(( $+functions[_rustup__doc_commands] )) ||
_rustup__doc_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup doc commands' commands "$@"
}
(( $+functions[_docs_commands] )) ||
_docs_commands() {
    local commands; commands=(

    )
    _describe -t commands 'docs commands' commands "$@"
}
(( $+functions[_rustup__docs_commands] )) ||
_rustup__docs_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup docs commands' commands "$@"
}
(( $+functions[_rustup__dump-testament_commands] )) ||
_rustup__dump-testament_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup dump-testament commands' commands "$@"
}
(( $+functions[_rustup__component__help_commands] )) ||
_rustup__component__help_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup component help commands' commands "$@"
}
(( $+functions[_rustup__help_commands] )) ||
_rustup__help_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup help commands' commands "$@"
}
(( $+functions[_rustup__override__help_commands] )) ||
_rustup__override__help_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup override help commands' commands "$@"
}
(( $+functions[_rustup__self__help_commands] )) ||
_rustup__self__help_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup self help commands' commands "$@"
}
(( $+functions[_rustup__set__help_commands] )) ||
_rustup__set__help_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup set help commands' commands "$@"
}
(( $+functions[_rustup__show__help_commands] )) ||
_rustup__show__help_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup show help commands' commands "$@"
}
(( $+functions[_rustup__target__help_commands] )) ||
_rustup__target__help_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup target help commands' commands "$@"
}
(( $+functions[_rustup__toolchain__help_commands] )) ||
_rustup__toolchain__help_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup toolchain help commands' commands "$@"
}
(( $+functions[_rustup__show__home_commands] )) ||
_rustup__show__home_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup show home commands' commands "$@"
}
(( $+functions[_rustup__install_commands] )) ||
_rustup__install_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup install commands' commands "$@"
}
(( $+functions[_rustup__target__install_commands] )) ||
_rustup__target__install_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup target install commands' commands "$@"
}
(( $+functions[_rustup__toolchain__install_commands] )) ||
_rustup__toolchain__install_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup toolchain install commands' commands "$@"
}
(( $+functions[_rustup__show__keys_commands] )) ||
_rustup__show__keys_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup show keys commands' commands "$@"
}
(( $+functions[_rustup__toolchain__link_commands] )) ||
_rustup__toolchain__link_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup toolchain link commands' commands "$@"
}
(( $+functions[_rustup__component__list_commands] )) ||
_rustup__component__list_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup component list commands' commands "$@"
}
(( $+functions[_rustup__override__list_commands] )) ||
_rustup__override__list_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup override list commands' commands "$@"
}
(( $+functions[_rustup__target__list_commands] )) ||
_rustup__target__list_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup target list commands' commands "$@"
}
(( $+functions[_rustup__toolchain__list_commands] )) ||
_rustup__toolchain__list_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup toolchain list commands' commands "$@"
}
(( $+functions[_rustup__man_commands] )) ||
_rustup__man_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup man commands' commands "$@"
}
(( $+functions[_rustup__override_commands] )) ||
_rustup__override_commands() {
    local commands; commands=(
        "list:List directory toolchain overrides" \
"set:Set the override toolchain for a directory" \
"unset:Remove the override toolchain for a directory" \
"help:Prints this message or the help of the given subcommand(s)" \
    )
    _describe -t commands 'rustup override commands' commands "$@"
}
(( $+functions[_rustup__set__profile_commands] )) ||
_rustup__set__profile_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup set profile commands' commands "$@"
}
(( $+functions[_rustup__show__profile_commands] )) ||
_rustup__show__profile_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup show profile commands' commands "$@"
}
(( $+functions[_rustup__component__remove_commands] )) ||
_rustup__component__remove_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup component remove commands' commands "$@"
}
(( $+functions[_rustup__override__remove_commands] )) ||
_rustup__override__remove_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup override remove commands' commands "$@"
}
(( $+functions[_rustup__remove_commands] )) ||
_rustup__remove_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup remove commands' commands "$@"
}
(( $+functions[_rustup__target__remove_commands] )) ||
_rustup__target__remove_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup target remove commands' commands "$@"
}
(( $+functions[_rustup__toolchain__remove_commands] )) ||
_rustup__toolchain__remove_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup toolchain remove commands' commands "$@"
}
(( $+functions[_rustup__run_commands] )) ||
_rustup__run_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup run commands' commands "$@"
}
(( $+functions[_rustup__self_commands] )) ||
_rustup__self_commands() {
    local commands; commands=(
        "update:Download and install updates to rustup" \
"uninstall:Uninstall rustup." \
"upgrade-data:Upgrade the internal data format." \
"help:Prints this message or the help of the given subcommand(s)" \
    )
    _describe -t commands 'rustup self commands' commands "$@"
}
(( $+functions[_rustup__override__set_commands] )) ||
_rustup__override__set_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup override set commands' commands "$@"
}
(( $+functions[_rustup__set_commands] )) ||
_rustup__set_commands() {
    local commands; commands=(
        "default-host:The triple used to identify toolchains when not specified" \
"profile:The default components installed" \
"help:Prints this message or the help of the given subcommand(s)" \
    )
    _describe -t commands 'rustup set commands' commands "$@"
}
(( $+functions[_rustup__show_commands] )) ||
_rustup__show_commands() {
    local commands; commands=(
        "active-toolchain:Show the active toolchain" \
"home:Display the computed value of RUSTUP_HOME" \
"profile:Show the current profile" \
"keys:Display the known PGP keys" \
"help:Prints this message or the help of the given subcommand(s)" \
    )
    _describe -t commands 'rustup show commands' commands "$@"
}
(( $+functions[_rustup__target_commands] )) ||
_rustup__target_commands() {
    local commands; commands=(
        "list:List installed and available targets" \
"add:Add a target to a Rust toolchain" \
"remove:Remove a target from a Rust toolchain" \
"help:Prints this message or the help of the given subcommand(s)" \
    )
    _describe -t commands 'rustup target commands' commands "$@"
}
(( $+functions[_rustup__toolchain_commands] )) ||
_rustup__toolchain_commands() {
    local commands; commands=(
        "list:List installed toolchains" \
"install:Install or update a given toolchain" \
"uninstall:Uninstall a toolchain" \
"link:Create a custom toolchain by symlinking to a directory" \
"help:Prints this message or the help of the given subcommand(s)" \
    )
    _describe -t commands 'rustup toolchain commands' commands "$@"
}
(( $+functions[_rustup__self__uninstall_commands] )) ||
_rustup__self__uninstall_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup self uninstall commands' commands "$@"
}
(( $+functions[_rustup__target__uninstall_commands] )) ||
_rustup__target__uninstall_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup target uninstall commands' commands "$@"
}
(( $+functions[_rustup__toolchain__uninstall_commands] )) ||
_rustup__toolchain__uninstall_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup toolchain uninstall commands' commands "$@"
}
(( $+functions[_rustup__uninstall_commands] )) ||
_rustup__uninstall_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup uninstall commands' commands "$@"
}
(( $+functions[_rustup__override__unset_commands] )) ||
_rustup__override__unset_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup override unset commands' commands "$@"
}
(( $+functions[_rustup__self__update_commands] )) ||
_rustup__self__update_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup self update commands' commands "$@"
}
(( $+functions[_rustup__toolchain__update_commands] )) ||
_rustup__toolchain__update_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup toolchain update commands' commands "$@"
}
(( $+functions[_rustup__update_commands] )) ||
_rustup__update_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup update commands' commands "$@"
}
(( $+functions[_rustup__self__upgrade-data_commands] )) ||
_rustup__self__upgrade-data_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup self upgrade-data commands' commands "$@"
}
(( $+functions[_rustup__which_commands] )) ||
_rustup__which_commands() {
    local commands; commands=(

    )
    _describe -t commands 'rustup which commands' commands "$@"
}

_rustup "$@"
