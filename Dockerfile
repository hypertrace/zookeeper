# https://console.cloud.google.com/gcr/images/google-containers/GLOBAL/kubernetes-zookeeper
# NOTE: The tag 1.0-3.4.10 is over 3 years old!
FROM k8s.gcr.io/kubernetes-zookeeper:1.0-3.4.10

ENV ZOOKEEPER_VERSION="1.0-3.4.10"

RUN set -ex \
    && apt-get update \
    && apt-get install -y wget \
    && mkdir -p /opt/prometheus \
    && wget -O /opt/prometheus/jmx_prometheus_javaagent-0.12.0.jar https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.12.0/jmx_prometheus_javaagent-0.12.0.jar \
    && apt-get autoremove -y wget
