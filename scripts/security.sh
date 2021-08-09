## SETUP ROOTKIT HINTER

sudo apt-get -y --no-install-recommends install rkhunter
sudo rkhunter --update
sudo apt-get install unhide
sudo rkhunter --enable hidden_ports
sudo rkhunter -c

## SETUP LYNIS

sudo apt-get install lynis
