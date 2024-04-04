FROM alpine:3.10

RUN apk update && apk add git bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]