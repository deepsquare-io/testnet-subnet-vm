#!/bin/bash
sudo apt -y install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

sudo apt -y install gcc jq



GO_SHASUM=36519702ae2fd573c9869461990ae550c8c0d955cd28d2827a6b159fda81ff95
curl -OL https://go.dev/dl/go1.19.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.19.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
source ~/.profile


VERSION=v1.9.7
git clone https://github.com/ava-labs/avalanchego.git
cd avalanchego
git checkout $VERSION
./scripts/build.sh

mkdir -p ~/.avalanchego/configs/chains/23q7DGje3AFbLKCgXFWcW6eo9zsB166mfknGHt5dySefGtJboZ/
echo '{ "allow-missing-tries": true }' >> ~/.avalanchego/configs/chains/23q7DGje3AFbLKCgXFWcW6eo9zsB166mfknGHt5dySefGtJboZ/config.json


cd ~/
git clone https://github.com/deepsquare-io/testnet-subnet-vm.git
mkdir -p ~/.avalanchego/plugins
cp testnet-subnet-vm/vms/v22/mDV28Yo1kHR1XAXo29LJsVh38vyKUdsvcdAZXYakdQd3LMwBY ~/.avalanchego/plugins/
chmod +x ~/.avalanchego/plugins/mDV28Yo1kHR1XAXo29LJsVh38vyKUdsvcdAZXYakdQd3LMwBY

cd ~/avalanchego
./build/avalanchego --http-host=0.0.0.0 --network-id=fuji --track-subnets=8dRakstCMfHV8CXRhdtq9Wbxo75535Pfran1yDX5x4TYJq22A
