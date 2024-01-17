FROM alpine:3.19

RUN apk update && apk add --no-cache jq wine

# Pre-initialize wine
RUN wine cmd

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
