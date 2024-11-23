#!/usr/bin/env bash

cd "$(mktemp -d)" || exit

URL="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
if test -n "$NEOVIM_VERSION"; then
  URL="https://github.com/neovim/neovim/releases/download/$NEOVIM_VERSION/nvim.appimage"
fi

curl -LO "$URL"
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract >/dev/null
mkdir -p /home/gitpod/.local/bin
ln -s "$(pwd)/squashfs-root/AppRun" /home/gitpod/.local/bin/nvim

(
  sudo apt update
  sudo apt install -y neofetch \
    gh \
    lazygit \
    lua-language-server
) >/dev/null &
disown

## Load dotfiles
(
  cd dotfiles || exit
  stow .
)

## installing language servers
(
  npm install -g vtsls \
    awk-language-server \
    vscode-solidity-server \
    solc \
    bash-language-server \
    @tailwindcss/language-server \
    vscode-langservers-extracted \
    @astrojs/language-server \
    svelte-language-server

) >/dev/null &
disown
