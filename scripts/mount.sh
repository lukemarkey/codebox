## UNCOMMENT USER_ALLOW_OTHER IN /ETC/FUSE.CONF
## MAKE SURE YOU SSH USING A ROOT USERNAME FOR REMOTE FOLDER PERMISSIONS

## /usr/share/nginx/archatech/wp-content/themes/nebula-theme /home/luke/mnt/

## INSTALL FUSE

sudo apt install fuse
sudo groupadd fuse
sudo gpasswd -a "$USER" fuse

## INSTALL TO TMOUNT A REMOTE FILE SYSTEM

sudo apt-get install sshfs

## MOUNT REMOTE FILESYSTEM

sudo sshfs -o allow_other ${SSH_SERVER}:/${TARGET_FOLDER} ${MOUNT_PATH}/${PROJECT_NAME} ## USE IF PERMISSION ISSUES
sshfs ${SSH_SERVER}:/${TARGET_FOLDER} ${MOUNT_PATH}/${PROJECT_NAME}

## KILL MOUNT ON LOCALHOST

pkill -kill -f "sshfs" && sudo umount -f ~/mnt
fusermount -u ~/mnt ## USE IF LOCALHOST MNT DIRECTORY ENDPOINT NOT CONNECTED
sudo umount ~/mnt ## USE AS OPTION FOR DISCONNECTING AND EMPTYING REMOTE FOLDER
