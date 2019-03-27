#!/bin/bash

cp -r ../plantuml/functional-specs/* ./

rm -rf ./ui-specs/ui-screenshots
cp -r ../cypress/screenshots/ ./ui-specs/ui-screenshots

pdflatex -quiet --synctex=1 /src/functional-spec.tex
pdflatex -quiet --synctex=1 /src/functional-spec.tex

cp ./*.pdf ../pdf
