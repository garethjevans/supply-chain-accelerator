# source-test-scan-to-url

## Installation

To install this into a cluster use:

```
ytt \
  --ignore-unknown-comments \
  --file ./config \
  --data-values-file values.yaml |
  kubectl apply -f-
```


