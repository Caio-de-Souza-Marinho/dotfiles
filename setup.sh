#!/bin/bash

# Symlink Neovim config
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json

# Symlink Lua folder
mkdir -p ~/.config/nvim/lua
for file in ~/dotfiles/nvim/lua/*; do
    ln -sf "$file" ~/.config/nvim/lua/
done

# Symlink tmux config
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

