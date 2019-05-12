#!/usr/bin/env bash
remoteip=<serverip>
keypath=<path/to/ssh/private/key>
remoteusr=<remote user>
port=49150

# should have nmap installed for this to work
if /usr/local/bin/nmap -p $port 127.0.0.1 | grep -q 'open'; then
   echo "Tunnel is already open"
   exit 1;
fi

ssh -i $keypath -o "StrictHostKeyChecking no" -L $port:$remoteip:$port $remoteusr@$remoteip -N

echo "Tunnel opened"

exit 0
