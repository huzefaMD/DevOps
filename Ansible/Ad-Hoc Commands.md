ansible demo -a "ls" - this command list all file in demo group nodes.

ansible all -a "ls" - this command list all files in all nodes.

ansible all -a "touch devopsfile" - this command creates devopsfile in all nodes

ansible demo -a "ls -la" - this command list all hidden file in demo group nodes

ansible demo -a "sudo yum install httpd -y"  - this command install apache in demo group nodes

which httpd - this command to check wether httpd installed or not
