FROM centos:centos7.9.2009
RUN yum -y install openssh-clients sshpass
COPY ./install-collectd.sh /home/install.sh
COPY ./collectd.conf /home/collectd.conf
ARG USER
ARG PASS
ARG OS
ENV USER=$USER
ENV PASS=$PASS
ENV OS=$OS
CMD ["bash", "/home/install.sh"]