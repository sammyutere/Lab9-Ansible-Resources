#!/bin/bash

#update instance and install ansible

apt-get update -y
apt-get install software-properties-common -y
apt-add-repository ppa:ansible/ansible
apt-get install ansible -y
hostnamectl set-hostname ansible 