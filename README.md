# td-agent-barito-kubernetes

This repository contains the source files needed to make a Docker image that collects Docker container log files using [td-agent](http://www.fluentd.org/) and sends them to [Barito](https://github.com/BaritoLog/).

This image is designed to be used as a [daemonset](http://kubernetes.io/docs/admin/daemons) in a [Kubernetes](https://github.com/kubernetes/kubernetes) cluster. Every new version will be pushed to [Barito Docker Hub](https://hub.docker.com/r/barito/td-agent-barito-kubernetes/)

Because there are additional configurations that have to be made, this image full functionality can only be realized when you install it using our [helm chart](https://github.com/BaritoLog/helm-charts).

## Usage

Sign in to BaritoMarket and find your Application Group. Barito `Application Group Secret` and `Produce URL` will be displayed, make note of those details.

### Install Helm Chart

1. Add our helm chart repo

```shell
helm repo add barito https://baritolog.github.io/helm-charts
```

2. Create a custom yaml containing helm chart values to specify app that you want its logs to be forwarded, example:

```yaml
# myApps.yaml
cluster_name: my-prod-cluster
defaultAppOptions:
  applicationGroupSecret: abc
  produceUrl: https://barito-router.my-domain.com/produce_batch
apps:
  - name: my-app-1
    baritoAppName: My App 1
  - name: my-app-2
    baritoAppName: My App 2
  - name: my-app-3
    baritoAppName: My App 3
    applicationGroupSecret: xyz
    produceUrl: https://barito-router.other-domain.com/produce_batch

```

> `name` is metadata name of your deployment

3. Install using helm

```shell
helm install barito/td-agent-barito --name=td-agent-barito --values=myApps.yaml
```

Override `rbac.create` when installing: `--set rbac.create=true` if you are using RBAC authorization.

## Notes

If not specified,

- DaemonSet will have memory limits of `2 Gi` and memory requests `1 Gi`. Use `--set resources.limits.memory=XX` or `--set resources.requests.memory=XX` to override.

- DaemonSet will have cpu limits of `2` and cpu requests `500m`. Use `--set resources.limits.cpu=XX` or `--set resources.requests.cpu=XX` to override.

- DaemonSet will have ephemeral-storage limits of `6 Gi` and ephemeral-storage requests `4 Gi`. Use `--set resources.limits.ephemeral-storage=XX` or `--set resources.requests.ephemeral-storage=XX` to override.

- td-agent will has config `parse @type none` by default. Use `--set useCRIFormat=true` if the cluster use CRI-o Format.
