#!/bin/bash

exec rm -rf /home/op/.config/fish &
exec rm -rf /home/op/.config/alacritty &
exec rm -rf /home/op/.alacritty.toml &
exec rm -rf /home/op/.config/nvim &
exec rm -rf /home/op/.config/zed &
exec rm -rf /home/op/.config/sway.toml &
exec ln -s /home/op/.config/dotfiles/sway/ /home/op/.config &
exec ln -s /home/op/.config/dotfiles/zed/ /home/op/.config &
exec ln -s /home/op/.config/dotfiles/alacritty/.alacritty.toml /home/op &
exec ln -s /home/op/.config/dotfiles/fish /home/op/.config &
exec ln -s /home/op/.config/dotfiles/nvim /home/op/.config &
