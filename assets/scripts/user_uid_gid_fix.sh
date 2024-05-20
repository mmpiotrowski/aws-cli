#!/bin/bash

set -eu

# user uid/gid fix
NEW_UID=`stat -c "%u" /home/user/workdir`
NEW_GID=`stat -c "%g" /home/user/workdir`
CHANGED=0

if [ $NEW_UID -eq 0 ]; 
    echo "Aviod running as root user"
    exit 1
fi

if [ $NEW_UID -ne $(id -u user) ]; then
    usermod -o -u $NEW_UID -d /tmp/nonexistment user
    usermod -d /home/user user
    CHANGED=1
    
fi;

if [ $NEW_UID -ne $(id -g user) ]; then
    groupmod -o -g $NEW_GID user
    CHANGED=1
fi;

if [ "$CHANGED" -eq "1" ]; then 
    chown -R user:user /home/user
fi;
