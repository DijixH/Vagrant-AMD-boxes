#!/bin/bash

packer init vmware-centos7.pkr.hcl
packer build -force vmware-centos7.pkr.hcl
cp metadata.json output/metadata.json
cd output
tar cvzf vmware-centos7-amd64.box ./*
md5 vmware-centos7-amd64.box >> md5-vmware-centos7-amd64.txt
rm -f *.v* *.nvram metadata.json