## UPDATE REPOSITORIES
sudo apt update -y
sudo apt upgrade -y

## INSTALL DEPENDENCIES
sudo apt-get install zlib1g-dev uuid-dev libmnl-dev pkg-config curl gcc make autoconf autoconf-archive autogen automake python python-yaml python-mysqldb nodejs lm-sensors python-psycopg2 netcat git -y

## CLONE LATEST VERSION OF NETDATA FROM GITHUB REPOSITORY
git clone https://github.com/firehol/netdata.git --depth=1 ~/netdata

## RUN INSTALL SCRIPT
sudo ~/netdata/netdata-installer.sh
