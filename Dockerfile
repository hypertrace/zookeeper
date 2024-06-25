FROM alpine:latest AS downloader

ARG ZOOKEEPER_VERSION=3.8.4

RUN apk add --update curl gpg gpg-agent && \
    curl -sLO https://www.apache.org/dist/zookeeper/KEYS && \
    gpg --import KEYS && \
    curl -sLO https://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz && \
    curl -sLO https://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc && \
    gpg --verify apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz && \
    tar xvfz apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz && \
    mv apache-zookeeper-${ZOOKEEPER_VERSION}-bin /opt/zookeeper && \
    rm -rf KEYS apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz.asc apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz

FROM eclipse-temurin:11-jre-jammy

RUN apt update && apt install -y netcat && apt upgrade -y

COPY --from=downloader /opt/zookeeper /opt/zookeeper

ENV ZOOKEEPER_HOME=/opt/zookeeper

WORKDIR /opt/zookeeper

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]

CMD ["start-foreground"]
