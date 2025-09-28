#!/bin/bash

exec rm -rf /home/mutexc/.config/fish &
exec rm -rf /home/mutexc/.config/alacritty &
exec rm -rf /home/mutexc/.alacritty.toml &
exec rm -rf /home/mutexc/.config/nvim &
exec rm -rf /home/mutexc/.config/ghostty &
exec rm -rf /home/mutexc/.config/zed &
exec rm -rf /home/mutexc/.config/hypr &
exec rm -rf /home/mutexc/.config/sway &
exec rm -rf /home/mutexc/.config/waybar &
exec rm -rf /home/mutexc/.config/tmux &
exec rm -rf /home/mutexc/.config/fuzzel &
exec ln -s /home/mutexc/.config/dotfiles/sway/ /home/mutexc/.config &
exec ln -s /home/mutexc/.config/dotfiles/zed/ /home/mutexc/.config &
exec ln -s /home/mutexc/.config/dotfiles/alacritty/.alacritty.toml /home/mutexc &
exec ln -s /home/mutexc/.config/dotfiles/fish /home/mutexc/.config &
exec ln -s /home/mutexc/.config/dotfiles/nvim /home/mutexc/.config &
exec ln -s /home/mutexc/.config/dotfiles/hypr /home/mutexc/.config &
exec ln -s /home/mutexc/.config/dotfiles/waybar /home/mutexc/.config &
exec ln -s /home/mutexc/.config/dotfiles/fuzzel /home/mutexc/.config &
exec ln -s /home/mutexc/.config/dotfiles/tmux /home/mutexc/.config  &
exec ln -s /home/mutexc/.config/dotfiles/ghostty /home/mutexc/.config 
