ansible all --list-hosts - list all nodes present in the host file

ansible demo --list-hosts - list demo group nodes of the host file

ansible demo[0] --list-hosts - this command shows the first node in the demo group

ansible demo[-1] --list-hosts - this command shows the last node in the demo grouop

ansible demo[0:1] --list-hosts - this command show the range in demo group
