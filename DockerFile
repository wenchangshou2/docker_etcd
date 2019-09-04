FROM alpine:latest
ENV VERSION=v3.4.0
# WORKDIR /app
RUN  mkdir /data && apk add --update ca-certificates openssl tar  &&\
  wget https://github.com/etcd-io/etcd/releases/download/${VERSION}/etcd-${VERSION}-linux-amd64.tar.gz &&\
  tar -zxvf etcd-${VERSION}-linux-amd64.tar.gz && \
  mv etcd-${VERSION}-linux-amd64/etcd* /bin/ && \
  apk del --purge tar openssl &&\
  rm -Rf etcd-${VERSION}-linux-amd64* /var/cache/apk/*
VOLUME /data
EXPOSE 2379 2380 4001 7001

ADD run.sh /bin/run.sh

ENTRYPOINT ["/bin/run.sh"]
