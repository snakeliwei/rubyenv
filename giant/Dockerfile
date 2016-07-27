FROM snakeliwei/rubyenv:base
MAINTAINER Lyndon <snakeliwei@gmail.com>

ADD ./Gemfile /tmp
ADD ./Gemfile.lock /tmp

RUN cd /tmp &&\
    /bin/bash -l -c "source /etc/profile.d/rvm.sh" &&\
    /bin/bash -l -c "bundle install" &&\
    rm -rf /tmp/*

    
    
