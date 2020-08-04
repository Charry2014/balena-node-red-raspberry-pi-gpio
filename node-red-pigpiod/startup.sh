#!/bin/bash

# killall pigpiod || echo "pigpiod Process was not running."
rm -f /var/run/pigpio.pid
/usr/local/bin/pigpiod -g

/usr/local/bin/pigs w 5  0
/usr/local/bin/pigs w 6  0
/usr/local/bin/pigs w 13 0
/usr/local/bin/pigs w 16 0
/usr/local/bin/pigs w 19 0