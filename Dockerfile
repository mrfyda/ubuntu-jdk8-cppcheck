FROM rtfpessoa/ubuntu-jdk8:latest
MAINTAINER Rodrigo Fernandes <rodrigo.fernandes@tecnico.ulisboa.pt>

#
# Ubuntu with Oracle JDK 8 and CPPCheck
#

# Install and setup project dependencies
RUN \
  apt-get -y update && \
  apt-get -y install software-properties-common && \
  apt-get -y install curl unzip nano git && \
  apt-get -y install build-essential python libpcre3 libpcre3-dev && \
  apt-get -y upgrade && \
  cd /usr/lib && git clone -b 1.70 https://github.com/danmar/cppcheck && \
  cd cppcheck && \
  make CFGDIR=/usr/lib/cppcheck/cfg HAVE_RULES=yes && \
  make install && \
  rm -rf /usr/lib/cppcheck/.git && \
  apt-get -y clean && \
  apt-get -y autoclean && \
  apt-get -y autoremove && \
  apt-get purge -y $(apt-cache search '~c' | awk '{ print $2 }') && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/apt && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  rm -rf /tmp/*
