###########################################################################
## IPTABLES PROCEDURE
###########################################################################

sudo apt-get update
sudo apt-get install iptables
sudo apt-get install iptables-persistent

## REMOVE ALL UFW REFERENCES IN IPTABLES
for ufw in `iptables -L |grep ufw|awk '{ print $2 }'`; do iptables -F $ufw; done
for ufw in `iptables -L |grep ufw|awk '{ print $2 }'`; do iptables -X $ufw; done

## RESET IPTABLES SET DEFAULT INPUT / OUTPUT AS ACCEPT
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -F

## ACCEPT ESTABLISHED AND RELATED CONNECTION TRAFFIC
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

## ALLOW LOOPBACK PORT ACCESS
sudo iptables -I INPUT 1 -i lo -j ACCEPT

## ALLOW PORTS FOR APPLICATIONS (76.97.68.93 - OFFICE IP)
#sudo iptables -A INPUT -p tcp --source 76.97.68.93 --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

## SET DEFAULT POLICY OF INPUT TO DROP
sudo iptables -P INPUT DROP

## SAVE IPTABLES
sudo iptables-save

###########################################################################
## COMMANDS
###########################################################################

## SHOW ALL ACTIVE IPTABLE RULES

sudo iptables -S
sudo iptables -L

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

sudo iptables -F
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

sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -I OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT -w

## ACCEPT INCOMING SSH FROM TRUSTED ADDRESS AND DROP ALL OTHER CONNECTIONS

iptables -A INPUT -p tcp -m state --state NEW --source 76.97.68.93 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP


