#!/usr/bin/env bash

mkdir ~/.ssh
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
sshpass -p ${PASS} scp -o StrictHostKeyChecking=no ~/.ssh/id_rsa.pub root@127.0.0.1:~/.ssh/authorized_keys
ssh root@127.0.0.1 'yum -y install collectd collectd-smart'
sshpass -p ${PASS} scp -o StrictHostKeyChecking=no /home/collectd.conf root@127.0.0.1:/etc/collectd.conf
ssh root@127.0.0.1 'systemctl enable collectd; systemctl start collectd'