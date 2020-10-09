#/bin/bash

# https://github.com/nodejs/help/wiki/Installation

NODE_LATEST_VERSION=$(curl -s -X GET https://nodejs.org/dist/latest/ | grep linux-x64.tar.gz | sed 's/<\/*[^>]*>//g' | awk '{print $1}' | awk -F "-" '{print $2}')

curl -s -X GET https://nodejs.org/dist/${NODE_LATEST_VERSION}/node-${NODE_LATEST_VERSION}-linux-x64.tar.gz -o node.tar.gz

mkdir -p /usr/local/lib/nodejs

tar -xvf node.tar.gz -C /usr/local/lib/nodejs 

mv /usr/local/lib/nodejs/node-${NODE_LATEST_VERSION}-linux-x64 /usr/local/lib/nodejs/node-latest-linux-x64

ln -s /usr/local/lib/nodejs/node-latest-linux-x64/bin/node /usr/local/bin/node
ln -s /usr/local/lib/nodejs/node-latest-linux-x64/bin/npm /usr/local/bin/npm
ln -s /usr/local/lib/nodejs/node-latest-linux-x64/bin/npx /usr/local/bin/npx