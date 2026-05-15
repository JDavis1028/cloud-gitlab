#!/usr/bin/env bash
set -e

cat > ../ansible/inventory/hosts.ini <<EOF
EOF

echo "" >> ../ansible/inventory/hosts.ini
echo "[ec2_instances]" >> ../ansible/inventory/hosts.ini
terraform output -json | jq -r 'to_entries[] | "\(.key) ansible_host=\(.value.value)"' >> ../ansible/inventory/hosts.ini