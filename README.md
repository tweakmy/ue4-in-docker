# ue4-in-docker

## Why do you have to run in Docker
This is the recording of what you have done to get in working for you.
I can experiment with the container(if I am unsure) without comprising what I want to preserved.
On the contrary, you could also share the your dockerbuild to verify the dependencies is properly installed
If I move to a new host which I am about too, because laptop sucks, then I dont have to worry about whole process of setup

##How to run in your desktop
### ubuntu ( I am using xubuntu 14:04) -feel free to contribute others

#### Preparation before docker build
1) clone the my repo to your local disk
````
git clone https://github.com/tweakmy/ue4-in-docker.git
$cd ue4-in-docker
````

2) clone the unreal engine within the folder, it will prompt for your password
````
$git clone https://github.com/EpicGames/UnrealEngine.git
$cd UnrealEngine
````
Run Setup.sh here to save time trying to download the Unreal Editor Dependencies (this would be the content,docu,sample,tutorial) during the docker build
 ````
$sudo apt-get install mono libmono-microsoft-build-tasks-v4.0-4.0-cil
$./Setup.sh
````

Now, this can be other git repo, which I will update shortly

3) copy your NVIDIA driver file this folder (ue4-in-docker)

4) Modify the `RUN apt-get install -yq --no-install-recommends nvidia-340` in the Dockefile and put the correct NVIDIA driver in there.
Dont know how best to automate this to work for everybody running in Linux


#### Do docker build
5) Install docker in your machine which you can look up in internet and then do a docker build. You also will need to install docker-compose otherwise the `docker run` command is super long.
````
$docker build -t ue4:master .
````
and wait a long time

6) While waiting, inspect your /dev folder by ls /dev
````
$ls /dev
autofs           fuse          mei                 ram13   sda3      tty12  tty29  tty45  tty61      ttyS19  ttyS7    vcsa3
block            hidraw0       mem                 ram14   sda5      tty13  tty3   tty46  tty62      ttyS2   ttyS8    vcsa4
bsg              hpet          net                 ram15   sda6      tty14  tty30  tty47  tty63      ttyS20  ttyS9    vcsa5
btrfs-control    input         network_latency     ram2    sg0       tty15  tty31  tty48  tty7       ttyS21  uhid     vcsa6
bus              kmsg          network_throughput  ram3    sg1       tty16  tty32  tty49  tty8       ttyS22  uinput   vcsa7
cdrom            kvm           null                ram4    shm       tty17  tty33  tty5   tty9       ttyS23  urandom  vga_arbiter
char             log           nvidia0             ram5    snapshot  tty18  tty34  tty50  ttyprintk  ttyS24  v4l      vhci
console          loop0         nvidiactl           ram6    snd       tty19  tty35  tty51  ttyS0      ttyS25  vcs      vhost-net
core             loop1         port                ram7    sr0       tty2   tty36  tty52  ttyS1      ttyS26  vcs1     video0
cpu              loop2         ppp                 ram8    stderr    tty20  tty37  tty53  ttyS10     ttyS27  vcs2     watchdog
cpu_dma_latency  loop3         psaux               ram9    stdin     tty21  tty38  tty54  ttyS11     ttyS28  vcs3     watchdog0
cuse             loop4         ptmx                random  stdout    tty22  tty39  tty55  ttyS12     ttyS29  vcs4     zero
disk             loop5         pts                 rfkill  tpm0      tty23  tty4   tty56  ttyS13     ttyS3   vcs5
dri              loop6         ram0                rtc     tty       tty24  tty40  tty57  ttyS14     ttyS30  vcs6
ecryptfs         loop7         ram1                rtc0    tty0      tty25  tty41  tty58  ttyS15     ttyS31  vcs7
fb0              loop-control  ram10               sda     tty1      tty26  tty42  tty59  ttyS16     ttyS4   vcsa
fd               mapper        ram11               sda1    tty10     tty27  tty43  tty6   ttyS17     ttyS5   vcsa1
full             mcelog        ram12               sda2    tty11     tty28  tty44  tty60  ttyS18     ttyS6   vcsa2
````
At this point of time, just look at your nvidia* and snd

7) Modify the docker-compose.yml file at "devices" section. Modify to suit for your machine to expose sound card and graphic card to container.

devices:
````
  - "/dev/nvidia0"
  - "/dev/nvidiactl"
  - "/dev/snd/timer"
  - "/dev/snd/seq"
  - "/dev/snd/hwC0D0"
  - "/dev/snd/controlC0"
  - "/dev/snd/hwC1D3"
  - "/dev/snd/hwC0D1"
  - "/dev/snd/hwC1D2"
  - "/dev/snd/hwC1D1"
  - "/dev/snd/hwC1D0"
  - "/dev/snd/controlC1"
  - "/dev/snd/pcmC1D7p"
  - "/dev/snd/pcmC1D8p"
  - "/dev/snd/pcmC1D9p"
  - "/dev/snd/pcmC1D3p"
  - "/dev/snd/pcmC0D0p"
  - "/dev/snd/pcmC0D0c"
````
#### Do docker-compose
8) Once the docker build is completed. Run docker-compse run
````
$docker-compose run ue4/bin/bash
````
which will signed you in as user `unreal`

9) Now, you will be in a terminal /UnrealEngine, the following will build the Unreal Engine Editor
````
$make
````
this takes me 40 minutes. It depends on how powerful is your machine.

10) On YOUR HOST MACHINE, to enable x display from the container
````
$xhost +
````

11) Run the Editor
````
$./Engine/Binaries/Linux/UE4Editor
````

#In future
Everything will be automated til the build and you will get the Unreal Editor or codelite displayed instead of terminal

A shell script should be provided to do step 2 and 7

use xauthority instead of using xhost +, to make it more seamless build
