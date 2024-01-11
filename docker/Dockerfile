FROM alpine:3.19

RUN apk add wine
RUN apk add jq

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
