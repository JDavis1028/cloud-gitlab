#!/usr/bin/env bash
set -e

cat > ~/cloud-gitlab/ansible/inventory/hosts.ini <<EOF
EOF

echo "" >> ~/cloud-gitlab/ansible/inventory/hosts.ini
echo "[main]" >> ~/cloud-gitlab/ansible/inventory/hosts.ini
cd ~/cloud-gitlab/terraform 
terraform output -json | jq -r 'to_entries[] | "\(.key) ansible_host=\(.value.value)"' >> ~/cloud-gitlab/ansible/inventory/hosts.ini