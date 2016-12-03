#!/bin/bash


hugo -t blog
git subtree push --prefix=public git@github.com:alkahan/blog.git gh-pages --squash
