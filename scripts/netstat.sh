## CHECK ACTIVE CONNECTIONS

sudo netstat -antp

## GET DETAILS ON PROCESS BY ID

sudo lsof -p ${PID}
sudo ps -Flww -p ${PID}

## GET ROUTING TABLE

netstat -r -n
