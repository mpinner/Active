#!/bin/bash

until /home/debian/git/Active/bin/active-slinger.sh; do
    echo "Active Slinger crashed with exit code $?.  Respawning.." >&2
    sleep 1
done
