# This file contains Installation and configuration of VCS using Git in Linux based OS.

#### Launch AWS EC2 Linux Instance or Create VM and Install Linux based OS.

# After launching your EC2 instance connect via Putty or Gitbash
# If you are using Local VM then connect directly.

# Update you OS.

yum update -y

# Install Apache in Your Linux 

yum install httpd
service httpd start
chkconfig httpd on

# you can test your web page by typing IP address of your PC
