#!/bin/bash

set -x # to test stderr output in /var/log/killercoda

echo starting... # to test stdout output in /var/log/killercoda

apt update
apt -y install zip unzip

curl -s "https://get.sdkman.io" | bash

source "/root/.sdkman/bin/sdkman-init.sh"

sdk install java 19.0.1-oracle

sdk install maven

cd /tmp
git clone https://github.com/tanquetav/coda.git
cp -r coda/recursion ~/

touch /tmp/finished
