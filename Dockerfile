FROM alpine:3.10

RUN apk update && apk add git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]