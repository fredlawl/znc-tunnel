#!/usr/bin/env bash
remoteip=<serverip>
keypath=<path/to/ssh/private/key>
remoteusr=<remote user>
port=49150

echodate()
{
  echo "[$(date +%Y-%m-%dT%H:%M:%S%z)]:" $*
}

connect()
{
    ssh -N -fi $keypath -o "StrictHostKeyChecking no" -o ExitOnForwardFailure=yes -L $port:$remoteip:$port $remoteusr@$remoteip
    if [[ $? -eq 0 ]]; then
        echodate "Tunnel opened"
    else
        echodate "Reattempting"
    fi
}


attempt()
{
    if [[ $(netstat -an -f inet | grep "127.0.0.1.$port.*LISTEN" | wc -l) -gt 0 ]]; then
        echodate "Tunnel is already open"
        exit 0
    fi

    connect
    sleep 5
    attempt
}


attempt

exit 0
