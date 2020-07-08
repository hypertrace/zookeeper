# Zookeeper
This repo publishes the docker image and helm chart for [Apache Zookeeper](https://zookeeper.apache.org).

## Prerequisites
* Kubernetes 1.10+
* Helm 3.0+

## Docker Image
The docker image is published to [Docker Hub](https://hub.docker.com/r/hypertrace/zookeeper)

## Helm Chart Components
This chart will do the following:

* Create a fixed size ZooKeeper ensemble using a [StatefulSet](http://kubernetes.io/docs/concepts/abstractions/controllers/statefulsets/).
* Create a [PodDisruptionBudget](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-disruption-budget/) so kubectl drain will respect the Quorum size of the ensemble.
* Create a [Headless Service](https://kubernetes.io/docs/concepts/services-networking/service/) to control the domain of the ZooKeeper ensemble.
* Create a Service configured to connect to the available ZooKeeper instance on the configured client port.
* Optionally apply a [Pod Anti-Affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature) to spread the ZooKeeper ensemble across nodes.
* Optionally start a JMX Exporter container inside Zookeeper pods.
* Optionally create a Prometheus ServiceMonitor for each enabled jmx exporter container.
* Optionally add prometheus alerts.
* Optionally create a new storage class.

## Installing the Chart
You can install the chart with the release name `zookeeper` as below.

```console
$ helm upgrade zookeeper ./helm --install --namespace hypertrace
```

## Configuration
You can specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm upgrade my-release ./helm --install --namespace hypertrace -f values.yaml
```

## Default Values
- You can find all user-configurable settings, their defaults in [values.yaml](helm/values.yaml).

