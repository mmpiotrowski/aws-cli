from ubuntu:22.04

ARG AWS_CLI_VERSION

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    unzip curl groff python3 python-is-python3 python3-venv

# https://docs.aws.amazon.com/cli/v1/userguide/install-linux.html
RUN cd /tmp && curl "https://s3.amazonaws.com/aws-cli/awscli-bundle-${AWS_CLI_VERSION}.zip" -o "awscli.zip" \
    && unzip awscli.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
    && rm -rf /tmp/*
    
RUN echo "complete -C '/usr/local/aws/bin/aws_completer' aws" >> /etc/bash.bashrc

WORKDIR /aws

ENTRYPOINT ["/usr/local/bin/aws"]