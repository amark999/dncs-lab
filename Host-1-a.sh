export DEBIAN_FRONTEND=noninteractive
# Startup commands go here

# Activating the network interface
ip link set dev enp0s8 up

# Adding an IP address to the network interface
ip addr add 172.16.2.2/23 dev enp0s8

# Actually these 2 commands are useless, since when the IP address is added with the previous command, the following rule is automatically deduced
ip route del 172.16.2.0/23
ip route add 172.16.2.0/23 dev enp0s8

# All the traffic destinated to an IP that is in the 172.16.0.0/12 block, is sent to "router-1"
ip route add 172.16.0.0/12 via 172.16.2.1 dev enp0s8
