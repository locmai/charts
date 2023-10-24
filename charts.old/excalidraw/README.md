# Excalidraw

## Parameters

### Common parameters

| Name               | Description                                                | Value                   |
| ------------------ | ---------------------------------------------------------- | ----------------------- |
| `replicaCount`     | Override replicaCount                                      | `1`                     |
| `image.repository` | image repository                                           | `excalidraw/excalidraw` |
| `image.pullPolicy` | pull policy                                                | `IfNotPresent`          |
| `image.tag`        | image tag (immutable tags are recommended)                 | `latest`                |
| `imagePullSecrets` | image pull secrets                                         | `[]`                    |
| `nameOverride`     | name to override with                                      | `""`                    |
| `fullnameOverride` | fullname to override with                                  | `""`                    |
| `service.type`     | service type (either ClusterIP, LoadBalancer, or NodePort) | `ClusterIP`             |
| `service.port`     | pull policy                                                | `80`                    |


## Additional notes

TBD