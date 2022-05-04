#!/bin/sh

echo "Installing dependencies..."
pip3 install erdpy
echo "Installing dependencies...done"

echo "Installing earendil..."
curl -LOs https://archive.org/download/earendil/earendil
chmod +x earendil
sudo mv earendil /usr/local/bin/earendil
echo "Installing earendil...done"