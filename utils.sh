#!/bin/bash

## This file should be imported (source) by others.
## It acts as a library of common useful functions

function checkRoot {
    if [[ $EUID -ne 0 ]]; then
        echo "Got root?"
	exit 1
    fi
}

function up {
    checkRoot
    apt update -y && apt dist-upgrade -y
    sed -i 's/jessie/stretch/g' /etc/apt/sources.list
    apt update -y && apt dist-upgrade -y
}

function checkUserExists {
    return id -u $1 > /dev/null 2>&1; echo $?
}
