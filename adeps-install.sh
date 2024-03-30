#!/bin/bash

echo '-----installing deps-----'

echo "
 _                      _   _                         
| |__  _   _ _ __  _ __| |_| |__   ___ _ __ ___   ___ 
| '_ \| | | | '_ \| '__| __| '_ \ / _ \ '_ ` _ \ / _ \
| | | | |_| | |_) | |  | |_| | | |  __/ | | | | |  __/
|_| |_|\__, | .__/|_|   \__|_| |_|\___|_| |_| |_|\___|
       |___/|_|                                       
     _                           _                 _           
  __| | ___ _ __   ___ _ __   __| | ___ _ __   ___(_) ___  ___ 
 / _` |/ _ \ '_ \ / _ \ '_ \ / _` |/ _ \ '_ \ / __| |/ _ \/ __|
| (_| |  __/ |_) |  __/ | | | (_| |  __/ | | | (__| |  __/\__ \
 \__,_|\___| .__/ \___|_| |_|\__,_|\___|_| |_|\___|_|\___||___/
           |_|
"

echo '----- all items -----'
echo "
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
"
declare -a packages=("eww"
		     "nerd-fonts-mononoki"
		     "nerd-fonts-jetbrains-mono"
		     "rofi-wayland"
		     "dunst"
		     "trayer"
		     "swww"
		     "macchina"
		     "socat"
		     "geticons"
		    )
declare -a aurs=("eww"
		     "nerd-fonts-mononoki"
		     "nerd-fonts-jetbrains-mono"
		     "rofi-wayland"
		     "dunst"
		     "trayer"
		     "swww"
		     "macchina"
		     "socat"
		     "geticons"
		    )

declare -a sources=("eww"
		     "nerd-fonts-mononoki"
		     "nerd-fonts-jetbrains-mono"
		     "rofi-wayland"
		     "dunst"
		     "trayer"
		     "swww"
		     "macchina"
		     "socat"
		     "geticons"
		    )


echo "----- installing from packages -----"
for package in "${packages[@]}"
do
    echo "----- installing $package ------"
    
done 


echo "----- installing from AURs -----"
for aur in "${aur[@]}"
do
    echo "----- installing $aur  ------"
    
done


echo "----- installing from sources -----"
for source in "${source[@]}"
do
    echo "----- installing $source ------"
    
done
