#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'

echo -e "${Colour}By using this script, you'll remove the default pi account, update the system, install Teamviewer and install the stable UniFi controller of your choice.\nUse CTRL+C to cancel the script\n\n${less}"
read -p "Please enter the STABLE version (e.g: 5.12.23) or press enter for version 5.12.22: " version

if [[ -z "$version" ]]; then
	version='5.12.22'
fi

echo -e "${Colour}\nRemoving the default pi account and the associated home directory\n${less}"
sudo deluser pi

echo -e "${Colour}\n\nThe system will now upgrade all the software and firmware, as well as clean up old/unused packages.\n\n${less}"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean
#sudo apt-get update --allow-releaseinfo-change && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean

echo -e "${Colour}\n\nTeamviewer is downloading now.\n\n${less}"
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb -O teamviewer.deb

echo -e "${Colour}\n\nTeamviewer will be installed now.\n\n${less}"
sudo dpkg -i teamviewer.deb; sudo apt-get install -f -y

echo -e "${Colour}\n\nThe UniFi controller with version $version is downloading now.\n\n${less}"
wget http://dl.ubnt.com/unifi/$version/unifi_sysvinit_all.deb -O unifi_$version\_sysvinit_all.deb

echo -e "${Colour}\n\nBefore installing the UniFi Controller, it will first install OpenJDK 8.\n\n${less}"
sudo apt-get install openjdk-8-jre-headless -y

echo -e "${Colour}\n\nIn order to fix an issue which can cause a slow start for the UniFi controller, haveged is installed.\n\n${less}"
sudo apt-get install haveged -y

echo -e "${Colour}\n\nThe UniFi controller will be installed now.\n\n${less}"
sudo dpkg -i unifi_$version\_sysvinit_all.deb; sudo apt-get install -f -y
