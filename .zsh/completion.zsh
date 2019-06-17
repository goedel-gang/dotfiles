#                                 .__            __   .__
#   ____   ____    _____  ______  |  |    ____ _/  |_ |__|  ____    ____
# _/ ___\ /  _ \  /     \ \____ \ |  |  _/ __ \\   __\|  | /  _ \  /    \
# \  \___(  <_> )|  Y Y  \|  |_> >|  |__\  ___/ |  |  |  |(  <_> )|   |  \
#  \___  >\____/ |__|_|  /|   __/ |____/ \___  >|__|  |__| \____/ |___|  /
#      \/              \/ |__|               \/                        \/
# FIGMENTIZE: completion

autoload -Uz compinit
# leftover from oh-my-zsh
# Sometimes I manually disable security checks, for example to run a zsh as
# root.
if [[ "$ZSH_DISABLE_COMPFIX" == "true" ]]; then
    compinit -u
else
    compinit
fi

# set up completions for kitty. Bit of a dubious way to package completion code,
# but hey. Also for some incomprehensible reason they seem to have custom
# completion code for files
if silent command -v kitty; then
    source <(kitty +complete setup zsh)
else
    >&2 echo "zshrc: you should probably install kitty or get rid of this bit"
fi

# define completion for the xcat function
compdef _command_names xcat

# completion insensitive to case and hyphen/underscores
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' glob 1
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes true
# zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle :compinstall filename "$ZDOTDIR/zshrc"

# Display red dots whilst waiting for completion.
expand-or-complete-with-dots() {
    print -Pn "%{%F{red}......%f%}"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
