#!/bin/bash

echo '-----installing deps-----'

IFS= read -r -d '' banner_1 <<'EOF'
      ___           ___           ___           ___     
     /\__\         |\__\         /\  \         /\  \    
    /:/  /         |:|  |       /::\  \       /::\  \   
   /:/__/          |:|  |      /:/\:\  \     /:/\:\  \  
  /::\  \ ___      |:|__|__   /::\~\:\  \   /::\~\:\  \ 
 /:/\:\  /\__\     /::::\__\ /:/\:\ \:\__\ /:/\:\ \:\__\
 \/__\:\/:/  /    /:/~~/~    \/__\:\/:/  / \/_|::\/:/  /
      \::/  /    /:/  /           \::/  /     |:|::/  / 
      /:/  /     \/__/             \/__/      |:|\/__/  
     /:/  /                                   |:|  |    
     \/__/                                     \|__|    
      ___           ___           ___           ___           ___     
     /\  \         /\__\         /\  \         /\__\         /\  \    
     \:\  \       /:/  /        /::\  \       /::|  |       /::\  \   
      \:\  \     /:/__/        /:/\:\  \     /:|:|  |      /:/\:\  \  
      /::\  \   /::\  \ ___   /::\~\:\  \   /:/|:|__|__   /::\~\:\  \ 
     /:/\:\__\ /:/\:\  /\__\ /:/\:\ \:\__\ /:/ |::::\__\ /:/\:\ \:\__\
    /:/  \/__/ \/__\:\/:/  / \:\~\:\ \/__/ \/__/~~/:/  / \:\~\:\ \/__/
   /:/  /           \::/  /   \:\ \:\__\         /:/  /   \:\ \:\__\  
   \/__/            /:/  /     \:\ \/__/        /:/  /     \:\ \/__/  
                   /:/  /       \:\__\         /:/  /       \:\__\    
                   \/__/         \/__/         \/__/         \/__/    
EOF

IFS= read -r -d '' banner_2 <<'EOF'
                    ___           ___         ___     
     _____         /\__\         /\  \       /\__\    
    /::\  \       /:/ _/_       /::\  \     /:/ _/_   
   /:/\:\  \     /:/ /\__\     /:/\:\__\   /:/ /\  \  
  /:/  \:\__\   /:/ /:/ _/_   /:/ /:/  /  /:/ /::\  \ 
 /:/__/ \:|__| /:/_/:/ /\__\ /:/_/:/  /  /:/_/:/\:\__\
 \:\  \ /:/  / \:\/:/ /:/  / \:\/:/  /   \:\/:/ /:/  /
  \:\  /:/  /   \::/_/:/  /   \::/__/     \::/ /:/  / 
   \:\/:/  /     \:\/:/  /     \:\  \      \/_/:/  /  
    \::/  /       \::/  /       \:\__\       /:/  /   
     \/__/         \/__/         \/__/       \/__/
EOF

IFS= read -r -d '' banner_3 <<'EOF'

                  ___     
    ___          /__/\    
   /  /\         \  \:\   
  /  /:/          \  \:\  
 /__/::\      _____\__\:\ 
 \__\/\:\__  /__/::::::::\
    \  \:\/\ \  \:\~~\~~\/
     \__\::/  \  \:\  ~~~ 
     /__/:/    \  \:\     
     \__\/      \  \:\    
                 \__\/
EOF

IFS= read -r -d '' banner_4 <<'EOF'
      ___                         ___           ___       ___       ___     
     /  /\          ___          /  /\         /  /\     /  /\     /  /\    
    /  /::\        /__/\        /  /::\       /  /:/    /  /:/    /  /::\   
   /__/:/\:\       \  \:\      /  /:/\:\     /  /:/    /  /:/    /  /:/\:\  
  _\_ \:\ \:\       \__\:\    /  /::\ \:\   /  /:/    /  /:/    /  /::\ \:\ 
 /__/\ \:\ \:\      /  /::\  /__/:/\:\_\:\ /__/:/    /__/:/    /__/:/\:\ \:\
 \  \:\ \:\_\/     /  /:/\:\ \__\/  \:\/:/ \  \:\    \  \:\    \  \:\ \:\_\/
  \  \:\_\:\      /  /:/__\/      \__\::/   \  \:\    \  \:\    \  \:\ \:\  
   \  \:\/:/     /__/:/           /  /:/     \  \:\    \  \:\    \  \:\_\/  
    \  \::/      \__\/           /__/:/       \  \:\    \  \:\    \  \:\    
     \__\/                       \__\/         \__\/     \__\/     \__\/    
      ___     
     /  /\    
    /  /::\   
   /  /:/\:\  
  /  /::\ \:\ 
 /__/:/\:\_\:\
 \__\/~|::\/:/
    |  |:|::/ 
    |  |:|\/  
    |__|:|~   
     \__\|    
EOF

printf '%s\n' "$banner_1"
printf '%s\n' "$banner_2"
printf '%s\n' "$banner_3"
printf '%s\n' "$banner_4"

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

echo '----- loading items -----'

declare -a packages=(
    # "eww"
    # "nerd-fonts-mononoki"
    # "nerd-fonts-jetbrains-mono"
    # "rofi-wayland"
    "dunst"
    "trayer"
    # "swww"
    # "macchina"
    "socat"
    # "geticons"
)
declare -a aurs=(
    "eww"
    # "nerd-fonts-mononoki"
    # "nerd-fonts-jetbrains-mono"
    # "rofi-wayland"
    # "dunst"
    # "trayer"
    "swww"
    "macchina"
    # "socat"
    "geticons"
)

declare -a sources=(
    # "eww"
    "nerd-fonts-mononoki"
    "nerd-fonts-jetbrains-mono"
    "rofi-wayland"
    # "dunst"
    # "trayer"
    # "swww"
    # "macchina"
    # "socat"
    # "geticons"
)

echo "----- ----- installing from packages ----- -----"
for package in "${packages[@]}"
do
    echo "----- ----- ----- installing $package ----- ----- ------"
    echo "--- : sudo pacman -S $package"
    sudo pacman -S $package
done

echo "----- ----- installing from AURs ----- -----"
for aur in "${aurs[@]}"
do
    echo "----- ----- ----- installing $aur ----- ----- -----"
    echo "--- : pacman -S $aur"
    pacman -S $aur
done

echo "----- ----- installing from sources ----- -----"
for source in "${sources[@]}"
do
    echo "----- ----- ----- installing $source ----- ----- -----"

    if [ $source == 'nerd-fonts-mononoki' ]
    then
	echo '--- found nerd-fonts-mononoki ---'
	echo '--- : yay -S ttf-mononoki'
	yay -S ttf-mononoki
    fi

    if [ $source == 'nerd-fonts-jetbrains-mono' ]
    then
	echo '--- found nerd-fonts-jetbrains-mono ---'
	echo '--- : yay -S ttf-jetbrains-mono-nerd'
	yay -S ttf-jetbrains-mono-nerd
    fi

    if [ $source == 'rofi-wayland' ]
    then
	echo '--- found rofi-wayland ---'
	echo '--- : yay -S rofi-lbonn-wayland-git'
	yay -S rofi-lbonn-wayland-git
    fi

done
