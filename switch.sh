export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common

# Startup commands for switch go here

# OpenVSwitch initiation command
ovs-vsctl init

# Adding a bridge called "switch"
ovs-vsctl add-br switch

# Adding the ports to "switch". The tags are used for VLAN setting
ovs-vsctl add-port switch enp0s8
ovs-vsctl add-port switch enp0s9 tag=20
ovs-vsctl add-port switch enp0s10 tag=10

# Activating the network interfaces
ip link set dev enp0s8 up
ip link set dev enp0s9 up
ip link set dev enp0s10 up
