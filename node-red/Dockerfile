# Node red
FROM balenalib/raspberrypi4-64-alpine:3.12-build

ENV NODE_VERSION 14.4.0
ENV YARN_VERSION 1.22.4

# Install dependencies
RUN apk add --no-cache libgcc libstdc++ libuv \
	&& apk add --no-cache libssl1.0 || apk add --no-cache libssl1.1

RUN for key in \
	6A010C5166006599AA17F08146C2130DFD2497F5 \
	; do \
		gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
		gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
	done \
	&& curl -SLO "http://resin-packages.s3.amazonaws.com/node/v$NODE_VERSION/node-v$NODE_VERSION-linux-alpine-aarch64.tar.gz" \
	&& echo "146e6cdffb839c21be2c85a5d4cb823a76ab48e3f868b1c5cd4a789e8a43ba7e  node-v$NODE_VERSION-linux-alpine-aarch64.tar.gz" | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-alpine-aarch64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-alpine-aarch64.tar.gz" \
	&& curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
	&& curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
	&& gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
	&& mkdir -p /opt/yarn \
	&& tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
	&& ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
	&& ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
	&& rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
	&& npm config set unsafe-perm true -g --unsafe-perm \
	&& rm -rf /tmp/*


WORKDIR /data/.node-red
RUN npm install -g --unsafe-perm node-red node-red-node-pi-gpiod
COPY . /data/.node-red
CMD node-red --userDir /data/.node-red --define logging.console.level=debug flows.json
