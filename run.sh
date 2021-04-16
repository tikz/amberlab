#!/bin/bash

# coincidir con uid gid del user en el host
if ! [ -z "$MAP_UID" ]; then
    usermod -u $MAP_UID user 
fi

if ! [ -z "$MAP_GID" ]; then
    groupmod -g $MAP_GID user 
fi

su user -c "jupyter-lab --ip 0.0.0.0 --port=${PORT:-8888} --ServerApp.token='' --ServerApp.password='${HASH_PASSWORD}' --ServerApp.allow_remote_access='True' --ServerApp.allow_origin='*'"