#!/bin/bash

rm -rf ./src/components/app
mkdir ./src/components/app

rm -rf ./src/tabledata
mkdir ./src/tabledata

cp -r ../rdl/input/src-gen/prototipo/src/components/app/* ./src/components/app
cp ../rdl/input/src-gen/prototipo/src/tabledata.js ./src
cp -r ../rdl/input/src-gen/prototipo/src/tabledata/* ./src/tabledata
cp ../rdl/input/src-gen/prototipo/src/index.js ./src

npm run dev
