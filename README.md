# v4l2loopback for Fedora Silverblue
***

A simple way to build v4l2loopback module on Fedora Silverblue flavours (Fedora kinoite).

This script will download automatically the last version of v4l2loopback from
[https://github.com/umlaeute/v4l2loopback](https://github.com/umlaeute/v4l2loopback).  

### Dependencies
1. **Podman**, check podman installation with the command:
 
        podman version
    
    The output is something like
    
        Client:       Podman Engine
        Version:      5.0.0-rc2
        API Version:  5.0.0-rc2
        Go Version:   go1.22.0
        Built:        Mon Feb 19 06:50:31 2024
        OS/Arch:      linux/amd64

## Express build and installation
If you just want build and run, lets go!:

1. Edit **Dockerfile** to configure your Fedora Version, default is **40**

   > ARG FEDORA_VERSION=**YOUR_VERSION**
   
3. Build
        
        sh podman_build.sh --no-cache

4. Install the module as a systemd service

        sudo sh install.sh

5. Check if all is ok

        sudo dmesg

    Output will be:
        
        [18109.162005] videodev: Linux video capture interface: v2.00
        [18109.164951] v4l2loopback driver version 0.13.1 (snapshot) loaded

If module stop works just repeat all steps again.

## Detailed Build

***

### Preparing build to your Fedora Version
1. Checkout or download all this files on a directory, after download you must have this files:

        v4l2loopback-fedora-silverblue
        ├── Dockerfile
        ├── install.sh
        ├── load-v4l2loopback.sh
        ├── podman_build.sh
        ├── README.md
        └── uninstall.sh


2. Verify your Fedora version with the command
    
    > uname -r
    
    The output is something like
    
        6.8.1-300.fc40.x86_64

    The **fc40** says that we are using **Fedora 40**

   Edit file **Dockerfile**  and change the first line to your version:

        ARG FEDORA_VERSION=40


### Building

1.  Open a terminal inside folder that you dowload an excecute the file **podman_build.sh**

        sh podman_build.sh

    A folder called **build** will be created and the module **v4l2loopback.ko** will be generated:

        ├── build
        │   └── v4l2loopback
        │       └── v4l2loopback.ko
        ├── Dockerfile
        ├── install.sh
        ├── load-v4l2loopback.sh
        ├── podman_build.sh
        ├── README.md
        └── uninstall.sh

2.  Load module:

        sudo sh load-v4l2loopback.sh

3   Great! your module must be loaded and working.

4.  Check with command:

        sudo dmesg

    Output will be:
        
        [18109.162005] videodev: Linux video capture interface: v2.00
        [18109.164951] v4l2loopback driver version 0.13.1 (snapshot) loaded


### Possible or Inevitable Problems

1.  You will have to repeat step 2 every time you restart your computer ( solution in the end of this document)
       
        sudo sh load-v4l2loopback.sh
    

2. Must repeat all building step if you update your kernel.

        sh podman_build.sh
        sudo sh load-v4l2loopback.sh

### Load this module when system starts.

Certainly there are many ways to do that, but a simple way is creating a service, lets do that!

1.  Execute the file **install.sh**

        sudo sh install.sh

    Output will be something like
    
        Creating a service on /etc/systemd/system/ ...
        Enable service...
        Starting service
        OK.Bye bye

2. Now the module will load before the user session starts, you can change **install.sh** script to adapt to your necessities.


3. To remove this service execute:

        sudo sh uninstall.sh

    output will be:

        Removing service...
        Removed "/etc/systemd/system/multi-user.target.wants/v4l2loopback-silverblue.service".
        Unloading module v4l2loopback
        Ok.Bye bye


### Build diretory is empty.
Execute the following command
    
        sh podman_build.sh --no-cache
        
### Can i use this in other distribution?
Sure you can! just adapt the dockerfile to your distribution.

https://github.com/moacirrf/new-lg4ff-fedora-silverblue/blob/main/Dockerfile

You can ask CHATGPT to convert dockerfile content to work with Ubuntu.

### Next features
- Automatically rebuild the module if module refuse to load.
- Or a graphical notification when module refuse to load (hard to do).
