FROM centos:centos7.9.2009
RUN yum -y install openssh-clients sshpass
COPY ./install-collectd.sh /home/install.sh
COPY ./collectd.conf.ubuntu /home/collectd.conf.ubuntu
COPY ./collectd.conf.centos /home/collectd.conf.centos
CMD ["bash", "/home/install.sh"]