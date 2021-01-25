export DEBIAN_FRONTEND=noninteractive
# Startup commands go here

# Activating the network interface
ip link set dev enp0s8 up

# Adding an IP address to the network interface
ip addr add 172.16.0.34/27 dev enp0s8

# Actually these 2 commands are useless, since when the IP address is added with the previous command, the following rule is automatically deduced
ip route del 172.16.0.32/27
ip route add 172.16.0.32/27 dev enp0s8

# All the traffic destinated to an IP that is in the 172.16.0.0/12 block, is sent to "router-2"
ip route add 172.16.0.0/12 via 172.16.0.33 dev enp0s8


# Installing docker using the official repository
apt-get update
apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io

# Pulling and running the nginx image
docker pull dustnic82/nginx-test
docker run -d -p 80:80 dustnic82/nginx-test
