# IPOP Structured P2P GroupVPN Controller

### Description
This project implements an IPOP GroupVPN controller for end-systems to operate in a structured peer-to-peer virtual private network. The controller is based on the refactored controller framework [1] for the IPOP project [2].

A set of scripts is available for automated preparation and simulation of a testbed for scalable testing of the IPOP network.

[1] https://github.com/GingerNinja23/controller-framework

[2] http://ipop-project.org/ or https://github.com/ipop-project

### Usage

#### Obtaining the source code

```
git clone https://github.com/ssabogal/ipop-structure-p2p-gvpn-controller
cd ipop-structure-p2p-gvpn-controller
mv ipop/ scale/node/
```

#### Preparing physical nodes (using CloudLab)

Create a profile, with at least one node and each node containing the following properties:

* Node Type ```raw-pc```

* Hardware Type ```C220M4```

* Disk Image ```Other...``` with URN ```urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU15-04-64-STD```

* Check the ```Publicly Routable IP``` option


Note: ensure that the host's SSH keys are applied to the CloudLab account.

Instantiate this profile as an experiment.

#### Using the automated test script

Open the ```List View``` tab to view the connections. Copy the connections (of the form ```<username>@<hostname>```) into ```scale/scale.cfg``` as ```NODE```, ```SERVER```, or ```FORWARDER```. Also specify the ```SIZE``` (the number of IPOP instances)

Run the bash script:
```bash scale/scale.bash```

Enter the following commands (see the ```README.md``` in ```scale/``` for information about what these commands do):
```
install
init
source
config <num_successors> <num_chords> <num_on_demand> <num_inbound>
run all
iperf <connection_type> <client_vnode_id> <server_vnode_id>
mem <vnode_id>
ping <connection_type> <vnode_id> <vnode_id> <count>
```

To view the IPOP network using the available visualizer, enter ```forward <port>``` within the bash script.

#### Using the visualizer:

Note: the visualizer depends on TKinter, use ```pacman -S tk``` (in Archlinux) or ```apt-get install python3-tk``` (in Ubuntu/Debian).

In scale.bash:

```forward <forwarder port>```

In a separate terminal:

```python3 visualizer.py tcp <forwarder ipv4> <forwarder port> <SIZE> <GUI window size (length)>```
