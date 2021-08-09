echo -n "How many gigs do you want to add to your swapfile? (1G, 2G, 4G):"
read SWAPFILE_SIZE

sudo touch /swapfile
sudo fallocate -l "${SWAPFILE_SIZE}" /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon -s
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab