# balena-node-red-raspberry-pi-gpio
Use Node Red to control the Raspberry PI GPIO and deploy the application with Balena
It took a fair amount of hackery to get this working so here is a nicely packaged base for you to start from.

The project is split into two Dockerfiles and an example flows.json which shows how to configure the node.

## Node Red
Based on Node Red Balena image based on Alpine Linux
https://github.com/balena-io-library/base-images/blob/master/balena-base-images/node/raspberrypi4-64/alpine/3.12/14.4.0/build/Dockerfile
Easy hack to get Node Red running
Add the node-red-node-pi-gpiod nodes:
https://flows.nodered.org/node/node-red-node-pi-gpiod

## Raspberry Pi GPIO Daemon
Essential for writing to the Pi GPIOs and a bit of a fiddle to get working in Docker. 
Very helpful web page http://abyz.me.uk/rpi/pigpio/pigpiod.html
Some useful background here https://nodered.org/docs/getting-started/docker


## Flows.json
The main thing here is to remember to change the Host in your node from localhost to 172.17.0.1 - this is a major gotcha.
