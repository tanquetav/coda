#!/bin/bash

set -x # to test stderr output in /var/log/killercoda

echo starting... # to test stdout output in /var/log/killercoda


curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
apt update
apt  -y install nodejs terraform
npm install --global cdktf-cli@latest

ssh node01 "curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -"
ssh node01 "wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg"
ssh node01 "echo \"deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main\" | sudo tee /etc/apt/sources.list.d/hashicorp.list"
ssh node01 "apt update"
ssh node01 "apt  -y install nodejs terraform"
ssh node01 "npm install --global cdktf-cli@latest"

rsync -a .kube node01:

mkdir env
cd env
cdktf init --template typescript --project-name env --enable-crash-reporting=false --project-description=CDKTF --providers-force-local  --log-level  --providers=\[\] --from-terraform-project=n << EOF
n
EOF

wget -O main.ts https://raw.githubusercontent.com/tanquetav/coda/main/cdk01/tools/main.ts

wget -O webdeployment.ts https://raw.githubusercontent.com/tanquetav/coda/main/cdk01/tools/webdeployment.ts

cd ..

wget -O sync.sh https://raw.githubusercontent.com/tanquetav/coda/main/cdk01/tools/sync.sh
chmod +x sync.sh
./sync.sh &

touch /tmp/finished
