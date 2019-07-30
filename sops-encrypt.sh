#!/bin/bash
set -exuo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
keyvault_id=$(cd ${dir}/../shared_infrastructure && terraform output keyvault_id)
echo $keyvault_id
files=$(find . -name "*.enc*")

for file in $files
do
  echo "Encrypting file in place: ${file}"
  sops -e -i \
    --azure-kv ${keyvault_id} \
    ${file}
done
