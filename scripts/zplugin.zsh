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

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin load  zdharma/history-search-multi-word
zplugin light zsh-users/zsh-history-substring-search
zplugin light zsh-users/zsh-completions

# Load the pure theme, with zsh-async library that's bundled with it.
RPROMPT='%F{white}%*'  # Display time on the right
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zplugin ice from"gh-r" as"command"
zplugin load junegunn/fzf-bin

# sharkdp/fd
zplugin ice from"gh-r" as"program" mv"fd* -> fd" pick"fd/fd" bpick"*darwin*"
zplugin light sharkdp/fd

# ogham/exa, replacement for ls
zplugin ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa" bpick"*macos*"
zplugin light ogham/exa

# zplugin ice from"gh-r" as"command"
# zplugin light "clvv/fasd"
# zplug "wookayin/fzf-fasd"
# zplug "BurntSushi/ripgrep", as:command, from:gh-r, rename-to:rg

zplugin ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg" bpick"*darwin*"
zplugin light BurntSushi/ripgrep


