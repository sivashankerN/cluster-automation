#! /bin/bash

# Host machine's root user password
PASSWORD_HOSTMACHINE=vlead123  

# Set network proxy, http_proxy and https_proxy
HTTP_PROXY="http://proxy.iiit.ac.in:8080"
HTTPS_PROXY="http://proxy.iiit.ac.in:8080"

## Required fields for setting up network in in host machine, Router container and config-server container.
## So that these three machines will get internet connection.
## Router and config-servers are containers.
## Following fields should be taken from LAN network which has internet
HOSTMACHINE_IP=10.4.59.220
ROUTER_IP=10.4.59.221
CONFIG_SERVER_IP=10.4.59.222
DNS1=10.4.12.160
DNS2=10.4.12.220
INTERNET_GATEWAY=10.2.56.1
NET_MASK=255.255.252.0

## Set Root password of cluster containers
CONTAINER_ROOT_PASSWORD=rootpassword

## Set name of the cluster
CLUSTERNAME=base8

## Server name through which mails will be delivered to specified email address in /etc/mail/sendmail.mc. 
#Each cluster container will be sending mails through this server
SMTP_SMART_HOST=stpi-router.vlabs.ac.in

#Set the Proxy  if network proxy denying ssh port 
CORKSCREW_PROXY=proxy.iiit.ac.in

#Set network proxy port 
PROXY_PORT=8080

# Path for common variables for cluster automation playbooks
COMMONVARS_PATH=build/code/imp/roles/common-vars/vars/main.yml
HOST_PATH=build/code/imp/hosts 

sed -i '/proxy=.*/d' /etc/yum.conf
echo "proxy=$HTTP_PROXY" >> /etc/yum.conf

## Install required packages
yum install epel-release -y
yum install ansible -y
yum install sshpass -y

echo -e '\n\nPlease press "n" if keys are already generated'

ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ""

sed -i '/^StrictHostKey.*/d' /etc/ssh/ssh_config
echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config
service sshd restart

sshpass -p $PASSWORD_HOSTMACHINE ssh-copy-id root@localhost
sshpass -p $PASSWORD_HOSTMACHINE ssh-copy-id root@127.0.0.1

## Have a copy of original file
cp $COMMONVARS_PATH $COMMONVARS_PATH.bkp

#Updating variables in common-vars of cluster-automation

sed -i "s|http_proxy_name:.*|http_proxy_name: $HTTP_PROXY|g" "$COMMONVARS_PATH"
sed -i "s|https_proxy_name:.*|https_proxy_name: $HTTPS_PROXY|g" "$COMMONVARS_PATH"
sed -i "s|hostmachine_ip:.*|hostmachine_ip: $HOSTMACHINE_IP|g" "$COMMONVARS_PATH"
sed -i "s|router_ip:.*|router_ip: $ROUTER_IP|g" "$COMMONVARS_PATH"
sed -i "s|config_server_ip:.*|config_server_ip: $CONFIG_SERVER_IP|g" "$COMMONVARS_PATH"
sed -i "s|dns1_server:.*|dns1_server: $DNS1|g" "$COMMONVARS_PATH"
sed -i "s|dns2_server:.*|dns2_server: $DNS2|g" "$COMMONVARS_PATH"
sed -i "s|clustername:.*|clustername: $CLUSTERNAME|g" "$COMMONVARS_PATH"
sed -i "s|container_root_password:.*|container_root_password: $CONTAINER_ROOT_PASSWORD|g" "$COMMONVARS_PATH"
sed -i "s|smtp_smart_host:.*|smtp_smart_host: $SMTP_SMART_HOST|g" "$COMMONVARS_PATH"
sed -i "s|proxy_port:.*|proxy_port: $PROXY_PORT|g" "$COMMONVARS_PATH"
sed -i "s|internet_gateway:.*|internet_gateway: $INTERNET_GATEWAY|g" "$COMMONVARS_PATH"
sed -i "s|net_mask:.*|net_mask: $NET_MASK|g" "$COMMONVARS_PATH"
sed -i "s|corkscrew_proxy:.*|corkscrew_proxy: $CORKSCREW_PROXY|g" "$COMMONVARS_PATH"
sed -i "/[config-server]/{ n; s/10.2.*/$CONFIG_SERVER_IP/; }" $HOST_PATH

RC_LOCAL=/etc/rc.d/rc.local

echo "cd ~/cluster-automation/build/code/imp/ > cd_logs.txt 2>&1" >> $RC_LOCAL
echo "ansible-playbook -i hosts cluster.yml > cluster.yml.txt 2>&1" >> $RC_LOCAL
echo 'sed -i "/ansible-playbook.*/d" '$RC_LOCAL'' >> $RC_LOCAL
echo 'sed -i "/cluster-automation.*/d" '$RC_LOCAL'' >> $RC_LOCAL

cat ~/.ssh/id_rsa.pub

echo -e "\n\nPlease add above diplayed key in systems-model repository."
echo -e "\n\nPlease press Y or y to continue."
read -p "Have you added host machine's public key ( ~/.ssh/id_rsa.pub) in bitbucket.org in systems-model repository(Y/y):: " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
 echo -e "\n\nYou Pressed wrong key please run make again and press correct key (y or Y)"
else
 cd ~/cluster-automation/build/code/imp/ && ansible-playbook -i hosts base-machine-setup.yml 
fi 
