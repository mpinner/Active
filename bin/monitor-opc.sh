#!/bin/bash

until /home/debian/opc-server.sh; do
    echo "OPC Server crashed with exit code $?.  Respawning.." >&2
    sleep 1
done
