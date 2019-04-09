#yallaV2 Sarmad & Tony 11/Jun/2018
staticip="$1"
netmask="255.255.0.0"
routerip="192.168.1.200"
broadcast="192.168.255.255"
network="192.168.0.0"

getInstallationFiles()
{
wget -O /home/rabibitrabassurra.sh http://192.168.1.69/rabibitrabassurra.sh
wget -O /etc/apt/apt.conf http://192.168.1.69/apt.conf
wget -O /etc/wgetrc http://192.168.1.69/wgetrc
}


writeInterFaceFile8()
{
cat << EOF > $1 
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).
# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
auto eth0

#Your static network configuration  
allow-hotplug eth0
iface eth0 inet static
address $staticip
netmask $netmask
network $network
broadcast $broadcast
gateway $routerip 
EOF
}

writeInterFaceFile9()
{
cat << EOF > $1 
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).
# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
auto enp3s0

#Your static network configuration  
allow-hotplug enp3s0
iface enp3s0 inet static
address $staticip
netmask $netmask
network $network
broadcast $broadcast
gateway $routerip 
EOF
}


file="/etc/network/interfaces"

source /etc/os-release

case $VERSION_ID in
   "8") writeInterFaceFile8 $file 
   ;;
   "9") writeInterFaceFile9 $file
   ;;
esac

/etc/init.d/networking restart

getInstallationFiles

chmod 777 /home/rabibitrabassurra.sh
cd /home/
./rabibitrabassurra.sh