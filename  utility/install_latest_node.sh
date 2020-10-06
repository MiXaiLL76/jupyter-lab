#/bin/bash

# https://github.com/nodejs/help/wiki/Installation

NODE_LATEST_VERSION=$(curl -s -X GET https://nodejs.org/dist/latest/ | grep linux-x64.tar.xz | sed 's/<\/*[^>]*>//g' | awk '{print $1}' | awk -F "-" '{print $2}')

curl -s -X GET https://nodejs.org/dist/${NODE_LATEST_VERSION}/node-${NODE_LATEST_VERSION}-linux-x64.tar.xz -o node.tar.xz

mkdir -p /usr/local/lib/nodejs

tar -xJvf node.tar.xz -C /usr/local/lib/nodejs 

mv /usr/local/lib/nodejs/node-${NODE_LATEST_VERSION}-linux-x64 /usr/local/lib/nodejs/node-latest-linux-x64