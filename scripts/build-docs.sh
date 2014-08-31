#!/bin/sh

rm -rf quantities_doc
idris --mkdoc quantities.ipkg
git checkout gh-pages
git rm -r docs
mv quantities_doc docs
git add docs
git commit -m "updated documentation"
git checkout master
