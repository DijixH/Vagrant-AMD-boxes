#!/bin/bash

# TODO: Pull and inject md5 hash into packer
packer init vmware-centos9.pkr.hcl
packer build -force vmware-centos9.pkr.hcl
cp metadata.json output/metadata.json
cd output
tar cvzf vmware-centos9-amd64.box ./*
md5 vmware-centos9-amd64.box >> md5-vmware-centos9-amd64.txt
rm -f *.v* *.nvram metadata.json