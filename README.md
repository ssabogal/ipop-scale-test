# IPOP Controllers

### Prerequisites

Obtain **IPOP-Controllers** by downloading the latest archive from the releases or by cloning this repository:
```git clone https://github.com/ipop-project/controllers.git```

Obtain **IPOP-Tincan** by downloading the latest archive from the releases or by building from source [2].


### Usage

#### Running SocialVPN

1. Change current directory to ```config```.
    
    ```cd config/```

2. Change the filename of sample-svpn-config.json to svpn-config.json and modify it as per your requirements to configure the controller [1].

    ```mv sample-svpn-config.json svpn-config.json```
    ```nano svpn-config.json```

3. Run IPOP-Tincan.

    ```cd ../;  sudo ./ipop-tincan &> tin.log &  ```

4. Run SocialVPN Controller.

	Make sure you return to the home directory for the ipop, same as where the 'ipop-tincan' file is located.
	```
	python -m controller.Controller -c config/svpn-config.json &> log.txt &
	```

5. Check status.

    ```echo -e '\x02\x01{"m":"get_state"}' | netcat -q 1 -u 127.0.0.1 5800```

#### Running GroupVPN

1. Change current directory to ```config```.

    ```cd config/```

2. Change the filename of sample-gvpn-config.json to gvpn-config.json and modify it as per your requirements to configure the controller [1].

    ```mv sample-gvpn-config.json gvpn-config.json```
    ```nano gvpn-config.json```

3. Run IPOP-Tincan.

    ```cd ../ ; sudo ./ipop-tincan &> tin.log &  ```

4. Run GroupVPN Controller.

	Make sure you return to the home directory of ipop, same as where the 'ipop-tincan' file is located.
	```
	python -m controller.Controller -c config/gvpn-config.json &> log.txt &
	```

5. Check status.

    ```echo -e '\x02\x01{"m":"get_state"}' | netcat -q 1 -u 127.0.0.1 5800```

#### Killing IPOP

The following commands will search the PID of IPOP-Tincan and IPOP-Controller and dispatch a kill signal.
```
ps aux | grep -v grep | grep ipop-tincan | awk '{print $2}' | xargs sudo kill -9
ps aux | grep -v grep | grep controller.Controller.py | awk '{print $2}' | xargs sudo kill -9
```

### Notes

[1] See https://github.com/ipop-project/documentation/wiki/Configuration for a detailed description of options for controller configuartion.

[2] See https://github.com/ipop-project/documentation/wiki under _Building the code_ for guides on building IPOP-Tincan from source.
