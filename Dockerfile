FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y vim python3 locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Set up UTF-8 locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir /app \
    && mkdir /mnt/underway

WORKDIR /mnt/underway

CMD ["/app/run.sh"]
