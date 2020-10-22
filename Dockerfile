FROM golang:1.14-alpine
MAINTAINER  Daniel Qian <qsj.daniel@gmail.com>

WORKDIR /go/src/app
COPY . .

RUN go mod download
RUN go mod verify
RUN go build

FROM alpine:latest

RUN apk --no-cache add ca-certificates
WORKDIR /root/

COPY --from=0 /go/src/app/kafka_exporter .

EXPOSE     9308
ENTRYPOINT [ "./kafka_exporter" ]