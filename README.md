# Customized charts

Support customized and opinionated applications and infrastructure charts until the official vendors do it better.

## TL;DR

OCI charts (see: [locmai/charts/packages](https://github.com/locmai?tab=packages&repo_name=charts)):

```
helm install secret-generator oci://ghcr.io/locmai/secret-generator --version 0.1.10
```

For ArgoCD specification:

```
spec:
  source:
    chart: secret-generator
    repoURL: ghcr.io/locmai
    targetRevision: 0.1.10
```

For legacy Helm releases:

```
helm repo add locmai https://locmai.github.io/charts/
helm search repo locmai
helm install secret-generator locmai/secret-generator
```

## Generate README.md

First, install the [readme-generator](https://github.com/bitnami-labs/readme-generator-for-helm) from bitnami-labs. Then:

```
export CHART=excalidraw
readme-generator --values "charts/$CHART/values.yaml" --readme "charts/$CHART/README.md"
```
