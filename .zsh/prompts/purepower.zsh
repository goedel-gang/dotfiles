# ______   __ __ _______   ____  ______    ____ __  _  __  ____ _______
# \____ \ |  |  \\_  __ \_/ __ \ \____ \  /  _ \\ \/ \/ /_/ __ \\_  __ \
# |  |_> >|  |  / |  | \/\  ___/ |  |_> >(  <_> )\     / \  ___/ |  | \/
# |   __/ |____/  |__|    \___  >|   __/  \____/  \/\_/   \___  >|__|
# |__|                        \/ |__|                         \/
# FIGMENTIZE: purepower

# Original location: https://github.com/romkatv/dotfiles-public/blob/master/.purepower.
# If you copy this file, keep the link to the original and this sentence intact;
# you are encouraged to change everything else.

# As the previous paragraph says, this is not my own, but I have tweaked it a
# little, mostly with explanatory comments. It's very cool and so is its author!

# This file defines configuration options for Powerlevel10k ZSH theme that will
# make your prompt lightweight and sleek, unlike the default bulky look. You can
# also use it with Powerlevel9k -- a great choice if you need an excuse to have
# a cup of coffee after every command you type.

# This is how it'll look:
# https://raw.githubusercontent.com/romkatv/dotfiles-public/master/dotfiles/purepower.png.

# Pure Power needs to be installed in addition to Powerlevel10k, not instead of
# it. Pure Power defines a set of configuration parameters that affect the
# styling of Powerlevel10k; there is no code in it.

#                         PHILOSOPHY

# This configuration is made for those who care about style and value clear UI
# without redundancy and tacky ornaments that serve no function.

#   * No overwhelming background that steals attention from real content on your
#     screen.
#   * No redundant icons. A clock icon next to the current time takes space
#     without conveying any information. This is your personal prompt -- you
#     don't need an icon to remind you that the segment on the right shows
#     current time.
#   * No separators between prompt segments. Different foreground colors are
#     enough to keep them visually distinct.
#   * Bright colors for important things, low-contrast colors for everything
#     else.
#   * No needless color switching. The number of stashes you have in a git
#     repository is always green. Since its meaning is the same in a clean and
#     in a dirty repository, it doesn't change color.
#   * Works with any font.

#   * Your current directory is bright blue when under $HOME and brownish
#     everywhere else.
#   * '#' is shown on the far left if you cannot write to the current directory.
#   * The prompt symbol on the left is '❮' when vicmd keymap is active and '❯'
#     otherwise. It's green if the last command has succeeded and red if it has
#     failed.
#   * Git prompt colors:
#     * Grey: prompt is refreshing in the background (happens only in large
#       repositories).
#     * Green: clean (no stated or unstaged changes and no untracked files).
#     * Yellow: dirty (some stated or unstaged changes).
#     * Teal: some untracked files but otherwise clean (no staged or unstaged
#       changes).
#   * Git prompt icons:
#     * '@12345678' (git prompt color): detached HEAD at commit 12345678.
#     * 'my-feature' (git prompt color): on branch my-feature.
#     * 'my-feature|master' (git prompt color): on branch my-feature tracking
#       remote branch master.
#     * '#my-release' (git prompt color): on tag my-release.
#     * '+' (yellow): staged changes.
#     * '!' (yellow): unstaged changes.
#     * '?' (teal): untracked files.
#     * '⇡42' (green): 42 commits ahead of remote.
#     * '⇣42' (green): 42 commits behind remote.
#     * '*42' (green): 42 stashes.

#                        RIGHT PROMPT

#   * Error code with an optional signal name of the last command if it failed,
#     in red.
#   * Last command execution time (in seconds).
#   * '⇶' if you have background jobs.
#   * user@host in bright yellow if root, grey otherwise.
#   * If you type `custom_rprompt() { echo 'message' }` in your terminal, you'll
#     get 'message' shown on the right. Useful for integration with your scripts
#     that change some sort of state/environment.

#                       INSTALLATION

# 1. Copy this file to your home directory.

#    ( cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )

# 2. Source the file from ~/.zshrc.

#    echo 'source ~/.purepower' >>! ~/.zshrc

# 3. Enable Powerlevel10k ZSH theme. The easiest way is this:

#    git clone https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
#    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

# If you are using a plugin manager, see
# https://github.com/romkatv/powerlevel10k for installation options.

#                       CONFIGURATION

# You can set PURE_POWER_MODE before sourcing ~/.purepower to restrict the range
# of used characters.

#   * PURE_POWER_MODE=fancy     use unicode characters in the prompt (default)
#   * PURE_POWER_MODE=portable  use only ascii characters in the prompt

# You can switch mode on the fly by setting PURE_POWER_MODE and executing zsh.
# Useful when you end up in a prehistoric environment and see gibberish on your
# screen.

#   PURE_POWER_MODE=portable exec zsh  # switch to portable mode
#   PURE_POWER_MODE=fancy    exec zsh  # switch to fancy mode

# To automatically switch to portable mode when logging in from a terminal that
# doesn't support unicode, put the following incantation in your ~/.zshrc.

#   [[ $TERM == xterm* ]] || : ${PURE_POWER_MODE:=portable}
#   source ~/.purepower

# To configure what gets shown in the prompt, edit ~/.purepower. See
# https://github.com/romkatv/powerlevel10k/blob/master/README.md#installation-and-configuration
# for configuration options. Prompt configuration is a deeply personal affair,
# so take your time to craft the right prompt just for you. The stock
# configuration is merely a starting point, a source of inspiration, a frame for
# your own creation. Mercilessly slash everything of little value to you. Don't
# care how long commands take to execute? Get rid of command_execution_time
# segment! Boldly mold prompt pieces useful to you to ensure a perfect fit to
# your workflow and aesthetic preferences. Take full advantage of powerlevel
# over 9k!

# Remember that colors looks differently in different terminals. Use this script
# to choose what works best for you.

#   for ((i = 0; i != 256; ++i)); do print -P "%F{${(l:3::0:)i}}${(l:3::0:)i} TEST%f"; done

# Keep in mind that some prompt segments can appear and disappear depending on
# the state of your environment. Make sure colors work well in every situation.
# Neighboring segments should always have distinct colors.

# Try different fonts. Pure Power doesn't use esoteric symbols even in fancy
# mode and thus doesn't require a patched font. Any monospace font will do,
# although some are notoriously bad at displaying non-ascii symbols in
# terminals.

# If you are using Pure Power with Powerlevel9k rather than Powerlevel10k,
# you'll need to set PURE_POWER_USE_P10K_EXTENSIONS=0 before sourcing
# ~/.purepower or you'll see gibberish in your left prompt. This option will
# turn off vi keymap integration, so your prompt symbol will always be '❯'. Your
# prompt will also be 10-100 times slower with Powerlevel9k. This is not the
# fault of Pure Power. Powerlevel9k is slow with any styling.

#                       ATTRIBUTION

# Visual design of this configuration borrows heavily from
# https://github.com/sindresorhus/pure. Recreation of Pure look and feel in
# Powerlevel10k was inspired by https://github.com/iboyperson/p9k-theme-pastel.
# The origin myth is chiseled onto
# https://www.reddit.com/r/zsh/comments/b45w6v/.

() {
    emulate -L zsh && setopt no_unset pipe_fail

    # `$(_pp_c x y`) evaluates to `y` if the terminal supports >= 256 colors and
    # to `x` otherwise.
    zmodload zsh/terminfo
    if (( terminfo[colors] >= 256 )); then
        function _pp_c() { print -nr -- $2 }
    else
        function _pp_c() { print -nr -- $1 }
        typeset -g POWERLEVEL9K_IGNORE_TERM_COLORS=true
    fi

    function p9k_shlvl_prompt {
        print -P "%(2L.%L.)"
    }

    POWERLEVEL9K_CUSTOM_SHLVL="p9k_shlvl_prompt"
    POWERLEVEL9K_CUSTOM_SHLVL_FOREGROUND=yellow
    POWERLEVEL9K_CUSTOM_SHLVL_BACKGROUND=none

    # `$(_pp_s x y`) evaluates to `x` in portable mode and to `y` in fancy mode.
    if [[ ${PURE_POWER_MODE:-fancy} == fancy ]]; then
        function _pp_s() { print -nr -- $2 }
    else
        if [[ $PURE_POWER_MODE != portable ]]; then
            >&2 echo -En "purepower: invalid mode: ${(qq)PURE_POWER_MODE}; "
            >&2 echo -E  "valid options are 'fancy' and 'portable'; falling back to 'portable'"
        fi
        function _pp_s() { print -nr -- $1 }
    fi

    # POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status custom_shlvl background_jobs history)
    # POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context root_indicator dir_writable dir vcs)

    typeset -ga POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
            root_indicator dir_writable dir vcs)

    typeset -ga POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
            status background_jobs custom_shlvl history context)

    typeset -g POWERLEVEL9K_HISTORY_BACKGROUND=none
    typeset -g POWERLEVEL9K_HISTORY_FOREGROUND=005

    local ins=$(_pp_s '>' '❯')
    local cmd=$(_pp_s '<' '❮')

    if (( ${PURE_POWER_USE_P10K_EXTENSIONS:-1} )); then
        local p="\${\${\${KEYMAP:-0}:#vicmd}:+${${ins//\\/\\\\}//\}/\\\}}}"
        p+="\${\${\$((!\${#\${KEYMAP:-0}:#vicmd})):#0}:+${${cmd//\\/\\\\}//\}/\\\}}}"
    else
        p=$ins
    fi
    local ok="%F{$(_pp_c 002 076)}${p}%f"
    local err="%F{$(_pp_c 001 196)}${p}%f"

    # I removed the ruler section as I like my prompt to resize dynamically a
    # lot (mostly with tiling WMs), and it all seemed a little too cutting edge
    typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

    typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    # put rprompt on newline. This means that the lprompt has more space on
    # small terminals, and lets me use the general approach of putting
    # non-critical things in the rprompt. This also makes the prompt behave
    # itself better when you redraw it, as zsh knows it's an rprompt.
    typeset -g POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=" "
    typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?.$ok.$err) "

    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
    typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
    typeset -g POWERLEVEL9K_WHITESPACE_BETWEEN_{LEFT,RIGHT}_SEGMENTS=

    typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=none
    typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_VISUAL_IDENTIFIER_COLOR=003
    typeset -g POWERLEVEL9K_LOCK_ICON='#'

    typeset -g POWERLEVEL9K_DIR_{ETC,HOME,HOME_SUBFOLDER,DEFAULT}_BACKGROUND=none
    typeset -g POWERLEVEL9K_DIR_{ETC,DEFAULT}_FOREGROUND=$(_pp_c 003 209)
    typeset -g POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER}_FOREGROUND=$(_pp_c 004 039)
    typeset -g POWERLEVEL9K_{ETC,FOLDER,HOME,HOME_SUB}_ICON=

    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED,LOADING}_BACKGROUND=none
    typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$(_pp_c 002 076)
    typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$(_pp_c 006 014)
    typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$(_pp_c 003 011)
    typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=$(_pp_c 005 244)
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_UNTRACKEDFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_UNSTAGEDFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_MODIFIED_FOREGROUND
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_STAGEDFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_MODIFIED_FOREGROUND
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_INCOMING_CHANGESFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_OUTGOING_CHANGESFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_STASHFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_CLEAN_FOREGROUND
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_ACTIONFORMAT_FOREGROUND=001
    typeset -g POWERLEVEL9K_VCS_LOADING_ACTIONFORMAT_FOREGROUND=$POWERLEVEL9K_VCS_LOADING_FOREGROUND
    typeset -g POWERLEVEL9K_VCS_{GIT,GIT_GITHUB,GIT_BITBUCKET,GIT_GITLAB,BRANCH}_ICON=
    typeset -g POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON=$'%{\b|%}'
    typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
    typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
    typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
    typeset -g POWERLEVEL9K_VCS_STAGED_ICON='+'
    typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$(_pp_s '<' '⇣')
    typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$(_pp_s '>' '⇡')
    typeset -g POWERLEVEL9K_VCS_STASH_ICON='*'
    typeset -g POWERLEVEL9K_VCS_TAG_ICON=$'%{\b#%}'
    typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED}_MAX_NUM=99

    typeset -g POWERLEVEL9K_STATUS_OK=false
    typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=none
    typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$(_pp_c 001 009)
    typeset -g POWERLEVEL9K_CARRIAGE_RETURN_ICON=

    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=none
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$(_pp_c 005 101)
    typeset -g POWERLEVEL9K_EXECUTION_TIME_ICON=

    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND=none
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_COLOR=002
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_ICON=$(_pp_s '%%' '⇶')

    # typeset -g POWERLEVEL9K_CUSTOM_RPROMPT=custom_rprompt
    # typeset -g POWERLEVEL9K_CUSTOM_RPROMPT_BACKGROUND=none
    # typeset -g POWERLEVEL9K_CUSTOM_RPROMPT_FOREGROUND=$(_pp_c 004 012)

    typeset -g POWERLEVEL9K_ROOT_ICON=*
    typeset -g POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND=none
    typeset -g POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND=001

    typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,ROOT,REMOTE_SUDO,REMOTE,SUDO}_BACKGROUND=none
    typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,REMOTE_SUDO,REMOTE,SUDO}_FOREGROUND=$(_pp_c 007 244)
    typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=$(_pp_c 003 011)

    unfunction _pp_c _pp_s
}

source "$POWERLEVEL_THEME"
# TODO: doesn't work
PROMPT2=".. "
RPROMPT2="%^"
