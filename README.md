# balena-node-red-raspberry-pi-gpio
Use Node Red to control the Raspberry PI GPIO and deploy the application with Balena. It took a fair amount of hackery to get this working so here is a nicely packaged base for you to start from.

The project is split into two Dockerfiles and an example flows.json which shows how to configure the node. The Pi is mounted in this Waveshare relay board to interact with the outside world through relays on the GPIO pins
* https://www.waveshare.com/rpi-relay-board-b.htm

## Node Red
Based on Node Red Balena image based on Alpine Linux. Some useful instructions for an easy approach to get Node Red running here:
* https://github.com/balena-io-library/base-images/blob/master/balena-base-images/node/raspberrypi4-64/alpine/3.12/14.4.0/build/Dockerfile


## Raspberry Pi GPIO Daemon
Essential for writing to the Pi GPIOs and a bit of a fiddle to get working in Docker. The nodes are installed using npm in the Dockerfile.

Add the node-red-node-pi-gpiod nodes:
* https://flows.nodered.org/node/node-red-node-pi-gpiod
* Very helpful web page http://abyz.me.uk/rpi/pigpio/pigpiod.html
* Some useful background here https://nodered.org/docs/getting-started/docker

The main thing to remember here is when using Docker you must **change the Host in your node from localhost to 172.17.0.1** - this is a major gotcha. Failing to do this will cause the ECONNREFUSED error which is fairly common with a few causes. My debugging lead me to rule out many complicated possibilities before I found this depressingly simple mistake.

## Flows.json
Ties everything together and uses MQTT to test and control the Pi GPIO pins. The MQTT broker is running Mosquitto on an AWS hosted EC2 instance in the free tier.

Note that there are two problems after rebooting or power cycle - 
* The gpiod container sometimes does not restart cleanly - using the Balena 'Restart' seems to fix this
* Node Red gives a dialog about “The flows on the server have been updated” which they have not been. It seems to be a bug somewhere related to the use of the node-red-node-pi-gpiod nodes. See my question here - https://discourse.nodered.org/t/the-flows-on-the-server-have-been-updated-with-pi-gpiod-nodes/29827


## Log Spooler

The Log Spooler container is responsible for accessing the container logs and device information through the Balena Supervisor API and spooling these into a log file. 

## Logagent from Sematext

See ./docker-compose.yml and note that the Dockerfile in this project is currently not used, rather the image provided by Sematext. The only configuration necessary is the LOG_GLOB variable and voila it (mostly) works. See the open issue which has been forwarded to Sematext for investigation.

The configuration necessary on Sematext is to sign-up for a free account, extract your LOGS_TOKEN for your application and paste it into docker-compose.yml. The rest should happen like magic.