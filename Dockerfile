FROM centos:centos7.9.2009
ARG PASS
COPY ./install-collectd.sh /home/install.sh
COPY ./collectd.conf /home/collectd.conf
RUN yum -y install openssh-clients sshpass
ENV PASS=$PASS
CMD ["bash", "/home/install.sh"]