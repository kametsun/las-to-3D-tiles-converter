FROM golang:1.24.3 AS builder

RUN apt update && apt install -y \
    git \
    libproj-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /go/src
RUN git clone https://github.com/mfbonfigli/gocesiumtiler.git
WORKDIR /go/src/gocesiumtiler
RUN go mod tidy
RUN go build -o bin/gocesiumtiler ./cmd/main.go

FROM debian:stable-slim

RUN apt update && apt install -y \
    libproj-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /go/src/gocesiumtiler/bin/gocesiumtiler /usr/local/bin/gocesiumtiler

# 作業ディレクトリの設定
WORKDIR /data

# デフォルトコマンド
CMD ["gocesiumtiler", "--help"]