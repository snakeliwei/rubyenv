From debian:jessie
MAINTAINER Lyndon li <snakeliwei@gmail.com>
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
    sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

WORKDIR /code

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
     && apt-get install -y --no-install-recommends \
        git curl libcurl4-openssl-dev libxslt-dev libxml2-dev imagemagick libmagickcore-dev libmagickwand-dev libpq-dev \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Install rvm, ruby, bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    \curl -sSL https://get.rvm.io | bash -s stable && \
    echo 'source /etc/profile.d/rvm.sh' >> /etc/profile && \
    source /etc/profile && \
    rvm requirements && \
    rvm install 2.1.0 && \
    rvm use --default 2.1.0 && \
    gem install bundler


RUN mkdir -p /tmp/data 
COPY . /tmp/data
WORKDIR /tmp/data
RUN bundle install

# Clean the apt cache
RUN rm -rf /var/lib/apt/lists/*

CMD ["irb"]

