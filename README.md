# Scale-Test for IPOP

### Description

This project composes a set of scripts for automating the deployment and simulation of IPOP networks. Scale-Test supports both GroupVPN (using a structured peer-to-peer topology) and SocialVPN (using an unstructured, social topology),

##### References

[1] [IPOP](http://ipop-project.org/) 

[2] [IPOP GitHub](https://github.com/ipop-project) 

[3] [Scale-Test concept](https://github.com/ipop-project/ipop-project.github.io/wiki/Testing-Your-Build) 

### Usage

#### Preparing physical nodes (using CloudLab)

##### Pre-defined sample profiles

Use any of the following pre-defined profiles: `IPOP_SCALE_TEST_1_VIVID`, `IPOP_SCALE_TEST_2_VIVID`, or `IPOP_SCALE_TEST_5_VIVID`.

##### Create a profile

Create a profile, with at least one node and each node containing the following properties:

* Node Type `raw-pc`

* Hardware Type `c220g2`

* Disk Image `Other...` with URN `urn:publicid:IDN+emulab.net+image+emulab-ops:UBUNTU15-04-64-STD`

* Check the `Publicly Routable IP` option

##### Create an experiment

Note: ensure that the host's SSH keys are added to the CloudLab account.

Instantiate this profile as to create an experiment.

#### Using the automated test script

Open the `List View` tab to view the connections. In `scale/scale.cfg`, assign the `NODE`, `SERVER`, and `FORWARDER` variables with connections of the form `<username>@<hostname>`. Specify the `SIZE` (the number of IPOP instances).

Specify the `CONTROLLER` and `TINCAN` variables with the tag or commit of the IPOP controller and tincan.

For example, the following configuration has 2 nodes (with one assuming the server and forwarder roles) with 20 LXCs (10 LXCs each) using version 16.08.0 of the IPOP controller and tincan:

```sh
#!/bin/sh

NODES="ipopuser@c220g2-011012.wisc.cloudlab.us ipopuser@c220g2-011013.wisc.cloudlab.us"
SERVER="ipopuser@c220g2-011012.wisc.cloudlab.us"
FORWARDER="ipopuser@c220g2-011012.wisc.cloudlab.us"
SIZE=20

CONTROLLER="v16.08.0"
TINCAN="v16.08.0"
```

Run the shell script:

`sh scale/scale.sh`

Enter the following commands:

```sh
download  # retrieves the IPOP sources specified by CONTROLLER and TINCAN or the defaults
accept    # enter 'yes' if prompted
install
init
source
config <gvpn | svpn> [options]
run all
```

#### Configuration

The `config` command supports user-configurable options for generating highly customized IPOP configurations.

+ For GroupVPN:

	```
	config gvpn <num_successors> <num_chords> <num_on_demand> <num_inbound> <ttl_link_initial> <ttl_link_pulse> <ttl_chord> <ttl_on_demand> <threshold_on_demand>
	```

	+ Example: `config gvpn 2 3 2 8 60 30 180 60 128` defines a GroupVPN topology with the follow characteristics:

		+ about 2 successors
		+ up to 3 chords
		+ up to 2 on-demand links
		+ about 8 in-bound links
		+ initializing links have a time-to-live of 60 seconds before they are trimmed
		+ established links have a time-to-live of 30 seconds before they are trimmed
		+ chords have a time-to-live of 180 seconds before they may be replaced
		+ on-demand links have a time-to-live of 60 seconds before they undergoes a threshold test
		+ on-demand links have a threshold of 128 transmitted bytes per second before they are trimmed

+ For SocialVPN:

	```
	config svpn
	```

	+ Example: `config svpn` defines a SocialVPN topology.


#### Using the visualizer:

Note: the visualizer depends on TKinter, use `pacman -S tk` (in Archlinux) or `apt-get install python3-tk` (in Ubuntu/Debian).

In scale.sh:

```sh
forward <forwarder port>
visualize <forwarder port> <gvpn | svpn>
```

### Miscellaneous

#### Using the Ubuntu 14.04 LTS

By default, Scale-Test only supports Ubuntu 15.04. To use Ubuntu 14.04 LTS, modify `scale/node/node.bash` and set the variable `NEW_TEST` to `false` prior to deployment.

A reference profile with one physical-node and 20 LXC-nodes is available: `IPOP_SCALE_TEST_1_TRUSTY`

#### Running IPOP with python3

By default, IPOP instances are ran with python2. To run IPOP with python3, modify `scale/node/ipop/ipop.bash` and set the variable `PYTHON` to `python3` prior to deployment.
