# FIGMENTIZE: aliases
#         .__   .__
# _____   |  |  |__|_____     ______  ____    ______
# \__  \  |  |  |  |\__  \   /  ___/_/ __ \  /  ___/
#  / __ \_|  |__|  | / __ \_ \___ \ \  ___/  \___ \
# (____  /|____/|__|(____  //____  > \___  >/____  >
#      \/                \/      \/      \/      \/

# this is a centralised repository of all my aliases, in addition to some
# functions that are really aliases in spirit

# It seems to roughly work with both zsh and bash, but I couldn't possibly tell
# you about anything else. It uses plenty of posix incompatible [[ ]]

# vim-like: totally silence the given command, with less of the tedium. doesn't
# affect return status, so can be used inside if statements.
# black magic: "$@" expands to each argument as a separate word.
# gotcha: this won't expand any aliases you have. This is probably preferred
# functionality anyway, though (at least for me)
silent() {
    "$@" > /dev/null 2> /dev/null
}

# if tac command doesn't exist, use tail -r instead, and hope for the best
if ! silent command -v tac; then
    tac() {
        tail -r -- "$@"
    }
fi

# function to fully expand its arguments if they're aliases.
# obviously for personal use only, it uses eval etc and so forth ad nauseum
# In zsh, you can interactively expand the current word as an alias using <C-x>a
# by default (the ZLE _expand_alias function)
# TODO: fix this - doesn't work properly for eg $ enhance echo "abc def" hij
enhance() {
    eval "
    GOEDEL_ENHANCE_F() {
        $*
    }"
    declare -f GOEDEL_ENHANCE_F |\
        if [ -n "$ZSH_VERSION" ]; then
            tail -n +2 | sed "s/^	//"
        # assume everything else acts like bash
        else
            tail -n +3 | sed "s/^    //"
        # this removes the last line. Can't use head -n -1 as that doesn't work
        # on BSD
        fi | tac | tail -n +2 | tac
}

# if you want to really ruin someone's day, run this in a high frequency while
# loop:
# while true; do insomniac_twitch; sleep 0.5; done
insomniac_twitch() {
    local dis_w=$(xdotool getdisplaygeometry | awk '{print $1}')
    local dis_h=$(xdotool getdisplaygeometry | awk '{print $2}')
    local gen_x=$(shuf -i 1-"$dis_w" -n 1)
    local gen_y=$(shuf -i 1-"$dis_h" -n 1)
    xdotool mousemove "$gen_x" "$gen_y"
    notify-send twitch "$(date +"%H:%M:%S")"
}

# tap left control, programmatically
insomniac_press() {
    xdotool key Control_L
    notify-send press "$(date +"%H:%M:%S")"
}

# function to cd to a lot of directories, for experimenting with DIRSTACK type
# options
# Also serves as a handy example of how to properly loop over find output.
alias populate_dirstack='find "$HOME" -maxdepth 2 -type d -print0 | while IFS= read -r -d "" d; do cd "$d"; done'

# switch on/switch off networking
alias airplane='nmcli radio all off'
alias unairplane='nmcli radio all on'

# sanitise $1 so that it becomes suitable for use with your basic grep
function grepsanitise() {
    sed 's/[].*^$]\|\[/\\&/g' <<< "$1"
}

# make grep and friends case insensitive
alias grep='grep -i --color=auto'
alias ack='ack -i'
alias ag='ag -i'

# run pascal files as scripts with instantfpc
alias ifpc='instantfpc'

# FIXME this doesn't actually work because of hoogle for some reason
alias hoogle='hoogle --color=true'

# cat with colours
alias ccat='highlight -O ansi'
# an alternative with pygmentize is:
# alias ccat='pygmentize -g -f terminal'

# DIY coloured man pages using an alias so it's faster
# colours personally engineered to not be utterly disgusting, unlike OMZ's
# colored-manpages, apparently.
# mb, md, so, us, me, se, ue respectively correspond to:
# start blinking - not sure what this is for actually
# start bold - used for section headers and key words
# start standout mode - used for statusline and search hits
# start underline mode - used for important words
# end all modes
# end standout
# end underline

# also, a bit of trickery to make the alias be on one line, but formatted over
# several, as some systems get themselves confused about \ns.
alias man="$(echo "LESS_TERMCAP_mb='$(tput bold)$(tput setaf 6)'"\
                  "LESS_TERMCAP_md='$(tput bold)$(tput setaf 4)'"\
                  "LESS_TERMCAP_so='$(tput setab 0)$(tput setaf 7)'"\
                  "LESS_TERMCAP_us='$(tput setaf 2)'"\
                  "LESS_TERMCAP_me='$(tput sgr0)'"\
                  "LESS_TERMCAP_se='$(tput sgr0)'"\
                  "LESS_TERMCAP_ue='$(tput sgr0)'"\
                  "man")"

alias info='info --vi-keys'

alias feh='feh -d'

# ls aliases, based on what the ls in PATH seems to be capable of
# https://stackoverflow.com/questions/1676426/how-to-check-the-ls-version
if silent ls --color -d .; then # GNU ls, probably
    # lc_all=c so that sorting is case sensitive, as it should be.
    alias ls='LC_ALL=C ls -h --group-directories-first --color=auto'
    # long listings with and without group of owner
    alias l='ls -l -G'
    alias ll='ls -l'
    alias la='ls -la'
    alias lt='\ls -ltrh --color=auto'
    alias lb='ls -lSr'
    alias ldir='ls -l --directory'
elif silent gls --color -d .; then # GNU ls is on the system as "gls"
    alias ls='LC_ALL=C gls -h --group-directories-first --color=auto'
    alias l='ls -l -G'
    alias ll='ls -l'
    alias la='ls -la'
    alias lt='\gls -ltrh --color=auto'
    alias lb='ls -lSr'
    alias ldir='ls -l --directory'
elif silent ls -G -d .; then # BSD ls, probably (eg as on MacOS)
    alias ls='LC_ALL=C ls -h -G'
    alias lt='\ls -ltrh -G'
    alias l='ls -l -o'
    alias ll='ls -l'
    alias la='ls -la'
    alias ldir='ls -l -d'
    alias lb='ls -lSr'
else # some other ls (solaris?)
    # empty true to make bash happy
    true
fi

# safety first
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# never mind about that, it seems to break everything
# case $OSTYPE in
#     darwin*)
#         # because the OSX system vimrc is shite
#         alias vim='vim -u ~/.vimrc'
#         ;;
# esac

# vim is now 60% faster to type than emacs
# This is an alias that I've quite badly gotten used to. Beware that you might
# accidentally open actual vi on systems where vi isn't symlinked to vim
alias vi=vim
# TODO: add TODO file
# VI TeX files, with a servername to enable SyncTeX
alias vitx='vim --servername vim **/*.tex **/*.sty'
# so I get my own vimrc when I use view
alias view='vim -R'

# open the most recently written session in ~/.vim/sessions
revim() {
    local n=${1:-1}
    # TODO
    # assumes that you've not got any newlines in your session names, because
    # chronological order is a PAIN with find.
    vim -S "$(\ls -t --directory "$HOME"/.vim/sessions/* | head -n $n | tail -n 1)"
}

# if light locker exists, alias lock to be alongside poweroff & reboot etc
if silent command -v light-locker-command; then
    alias lock='light-locker-command -l'
else
    # mess around with quotes for ships and giggs
    # I basically just prefer to have a consistent outer quoting style here.
    alias lock='echo "I don'"'"'t know how to lock"'
fi

# open ipython with my maths profile
alias maths='ipython --profile=maths'

# display my timetable for school using elinks
alias tt='elinks -dump -dump-width $COLUMNS "$HOME/Documents/timetable.html"'

# new and improved c & v, inspired by & modified from OMZ. Aliases pointing to
# executables in my ~/bin
# These provide copy and paste, somewhat sensitive to what cliboard interfaces
# there are on your system.
alias c='goedel_copy'
alias v='goedel_paste'

# define the o alias to be a mimetype aware opener.
case "$(uname -s)" in
    Darwin)
        alias o=open
        ;;
    Cygwin)
        alias o=cygstart
        ;;
    *)
        if silent command -v mimeopen; then
            alias o=mimeopen
        elif silent command -v xdg-open; then
            alias o=xdg-open
        else
            alias o='echo "no idea mate" >&2'
        fi
        ;;
esac

# latex/pdf compilation related aliases
alias lmk='latexmk'
alias present='evince -s'
alias latex="latex -synctex=1  --shell-escape -halt-on-error";
alias pdflatex="pdflatex -synctex=1 -shell-escape -halt-on-error";
alias xelatex="xelatex -synctex=1 -shell-escape -halt-on-error";

# use GNU sed to explicitly print escape sequences
alias clarify='sed -n l'

# the space means that sudo can be followed by an alias (particularly things
# like sudo p for sudo pacman)
alias sudo='sudo '

# root zsh
alias rzsh='sudo ZSH_DISABLE_COMPFIX=true ZDOTDIR="$ZDOTDIR" HOME="$HOME" zsh'
# bare zsh
alias bzsh='ZDOTDIR=/ zsh'
# plain (root)? zsh
alias pzsh='GOEDEL_NO_POWERLINE=true zsh'
alias przsh='sudo GOEDEL_NO_POWERLINE=true ZSH_DISABLE_COMPFIX=true ZDOTDIR="$ZDOTDIR" HOME="$HOME" zsh'
# (plain)? zsh with apparix loaded
# alias azsh='GOEDEL_APPARIX=true zsh'
# alias pazsh='GOEDEL_NO_POWERLINE=true GOEDEL_APPARIX=true zsh'
# The intersection of root and apparix is intentionally unexplored.
# reload zsh configuration properly, by replacing the current shell with a fresh
# zsh
alias z='exec zsh'

# similar for bash
alias b='exec bash'
# root bash
alias rbash='sudo HOME="$HOME" bash'

# open various config files
alias vi3='vim ~/.config/i3/config'
alias viz='vim "$ZDOTDIR"/{zshrc,*.zsh,*.sh,zshenv,zprofile,prompts/*} "$BASHDOTDIR"/* ~/.profile'
alias vig='vim ~/.gitconfig'
alias vit='vim ~/Documents/TODO'
alias viv='vim ~/.vim/{*vimrc,*.vim}'
alias vif='vim ~/fun'
alias vid='vim ~/fun/diary'
alias vix='vim ~/.Xresources'
alias vic='vim ~/.config'
alias visafe='vim -c "set noswapfile nobackup nowritebackup noundofile viminfo="'
alias vienc='visafe ~/Documents/.enc/'
alias vitm='vim ~/.tmux.conf'

# reload various types of configuration
alias x='xrdb merge ~/.Xresources'
alias t='tmux source-file ~/.tmux.conf'

# restart or test wifi connection
alias wifirestart='sudo systemctl restart NetworkManager.service'
alias p88='ping 8.8.8.8 -c 20 -w 60'

# nice git alias. BASH USERS BEWARE: Bash isn't able to look inside aliases to
# provide tab completion for their contents. The easy solution is to switch to
# zsh, or you might consider implementing something like this
# https://unix.stackexchange.com/questions/4219/how-do-i-get-bash-completion-for-command-aliases
# in your bashrc.
alias g=git

# special git for dotfiles
# it's a function because it can't be trusted to have its completion inferred
# from the alias, and I define my own completion in ~/.zcomp/_cfg
cfg() {
    /usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" "$@"
}

# legacy gal function from when I used shell aliases for git
# gal() {
#     grep alias "$HOME/.gitconfig" | grep "$*"
# }

# function to display or filter git aliases, looking for some regex. quite
# useful if you have a complex alias for something but you can't remember
# the name, but you know roughly the subject it's in. Can also be used to show
# what aliases do if you want to use them yourself.
gal() {
    # scrape the alias section using an awk command, which sets a flag to true
    # at [alias], and then unsets it as soon as there is a nonwhite character on
    # the first line
    # awk '/\[alias\]/{a=1;next}/^[^	]/{a=0}a' "$HOME/.gitconfig" |\
    #   sed "s/^	//" | grep -v "^;" | grep "$1"
    git config --list | grep '^alias' | sed 's/^alias\.//' | grep "$1"
}

alias mutt='echo "use configured mailbox" >&2'
alias hills_mail='\mutt -F ~/.mutt/hills_muttrc'
alias gmail='\mutt -F ~/.mutt/gmail_muttrc'

# get most recent n screenshots (1 by default)
# useful to copy it to current directory or similar.
# this assumes that screenshots are stored to ~/Pictures/screenshots
# TODO:
# uses ls instead of find for chronological ordering
screenshots() {
    \ls -t --directory "$HOME"/Pictures/screenshots/* |
        grep "${2:-}" | head -"${1:-1}";
}

# Get a weather report, over http
wttr() {
    curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${*:-Great_Shelford}"
}

# Copy a full path to its argument. Useful if you need to open something in
# another application that understands file paths.
cppath() {
    # hack to cleanly get rid of the trailing newline
    realpath "$1" -z | xargs -0 echo -n | goedel_copy
}

# Arch linux specific aliases
alias pacman='pacman --color=auto'
alias p='pacman'
alias pacsystree='for i in $(pacman -Qeq); do pactree $i; done'


# Frivolous aliases

# make figlet use my extra figlet fonts
if [ -d "$HOME/builds/figlet-fonts" ]; then
    alias figlet='figlet -k -t -d ~/builds/figlet-fonts/'
else
    alias figlet='figlet -k -t'
fi

# display all figlet fonts
figfonts() {
    local exts="$(end='' printf "%s" '.*\.\('"$(
        (end='' printf "flf tlf "  && figlet -I 5) | sed -e 's/  */\\|/g')"'\)$')"
    echo "finding all $exts in $(figlet -I 2)"
    find "$(figlet -I 2)" -type f -regex "$exts" \
        -exec echo {} \;\
        -exec figlet -ktd "$(figlet -I 2)" -f {} "${1:-Test 123}" \;\
        -exec echo \;
}

# force lolcat to colour, so it can be piped. Who on earth pipes data to lolcat
# in order for lolcat NOT TO CHANGE IT???
alias lolcat='lolcat -f'

# self explanatory
# TODO: add The Box
alias starwars='tput setaf 220 && tput bold && figlet -f starwars -w 80 "STAR WARS"'

# hack to force buffering by line
partytime() {
    base64 --wrap=$COLUMNS /dev/urandom | lolcat -F 0.01 -p 1 | while read -r line;
    do
        echo "$line"
    done
}

# random {cowsay,cowthink}
alias rcowsay='cowsay -f $(cowsay -l | tail +2 | xargs shuf -n1 -e)'
alias rcowthink='cowthink -f $(cowsay -l | tail +2 | xargs shuf -n1 -e)'
# SINGLE QUOTES to stop the command substitution happening at startup
alias partycow='while true; do fortune | rcowsay; done | pv -q -l -L 3 | lolcat'
# go on a 23 day mad one
alias mathsparty='timestable -l 10000000 | pv -lq -L 5 | lolcat -p 10 -F 0.01'

# look cooler
alias cmatrix='cmatrix -abu 1'