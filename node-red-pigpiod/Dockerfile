# pigpiod
FROM balenalib/raspberrypi4-64-alpine:latest

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

HEALTHCHECK --interval=1m --timeout=10s CMD ps -ef | grep -v grep | grep -e pigpiod || exit 1

# This works
COPY startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh
CMD ["/root/startup.sh"]
