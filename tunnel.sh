#!/usr/bin/env bash
remoteip=<serverip>
keypath=<path/to/ssh/private/key>
remoteusr=<remote user>
port=49150

echodate()
{
  echo "[$(date +%Y-%m-%dT%H:%M:%S%z)]:" $*
}

if /usr/local/bin/nmap -p $port 127.0.0.1 | grep -q 'open'; then
   echodate "Tunnel is already open"
   exit 0;
fi

echodate $(ssh -i $keypath -o "StrictHostKeyChecking no" -L $port:$remoteip:$port $remoteusr@$remoteip -N)
echodate "Tunnel opened"

exit 0
