#!/bin/bash

SVC_ADDRESS=$(kubectl get -n accelerator-system service/acc-server | grep -v NAME | awk '{print $4}')
OUTPUT=generated-supply-chain

tanzu accelerator generate-from-local \
  --accelerator-path supply-chain-accelerator=. \
  --fragment-names tap-workload \
  --options '{"projectName":"test-supply-chain","workloadType":"web","hasTests":true,"hasSourceScan":true,"hasImageScan":true",sourceScanningTool":"grype","buildTool":"tbs"}' \
  --output-dir "./$OUTPUT" \
  --server-url http://accelerator.$SVC_ADDRESS.nip.io

tree $OUTPUT

