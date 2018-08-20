#!/bin/bash


hugo -t blog
git add -f public 
git commit -m "publication"
git subtree push --prefix=public git@github.com:alkahan/blog.git gh-pages --squash
