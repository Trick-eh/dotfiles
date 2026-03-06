zen_mode=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$zen_mode" = 1 ]; then
    hyprctl --batch "\
        keyword animations:enabled 0; \
        keyword decoration:drop_shadow 0; \
        keyword decoration:blur:enabled 0; \
        keyword decoration:rounding 0; \
        keyword general:gaps_in 0; \
        keyword general:gaps_out 0; \
        keyword general:border_size 1; \
        "
    killall waybar
    exit
fi

waybar &
hyprctl reload
