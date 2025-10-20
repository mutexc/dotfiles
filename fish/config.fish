# Db url for fleetar, need to add sslmode capability later
set -x DATABASE_URL "postgresql://fleetar_app:aobd1202@localhost:5432/fleetar_prod?sslmode=disable"
set -x DATABASE_URL_PROD "postgresql://fleetar_app:aobd1202@localhost:5432/fleetar_prod?sslmode=disable"
set -x DATABASE_URL_DEV "postgresql://fleetar_app:aobd1202@localhost:5432/fleetar_dev?sslmode=disable"
set -x DATABASE_URL_TEST "postgresql://fleetar_app:aobd1202@localhost:5432/fleetar_test?sslmode=disable"
set -Ux ASSETS_FOLDER /home/op/abs/src/assets
set LANG C.UTF-8
# Authentik stuff
set -x CLIENT_ID "TOGPfDsOs12RtMlYQx6j6QwUByTnm6PS1zZsXa5u"
set -x CLIENT_SECRET "swsv69Hw5uchbwZBzrJoXb6lr00zNpn8aFREAg6MNHVkHv1ZhYrByvReiwB8eD3UDTjQa5DtJVQmip3dwf0AXnOioa09kMoMaGel6vplOl30Serrs5NOJUz7nHupzt5M"
set -x AUTH_URI "http://localhost/application/o/authorize/"
set -x TOKEN_URI "http://localhost/application/o/token/"

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
#alias hx=helix

# Commented out after switching to nixos
 fish_add_path /home/op/.cargo/bin
fish_add_path /usr/bin/
fish_add_path /home/op/.local/share/icons
fish_add_path /home/op/.local/bin/
fish_add_path /home/op/.local/share
fish_add_path /home/op/go/bin/
fish_add_path /home/op/.bin
#
set fish_greeting ""
set -Ux _JAVA_AWT_WM_NONREPARENTING 1
set -g fish_color_autosuggestion '555555'

