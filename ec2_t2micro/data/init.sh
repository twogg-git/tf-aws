#!/usr/bin/env bash

yum -y install golang
mkdir index
cd index
curl https://raw.githubusercontent.com/twogg-git/tf-aws/master/ec2_t2micro/data/main.go -o main.go 
sudo go build
./index