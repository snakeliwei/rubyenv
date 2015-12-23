From debian:jessie
MAINTAINER Lyndon li <snakeliwei@gmail.com>

RUN  #sed -i 's/httpredir.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
     apt-get update \
     && apt-get install -y --no-install-recommends \
        git curl imagemagick libmagickcore-dev libmagickwand-dev libpq-dev \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

ENV RUBY_VERSION 2.1.0

# Install RVM, RUBY, bundler 
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
    && \curl -sSL https://get.rvm.io | bash -s stable

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN source /usr/local/rvm/scripts/rvm \
    && rvm requirements \
    && rvm install $RUBY_VERSION \
    && rvm use $RUBY_VERSION --default \
    && gem install bundler --no-doc --no-ri
    
RUN mkdir -p /tmp/data 
COPY . /tmp/data
WORKDIR /tmp/data
RUN bundle install

CMD ["irb"]
