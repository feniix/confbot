FROM ubuntu:bionic as builder

      #apt-get -y install curl wget gnupg libz-dev xxxlibssl1.0-dev && \
RUN apt-get update && \
      apt-get -y install curl wget gnupg pkg-config libz-dev && \
      curl -sL "https://keybase.io/crystal/pgp_keys.asc" | apt-key add - && \
      echo "deb https://dist.crystal-lang.org/apt crystal main" | tee /etc/apt/sources.list.d/crystal.list && \
      apt-get update && \
      apt-get install -y crystal

WORKDIR /app

COPY . /app/

RUN shards build

FROM ubuntu:bionic
RUN apt-get update && \
      apt-get -y install libssl1.1 libevent-2.1

COPY --from=builder /app/bin/confbot .

CMD ["./confbot"]

