ansible demo -b -m yum -a "pkg=httpd state=present" - this command is to install httpd in demo node group

ansible demo -b -m yum -a "pkg=httpd state=latest" - this command is to update apache version in demo node group

ansible demo -b -m yum -a "pkg=httpd state=started" - this command is to update apache version in demo node group

ansible demo -b -m yum -a "pkg=httpd state=absent" - this command is to update apache version in demo node group

ansible demo -b -m user -a "name=dev1" - this command is to create user in demo node group

ansible demo [-1] -b -m copy -a "src=file.txt dest=/tmp" - this command is to copy file from Ansible server to last node in demo group

ansible demo -b -m copy -a "src=logo.bmp dest=/tmp" - this command is to copy file from Ansible to demo node group

ansible demo -m setup - this command to see 

ansible demo -m setup -a "filter=*ipv4*"
