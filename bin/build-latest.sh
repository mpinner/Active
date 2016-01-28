#!/bin/bash

cd $ACTIVE_HOME/src;
make

sudo cp $ACTIVE_HOME/bin/env.sh /boot/uboot/

cd $OPC_SERVER_HOME
make
