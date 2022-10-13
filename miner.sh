#!/bin/bash
# +++++++++++
# Version 0.1
# buerzel 2022
# +++++++++++

# To Start the script 
# 1. make it executable (chmod +x miner.sh)
# 2. start with: miner.sh MinerXX
###########################################
# configuration part
###########################################
# Path, binary and attributes example
# MinerXX can be other miner, same miner with other username or modifikations - feel free

Miner01="/tmp/apollo-miner -host solo.ckpool.org -port 3333 -user <BTCADRESS> -pswd x -comport /dev/ttyAMA0 -brd_ocp 48 -osc 30 -ao_mode 1"
Miner02="/tmp/cgminer -o stratum+tcp://solo.ckpool.org:3333 -u <BTCADRESS> -p x --suggest-diff 32 --gekko-newpac-freq 100 --gekko-newpac-boost"

#Template for other miner
#MinerXY=""

###########################################################

# first end active sessions (hope you use screen only for the mining part!)

/usr/bin/killall screen >/dev/null 2>&1

# now start the new one

if [ $1 == "Miner01" ]
    then
    /usr/bin/screen | $Miner01
elif [ $1 == "Miner02" ]
    then
    /usr/bin/screen | $Miner02

### Template for every new Miner you create in the configuration part (under line 16) ###
#elif [ $1 == "MinerXY" ]
#    then
#    /usr/bin/screen | $MinerXY


# Stop 
elif [ $1 == "stop" ]
    then
    /usr/bin/killall screen >/dev/null 2>&1

# Help section
elif [ $1 == "-h" ]
    then
    echo "Help for use!
    Is the script executable?
    1. Before start, edit the script.
       Feel free to create as many entries as you need. 
    2. Start the script: miner.sh Minerxx
    3. for only stop all: miner.sh stop
    "
else
    echo "no choice"
fi


####################
