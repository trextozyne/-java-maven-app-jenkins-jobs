#!/usr/bin/env bash

yum update
yum install ansible -y
yum install python3-pip -y
pip3 install boto3 botocore