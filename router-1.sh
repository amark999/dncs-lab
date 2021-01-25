export DEBIAN_FRONTEND=noninteractive
# Startup commands go here

# Two additional links for VLAN management: all the traffic will go thorough the master interface "enp0s8", but with a VLAN tag.
ip link add link enp0s8 name enp0s8.10 type vlan id 10
ip link add link enp0s8 name enp0s8.20 type vlan id 20

# Activating the network interfaces
ip link set dev enp0s8 up
ip link set dev enp0s8.10 up
ip link set dev enp0s8.20 up
ip link set dev enp0s9 up

# Adding IP addresses to the network interfaces
ip addr add 172.16.1.1/24 dev enp0s8.10
ip addr add 172.16.2.1/23 dev enp0s8.20
ip addr add 172.16.0.5/30 dev enp0s9
# It is not necessary to assign an IP to "enp0s8", since only the two VLAN are used.

# Actually these 6 commands are useless, since when the IP addresses are added with the previous commands, the following rules are automatically deduced
ip route del 172.16.1.0/24
ip route del 172.16.2.0/23
ip route del 172.16.0.4/30
ip route add 172.16.1.0/24 dev enp0s8.10
ip route add 172.16.2.0/23 dev enp0s8.20
ip route add 172.16.0.4/30 dev enp0s9

# All the traffic destinated to the Hub subnetwork, is sent to "router-2"
ip route add 172.16.0.32/27 via 172.16.0.6 dev enp0s9

# Allowing the forwarding of the packets
sysctl -w net.ipv4.ip_forward=1

## Uncomment the following for the installation of wireshark and tshark
#apt-get update
#apt-get -y install wireshark
#apt-get -y install tshark
#apt-get update

