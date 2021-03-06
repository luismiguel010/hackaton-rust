FROM rust:1.55.0-alpine3.13 as builder

RUN apk add libressl-dev
RUN apk add musl-dev pkgconfig openssl && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

WORKDIR /usr/src/hackaton-rust
RUN USER=root cargo init
COPY Cargo.toml .
COPY src src
RUN cargo build --release

#FROM debian:stretch-slim
FROM alpine:3.13.6
EXPOSE 5000
COPY --from=builder /usr/src/hackaton-rust/target/release/hackaton-rust /bin/
CMD hackaton-rust
