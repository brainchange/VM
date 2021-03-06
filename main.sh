#######################################################################################################################
#######################################################################################################################
#
#  =====================================BRAIN------CHANGE==============================================================
#
#  ********************************************************************************************************************
#
#  ------------------------KAUSTAV-----------BANERJEE---------[KGEC]---------------------------------------------------
#
#  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#
#  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P='default' #default password
U='root' #default user
SERVER='xrdp' # default server
OS_ID='Ubuntu' #default os name
OS_VERSION='17.04' #default os version
OS_NAME='$OS_ID $OSVERSION'
STARTUP_BROWSER='chrome' #default browser
detect_os()
{	
	sudo apt-get -y update
	sudo apt-get -y install python
	OS_ID=$(python -c 'import platform ; print platform.dist()[0]')
	OS_VERSION=$(python -c 'import platform ; print platform.dist()[1]')
	OS_NAME="$OS_ID $OS_VERSION"
	echo "-----------------------------------"
	echo "OS Ditected : $OS_NAME"
	echo "-----------------------------------"
}
install_extra_packages()
{
	if [[ "$OS_ID" == "Ubuntu" ]]; then
		sudo apt-get update;
		if [[ "$OS_VERSION" == "14.04" ]]; then
			sudo apt-get -y install chromium-browser firefox flashplugin-installer;
		else
			sudo apt-get -y install chromium-browser firefox browser-plugin-freshplayer-pepperflash ;
		fi
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb;
		sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb;sudo apt-get -y install -f; #installing chrome
		rm /tmp/google-chrome-stable_current_amd64.deb;
		sudo chmod a=rwx /etc/chromium-browser/default;
		sudo chmod -R a=rwx /home/;
		echo "CHROMIUM_FLAGS=\" --user-data-dir --no-sandbox\"" >  /etc/chromium-browser/default ;
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=chrome\nExec=google-chrome --no-sandbox www.gmail.com\nType=Application" >> /home/chrome.desktop
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=chromium\nExec=chromium-browser www.gmail.com\nType=Application" >> /home/chromium.desktop
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=firefox\nExec=firefox www.gmail.com\nType=Application" >> /home/firefox.desktop
		chmod +x /home/chromium.desktop;
		chmod +x /home/chrome.desktop;
		chmod +x /home/firefox.desktop;
	elif [[ "$OS_ID" == "debian" ]]; then
		sudo apt -y install chromium
		sudo apt -y install firefox-esr
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb;
		sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb;sudo apt-get -y install -f; #installing chrome
		rm /tmp/google-chrome-stable_current_amd64.deb;
		sudo chmod a=rwx /etc/chromium-browser/default;
		sudo chmod -R a=rwx /home/;
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=chrome\nExec=google-chrome --no-sandbox www.gmail.com\nType=Application" >> /home/chrome.desktop
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=chromium\nExec=chromium www.gmail.com\nType=Application" >> /home/chromium.desktop
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=firefox\nExec=firefox www.gmail.com\nType=Application" >> /home/firefox.desktop
		chmod +x /home/chromium.desktop;
		chmod +x /home/chrome.desktop;
		chmod +x /home/firefox.desktop;
	else
		echo "ERROR OS NOT SUPPORTED YET!!"
	fi
}
machine_info()
{
	
	alias extip=$(curl ipecho.net/plain 2>/dev/null);
	city=$(curl ipinfo.io/city/$extip);
	region=$(curl ipinfo.io/region/$extip);
	country=$(curl ipinfo.io/country/$extip);
	latlong=$(curl ipinfo.io/loc/$extip);
	echo "Internal IP: ";
	ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/';
	ip=$(curl ipecho.net/plain 2>/dev/null)
	echo -e "External IP:\n$ip"
	echo "Operating System: " $OS $VR;
	
	echo "Location : " $city " , " $region " , " $country " . Latitude , Longitude --> " $latlong;
}
startup_settings()
{
		if [[ "$OS_ID" == "Ubuntu" ]]; then
			sudo chmod -R a=rwx /etc/xdg/autostart/ ; #granting permission to edit autostart
			if [[ "$STARTUP_BROWSER" == "chrome" ]]; then
				echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=Chrome_autostart\nExec=google-chrome --no-sandbox www.google.com \nType=Application" >>/etc/xdg/autostart/chrome.desktop; #chrome would start at start up
				sudo chmod +x /etc/xdg/autostart/chrome.desktop;
			elif [[ "$STARTUP_BROWSER" == "chromium" ]]; then
				echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=Chromium_autostart\nExec=chromium-browser --no-sandbox www.google.com \nType=Application" >>/etc/xdg/autostart/chromium.desktop; #chrome would start at start up
				sudo chmod +x /etc/xdg/autostart/chromium.desktop;
			elif [[ "$STARTUP_BROWSER" == "firefox" ]]; then
				echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=Firefox_autostart\nExec=firefox www.google.com \nType=Application" >>/etc/xdg/autostart/fox.desktop; #chrome would start at start up
				sudo chmod +x /etc/xdg/autostart/fox.desktop;
			else
				echo "ERROR!! BROWSER NOT AVAILABLE!!"
			fi
			echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=Terminal_autostart\nExec=xterm -hold -e 'cat /home/Automation/txt.file'\nType=Application" >>/etc/xdg/autostart/term.desktop; #terminal would start at start up
			sudo chmod +x /etc/xdg/autostart/term.desktop;
			echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=Terminal_autostart1\nExec=xterm\nType=Application" >>/etc/xdg/autostart/term1.desktop; #terminal would start at start up
			sudo chmod +x /etc/xdg/autostart/term1.desktop;
		elif [[ "$OS_ID" == "debian" ]]; then
			sudo chmod -R a=rwx /etc/xdg/autostart/ ; #granting permission to edit autostart
			if [[ "$STARTUP_BROWSER" == "chrome" ]]; then
				echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=Chrome_autostart\nExec=google-chrome --no-sandbox www.gmail.com\nType=Application" >>/etc/xdg/autostart/chrome.desktop; #chrome would start at start up
				sudo chmod +x /etc/xdg/autostart/chrome.desktop;
			elif [[ "$STARTUP_BROWSER" == "chromium" ]]; then
				echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=Chromium_autostart\nExec=chromium --no-sandbox www.gmail.com\nType=Application" >>/etc/xdg/autostart/chromium.desktop; #chrome would start at start up
				sudo chmod +x /etc/xdg/autostart/chromium.desktop;
			elif [[ "$STARTUP_BROWSER" == "firefox" ]]; then
				echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=Firefox_autostart\nExec=firefox www.gmail.com\nType=Application" >>/etc/xdg/autostart/fox.desktop; #chrome would start at start up
				sudo chmod +x /etc/xdg/autostart/fox.desktop;
			else
				echo "Browser not supported!!"
			fi
			
			echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=Terminal_autostart\nExec=xterm\nType=Application" >>/etc/xdg/autostart/term.desktop; #terminal would start at start up
			sudo chmod +x /etc/xdg/autostart/term.desktop;
		fi

}
install_desktop()
{
	if [[ "$OS_ID" == "Ubuntu" ]]; then
		if [[ "$SERVER" == "xrdp" ]]; then
			sudo apt-get update;
			sudo apt-get -y install xrdp xfce4 xfce4-goodies;
			if [[ "$OS_VERSION" == "18.04" ]]; then
				sudo sed -i.bak '/fi/a #xrdp multiple users configuration \n xfce-session \n' /etc/xrdp/startwm.sh;
				sudo ufw allow 3389/tcp;
			else
				echo xfce4-session >~/.xsession;
				sudo sed -i.bak '/fi/a #edit \n startxfce4 \n' /etc/xrdp/startwm.sh;
			fi
			if [[ "$OS_VERSION" == "16.04" ]]; then
				sudo cp .xsession /etc/skel/;
				sudo sed -i.bak '/port/c port=ask-1' /etc/xrdp/xrdp.ini;
			elif [[ "$OS_VERSION" == "14.04" ]]; then
				sudo cp .xsession /etc/skel/;
				sudo sed -i.bak '/port/c port=ask-1' /etc/xrdp/xrdp.ini;
			fi
		else
			sudo apt-get -y install vnc4server autocutsel;
			sudo apt-get -y install xfce4 xfce4-goodies;
			echo -e "$P\n$P" | sudo vncserver -geometry 1600x900 -depth 24; 
			sudo sed -i.bak '/x-terminal-emulator/c startxfce4 & \n' ~/.vnc/xstartup;
			sudo vncserver -kill :1;
			sudo vncserver -geometry 1600x900 -depth 24;
		fi
	elif [[ "$OS_ID" == "debian" ]]; then
		sudo apt-get update
		sudo apt -y install xrdp
		sudo systemctl start xrdp
		sudo systemctl enable xrdp
		sudo apt -y install xfce4
		sudo apt -y install xfce4-goodies
		sudo apt-get -f install
		echo xfce4-session >~/.xsession;
		sudo sed -i.bak '/fi/a #edit \n startxfce4 \n' /etc/xrdp/startwm.sh;

	else
		echo "ERROR OS NOT SUPPORTED YET!!"
	fi
		
}
automation_kit()
{
	sudo apt -y install python-pip git mpack ssmtp
	sudo chmod a=rwx /etc/ssmtp/ssmtp.conf
	echo -e "root=username123@gmail.com\nmailhub=smtp.gmail.com:465\nrewriteDomain=gmail.com\nAuthUser=username123\nAuthPass=password123\nFromLineOverride=YES\nUseTLS=YES" /etc/ssmtp/ssmtp.conf
	sudo pip install selenium setuptools bs4 lxml
	cd /home
	sudo apt-get -f install
	sudo git clone https://github.com/brainchange/Automation
	sudo cp Automation/chromedriver /
	sudo chmod +x /chromedriver
	sudo chmod a=rwx /home/Automation/refer.py
	sudo chmod +x /home/Automation/refer.py
	cd ..
	if [ -f /etc/xdg/autostart/xscreensaver.desktop ]; then
		sudo rm ~/.config/google-chrome/Default/Bookmarks
		sudo cp /home/Automation/Bookmarks ~/.config/google-chrome/Default/
	else
		echo "Bookmark Addition not possible"
	fi
}
restart_service()
{	
	if [[ "$OS_ID" == "Ubuntu" ]]; then
		if [[ "$SERVER" == "xrdp" ]]; then
			if [[ "$OS_VERSION" == "18.04" ]]; then
				sudo /etc/init.d/xrdp restart;
			else
				sudo service xrdp restart;
			fi
		else
			sudo vncserver -kill :1;
			echo -e "$P\n$P" | sudo vncserver -geometry 1600x900 -depth 24;
		fi
	elif [[ "$OS_ID" == "centos" ]]; then
		sudo systemctl restart xrdp.service
		sudo systemctl isolate graphical.target
	elif [[ "$OS_ID" == "debian" ]]; then
		sudo service xrdp restart;
	fi

}
if [[ "$1" == "-help" ]]; then
	echo "==================================HELP================================"
	echo "sudo bash main.sh [user] [password] [server] [browser] [GCP/my.vultr] [Starting Website]"
	echo "WARNING!!        All the Arguments Must Be Present!!"
	echo "user     ->         1 (root) | Any other Username"
	echo "password ->         1 (akshay@123) | Any other password"
	echo "server   ->         1 (xrdp) | 2 (vnc)"
	echo "browser  ->         1 (chrome) | 2 (firefox) / 3 (chromium)"
	echo "Cloud    ->         1 (GCP) | 2 (my.vultr)"
	echo "======================================================================"
	echo "For example"
	echo "GCP Chrome - "
	echo "sudo bash main.sh 1 1 1 1 1"
	echo "Vultr Chrome - "
	echo "sudo bash main.sh 1 1 1 1 2"
	exit 0
else

	if [[ "$1" == "1" ]]; then
		U='root'
	else
		U="$1"
	fi
	if [[ "$2" == "1" ]]; then
		P='akshay@123'  #as this password will be also used for vncserver if chosen
	else
		P="$2"
	fi
	echo -e "$P\n$P" | sudo passwd $U
	detect_os
	if [[ "$3" == "1" ]]; then
		SERVER='xrdp'
	else
		SERVER="vnc"
	fi
	if [[ "$4" == "1" ]]; then
		STARTUP_BROWSER='chrome'
	else
		if [[ "$4" == "2" ]]; then
			STARTUP_BROWSER='firefox'
		else
			STARTUP_BROWSER='chromium'
		fi
	fi
	if [[ "$5" == "1" ]]; then
		install_extra_packages
		install_desktop
		startup_settings
		restart_service
		automation_kit
		machine_info
		echo "###################################################################"
	elif [[ "$5" == "3" ]]; then
		sudo apt-get update;
		if [[ "$OS_VERSION" == "14.04" ]]; then
			sudo apt-get -y install lxde ubuntu-gnome-desktop tightvncserver xrdp chromium-browser firefox flashplugin-installer;
		else
			sudo apt-get -y install lxde ubuntu-gnome-desktop tightvncserver xrdp chromium-browser firefox browser-plugin-freshplayer-pepperflash; # installing desktop and browsers and plugins
		fi
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb;
		sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb;sudo apt-get -y install -f; #installing chrome
		rm /tmp/google-chrome-stable_current_amd64.deb;
		sudo chmod a=rwx /etc/chromium-browser/default;
		sudo chmod -R a=rwx /home/;
		echo "CHROMIUM_FLAGS=\" --user-data-dir --no-sandbox\"" >  /etc/chromium-browser/default ;
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=chrome\nExec=google-chrome --no-sandbox www.gmail.com\nType=Application" >> /home/chrome.desktop
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=chromium\nExec=chromium-browser www.gmail.com\nType=Application" >> /home/chromium.desktop
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=firefox\nExec=firefox www.gmail.com\nType=Application" >> /home/firefox.desktop
		chmod +x /home/chromium.desktop;
		chmod +x /home/chrome.desktop;
		chmod +x /home/firefox.desktop;
		echo lxsession -s LXDE -e LXDE > ~/.xsession ;
		automation_kit # selenium dependencies and git repository download
		sudo chmod -R a=rwx /etc/xdg/autostart/ ; #granting permission to edit autostart	
		startup_settings
		echo  sudo /etc/init.d/xrdp restart ; #restart
		machine_info
	else
		sudo apt-get update;
		if [[ "$OS_VERSION" == "14.04" ]]; then
			sudo apt-get -y install lxde ubuntu-gnome-desktop tightvncserver xrdp chromium-browser firefox flashplugin-installer;
		else
			sudo apt-get -y install lxde ubuntu-gnome-desktop tightvncserver xrdp chromium-browser firefox browser-plugin-freshplayer-pepperflash; # installing desktop and browsers and plugins
		fi
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb;
		sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb;sudo apt-get -y install -f; #installing chrome
		rm /tmp/google-chrome-stable_current_amd64.deb;
		sudo chmod a=rwx /etc/chromium-browser/default;
		sudo chmod -R a=rwx /home/;
		echo "CHROMIUM_FLAGS=\" --user-data-dir --no-sandbox\"" >  /etc/chromium-browser/default ;
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=chrome\nExec=google-chrome --no-sandbox www.gmail.com\nType=Application" >> /home/chrome.desktop
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=chromium\nExec=chromium-browser www.gmail.com\nType=Application" >> /home/chromium.desktop
		echo -e "#!/usr/bin/env xdg-open\n[Desktop Entry]\nName=firefox\nExec=firefox www.gmail.com\nType=Application" >> /home/firefox.desktop
		chmod +x /home/chromium.desktop;
		chmod +x /home/chrome.desktop;
		chmod +x /home/firefox.desktop;
		echo lxsession -s LXDE -e LXDE > ~/.xsession ;
		automation_kit # selenium dependencies and git repository download
		sudo apt-get -y install xterm
		sudo chmod -R a=rwx /etc/xdg/autostart/ ; #granting permission to edit autostart		
		startup_settings
		machine_info
	fi
fi
if [ -f /etc/xdg/autostart/xscreensaver.desktop ]; then
	sudo rm /etc/xdg/autostart/xscreensaver.desktop
else
	sudo sed -i.bak '/@xscreensaver/c #screensaver removes' /etc/xdg/lxsession/LXDE/autostart
fi
