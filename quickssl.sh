#!/bin/bash

echo "Downloading main script:"
wget https://raw.githubusercontent.com/zerohack16/ZeroSSLDA/main/zerodassl.sh

echo "moving script to right path: "
mv zerodassl.sh /root/

echo "setting up permissions"
chmod +x /root/zerodassl.sh

/root/zerodassl.sh
rm /root/zerodassl.sh

echo "process done."