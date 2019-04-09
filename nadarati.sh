installAll()
{
  fileeee="/etc/init.d/nadarati"

  apt-get install playonlinux -y

  wget -q "http://deb.playonlinux.com/public.gpg" -O- | apt-key add -
  wget http://deb.playonlinux.com/playonlinux_trusty.list -O /etc/apt/sources.list.d/playonlinux.list

  apt-get update

  apt-get install gvfs-backends -y
  apt-get install samba -y

  apt-get install playonlinux -y
  apt-get install winetricks -y

  apt-get install cups -y
  
  apt-get install shotwell -y
  apt-get install pulseaudio -y

  installRDesktop

  apt-get install openssh-server -y
  sed 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
  /etc/init.d/ssh restart
  apt-get install sshpass
  apt-get install smbclient
  /etc/init.d/cups restart
  apt-get install libpulse-mainloop-glib0
  sshpass -p 'AcA8685AtA' scp -r root@192.168.1.69:/home/bonasera/yalla/konsistMed /root/
  
  OS_TYPE='uname -m'
  if [ ${OS_TYPE} == 'x86_64' ]; then
    sshpass -p 'AcA8685AtA' scp -r -o 'StrictHostKeyChecking no' root@192.168.1.69:/home/bonasera/yalla/Libreoffice_64 /root/
    sshpass -p 'AcA8685AtA' scp -r -o 'StrictHostKeyChecking no' root@192.168.1.69:/home/bonasera/yalla/Wpsoffice_64 /root/
    mv /root/Libreoffice_64 /root/Libreoffice
    mv /root/Wpsoffice_64 /root/Wpsoffice
  else
    sshpass -p 'AcA8685AtA' scp -r -o 'StrictHostKeyChecking no' root@192.168.1.69:/home/bonasera/yalla/Libreoffice /root/
    sshpass -p 'AcA8685AtA' scp -r -o 'StrictHostKeyChecking no' root@192.168.1.69:/home/bonasera/yalla/Wpsoffice /root/
  fi

  installLibreoffice
  installWpsoffice
  #/root/konsistMed/./latensa.sh
  echo -ne "\nwinetricks corefonts eufonts lucida opensymbol tahoma cjkfonts\nwinetricks vb6run\nwinetricks mdac28\nwinetricks msxml4 mfc42 jet40 native_oleaut32\nwine control" >> /usr/share/playonlinux/etc/pol_bash
  cp -R /root/konsistMed/Indexador/ /usr/local/
  cp /root/konsistMed/threadIndexador /etc/init.d/
  cd /etc/init.d/
  killall -9 java
  update-rc.d nadarati remove
  rm $fileeee
  su suporte
  cd /usr/share/playonlinux/bash/
  ./playonlinux-shell
  sed -i '/winetricks corefonts eufonts lucida opensymbol tahoma cjkfonts/d' /usr/share/playonlinux/etc/pol_bash
  sed -i '/winetricks vb6run/d' /usr/share/playonlinux/etc/pol_bash
  sed -i '/winetricks mdac28/d' /usr/share/playonlinux/etc/pol_bash
  sed -i '/winetricks msxml4 mfc42 jet40 native_oleaut32/d' /usr/share/playonlinux/etc/pol_bash
  sed -i '/wine control/d' /usr/share/playonlinux/etc/pol_bash
}

installLibreoffice()
{
  apt-get purge libreoffice* -y
  cd /root/Libreoffice/
  tar -zxvf LibreOffice.tar.gz
  dpkg -i Libre*/DEBS/*.deb
  rm -r Libre*/
  tar -zxvf LibreOffice_langpack.tar.gz
  dpkg -i Libre*/DEBS/*.deb
  rm -r Libre*/
  tar -zxvf LibreOffice_helppack.tar.gz
  dpkg -i Libre*/DEBS/*.deb
  cd /root/
  rm -r Libreoffice
}
installWpsoffice()
{
  cd /root/Wpsoffice/
  dpkg -i *.deb
}
installRDesktop()
{
  apt-get install libx11-dev libssl-dev -y
  apt-get install build-essential -y
  apt-get install remmina -y
}

installAll