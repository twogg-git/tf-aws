#!/usr/bin/env bash

yum -y install golang
mkdir index
cd index
curl https://raw.githubusercontent.com/twogg-git/docker-registry-workshop/master/golang/main.go -o main.go 
sudo go build
./index