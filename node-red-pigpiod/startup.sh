#!/bin/bash
set -e

echo "startup.sh running"
killall pigpiod || echo "pigpiod Process was not running."
rm -f /var/run/pigpio.pid
/usr/local/bin/pigpiod -g
echo "startup.sh ending"