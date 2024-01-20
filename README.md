# Customized charts

Support customized and opinionated applications and infrastructure charts until the official vendors do it better.

## TL;DR

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
