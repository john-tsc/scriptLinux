#rabibit_rabassurraV10.2 Sarmad & Tony 11/Jun/2018
#!/bin/bash
dns1="8.8.8.8"
dns2="8.8.4.4"

getent passwd suporte > /dev/null 2&>1
if [ $? -eq 0 ]; then
    echo -e "1qaz2wsx\n1qaz2wsx" | passwd suporte
else
    echo -e "1qaz2wsx\n1qaz2wsx\n\n" | adduser suporte
fi


writedns()
{
cat << EOF > $1 
nameserver $dns1
nameserver $dns2
EOF
}

writesourceslist8()
{
cat << EOF > $1
deb http://security.debian.org/ jessie/updates main
deb-src http://security.debian.org/ jessie/updates main
deb http://ftp.br.debian.org/debian/ jessie main contrib non-free
deb http://security.debian.org/ jessie/updates main contrib non-free
deb http://ftp.br.debian.org/debian jessie-proposed-updates main contrib non-free
deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty  main
deb http://www.debian-desktop.org/pub/linux/debian/xfce46 lenny xfce460
deb-src http://www.debian-desktop.org/pub/linux/debian/xfce46 lenny xfce460
deb http://ftp.fr.debian.org/debian jessie-backports main contrib non-free
deb-src http://ftp.fr.debian.org/debian jessie-backports main contrib non-free
EOF
}

writesourceslist9()
{
cat << EOF > $1
deb http://ftp.us.debian.org/debian/ stretch main contrib non-free
deb http://security.debian.org/ stretch/updates main contrib non-free
deb http://deb.debian.org/debian/ stretch main contrib non-free
deb http://deb.debian.org/security/ stretch/updates main contrib non-free
EOF
}


writeNadarati()
{
cat << EOF > $1
#! /bin/sh
# /etc/init.d/nadarati
#

### BEGIN INIT INFO
# Provides:          nadarati
# Required-Start:    \$local_fs \$remote_fs \$network \$syslog
# Required-Stop:     \$local_fs \$remote_fs \$network \$syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start nadarati at boot time
# Description:       Enable service provided by nadarati
### END INIT INFO


# Some things that run always

# Carry out specific functions when asked to by the system
case "\$1" in
  start)
    /usr/local/./waiting.sh
    ;;
  stop)
    echo "Stopping script blah"
    echo "Could do more here"
    ;;
  open)
    java -cp /usr/local/WaitingDebian.jar com.br.tabx.waiting.debian.Main & installAll
    ;;
  *)

    echo "start|stop"
    ;;
esac

exit 0

EOF
}


filee="/etc/resolv.conf"
fileee="/etc/apt/sources.list"
fileeee="/etc/init.d/nadarati"

writedns $filee

source /etc/os-release

case $VERSION_ID in
   "8") writesourceslist8 $fileee 
   ;;
   "9") writesourceslist9 $fileee
   ;;
esac


apt-get update
apt-get upgrade -y
apt-get update

apt-get install sudo -y

apt-get install make -y

apt-get install oracle-java8-installer

apt-get install xfce4 xfce4-goodies -y

apt-get install lightdm -y
apt-get install evince-gtk -y
apt-get install gnome-orca -y
apt-get install hunspell-en-us -y
apt-get install hyphen-en-us -y
apt-get install iceweasel -y
apt-get install network-manager-gnome -y
apt-get install quodlibet -y
apt-get install synaptic -y
apt-get install system-config-printer -y
apt-get install vlc -y
apt-get install xsane -y

echo “1” > /etc/init.d/nadarati

writeNadarati $fileeee

chmod 755 $fileeee
cd /etc/init.d/
update-rc.d nadarati defaults

chmod -R 755 /usr/local/
wget -P /usr/local/ "http://192.168.1.69/WaitingDebian.jar"
wget -P /usr/local/ "http://192.168.1.69/waiting.sh"
wget -P /usr/local/ "http://192.168.1.69/nadarati.sh"
chmod 777 /usr/local/WaitingDebian.jar
chmod 777 /usr/local/waiting.sh
chmod 777 /usr/local/nadarati.sh

reboot
