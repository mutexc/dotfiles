# General apps
echo 'installing general apps...' &
exec sudo pacman -S --needed hyprland waybar alacritty zed neovim fish firefox chromium inkscape krita virt-manager qemu obs-studio & 
echo 'Done' &
echo 'removing default config...' &
# remove existing configs
exec rm -rf /home/op/.config/fish &
exec rm -rf /home/op/.config/alacritty &
exec rm -rf /home/op/.alacritty.toml &
exec rm -rf /home/op/.config/nvim &
exec rm -rf /home/op/.config/zed &
exec rm -rf /home/op/.config/hypr &
exec rm -rf /home/op/.config/waybar &
exec rm -rf /home/op/.config/fuzzel &
exec mkdir /home/op/.themes &
echo 'Done' &
echo 'creating symlinks...' &
# hyperlinks
exec ln -s /home/op/.config/dotfiles/zed/ /home/op/.config &
exec ln -s /home/op/.config/dotfiles/alacritty/.alacritty.toml /home/op &
exec ln -s /home/op/.config/dotfiles/fish /home/op/.config &
exec ln -s /home/op/.config/dotfiles/nvim /home/op/.config &
exec ln -s /home/op/.config/dotfiles/hypr /home/op/.config &
exec ln -s /home/op/.config/dotfiles/waybar /home/op/.config &
exec ln -s /home/op/.config/dotfiles/fuzzel /home/op/.config &
exec ln -s /home/op/.config/dotfiles/themes/adwaita-dark/ /home/op/.themes &
echo 'Done'
