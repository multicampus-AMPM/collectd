#!/usr/bin/env bash

mkdir ~/.ssh
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
mkdir /home/.ssh
cp -ra ~/.ssh/id_rsa.pub /home/.ssh/
mv /home/.ssh/id_rsa.pub /home/.ssh/authorized_keys
sshpass -p ${PASS} scp -o StrictHostKeyChecking=no -r /home/.ssh/ ${USER}@127.0.0.1:~/

if [ "${OS}" == "centos" ]
then
    ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S yum -y install collectd collectd-smart'
    sshpass -p ${PASS} scp -o StrictHostKeyChecking=no /home/collectd.conf ${USER}@127.0.0.1:~/collectd.conf
    ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S mv -f ~/collectd.conf /etc/collectd.conf'
    ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S chown root:root /etc/collectd.conf'
elif [ "${OS}" == "ubuntu" ]
then
    ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S apt-get -y install collectd libatasmart-dev'
    sshpass -p ${PASS} scp -o StrictHostKeyChecking=no /home/collectd.conf ${USER}@127.0.0.1:~/collectd.conf
    ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S mv -f ~/collectd.conf /etc/collectd/collectd.conf'
    ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S chown root:root /etc/collectd/collectd.conf'
else
    echo "No supoorted os found : OS="${OS}
    exit 1
fi

ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S systemctl enable collectd'
ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S systemctl start collectd'
ssh ${USER}@127.0.0.1 'rm -rf ~/.ssh/authorized_keys'
