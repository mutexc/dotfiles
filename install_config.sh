exec rm -rf /home/op/.themes &
exec rm -rf /home/op/.config/fish &
exec rm -rf /home/op/.config/alacritty &
exec rm -rf /home/op/.config/sway &
exec rm -rf /home/op/.alacritty.toml &
exec rm -rf /home/op/.tmux.conf &
exec rm -rf /home/op/.config/nvim &
exec rm -rf /home/op/.config/foot &
exec rm -rf /home/op/.vimrc &
exec rm -rf /home/op/.config/fuzzel &
exec ln -s /home/op/.config/dotfiles/alacritty/.alacritty.toml /home/op &
exec ln -s /home/op/.config/dotfiles/vim/.vimrc /home/op/.vimrc &
exec ln -s /home/op/.config/dotfiles/fuzzel /home/op/.config &
exec ln -s /home/op/.config/dotfiles/fish /home/op/.config &
exec ln -s /home/op/.config/dotfiles/sway /home/op/.config &
exec ln -s /home/op/.config/dotfiles/.themes /home/op/ &
exec ln -s /home/op/.config/dotfiles/tmux/.tmux.conf /home/op/ &
exec ln -s /home/op/.config/dotfiles/nvim /home/op/.config &
exec ln -s /home/op/.config/dotfiles/foot /home/op/.config &
