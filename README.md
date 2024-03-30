# Lab9-Ansible-Resources
This work demonstates simple configuration management principles.  Whereupon a control node - ansible on Ubuntu is used to demonstrate a simple automated management of   Redhat and Ubuntu system (managed nodes) by installing simple apache (httpd) server on them.
You must have an AWS account to be able to replicate this lab.  You must have setup the following on your system, which could be mac or linux:
VS Code
AWS CLI
Terraform on VS Code

Steps to Follow:
Step 1:
To provision the resources on AWS, run from VS Code, 
terraform init, terraform validate, terraform plan, terraform apply
Step 2: 
Ensure you copy and paste the output ip addresses somewhere - you are going to need them
Step 3:
ssh into the ansible server and use ssh-keygen command to generate keypairs
The keys would be used by the ansible control node for remote ssh connection to the managed nodes, 
the redhat and ubuntu servers. The key pair in Linux systems is located by default in the .ssh directory. 
The public key will be copied into the authorized_keys file of the managed nodes, the redhat and ubuntu servers.
Step 4:
Use the command cd /home/ubuntu/.ssh and cd /home/redhat/.ssh to change directory to the location of the keypair files
Use the command sudo cat id_rsa.pub to access, then copy the public key and paste somewhere, for next step.
Step 5:


