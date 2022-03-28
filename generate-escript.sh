#!/bin/sh

git clone git@github.com:nerds-sh/earendil-cli.git clone 
cd clone 
mix deps.get
mix escript.build
mv earendil_cli ../
cd ..
rm -rf clone