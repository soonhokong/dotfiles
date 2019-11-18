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
zplugin load  zdharma/history-search-multi-word
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-completions

# Load the pure theme, with zsh-async library that's bundled with it.
RPROMPT='%F{white}%*'  # Display time on the right
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

if [ "$(uname -s)" = 'Linux' ]; then
    BPICK="(*darwin*)|(*macos*)"
else
    BPICK="*linux*"
fi

# FZF
zplugin ice from"gh-r" fbin"fzf"
zplugin load junegunn/fzf-bin

# FD
zplugin ice from"gh-r" fbin"fd/fd" as"program" mv"fd* -> fd" pick"fd/fd" bpick"${BPICK}"
zplugin light sharkdp/fd

# EXA
zplugin ice from"gh-r" fbin"exa" as"program" mv"exa* -> exa" bpick"${BPICK}"
zplugin light ogham/exa

# RG
zplugin ice from"gh-r" fbin"rg/rg" as"program" mv"ripgrep* -> rg" pick"rp/rg" bpick"${BPICK}"
zplugin light BurntSushi/ripgrep

# # zplugin ice from"gh-r" as"command"
# # zplugin light "clvv/fasd"
# # zplug "wookayin/fzf-fasd"
