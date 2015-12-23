From debian:jessie
MAINTAINER Lyndon li <snakeliwei@gmail.com>

RUN apt-get update \
     && apt-get install -y --no-install-recommends \
        git curl imagemagick libmagickcore-dev libmagickwand-dev libpq-dev \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

ENV RUBY_VERSION 2.1.0
ENV PATH /usr/local/rvm/bin:$PATH 
# Install RVM, RUBY, bundler 
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
    && \curl -sSL https://get.rvm.io | bash -s stable \
    && /bin/bash -l -c 'source /usr/local/rvm/scripts/rvm' \
    && /bin/bash -l -c 'rvm requirements' \
    && /bin/bash -l -c 'rvm install $RUBY_VERSION' \
    && /bin/bash -l -c 'rvm use $RUBY_VERSION --default' \
    && /bin/bash -l -c 'rvm rubygems current' \
    && /bin/bash -l -c 'gem install bundler --no-doc --no-ri'
    
RUN mkdir -p /tmp/data 
COPY . /tmp/data
WORKDIR /tmp/data
RUN /bin/bash -l -c 'bundle install'

CMD ["irb"]
