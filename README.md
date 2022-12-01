# cyber-hyprland-theme

## Screenshot

![20221201124048_1](https://user-images.githubusercontent.com/36456160/205144772-bc832650-15e6-4304-9c65-fe7ce7f73e83.png)


## Installation
For complete system config, please see https://github.com/taylor85345/hyprland-dotfiles

1. Install Hyprland and all Dependencies
2. `mkdir ~/.config/hypr/themes`
3. `cd ~/.config/hypr/themes`
4. `git clone https://github.com/taylor85345/cyber-hyprland-theme cyber`
5. Add `source=~/.config/hypr/themes/cyber/theme.conf` to the end of your hyprland.conf

## Dependencies

- [hyprland-git](https://github.com/hyprwm/hyprland) - Wayland Compositor/WM
- [eww](https://github.com/elkowar/eww) - Bar and Widgets
- [nerd-fonts-mononoki](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Mononoki) - Font for bar text and icons
- [nerd-fonts-jetbrains-mono](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/) - Font for bar text and icons
- [rofi-wayland](https://github.com/lbonn/rofi) - For search utility, since no Wayland utilities can handle custom Rofi modi (that I know of)
- [dunst](https://github.com/dunst-project/dunst) - Notification Daemon
- [trayer](https://github.com/sargon/trayer-srg) - Systray Utility
- [swww](https://github.com/GhostNaN/mpvpaper) - Wallpaper Daemon
- [macchina](https://github.com/Macchina-CLI/macchina) - (Optional) Fetch Script
- [socat](http://www.dest-unreach.org/socat/) - Socket utility for eww workspace module
- [geticons](https://git.sr.ht/~zethra/geticons) - CLI tool for locating icons
