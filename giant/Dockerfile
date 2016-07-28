FROM snakeliwei/rubyenv:base
MAINTAINER Lyndon <snakeliwei@gmail.com>

RUN mkdir -p /temp 
COPY . /temp

RUN cd /temp && \
    /bin/bash -l -c "source /etc/profile.d/rvm.sh" && \
    /bin/bash -l -c "bundle install" && \
    rm -rf /tmp/*
