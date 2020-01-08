ZPLUGIN_HOME=$HOME/.zplugin
if [ ! -d "${ZPLUGIN_HOME}" ]; then
   mkdir ~/.zplugin
   git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi
if [ ! -f "${ZPLUGIN_HOME}/bin/zplugin.zsh" ]; then
    echo "zplugin is not properly installed. Please check."
fi

# Load zplugin
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Install an extension for zplugin for managing "shims"
zplugin load zplugin/z-a-bin-gem-node

# Load the pure theme, with zsh-async library that's bundled with it.
RPROMPT='%F{white}%*'  # Display time on the right
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

if [ "$(uname -s)" = 'Linux' ]; then
    BPICK="(*x86*linux*)|(*linux-x86*)|(*linux*amd*)"
else
    BPICK="(*darwin*amd*)|(*macos*)|(*apple*darwin*)"
fi

# FZF
zplugin ice from"gh-r" fbin"fzf" bpick"${BPICK}"
zplugin load junegunn/fzf-bin

# fzf-tmux script, completions for many programs (e.g. kill <TAB>)
# and key bindings
zplugin ice multisrc"shell/{completion,key-bindings}.zsh" \
    id-as"junegunn/fzf_completions" pick"/dev/null" \
    sbin"bin/fzf-tmux"
zplugin load junegunn/fzf

# FD
zplugin ice from"gh-r" fbin"fd/fd" as"program" mv"fd* -> fd" pick"fd/fd" bpick"${BPICK}"
zplugin light sharkdp/fd

# EXA
zplugin ice from"gh-r" fbin"exa" as"program" mv"exa* -> exa" bpick"${BPICK}"
zplugin light ogham/exa

# RG
zplugin ice from"gh-r" fbin"rg/rg" as"program" mv"ripgrep* -> rg" pick"rp/rg" bpick"${BPICK}"
zplugin light BurntSushi/ripgrep

# Bazel completion
if [ "$(uname -s)" = 'Linux' ]; then
    zplugin snippet https://raw.githubusercontent.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel
    # This way the completion script does not have to parse Bazel's options
    # repeatedly.  The directory in cache-path must be created manually.
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh/cache
    if [ ! -d ~/.zsh/cache ]; then
	mkdir -p ~/.zsh/cache
    fi
fi

# fzf-fasd
zplugin ice as"program" make
zplugin light "clvv/fasd"
# Setup fasd
eval "$(fasd --init auto)"
zplugin light "wookayin/fzf-fasd"

# Additional completion definitions
zplugin ice blockf atclone'zplugin creinstall -q .' atpull'%atclone'
zplugin load zsh-users/zsh-completions

# History search by `Ctrl+R`
zplugin ice compile'{hsmw-*,test/*}'
zplugin load zdharma/history-search-multi-word

# Autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zplugin ice compile'{src/*.zsh,src/strategies/*}' atload'_zsh_autosuggest_start'
zplugin load zsh-users/zsh-autosuggestions

# Syntax highlighting
# (compinit without `-i` spawns warning on `sudo -s`)
zplugin ice wait'0' lucid atinit"ZPLGM[COMPINIT_OPTS]='-i' zpcompinit; zpcdreplay"
zplugin load zdharma/fast-syntax-highlighting
