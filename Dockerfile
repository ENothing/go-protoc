FROM golang:1.14 as builder
WORKDIR /tmp/proto
ENV GOPATH=/tmp/proto

ENV GOPROXY=https://goproxy.cn

ENV GO111MODULE=on

RUN apt-get update
RUN apt-get install -y unzip

# protoc
RUN curl https://github.com/protocolbuffers/protobuf/releases/download/v3.11.4/protoc-3.11.4-linux-x86_64.zip -L -o protoc.zip
RUN unzip protoc.zip

# protoc-gen-go
RUN go get  github.com/golang/protobuf/protoc-gen-go


# protoc-gen-micro
RUN go get github.com/micro/protoc-gen-micro/v2


FROM busybox:1.31-glibc
COPY --from=builder /tmp/proto/bin/protoc /usr/local/bin/protoc
COPY --from=builder /tmp/proto/bin/protoc-gen-go /usr/local/bin/protoc-gen-go
COPY --from=builder /tmp/proto/bin/protoc-gen-micro /usr/local/bin/protoc-gen-micro

ENTRYPOINT ["/usr/local/bin/protoc"]