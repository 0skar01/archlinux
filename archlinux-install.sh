#! /bin/bash
echo "+++++++++++++++++++++++++++"
echo "Ein paar Infos bekommen"
echo "+++++++++++++++++++++++++++"
echo "Geben Sie Ihren Hostnamen ein: "
read hostname
echo "Benutzernamen eingeben: "
read username
echo "+++++++++++++++++++++++++++++++++++++++"
echo "Ihre lokale Zeitzone auf Berlin einstellen"
echo "+++++++++++++++++++++++++++++++++++++++"
timedatectl list-timezones | grep Berlin
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Ihre Sprache und Tastatur auf Deutsch einstellen"
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "de-DE.UTF-8" >> /etc/locale.gen
echo "LANG=de_DE.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de-latin1" >> /etc/vconsole.conf
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Ihres Hostnamens Einstellen"
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "$hostname" >> /etc/hostname
echo "127.0.0.1     localhost" >> /etc/hosts
echo "::1           localhost" >> /etc/hosts
echo "127.0.1.1     $hostname.localdomain   $hostname" >> /etc/hosts
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Bitte geben Sie ein Passwort für Ihren $hostname Hostnamen ein"
echo "+++++++++++++++++++++++++++++++++++++++++++"
passwd

pacman -S --noconfirm grub efibootmgr networkmanager network-manager-applet base-devel dialog mtools dosfstools wpa_supplicant reflector linux-headers xdg-utils xdg-user-dirs rsync inetutils nfs-utils gvfs gvfs-smb openssh xf86-video-intel cups hplip pulseaudio alsa-utils pavucontrol terminus-font
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable cups
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Hinzufügen eines neuen Benutzers mit dem Benutzernamen $username"
echo "+++++++++++++++++++++++++++++++++++++++++++"
useradd --badnames -mG wheel $username
echo "+++++++++++++++++++++++++++++++++++++++++++"
echo "Bitte geben Sie ein Passwort für den Benutzer $username ein"
echo "+++++++++++++++++++++++++++++++++++++++++++"
passwd $username
pacman -S sudo
"%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "++++++++++++++++++++++++++++++++++++++++++++++++        +++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++             +++++++"
echo "+++++++++++++++++++++++++++++++++++++                   +++++++"
echo "+++++++++++++++++++++++++++                             +++++++"
echo "++++++++++++++++++                                      +++++++"
echo "+++++++++                                               +++++++"
echo "Möchten Sie eine grafische Oberfläche installieren?     +++++++"
echo "Bitte geben Sie J für Ja oder N für Nein ein            +++++++"
echo "+++++++++                                               +++++++"
echo "++++++++++++++++++                                      +++++++"
echo "+++++++++++++++++++++++++++                             +++++++"
echo "+++++++++++++++++++++++++++++++++++++                   +++++++"
echo "+++++++++++++++++++++++++++++++++++++++++++             +++++++"
echo "++++++++++++++++++++++++++++++++++++++++++++++++        +++++++"
read answer
if [ $answer == 'J' ] || [ $answer == 'j' ]
then
    sudo pacman -S --needed xorg
    sudo pacman -S --needed xfce4 mousepad parole ristretto thunar-archive-plugin thunar-media-tags-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver xfce4-taskmanager xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin file-roller network-manager-applet leafpad epdfview galculator lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings capitaine-cursors arc-gtk-theme xdg-user-dirs-gtk
    sudo pacman -S --needed xfce4-goodies
    sudo pacman -S --needed virtualbox-guest-utils xf86-video-vmware
    sudo systemctl enable lightdm
fi
echo "--------------------------------------------------------------------------"
echo "almost there"
echo "BITTE GEBEN SIE DIE FOLGENDE BEFEHLE IN DIE REINFOLGE EIN:"
echo "1. exit           2. umount -a           3. reboot"
echo "Oskar"
echo ":P"
echo "--------------------------------------------------------------------------"

