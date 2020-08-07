FROM balenalib/raspberrypi4-64-alpine:3.12-build

RUN \
  apk add --no-cache --update bash tini jq && \
  rm -rf /var/cache/apk/*

# RUN \ 
#  apk add --no-cache --virtual .build-deps alpine-sdk python

COPY run.sh /run.sh
RUN chmod +x /run.sh
HEALTHCHECK --interval=1m --timeout=10s CMD ps -ef | grep -v grep | grep -e curl || exit 1

CMD ["/run.sh"]