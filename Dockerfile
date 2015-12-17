From debian:jessie
MAINTAINER Lyndon li <snakeliwei@gmail.com>

RUN apt-get update && \
    apt-get install -y git curl libcurl4-openssl-dev libxslt-dev libxml2-dev imagemagick libmagickcore-dev libmagickwand-dev libpq-dev 

# Install rvm, ruby, bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    \curl -sSL https://get.rvm.io | bash -s stable && \
    /bin/bash -l -c "rvm requirements" && \
    /bin/bash -l -c "rvm install 2.1.0" && \
    /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN mkdir -p /tmp/data/
RUN COPY . /tmp/data/
RUN /bin/bash -l -c "bundle install"

# Clean the apt cache
RUN rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

