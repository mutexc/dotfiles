exec rm -rf /home/op/.config/fish &
exec rm -rf /home/op/.config/alacritty &
exec rm -rf /home/op/.config/nvim &
exec rm -rf /home/op/.config/wezterm &
exec ln -s /home/op/.config/dotfiles/wezterm /home/op/.config &
exec ln -s /home/op/.config/dotfiles/alacritty/.alacritty.toml /home/op &
exec ln -s /home/op/.config/dotfiles/nvim /home/op/.config &
exec ln -s /home/op/.config/dotfiles/fish /home/op/.config &
