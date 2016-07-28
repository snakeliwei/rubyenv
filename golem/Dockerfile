FROM snakeliwei/rubyenv:base
MAINTAINER Lyndon <snakeliwei@gmail.com>

COPY ./* /tmp

RUN /bin/bash -l -c "cd /tmp" && \
    /bin/bash -l -c "source /etc/profile.d/rvm.sh" && \
    /bin/bash -l -c "bundle install" && \
    rm -rf /tmp/*
