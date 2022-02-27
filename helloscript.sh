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
pacman -S --noconfirm grub efibootmgr networkmanager network-manager-applet base-devel dialog mtools dosfstools wpa_supplicant reflector linux-headers xdg-utils xdg-user-dirs rsync inetutils nfs-utils gvfs gvfs-smb openssh xf86-video-intel (bei intel graphic karte) xf86-video-andgpu (bei amd) nvidia nvidia-utils (bei nvidia graphic karte) bluez bluez-utils (für Bluetooth) cups hplip (für drücker) pulseaudio alsa-utils pavucontrol terminus-font
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
systenctl enable NetworkManager
systenctl enable sshd
systenctl enable reflector.timer
systenctl enable cups
useradd -mG wheel $username
passwd $username
pacman -S sudo
