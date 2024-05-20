from ubuntu:22.04

ARG AWS_CLI_VERSION

LABEL aws_cli.version=${AWS_CLI_VERSION}

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    unzip curl groff python3 python-is-python3 python3-venv

# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
RUN cd /tmp && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" -o "awscli.zip" \
    && unzip awscli.zip \
    && ./aws/install \
    && rm -rf /tmp/*

RUN echo "complete -C '/usr/local/bin/aws_completer' aws" >> /etc/bash.bashrc

COPY /assets /assets/

RUN useradd --create-home --shell /bin/bash user \
    && mkdir -p /home/user/workdir \
    && chown user:user -R /home/user

WORKDIR /home/user/workdir

ENTRYPOINT ["/assets/scripts/entrypoint.sh", "aws"]
