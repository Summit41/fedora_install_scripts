#!/bin/bash

if [ $# -eq 0 ]; then
    node_version="20.11.0"
else
    node_version=$1
fi

sudo yum install gcc-c++ make
mkdir nodejs
cd nodejs

wget "https://nodejs.org/dist/v$node_version/node-v$node_version.tar.gz"
tar -xzvf "node-v$node_version.tar.gz"
cd "node-v$node_version"

./configure
make

sudo make install

node -v
npm -v
