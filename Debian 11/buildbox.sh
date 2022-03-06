#!/bin/bash

packer init vmware-bullseye.pkr.hcl
packer build -force vmware-bullseye.pkr.hcl
cp metadata.json output/metadata.json
cd output
tar cvzf vmware-bullseye-amd64.box ./*
md5 vmware-bullseye-amd64.box >> vmware-bullseye-amd64-md5key.txt
rm -rf *.v* *.nvram metadata.json