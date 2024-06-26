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
  
Step 8:  
Use the command sudo vi /etc/ansible/hosts to update the host inventory file on ansible.  
This file determines how ansible is able to locate the ip addresses of the managed nodes.  
This is where the ip addresses of the target servers are stored.  
Press letter I to get into insert mode,  
press the enter key to move down the contents and the paste the following at the top of the file,  
  
[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[host-1]
18.171.175.192 ansible_user=ec2-user #redhat  
  
[host-2]
35.177.172.123 ansible_user=ubuntu #ubuntu  

Note the Following:  
The ip addresses are added to different groups because they are of different Linux distros  
hence ansible is going to connect to them differently.  
In a production environment or server it would be advisable to add the private ip, instead of the public ip which can change.  

The first line of code is the strict hostname checking switch.  
It switches off the prompt asking for approval during connection from ansible (control node) to any managed node.  
Which if allowed to be on, will hinder automation in a production environment.  

Step 9:  
Use the command ansible -m ping host-2 or ansible -m ping host-1 or ansible -m ping all  
to test connectivity between the control node and managed nodes.  

Step 10:  
Use the command touch apache.yml to create ansible playbook file.  
Press letter I to get into insert mode, type in the code as shown in the attached file.  
Check your code at, https://jsonformatter.org/yaml-validator before pasting it in the apache.yml file.

![ansible-playbook](https://github.com/sammyutere/Lab9-Ansible-Resources/assets/115847964/a9fa01d0-550a-4379-b136-6b5641bcf349)  

Press esc key to get to command mode, type :wq! And press enter key to save and exit.  

Step 11:  
Use the command ansible-playbook apache.yml –syntax-check to check your syntax.  

Step 12:  
Use the command ansible-playbook apache.yml to execute the playbook.  
Note:  
It is advisable to be in the directory where the yaml file is located, usually in the default directory.  
If it is not in the default directory use ansible-playbook -i full-path-to-playbook-file.  

Step 13:  
Copy the public ip addresses of the managed nodes and paste them on to a browser to  
verify that apache(httpd) was successfully configured by the ansible control node.



