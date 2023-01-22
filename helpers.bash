#!/bin/bash

NODE_URL=127.0.0.1:9650

function isNodeValidator() {
	curl -s -X POST --data '{
		"jsonrpc":"2.0",
		"id" :1,
		"method" :"platform.getCurrentValidators"
	}' -H 'content-type:application/json;' $NODE_URL/ext/bc/P | jq | grep -A7 -B3 $1 
}


function getNodeID() {
	curl -s -X POST --data '{
		"jsonrpc":"2.0",
		"id"     :1,
		"method" :"info.getNodeID"
	}' -H 'content-type:application/json;' $NODE_URL/ext/info | jq '.result.nodeID'
}


function isBootstrapped() {
	request="{
		\"jsonrpc\":\"2.0\",
		\"id\"     :1,
		\"method\" :\"info.isBootstrapped\",
		\"params\": {
			\"chain\":\"${1:-X}\"
		}
	}"
	curl -s -X POST --data $request  -H 'content-type:application/json;' $NODE_URL/ext/info | jq
}

function isBlockchainPublished() {
	export BLOCKCHAIN_ID=${1:-C}
	res=$(curl -s -X POST --data '{
		"jsonrpc":"2.0",
		"id" :1,
		"method" :"platform.getBlockchains"
	}' -H 'content-type:application/json;' $NODE_URL/ext/bc/P | 
	jq ".. | {id: .id?, name} | select(.id == \"$BLOCKCHAIN_ID\") | .id")
	if [ "$res" = "\"${BLOCKCHAIN_ID}\"" ]; then
	 	echo "blockchain with id ${BLOCKCHAIN_ID} found"
	 	return 0
	else
	 	>&2 echo "blockchain not found"
	 	return 1
	fi
}