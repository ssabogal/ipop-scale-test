#!/bin/bash

NODE="ssabogal@pc-c220m4-r03-14.wisc.cloudlab.us"

FORWARDER="./node/cv_forwarder.py"

cd $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

case "$1" in
    ("accept")
        echo "enter 'yes' to add a node to the list of known hosts"
        ssh $NODE "echo 'accepted connection: $NODE'"
        ;;
    ("source")
        echo "put $FORWARDER" | sftp $NODE;
        ;;
    ("forward")
        node_ethd=$(ssh $NODE ifconfig | grep eth | awk '{print $1}' | head -n 1)
        node_ipv4=$(ssh $NODE ifconfig $node_ethd | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')
        recv_port=$2
        forward_port=$3
        ssh $NODE "python3 $node_ipv4 $recv_port $forward_port &" &
        echo "connect visualizer to $node_ipv4 $forward_port"
        ;;
    (*)
        echo "usage:"
        echo "accept                             : add node to list of known hosts"
        echo "source                             : upload forwarder"
        echo "forward <recv_port> <forward_port> : run forwarder (udp:recv) to (tcp:forward)"
        ;;
esac
