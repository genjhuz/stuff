yum -y install nano

# Ubah GRUB_TIMEOUT=2
nano /etc/default/grub

# Apply to boot config
grub2-mkconfig --output /boot/grub2/grub.cfg

# Reboot after apply
reboot

# Install GUI
yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y
ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
reboot

# Vino Dependencies
yum -y install git gnome-common intltool NetworkManager

# Aktifkan port untuk VNC-Server (5900) via Firewalld GUI

# Install dconf-editor
yum -y install dconf-editor

# Buka dconf-editor org>gnome>desktop>remotte-access
# Buang centang pada require-encryption

# Matikan enkripsi Vino agar bisa diakses Windows
gsettings set org.gnome.Vino require-encryption false

# Cek port VNC-Server
netstat -tulpn

# Ubah password Vino pada screen sharing & dconf-editor
# Matikan notification popup di menu setting

# Install Apache
yum -y update
yum -y install epel-release
yum -y install httpd

# Disable Sleep Mode
setterm -powersave off -blank 0
/usr/bin/setterm -powersave off -blank 0
