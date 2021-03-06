#     .___.__                        .__
#   __| _/|__|_______   ____   ____  |  |    ____ _______  ______
#  / __ | |  |\_  __ \_/ ___\ /  _ \ |  |   /  _ \\_  __ \/  ___/
# / /_/ | |  | |  | \/\  \___(  <_> )|  |__(  <_> )|  | \/\___ \
# \____ | |__| |__|    \___  >\____/ |____/ \____/ |__|  /____  >
#      \/                  \/                                 \/
# FIGMENTIZE: dircolors

# file that sets up pretty ls colours, as best as it can according to what's on
# the system

# TODO make aware of profiles etc
if >/dev/null 2>&1 command -v dircolors; then
    if [ "$GOEDEL_IS_TTY" != "true" ]; then
        # workaround because dircolors doesn't know kitty's terminfo, and I
        # sometimes like to use kitty
        if [ "$TERM" = "xterm-kitty" ]; then
            provisional_term=xterm-256color
        else
            provisional_term="$TERM"
        fi

        if [ -r "$ZDOTDIR/solarized.dircolors" ]; then
            # regenerate this here just to keep it up to date
            TERM="xterm-256color" dircolors "$ZDOTDIR/solarized.dircolors" > "$ZDOTDIR/solarized.lscolors"
            eval "$(TERM="$provisional_term" dircolors "$ZDOTDIR/solarized.dircolors")"
        else
            >&2 echo "using default dircolors"
            eval "$(TERM="$provisional_term" dircolors)"
        fi
    else
        >&2 echo "using default dircolors as in tty"
        eval "$(dircolors)"
    fi
else
    >&2 echo "dircolors executable not found, using one I prepared earlier"
    source "$ZDOTDIR/solarized.lscolors"
fi
