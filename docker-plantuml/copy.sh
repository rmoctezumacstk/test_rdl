#!/bin/bash

cp -r ../rdl/input/src-gen/functional-specs/ ./functional-specs
cp -r ../rdl/input/src-gen/technical-specs/ ./technical-specs
cp ../rdl/input/src-gen/bash/gendoc.sh ./

cat gendoc.sh | grep ^java | sed 's/$1\/functional-specs/\.\/functional-specs/g' | sed 's/$1\/technical-specs/\.\/technical-specs/g' | sed 's/java -jar \/c\/@Programs\/plantuml.jar/java -jar plantuml.jar/g' | sed '1s/^/#\!\/bin\/bash\n\n/' | tee gendoc_2.sh

chmod +x gendoc_2.sh

./gendoc_2.sh
