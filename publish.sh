#!/bin/bash


git checkout blog
git rebase master
hugo -t blog
git add -f public
git commit -m "publication"
git subtree push --prefix=public git@github.com:alkahan/blog.git gh-pages --squash
git checkout master
