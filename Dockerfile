FROM jenkins/jenkins:latest
ARG DOCKER_GID=1000
USER root

# aws cli install
COPY scripts/install-awscli.sh.sh /install-awscli.sh.sh
RUN chmod u+x /install-awscli.sh.sh && \
    /install-awscli.sh.sh

# docker install
COPY scripts/install-docker.sh /install-docker.sh
RUN chmod u+x /install-docker.sh && \
    /install-docker.sh

# set jenkins user to host docker group
RUN /usr/sbin/groupadd -g ${DOCKER_GID:-1000} -f docker && \
    /usr/sbin/usermod -aG docker ubuntu

USER ubuntu 
