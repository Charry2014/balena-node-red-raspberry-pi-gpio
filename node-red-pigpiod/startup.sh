#!/bin/bash

# killall pigpiod || echo "pigpiod Process was not running."
rm -f /var/run/pigpio.pid
/usr/local/bin/pigpiod -g

# Set the outputs to 1 - which represents also the power off state of the relays
# 5 Channels of water
/usr/local/bin/pigs w 5  1
/usr/local/bin/pigs w 6  1
/usr/local/bin/pigs w 13 1
/usr/local/bin/pigs w 16 1
/usr/local/bin/pigs w 19 1
# Gate
/usr/local/bin/pigs w 20 1

# Set the channels to inputs and set pullup/pulldown resistor
# Garage - exit release on gate
/usr/local/bin/pigs m 21 r
/usr/local/bin/pigs pud 21 u 
