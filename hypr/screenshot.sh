#/run/current-system/sw/bin/sh

# Author: @the-bay-kay
# Date: 16-08-23
#
# Description: A basic script that runs grim + slurp, names
# the file based on the current hyprland active window, 
# then saves the screenshot under /home/$USER/Pictures/Screenshots/

name=$(hyprctl activewindow | grep title | cut -c8- | tr -d " " | tr "/" "_")_
date=$(date +'%s_grim.png')
filename=$name$date

echo $filename

grim -g "$(slurp)" /home/$USER/Pictures/Screenshots/$filename
