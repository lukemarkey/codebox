###########################################################################
## UBUNTU DESKTOP AUTOMATIC BACKUPS
###########################################################################

sudo apt install duplicity

###########################################################################
## USE DD TO COPY PARTITION
###########################################################################

## LIST PARTITIONS
sudo lsblk

## COPY PARTITION TO BACKUP FILE
sudo dd if=/dev/sdb of=/home/luke/snapshot

## RESTORE A PARTITION BACKUP
sudo dd if=/dev/sdb1 of=/dev/

###########################################################################
## LOGICAL VOLUME MANAGEMENT
###########################################################################

## INSTALL GPARTED
sudo apt install gparted

## INSTALL LVM
sudo apt install lvm2

## LIST DISK PARTITIONS
sudo lvmdiskscan

## LIST VOLUME GROUPS
sudo vgscan

