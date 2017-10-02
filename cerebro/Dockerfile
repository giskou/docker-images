FROM openjdk:8-jre

ARG GOSU_VERSION=1.10
ARG CEREBRO_VERSION=0.6.8

ENV GOSU_VERSION $GOSU_VERSION
RUN set -x \
 && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
 && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
 && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
 && rm /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu \
 && gosu nobody true

ENV CEREBRO_VERSION $CEREBRO_VERSION
RUN cd /opt/ \
 && wget -O cerebro-${CEREBRO_VERSION}.tgz https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VERSION}/cerebro-${CEREBRO_VERSION}.tgz \
 && tar zxvf cerebro-${CEREBRO_VERSION}.tgz \
 && rm cerebro-${CEREBRO_VERSION}.tgz \
 && mkdir cerebro-${CEREBRO_VERSION}/logs \
 && mv cerebro-${CEREBRO_VERSION} cerebro

EXPOSE 9000

ENTRYPOINT ["/opt/cerebro/bin/cerebro"]
