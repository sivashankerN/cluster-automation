#! /bin/bash

#PASSWORD_HOSTMACHINE=vlead123
HTTP_PROXY="http://proxy.iiit.ac.in:8080"
HTTPS_PROXY="http://proxy.iiit.ac.in:8080"
HOSTMACHINE_IP=10.4.59.220
ROUTER_IP=10.4.59.221
CONFIG_SERVER_IP=10.4.59.222
DNS1=10.4.12.160
DNS2=10.4.12.220
CONTAINER_ROOT_PASSWORD=
CLUSTERNAME=Sunny
SMTP_SMART_HOST=
PROXY_PORT=
SUBNET=
INTERNET_GATEWAY=
NET_MASK=
CORKSCREW_PROXY=

COMMONVARS_PATH=cluster-automation/build/code/imp/roles/common-vars/vars/main.yml

#
#sed -i '/proxy=.*/d' /etc/yum.conf
#echo 'proxy=http://proxy.iiit.ac.in:8080' >> /etc/yum.conf
#
#
#yum install epel-release -y
#yum install ansible -y
#yum install emacs -y
#yum install sshpass -y
#
#
#ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ""
#
#echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config
#
#sudo mknod -m 666 /dev/tty c 5 0
#sshpass -p $PASSWORD_HOSTMACHINE ssh-copy-id root@localhost
#sshpass -p $PASSWORD_HOSTMACHINE ssh-copy-id root@127.0.0.1


sed -i "s|http_proxy:.*|http_proxy: $HTTP_PROXY|g" "$COMMONVARS_PATH"
sed -i "s|https_proxy:.*|https_proxy: $HTTPS_PROXY|g" "$COMMONVARS_PATH"
sed -i "s|hostmachine_ip:.*|hostmachine_ip: $HOSTMACHINE_IP|g" "$COMMONVARS_PATH"
sed -i "s|router_ip:.*|router_ip: $ROUTER_IP|g" "$COMMONVARS_PATH"
sed -i "s|config_server_ip:.*|config_server_ip: $CONFIG_SERVER_IP|g" "$COMMONVARS_PATH"
sed -i "s|dns1:.*|dns1: $DNS1|g" "$COMMONVARS_PATH"
sed -i "s|dns2:.*|dns2: $DNS2|g" "$COMMONVARS_PATH"
sed -i "s|clustername:.*|clustername: $CLUSTERNAME|g" "$COMMONVARS_PATH"
sed -i "s|container_root_password:.*|container_root_password: $CONTAINER_ROOT_PASSWORD|g" "$COMMONVARS_PATH"
sed -i "s|smtp_smart_host:.*|smtp_smart_host: $SMTP_SMART_HOST|g" "$COMMONVARS_PATH"
sed -i "s|proxy_port:.*|proxy_port: $PROXY_PORT|g" "$COMMONVARS_PATH"
sed -i "s|subnet:.*|subnet: $SUBNET|g" "$COMMONVARS_PATH"
sed -i "s|internet_gateway:.*|internet_gateway: $INTERNET_GATEWAY|g" "$COMMONVARS_PATH"
sed -i "s|net_mask:.*|net_mask: $NET_MASK|g" "$COMMONVARS_PATH"
sed -i "s|corkscrew_proxy:.*|corkscrew_proxy: $CORKSCREW_PROXY|g" "$COMMONVARS_PATH"
