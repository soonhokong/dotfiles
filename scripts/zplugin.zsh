ZPLUGIN_HOME=$HOME/.zplugin
if [ ! -d "${ZPLUGIN_HOME}" ]; then
   mkdir ~/.zplugin
   git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi
if [ ! -f "${ZPLUGIN_HOME}/bin/zplugin.zsh" ]; then
    echo "zplugin is not properly installed. Please check."
fi
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light zplugin/z-a-bin-gem-node

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-completions

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

# fzf: Auto-completion
zplugin snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
ls "${HOME}/.zplugin/snippets/https--raw.githubusercontent.com--junegunn--fzf--master--shell/completion.zsh/completion.zsh"
[[ $- == *i* ]] && source "${HOME}/.zplugin/snippets/https--raw.githubusercontent.com--junegunn--fzf--master--shell/completion.zsh/completion.zsh" 2> /dev/null

# fzf: Key bindings
zplugin snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
ls ${HOME}/.zplugin/snippets/https--raw.githubusercontent.com--junegunn--fzf--master--shell/key-bindings.zsh/key-bindings.zsh
source "${HOME}/.zplugin/snippets/https--raw.githubusercontent.com--junegunn--fzf--master--shell/key-bindings.zsh/key-bindings.zsh"

# HSMM
zplugin load  zdharma/history-search-multi-word

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
