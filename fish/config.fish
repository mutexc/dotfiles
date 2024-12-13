# for a bitsavvy in rust
set -Ux DATABASE_URL_C "postgresql://op:aobd1202@localhost:5432/abs_db"
set -Ux DATABASE_URL "postgresql://op:aobd1202@localhost:5432/abs_db"
# set -Ux DATABASE_URL "postgresql://op:aobd1202@localhost/abs_db"
set -Ux ASSETS_FOLDER /home/op/abs/src/assets

# for a bitsavvy rewrite in go
# set -Ux GO_DATABASE_URL_C "host=localhost port=5999 user=op password=aobd1202 dbname=abs_db sslmode=disable"
# set -Ux GO_DATABASE_URL "host=localhost port=5999 user=op password=aobd1202 dbname=abs_db sslmode=disable"
# set -Ux ASSETS_FOLDER /home/op/ABitSavvy/src/assets

# enable vim mode
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
    fish_vi_key_bindings
end

# Commented out after switching to nixos
# fish_add_path /home/op/.cargo/bin
fish_add_path /usr/bin/
fish_add_path /home/op/.local/share/bin
fish_add_path /home/op/.local/share/icons
fish_add_path /home/op/.local/bin/
fish_add_path /home/op/.local/share
fish_add_path /home/op/go/bin/
#
set fish_greeting ""
set -Ux _JAVA_AWT_WM_NONREPARENTING 1
