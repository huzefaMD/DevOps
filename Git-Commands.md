# Basic Git Commands
### This file contains Installation and configuration of VCS using Git in Linux based OS.

#### Launch [AWS EC2 Linux Instance] (https://docs.aws.amazon.com/quickstarts/latest/vmlaunch/step-1-launch-instance.html) or Create VM and Install Linux based OS.

#### After launching your EC2 instance connect via Putty or Gitbash
#### If you are using Local VM then connect directly.

#### Update you OS.

*yum update -y*

#### Install Apache in Your Linux 

*yum install httpd*

*service httpd start*

*chkconfig httpd on*

#### you can test your web page by typing IP address of your PC

#### Download and Install Git

*yum install git -y*

#### After installing git go to default home directory of Apache.

*cd /var/www/html*

#### Create a file **index.html** 

*touch index.html*

#### edit the file with some html coding.

*<h4>this is heading</h4>*

#### save and close the file.

*:wq*

#### Test the web Page by typing the ip address of the Server in another computer.

*IP Address*

#### Create a **github** account for testing the git configuration

#### Create a Repository in github so that you can **PULL** and **PUSH** from the local git repository.

#### While you creating git repository it will create README.MD file with **master** branch

#### In Local Linux computer (Web Server) go to the path.

*cd /var/www/html*

#### Intial git command **This command to inital git in located folder**

*git init*

#### check the status 

*git status*

#### configure git 

*git config --global user.email huzefa@sansbound.com*
*git config --global user.name Huzefa*

#### Create Key Pair to Authenticate git with github repository

*ssh-keygen -t rsa -b 4096 -C "yourname@domain.com"*
*eval "$(ssh-agent -s)"*
*ssh-add /root/.ssh/id_rsa*

#### copy the public key in key pair from the local path

*cat /root/.ssh/id_rsa.pub*

#### go to github repository
#### select the repository
#### select the settings
#### deploy keys
#### add key by typing Name and Paste the key which you copied from local PC.

#### copy the URL of git repository of **https** and **ssh**
#### add in the local git as **remote origin** using following commands

_git remote add origin <url of git repo> **https**_
_git remote set-url origin <url of git repo> **ssh**_

#### Pull Repository from remote to local

*git pull origin master*

#### Push Repository from Local to remote

*git push origin master*

#### now you can check the staus of local

*git status* 
