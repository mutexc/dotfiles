set -Ux DATABASE_URL_C "postgresql://op:aobd1202@127.0.0.1/abitsavvy"
set -Ux DATABASE_URL "postgresql://op:aobd1202@localhost/abitsavvy"
set -Ux ASSETS_FOLDER /home/op/ABitSavvy/src/assets

# enable vim mode
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
    fish_vi_key_bindings
end

fish_add_path /home/op/.cargo/bin
fish_add_path /usr/bin/
fish_add_path /home/mutexc/.local/bin/
#
set fish_greeting ""
set -Ux _JAVA_AWT_WM_NONREPARENTING 1
