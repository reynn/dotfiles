function go_ch
    if test -n "$1"
        echo "[Debug] Running Gimme with version $1"
        eval (GIMME_SILENT_ENV=true gimme $1)
    else
        echo "[Debug] Sourcing latest Gimme env..."
        test ! -L "$HOME/.gimme/envs/latest.env" || source "$HOME/.gimme/envs/latest.env"
    end
end
