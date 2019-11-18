export ZPLUG_HOME=${HOME}/.zplug
if [ ! -d "${ZPLUG_HOME}" ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
if [ ! -f "${ZPLUG_HOME}/init.zsh" ]; then
    echo "zplug is not properly installed. Please check."
fi
source ${ZPLUG_HOME}/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# (defer:2 means syntax-highlighting gets loaded after completions)
zplug 'zdharma/fast-syntax-highlighting', defer:2 # (like fish)
# (defer:3 means history-substring search gets loaded after syntax-highlighting)
zplug 'zsh-users/zsh-history-substring-search', defer:3 # (like fish)
zplug 'zsh-users/zsh-autosuggestions' # (like fish)
zplug 'zsh-users/zsh-completions', depth:1 # more completions

# For pure prompt
RPROMPT='%F{white}%*'  # Display time on the right
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# fzf
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2

zplug 'sharkdp/fd', as:command, from:gh-r
zplug "clvv/fasd", as:command, use:fasd
zplug "wookayin/fzf-fasd"
zplug "BurntSushi/ripgrep", as:command, from:gh-r, rename-to:rg
zplug "docker/cli", use:contrib/completion/zsh
if [ "$(uname -s)" = 'Darwin' ]; then
    ZPLUG_EXA_USE=macos-x86_64
else
    ZPLUG_EXA_USE=linux-x86_64
fi
zplug "ogham/exa", as:command, from:gh-r, use:"*${ZPLUG_EXA_USE}*", rename-to:exa

if [ "$(uname -s)" = 'Linux' ]; then
    # ----------------
    # Bazel completion
    # ----------------
    zplug bazelbuild/bazel, use:scripts
    fpath[1,0]=$ZPLUG_HOME/repos/bazelbuild/bazel/scripts/zsh_completion
    # This way the completion script does not have to parse Bazel's options
    # repeatedly.  The directory in cache-path must be created manually.
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh/cache
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Setup fasd
eval "$(fasd --init auto)"
