# the-bay-kay dotfiles

## Introduction
Hi there!  As a longtime linux user, I've been consistently tweaking my setup for
quite some time.  After lots of experimenting, I figured I should upload my dots to
my github!  Here's some initial facts about the setup:

- Operating Sytem: NixOS
- Window Manager: Hyprland
- Status Bar: Waybar (Experimenting with eww)
- Wallpaper Engine: swww 

## Installation
- First, install NixOS
- Copy this repository via nix-shell:
```
$ nixshell -p git
$ git clone https://github.com/the-bay-kay/NixOS_Configs.git
```
- I'm currently using NixOS as my operating system:  the directory `nixos_configs/` should
contain OS specific files.  To replicate my system (i.e., install all of the prerequisit packages),
you need to run the following:
```
$ sudo cp -r {path-to-repository}/NixOS_Configs/nixos_configs/configuration.nix /etc/nixos/
$ sudo nixos-rebuild switch
```
Because NixOS automatically does version control, I believe there's no need to back up your
old configs!  (If you wanted to, run `sudo cp /etc/nixos/configuration.nix /etc/nixos/old_config.nix`.
- After initializing `nixos_configs/` as above, you should be able to to run
```
$ cp -r {path-to-repository}/NixOS_Configs/* ~/.config/
``` 
to transfer all of the relevant files over!  This will overwrite some existing config files, 
so feel free to take the time to back these up beforehand if you so desire.
- After rebooting your machine, you should be able to log in to `hyprland` using lightdm!  Eventually,
I'll write a tutorial for all of my `hyprland` keybindings; for now, please view `hyprland.conf`
for more details.  Basically, I use vim-style keybinds to move and resize windows, with pneumonics
to remember application launch macros!  To get started, press `SUPER+R` to run the application
launcher `rofi`!
- Your new machine has a variety of (what I would consider) essentials pre-downloaded!  Please
view your new `configuration.nix` for the list of packages.

## Support & Going Forward
Obviously, this setup is not fully complete!  I need to test the installation proccess above (perhaps on a VM, I may switch certain applications in my config (I want to try out EWW), and I may switch
operating systems entirely!  For future update plans, please see the git log for my To-Do lists. 
