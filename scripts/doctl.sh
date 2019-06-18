###########################################################################
## INSTALL REQUIREMENTS
###########################################################################

## INSTALL LOCALLY
sudo snap install doctl

## GENERATE TOKEN IN DIGITALOCEAN API MENU
doctl auth init

doctl compute volume list
doctl compute snapshot list
doctl compute droplet list
