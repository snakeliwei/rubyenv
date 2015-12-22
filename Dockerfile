From debian:jessie
MAINTAINER Lyndon li <snakeliwei@gmail.com>

RUN apt-get update \
     && apt-get install -y --no-install-recommends \
        git curl procps zlib1g-dev ca-certificates libffi-dev \
        libgdbm3 libssl-dev libyaml-dev libcurl4-openssl-dev libxslt-dev \
        libxml2-dev imagemagick libmagickcore-dev libmagickwand-dev libpq-dev \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Setup User
RUN useradd --home /home/worker -M worker -K UID_MIN=10000 -K GID_MIN=10000 -s /bin/bash \
    && mkdir /home/worker \
    && chown worker:worker /home/worker \
    && adduser worker sudo \
    && echo 'worker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    
USER worker

ENV RUBY_VERSION 2.1.0

# Install RVM, RUBY, bundler 
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
    && \curl -sSL https://get.rvm.io | bash -s stable \
    && /bin/bash -l -c 'source /etc/profile.d/rvm.sh' \
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
