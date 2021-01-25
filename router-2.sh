export DEBIAN_FRONTEND=noninteractive
# Startup commands go here

# Activating the network interfaces
ip link set dev enp0s8 up
ip link set dev enp0s9 up

# Adding IP addresses to the network interfaces
ip addr add 172.16.0.33/27 dev enp0s8
ip addr add 172.16.0.6/30 dev enp0s9

# Actually these 4 commands are useless, since when the IP addresses are added with the previous commands, the following rules are automatically deduced
ip route del 172.16.0.32/27
ip route del 172.16.0.4/30
ip route add 172.16.0.32/27 dev enp0s8
ip route add 172.16.0.4/30 dev enp0s9

# All the traffic destinated to the Hosts-A and Hosts-B subnetworks, is sent to "router-1"
ip route add 172.16.1.0/24 via 172.16.0.5 dev enp0s9
ip route add 172.16.2.0/23 via 172.16.0.5 dev enp0s9

# Allowing the forwarding of the packets
sysctl -w net.ipv4.ip_forward=1
