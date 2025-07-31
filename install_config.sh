#!/bin/bash

exec rm -rf /home/op/.config/fish &
exec rm -rf /home/op/.config/alacritty &
exec rm -rf /home/op/.alacritty.toml &
exec rm -rf /home/op/.config/nvim &
exec rm -rf /home/op/.config/zed &
exec rm -rf /home/op/.config/hypr &
exec rm -rf /home/op/.config/sway &
exec rm -rf /home/op/.config/waybar &
exec ln -s /home/op/.config/dotfiles/sway/ /home/op/.config &
exec ln -s /home/op/.config/dotfiles/zed/ /home/op/.config &
exec ln -s /home/op/.config/dotfiles/alacritty/.alacritty.toml /home/op &
exec ln -s /home/op/.config/dotfiles/fish /home/op/.config &
exec ln -s /home/op/.config/dotfiles/nvim /home/op/.config &
exec ln -s /home/op/.config/dotfiles/hypr /home/op/.config &
exec ln -s /home/op/.config/dotfiles/waybar /home/op/.config &
