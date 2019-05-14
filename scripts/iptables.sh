## SHOW ALL ACTIVE IPTABLE RULES

sudo iptables -S
sudo iptbales -L

## SHOW PACKETS AND FILTER BY INPUT

sudo iptables -L INPUT -v

## GET RULES LINE NUMBER

sudo iptables -L --line-numbers

## DELETE RULE

sudo iptables -D INPUT 3

## SHOW IPTABLES BY TYPE

iptables -vL -t filter
iptables -vL -t nat
iptables -vL -t mangle
iptables -vL -t raw
iptables -vL -t security

## RESET FIREWALL

sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X

## CUSTOMIZE AND PERSIST IPTABLES RULES

sudo apt-get install iptables-persistent
sudo netfilter-persistent save


## DENY ALL ALLOW OUTGOING

sudo iptables -P INPUT DROP -w
sudo iptables -P FORWARD DROP -w
sudo iptables -P OUTPUT DROP -w

sudo iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT -w
sudo iptables -I OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT -w

## ACCEPT INCOMING SSH FROM TRUSTED ADDRESS AND DROP ALL OTHER CONNECTIONS

iptables -A INPUT -p tcp -m state --state NEW --source 73.82.241.34 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP


