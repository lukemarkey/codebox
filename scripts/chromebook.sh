
## ON REMOTE SSH CONSOLE

sudo apt update -y
sudo apt upgrade -y

sudo apt install epiphany-browser
sudo apt install xscreensaver
sudo apt install xfce4-goodies
sudo apt install apt-transport-https

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt install sublime-text

ssh-keygen

wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --with-source=chrome-remote-desktop_current_amd64.deb chrome-remote-desktop

## FOR XFCE DESKTOP

sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes xfce4 desktop-base
echo "xfce4-session" > ~/.chrome-remote-desktop-session
sudo systemctl disable lightdm.service

sudo passwd $(whoami) ## SET USER PASSWORD
visudo ## ADD USER TO SUDOERS FOR REMOTE DESKTOP ACCESS
https://remotedesktop.google.com/headless ## VISIT ON LOCALHOST TO SETUP REMOTE DESKTOP

## THINGS TO DO ON NEW VIRTUAL MACHINE (XFCE4)
## DISABLE SCREENSAVER ON XFCE SETTINGS
## ADD HARDWARE PANELS TO DESKTOP
## ADD MATERIAL-THEME TO SUBLIME TEXT
## SETTINGS > WINDOW MANAGER > KEYBOARD > CYCLE WINDOWS > ALT + RIGHT
## SETTINGS > WINDOW MANAGER > KEYBOARD > MOVE WINDOW TO NEXT WORKSPACE > CTRL + ALT + SHIFT + RIGHT
## SETUP SWAPFILE FOR RAM
