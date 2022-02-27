#! /bin/bash

echo "Enter your Hostname: "
read hostname
echo "Enter Username: "
read username
timedatectl list-timezones | grep Berlin
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
echo "de-DE.UTF-8" >> /etc/locale.gen
echo "LANG=de_DE.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de-latin1" >> /etc/vconsole.conf
echo "$hostname" >> /etc/hostname
echo "127.0.0.1     localhost" >> /etc/hosts
echo "::1           localhost" >> /etc/hosts
echo "127.0.1.1     $hostname.localdomain   $hostname" >> /etc/hosts
passwd
pacman -S --noconfirm grub efibootmgr networkmanager network-manager-applet base-devel dialog mtools dosfstools wpa_supplicant reflector linux-headers xdg-utils xdg-user-dirs rsync inetutils nfs-utils gvfs gvfs-smb openssh xf86-video-intel cups hplip pulseaudio alsa-utils pavucontrol terminus-font
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
systenctl enable NetworkManager
systenctl enable sshd
systenctl enable reflector.timer
systenctl enable cups
useradd -mG wheel $username
passwd $username
pacman -S sudo
sudo pacman -S --needed xorg
sudo pacman -S --needed xfce4 mousepad parole ristretto thunar-archive-plugin thunar-media-tags-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver xfce4-taskmanager xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin file-roller network-manager-applet leafpad epdfview galculator lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings capitaine-cursors arc-gtk-theme xdg-user-dirs-gtk
sudo pacman -S --needed xfce4-goodies
sudo pacman -S --needed virtualbox-guest-utils xf86-video-vmware
sudo systemctl enable lightdm
echo "run visudo and uncomment line 82 (to line number enter :set number)"
echo "then these orders in order: exit      umouunt -a      reboot"
echo "go go go"
