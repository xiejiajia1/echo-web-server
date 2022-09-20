FROM docker.io/library/golang:1.17 AS builder

RUN echo 'deb http://mirrors.aliyun.com/debian/ buster main non-free contrib' > /etc/apt/sources.list
RUN echo 'deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib' >> /etc/apt/sources.list
RUN echo 'deb http://mirrors.aliyun.com/debian-security buster/updates main' >> /etc/apt/sources.list
RUN echo 'deb-src http://mirrors.aliyun.com/debian-security buster/updates main' >> /etc/apt/sources.list
RUN echo 'deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib' >> /etc/apt/sources.list
RUN echo 'deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib' >> /etc/apt/sources.list
RUN echo 'deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib' >> /etc/apt/sources.list
RUN echo 'deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib' >> /etc/apt/sources.list

ENV GOPROXY=https://goproxy.cn,direct
ARG PACKAGE=github.com/haoshuwei/echo-server

RUN mkdir -p /go/src/${PACKAGE}
WORKDIR /go/src/${PACKAGE}

COPY . .
RUN go mod download
# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o echo-server main.go

# Copy the controller-manager into a thin image
FROM registry.cn-hangzhou.aliyuncs.com/acs/alpine:3.13.2-base
WORKDIR /
COPY --from=builder /go/src/github.com/haoshuwei/echo-server .
USER 65532:65532

ENTRYPOINT ["/echo-server"]
