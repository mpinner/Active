#!/bin/bash

until /home/debian/git/Active/bin/opc-server.sh; do
    echo "OPC Server crashed with exit code $?.  Respawning.." >&2
    sleep 1
done
