#!/bin/bash

set -euo pipefail

ENV=$1

SVC_ADDRESS=$(kubectl get -n accelerator-system service/acc-server | grep -v NAME | awk '{print $4}')
OUTPUT=generated/$ENV

tanzu accelerator generate-from-local \
  --accelerator-path supply-chain-accelerator=. \
  --fragment-names tap-workload \
  --options-file tests/$ENV.json \
  --output-dir "$OUTPUT" \
  --server-url http://accelerator.$SVC_ADDRESS.nip.io

tree $OUTPUT

#cat $OUTPUT/accelerator-log.md
#cat $OUTPUT/cluster-supply-chain.yaml

echo "================================================"
echo "Supply Chain Delta"
set +e
diff $OUTPUT/config/cluster-supply-chain.yaml config/cluster-supply-chain.yaml
set -e

echo "================================================"
echo "README.md Delta"
set +e
diff $OUTPUT/README.md README.md
set -e

echo "================================================"
echo "Checking $OUTPUT/cluster-supply-chain.yaml against tests/expected-$ENV.yaml"
diff $OUTPUT/config/cluster-supply-chain.yaml tests/expected-$ENV.yaml

pushd $OUTPUT
	./display.sh
popd
