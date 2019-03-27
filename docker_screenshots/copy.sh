#!/bin/bash

echo "Copying files"
if [ ! -d ./cypress/integration ]
then
	mkdir ./cypress/integration
fi
cp -r /rdl/input/src-gen/cypress/integration/* ./cypress/integration
echo "Replacing ip"
cd ./cypress/integration
ls -l
sed -i 's/localhost/10\.0\.75\.1/g' *-Screenshots.js
echo "Running Cypress"
cd /
$(npm bin)/cypress run -s './cypress/integration/*-Screenshots.js'
