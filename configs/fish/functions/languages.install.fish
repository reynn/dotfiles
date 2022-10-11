#!/usr/bin/env fish

function languages.install -d "Install language SDKs based on the LANGUAGES_xxxxx env variables"
    function ___usage
        set -l help_args -a "Install language SDKs based on the LANGUAGES_xxxxx env variables"

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    if test -n "$LANGUAGES_RUST_VERSION"
      __log debug "Installing Rust version $LANGUAGES_RUST_VERSION"
      if not test -x (which rustup)
        installer.rustup --quiet -y --no-modify-path
        set -p PATH "$HOME/.cargo/bin"
      end
      rustup install "$LANGUAGES_RUST_VERSION"
    end

    if test -n "$LANGUAGES_GO_VERSION"
      __log debug "Installing Go version $LANGUAGES_GO_VERSION"
      go.version.update "$LANGUAGES_GO_VERSION"
    end

    if test -n "$LANGUAGES_NODE_VERSION"
      __log debug "Installing NodeJS version $LANGUAGES_NODE_VERSION"
      nvm install "$LANGUAGES_NODE_VERSION"
    end
end

