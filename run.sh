#!/bin/bash

# coincidir con uid gid del user en el host
if ! [ -z "$MAP_UID" ]; then
    usermod -u user $MAP_UID
fi

if ! [ -z "$MAP_GID" ]; then
    groupmod -u user $MAP_GID
fi

su user -c "jupyter-lab --ip 0.0.0.0 --LabApp.token=''"