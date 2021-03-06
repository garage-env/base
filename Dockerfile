# -------------------------------------------------------------------
# $ docker build -t garage-env/base git://https://github.com/garage-env/base.git
# -------------------------------------------------------------------

FROM stackbrew/ubuntu:saucy

MAINTAINER Reinaldo Junior <juniorz@gmail.com>

RUN apt-get update && apt-get upgrade -y

# User
RUN groupadd --gid 9999 garage &&\
    useradd --uid 9999 --gid 9999 --comment "Garage" garage &&\
    usermod -L garage &&\
    mkdir -p /home/garage

# Build tools
ADD garage /var/garage/
RUN chgrp -R garage /var/garage

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/garage"]
WORKDIR /garage

CMD ["/var/garage/info", "--help"]