#!/bin/bash

cd /home/debian/git/Active;

while true; do

    until ./bin/active-slinger.sh; do
        echo "Active Slinger crashed with exit code $?.  Respawning.." >&2
        sleep 1
    done
done