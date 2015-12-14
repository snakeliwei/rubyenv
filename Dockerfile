From ubuntu:14.04.3
MAINTAINER Lyndon li <snakeliwei@gmail.com>

RUN apt-get update && \
    apt-get install -y curl

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.0

RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["source /usr/local/rvm/scripts/rvm"]
CMD ["/bin/bash"]

