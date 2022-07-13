FROM golang:1.17.12-bullseye as builder

RUN git clone -b v0.2.7 https://github.com/suyashkumar/ssl-proxy /ssl-proxy
WORKDIR /ssl-proxy
RUN CGO_ENABLED=0 make

FROM alpine:3.15.4

COPY --from=builder /ssl-proxy/ssl-proxy /usr/bin/ssl-proxy
RUN chmod +x /usr/bin/ssl-proxy
ENTRYPOINT [ "/usr/bin/ssl-proxy" ]
