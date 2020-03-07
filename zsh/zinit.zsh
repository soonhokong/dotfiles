ZINIT_HOME=$HOME/.zinit
if [ ! -d "${ZINIT_HOME}" ]; then
   mkdir ~/.zinit
   git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
if [ ! -f "${ZINIT_HOME}/bin/zinit.zsh" ]; then
    echo "zinit is not properly installed. Please check."
fi

# Load zinit
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Install an extension for zinit for managing "shims"
zinit load soonho-tri/zabingemnode

# Load the pure theme, with zsh-async library that's bundled with it.
RPROMPT='%F{white}%*'  # Display time on the right
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

if [ "$(uname -s)" = 'Linux' ]; then
    BPICK="(*x86*linux*)|(*linux-x86*)|(*linux*amd*)"
else
    BPICK="(*darwin*amd*)|(*macos*)|(*apple*darwin*)"
fi

# FZF
zinit ice from"gh-r" fbin"fzf" bpick"${BPICK}"
zinit load junegunn/fzf-bin

# fzf-tmux script, completions for many programs (e.g. kill <TAB>)
# and key bindings
zinit ice multisrc"shell/{completion,key-bindings}.zsh" \
    id-as"junegunn/fzf_completions" pick"/dev/null" \
    sbin"bin/fzf-tmux"
zinit load junegunn/fzf

# FD
zinit ice from"gh-r" fbin"fd/fd" as"program" mv"fd* -> fd" pick"fd/fd" bpick"${BPICK}"
zinit light sharkdp/fd

# EXA
zinit ice from"gh-r" fbin"exa" as"program" mv"exa* -> exa" bpick"${BPICK}"
zinit light ogham/exa

# RG
zinit ice from"gh-r" fbin"rg/rg" as"program" mv"ripgrep* -> rg" pick"rp/rg" bpick"${BPICK}"
zinit light BurntSushi/ripgrep

# Bazel completion
if [ "$(uname -s)" = 'Linux' ]; then
    zinit snippet https://raw.githubusercontent.com/bazelbuild/bazel/master/scripts/zsh_completion/_bazel
    # This way the completion script does not have to parse Bazel's options
    # repeatedly.  The directory in cache-path must be created manually.
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh/cache
    if [ ! -d ~/.zsh/cache ]; then
	mkdir -p ~/.zsh/cache
    fi
fi

# fzf-fasd
zinit ice as"program" make
zinit light "clvv/fasd"
# Setup fasd
eval "$(fasd --init auto)"
zinit light "wookayin/fzf-fasd"

# Additional completion definitions
zinit ice blockf atclone'zinit creinstall -q .' atpull'%atclone'
zinit load zsh-users/zsh-completions

# History search by `Ctrl+R`
zinit ice compile'{hsmw-*,test/*}'
zinit load zdharma/history-search-multi-word

# Autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zinit ice compile'{src/*.zsh,src/strategies/*}' atload'_zsh_autosuggest_start'
zinit load zsh-users/zsh-autosuggestions

# Syntax highlighting
zinit light soonho-tri/fastsyntaxhighlighting
