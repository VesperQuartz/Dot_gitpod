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
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit -D -t /usr/local/bin/
) >/dev/null &
disown
(
  sudo apt update
  sudo apt install -y neofetch \
    gh \
    exa
) >/dev/null &
disown

## installing language servers
(
  npm install -g @vtsls/language-server \
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

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

## Load dotfiles
(
  rm ~/.zshrc
  cd ~/.dotfiles || exit
  stow .
) &
disown
