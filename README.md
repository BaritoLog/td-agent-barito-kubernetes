# td-agent-barito-kubernetes

This repository contains the source files needed to make a Docker image that collects Docker container log files using [td-agent](http://www.fluentd.org/) and sends them to [Barito](https://github.com/BaritoLog/).

## Overview

This Docker image is designed to be deployed as a [DaemonSet](http://kubernetes.io/docs/admin/daemons) in a [Kubernetes](https://github.com/kubernetes/kubernetes) cluster. It automatically collects logs from all containers in the cluster and forwards them to your Barito logging infrastructure.

### Features

- **Kubernetes Native**: Designed specifically for Kubernetes deployments
- **Auto-discovery**: Automatically detects and collects logs from all pods
- **Flexible Configuration**: Support for per-application custom settings
- **Resource Management**: Configurable CPU, memory, and storage limits
- **Client Trail Support**: Add custom metadata to logs for better filtering
- **CRI-O Compatible**: Support for both Docker and CRI-O container runtimes

### Docker Images

Every new version is automatically pushed to [Barito Docker Hub](https://hub.docker.com/r/barito/td-agent-barito-kubernetes/).

## Prerequisites

- Kubernetes cluster
- Helm 3.x
- Barito Market account with:
  - Application Group Secret
  - Produce URL

## Installation

### 1. Add Helm Repository

```shell
helm repo add barito https://baritolog.github.io/helm-charts
helm repo update
```

### 2. Configure Your Applications

Create a custom YAML file containing helm chart values to specify applications for log forwarding:

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

**Configuration Notes:**

- `name`: Metadata name of your deployment
- `baritoAppName`: Display name in Barito
- Individual apps can override default settings

### 3. Install with Helm

```shell
helm install td-agent-barito barito/td-agent-barito --values=myApps.yaml
```

For RBAC-enabled clusters:

```shell
helm install td-agent-barito barito/td-agent-barito --values=myApps.yaml --set rbac.create=true
```

## Configuration Options

### Resource Limits

The DaemonSet uses the following default resource settings:

- **Memory**: 1 Gi requests, 2 Gi limits
- **CPU**: 500m requests, 2 limits  
- **Ephemeral Storage**: 4 Gi requests, 6 Gi limits

Override these settings:

```shell
# Memory
--set resources.limits.memory=4Gi
--set resources.requests.memory=2Gi

# CPU
--set resources.limits.cpu=4
--set resources.requests.cpu=1

# Ephemeral Storage
--set resources.limits.ephemeral-storage=8Gi
--set resources.requests.ephemeral-storage=6Gi
```

### Container Runtime

- **Default**: Docker format (`parse @type none`)
- **CRI-O**: Use `--set useCRIFormat=true` for CRI-O clusters

### Client Trail Information

Add custom metadata to logs for better filtering and analysis:

```yaml
# In your values.yaml
additionalLabels:
  env: "staging"
  cloud_service_provider: "gcp"
  region: "us-west-2"
```

This will add metadata to your logs:

```json
{
  "message": "Sample log message",
  "client_trail": {
    "env": "staging",
    "cloud_service_provider": "gcp",
    "region": "us-west-2"
  }
}
```

**Use Cases:**

- Environment-based filtering: `client_trail.env: staging`
- Service identification: `client_trail.service_name: api-gateway`
- Regional analysis: `client_trail.region: us-west-2`

## Troubleshooting

### Common Issues

1. **Pods not starting**: Check resource limits and cluster capacity
2. **No logs appearing**: Verify Application Group Secret and Produce URL
3. **Permission denied**: Ensure RBAC is properly configured

### Debug Commands

```shell
# Check DaemonSet status
kubectl get daemonset td-agent-barito

# View pod logs
kubectl logs -l app=td-agent-barito

# Check configuration
kubectl describe configmap td-agent-barito-config
```

## Development

For development and customization of this image, please see the source repository structure and build instructions in the project's development documentation.

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the same terms as the Barito project.
