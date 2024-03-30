# Lab9-Ansible-Resources
This work demonstates simple configuration management principles.  
Whereupon a control node - ansible on Ubuntu is used to demonstrate a simple automated management of  
Redhat and Ubuntu system (managed nodes) by installing simple apache (httpd) server on them.  
You must have an AWS account to be able to replicate this lab.  
You must have setup the following on your system, which could be mac or linux:  
Created a keypair using the command ssh-keygen, this keypair must be in your Terraform project directory.  
AWS will use the public key to provision the EC2 instances but the private key will remain in your local machine.  
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
the redhat and ubuntu servers.  
The key pair in Linux systems is located by default in the .ssh directory.  
The public key will be copied into the authorized_keys file of the managed nodes, the redhat and ubuntu servers.  
Step 4:
Use the command cd /home/ubuntu/.ssh and cd /home/redhat/.ssh to change directory to the location of the keypair files
Use the command sudo cat id_rsa.pub to access, then copy the public key and paste somewhere, for the next step.  
Step 5:  
ssh into the redhat or ubuntu system  
Step 6:  
Use the command, sudo vi .ssh/authorized_keys to access the authorized_keys file  
Press letter I to get into insert mode,  
press the enter key to move down the previous public key that was added during provisioning of the  
EC2 instance and paste the public key that was generated from the ansible EC2 instance.  
Press esc key to get to command mode, type :wq! And press enter key to save and exit.  
Step 7:  
Repeat step 5 and 6 for the ubuntu (managed node).  
Note that the redhat and ubuntu instances now have two public keys, so it is possible for the ansible (control node) to  
establish ssh connection with the redhat (managed node) and the ubuntu (managed node).  
It is also possible to establish an ssh connection with all the instances from your local machine  
which contains the private key and the public key (which Terraform used to provision the instances on AWS).


