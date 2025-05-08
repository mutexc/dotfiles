# General apps
echo 'installing general apps...' &
exec sudo pacman -S --needed alacritty zed neovim fish firefox chromium inkscape krita virt-manager qemu obs-studio & 
# Desktop environment with some choosen apps
echo 'Done' &
echo 'installing kde apps...' &
exec sudo pacman -S --needed plasma dolphin dolphin-plugins ark gwenview okular spectacle kate filelight konsole kcalc kwalletmanager kio-extras ffmpegthumbs kdegraphics-thumbnailers qt6-imageformats kimageformats &
echo 'Done' &
echo 'removing default config...' &
# remove existing configs
exec rm -rf /home/op/.config/fish &
exec rm -rf /home/op/.config/alacritty &
exec rm -rf /home/op/.alacritty.toml &
exec rm -rf /home/op/.config/nvim &
exec rm -rf /home/op/.config/zed &
exec rm -rf /home/op/.config/xsettingsd &
exec rm -rf /home/op/.config/kglobalshortcutsrc &
echo 'Done' &
echo 'creating symlinks...' &
# hyperlinks
exec ln -s /home/op/.config/dotfiles/zed/ /home/op/.config &
exec ln -s /home/op/.config/dotfiles/alacritty/.alacritty.toml /home/op &
exec ln -s /home/op/.config/dotfiles/fish /home/op/.config &
exec ln -s /home/op/.config/dotfiles/nvim /home/op/.config &
exec ln -s /home/op/.config/dotfiles/kde-settings/xsettingsd/ /home/op/.config &
exec ln -s /home/op/.config/dotfiles/kde-settings/kglobalshortcutsrc /home/op/.config &
echo 'Done'
