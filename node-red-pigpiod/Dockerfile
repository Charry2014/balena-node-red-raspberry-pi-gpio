# pigpiod
FROM alpine 

STOPSIGNAL 9
  
RUN apk --update --no-cache add --virtual build-dependencies build-base && \
    cd /tmp && \
    wget https://github.com/joan2937/pigpio/archive/master.zip && \
    unzip -qq master.zip && \
    cd pigpio-master && \
    make && \
    sed -i 's/ldconfig/ldconfig \/usr\/local/g' Makefile && \
    make install && \
    apk del build-dependencies && \
    rm -rf /tmp/* && \
    apk --no-cache add tini

EXPOSE 8888

# This works
#RUN killall pigpiod || echo "pigpiod Process was not running."
#RUN rm -f /var/run/pigpio.pid
#CMD /usr/local/bin/pigpiod -g

# 
RUN killall pigpiod || echo "pigpiod Process was not running."
RUN rm -f /var/run/pigpio.pid
# Start the daemon and write default value 0 to all GPIO
# Note that pigs uses the Broadcom pin number not the GPIO number
CMD sleep 1 && /usr/local/bin/pigpiod -g && sleep 1 && /usr/local/bin/pigs w 5 0 && \
    /usr/local/bin/pigs w 6 0 && \
    /usr/local/bin/pigs w 13 0 && \
    /usr/local/bin/pigs w 16 0 && \
    /usr/local/bin/pigs w 19 0

# Can't get this to work, it just gets stuck starting up
#COPY startup.sh /root/startup.sh
#ENTRYPOINT ["/root/startup.sh"]
#RUN killall pigpiod || echo "pigpiod Process was not running."
#RUN rm -f /var/run/pigpio.pid
#CMD echo "Done."