exec rm -rf /root/.config/fish &
exec rm -rf /root/.config/tmux &
exec rm -rf /root/.config/nvim &
exec ln -s /home/mutexc/.config/dotfiles/fish /root/.config &
exec ln -s /home/mutexc/.config/dotfiles/tmux /root/.config  &
exec ln -s /home/mutexc/.config/dotfiles/nvim /root/.config &
