# compiles and runs niftycoin-seeder
#
# build the container:
#   docker build -t niftycoin-seeder .
#
# run the dns node:
#   docker run -d -p 53:53/tcp -p 53:53/udp niftycoin-seeder
#
# if you want to poke around in the container:
#   docker run -ti --rm --entrypoint /bin/sh niftycoin-seeder -c /bin/sh
#
# and don't forget on the host:
#
#   ufw allow 53
#
# related resources:
#
#   https://github.com/sipa/bitcoin-seeder/blob/master/README
#   https://help.ubuntu.com/community/UFW
#   http://docs.docker.io/installation/ubuntulinux/#docker-and-ufw

FROM alpine:latest

RUN mkdir -p /app/bin /app/src /var/lib/niftycoin-seeder

WORKDIR /app/src

RUN apk --no-cache add --virtual build_deps    \
      boost-dev                                \
      gcc                                      \
      git                                      \
      g++                                      \
      libc-dev                                 \
      make                                     \
      openssl-dev                           && \
    git clone https://github.com/perivar/niftycoin-seeder.git . && \
    make                                    && \
    mv /app/src/dnsseed /app/bin/dnsseed    && \
    rm -rf /app/src                         && \
    apk --purge del build_deps

RUN apk --no-cache add    \
      libgcc              \
      libstdc++

WORKDIR /var/lib/niftycoin-seeder
VOLUME /var/lib/niftycoin-seeder

EXPOSE 53

ENTRYPOINT ["/app/bin/dnsseed"]

CMD ["-h", "dnsseed.niftycoin.org", \
     "-n", "niftycoin.org", \
     "-m", "dnsadmin.niftycoin.org", \
     "-p", "53"]
